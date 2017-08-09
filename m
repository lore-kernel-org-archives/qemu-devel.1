Received: from eggs.gnu.org ([2001:4830:134:3::10]:58377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dfWmh-0001ZW-QW
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 15:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dfWme-00081Y-Bp
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 15:36:51 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:46542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dfWmd-0007xm-CB
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 15:36:48 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Thu, 10 Aug 2017 01:06:27 +0530
Message-Id: <1502307387-19671-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH] QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jsnow@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

qemu-backup will be a command-line tool for performing full and
incremental disk backups on running VMs. It is intended as a
reference implementation for management stack and backup developers
to see QEMU's backup features in action. The tool writes details of
guest in a configuration file and the data is retrieved from the file
while creating a backup. The location of config file can be set as an
environment variable QEMU_BACKUP_CONFIG. The usage is as follows:

Add a guest
python qemu-backup.py guest add --guest <guest_name> --qmp <socket_path>

Add a drive for backup in a specified guest
python qemu-backup.py drive add --guest <guest_name> --id <drive_id> [--target <target_file_path>]

Create backup of the added drives:
python qemu-backup.py backup --guest <guest_name>

List all guest configs in configuration file:
python qemu-backup.py guest list

Restore operation
python qemu-backup.py restore --guest <guest-name>

Remove a guest
python qemu-backup.py guest remove --guest <guest_name>


Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
---
 contrib/backup/qemu-backup.py | 217 +++++++++++++++++++++++++++---------------
 1 file changed, 141 insertions(+), 76 deletions(-)

diff --git a/contrib/backup/qemu-backup.py b/contrib/backup/qemu-backup.py
index 9c3dc53..9bbbdb7 100644
--- a/contrib/backup/qemu-backup.py
+++ b/contrib/backup/qemu-backup.py
@@ -1,22 +1,54 @@
 #!/usr/bin/python
 # -*- coding: utf-8 -*-
+#
+# Copyright (C) 2013 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
 """
 This file is an implementation of backup tool
 """
+from __future__ import print_function
 from argparse import ArgumentParser
 import os
 import errno
 from socket import error as socket_error
-import configparser
+try:
+    import configparser
+except ImportError:
+    import ConfigParser as configparser
 import sys
-sys.path.append('../../scripts/qmp')
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..',
+                             'scripts', 'qmp'))
 from qmp import QEMUMonitorProtocol
 
 
 class BackupTool(object):
     """BackupTool Class"""
-    def __init__(self, config_file='backup.ini'):
-        self.config_file = config_file
+    def __init__(self,
+                 config_file=os.path.expanduser('~')+'/.qemu/backup/config'):
+        if "QEMU_BACKUP_CONFIG" in os.environ:
+            self.config_file = os.environ["QEMU_BACKUP_CONFIG"]
+        else:
+            self.config_file = config_file
+            try:
+                if not os.path.isdir(os.path.expanduser('~')+'/.qemu/backup'):
+                    os.makedirs(os.path.expanduser('~')+'/.qemu/backup')
+            except:
+                print("Cannot find the config file", file=sys.stderr)
+                exit(1)
         self.config = configparser.ConfigParser()
         self.config.read(self.config_file)
 
@@ -24,66 +56,70 @@ class BackupTool(object):
         """
         Writes configuration to ini file.
         """
-        with open(self.config_file, 'w') as config_file:
-            self.config.write(config_file)
+        config_file = open(self.config_file+".tmp", 'w')
+        self.config.write(config_file)
+        config_file.flush()
+        os.fsync(config_file.fileno())
+        config_file.close()
+        os.rename(self.config_file+".tmp", self.config_file)
 
-    def get_socket_path(self, socket_path, tcp):
+    def get_socket_address(self, socket_address):
         """
         Return Socket address in form of string or tuple
         """
-        if tcp is False:
-            return os.path.abspath(socket_path)
-        return (socket_path.split(':')[0], int(socket_path.split(':')[1]))
+        if socket_address.startswith('tcp'):
+            return (socket_address.split(':')[1],
+                    int(socket_address.split(':')[2]))
+        return socket_address.split(':',2)[1]
 
-    def __full_backup(self, guest_name):
+    def _full_backup(self, guest_name):
         """
         Performs full backup of guest
         """
         if guest_name not in self.config.sections():
-            print ("Cannot find specified guest")
-            return
-        if self.is_guest_running(guest_name, self.config[guest_name]['qmp'],
-                                 self.config[guest_name]['tcp']) is False:
-            return
+            print ("Cannot find specified guest", file=sys.stderr)
+            exit(1)
+
+        self.verify_guest_running(guest_name)
         connection = QEMUMonitorProtocol(
-                                         self.get_socket_path(
-                                             self.config[guest_name]['qmp'],
-                                             self.config[guest_name]['tcp']))
+                                         self.get_socket_address(
+                                             self.config[guest_name]['qmp']))
         connection.connect()
         cmd = {"execute": "transaction", "arguments": {"actions": []}}
         for key in self.config[guest_name]:
             if key.startswith("drive_"):
-                drive = key[key.index('_')+1:]
+                drive = key[len('drive_'):]
                 target = self.config[guest_name][key]
                 sub_cmd = {"type": "drive-backup", "data": {"device": drive,
                                                             "target": target,
                                                             "sync": "full"}}
                 cmd['arguments']['actions'].append(sub_cmd)
-        print (connection.cmd_obj(cmd))
+        connection.cmd_obj(cmd)
+        if connection.pull_event(wait=True)['event'] == 'BLOCK_JOB_COMPLETED':
+            print("Backup Complete")
+        else:
+            print("Cannot complete backup", file=sys.stderr)
 
-    def __drive_add(self, drive_id, guest_name, target=None):
+    def _drive_add(self, drive_id, guest_name, target=None):
         """
         Adds drive for backup
         """
         if target is None:
-            target = os.path.abspath(drive_id) + ".img"
+            target = os.path.abspath(drive_id)
 
         if guest_name not in self.config.sections():
-            print ("Cannot find specified guest")
-            return
+            print ("Cannot find specified guest", file=sys.stderr)
+            exit(1)
 
         if "drive_"+drive_id in self.config[guest_name]:
-            print ("Drive already marked for backup")
-            return
+            print ("Drive already marked for backup", file=sys.stderr)
+            exit(1)
 
-        if self.is_guest_running(guest_name, self.config[guest_name]['qmp'],
-                                 self.config[guest_name]['tcp']) is False:
-            return
+        self.verify_guest_running(guest_name)
 
         connection = QEMUMonitorProtocol(
-                                         self.get_socket_path(
-                                             self.config[guest_name]['qmp'],
-                                             self.config[guest_name]['tcp']))
+                                         self.get_socket_address(
+                                             self.config[guest_name]['qmp']))
         connection.connect()
         cmd = {'execute': 'query-block'}
         returned_json = connection.cmd_obj(cmd)
@@ -93,69 +129,93 @@ class BackupTool(object):
                 device_present = True
                 break
 
-        if device_present is False:
-            print ("No such drive in guest")
-            return
+        if not device_present:
+            print ("No such drive in guest", file=sys.stderr)
+            sys.exit(1)
 
         drive_id = "drive_" + drive_id
-        for id in self.config[guest_name]:
-            if self.config[guest_name][id] == target:
-                print ("Please choose different target")
-                return
+        for d_id in self.config[guest_name]:
+            if self.config[guest_name][d_id] == target:
+                print ("Please choose different target", file=sys.stderr)
+                exit(1)
         self.config.set(guest_name, drive_id, target)
         self.write_config()
         print("Successfully Added Drive")
 
-    def is_guest_running(self, guest_name, socket_path, tcp):
+    def verify_guest_running(self, guest_name):
         """
         Checks whether specified guest is running or not
         """
+        socket_address = self.config.get(guest_name, 'qmp')
         try:
-            connection = QEMUMonitorProtocol(
-                                             self.get_socket_path(
-                                                  socket_path, tcp))
+            connection = QEMUMonitorProtocol(self.get_socket_address(
+                                             socket_address))
             connection.connect()
         except socket_error:
             if socket_error.errno != errno.ECONNREFUSED:
-                print ("Connection to guest refused")
-            return False
-        except:
-            print ("Unable to connect to guest")
-            return False
-        return True
+                print ("Connection to guest refused", file=sys.stderr)
+                sys.exit(1)
 
-    def __guest_add(self, guest_name, socket_path, tcp):
+    def _guest_add(self, guest_name, socket_address):
         """
         Adds a guest to the config file
         """
-        if self.is_guest_running(guest_name, socket_path, tcp) is False:
-            return
-
         if guest_name in self.config.sections():
-            print ("ID already exists. Please choose a different guestname")
-            return
-
-        self.config[guest_name] = {'qmp': socket_path}
-        self.config.set(guest_name, 'tcp', str(tcp))
+            print ("ID already exists. Please choose a different guestname",
+                   file=sys.stderr)
+            sys.exit(1)
+        self.config[guest_name] = {'qmp': socket_address}
+        self.verify_guest_running(guest_name)
         self.write_config()
         print("Successfully Added Guest")
 
-    def __guest_remove(self, guest_name):
+    def _guest_remove(self, guest_name):
         """
         Removes a guest from config file
         """
         if guest_name not in self.config.sections():
-            print("Guest Not present")
-            return
+            print("Guest Not present", file=sys.stderr)
+            sys.exit(1)
         self.config.remove_section(guest_name)
         print("Guest successfully deleted")
 
+    def _restore(self, guest_name):
+        """
+        Prints Steps to perform restore operation
+        """
+        if guest_name not in self.config.sections():
+            print ("Cannot find specified guest", file=sys.stderr)
+            exit(1)
+
+        self.verify_guest_running(guest_name)
+        connection = QEMUMonitorProtocol(
+                                         self.get_socket_address(
+                                             self.config[guest_name]['qmp']))
+        connection.connect()
+        print("To perform restore, replace:")
+        for key in self.config[guest_name]:
+            if key.startswith("drive_"):
+                drive = key[len('drive_'):]
+                target = self.config[guest_name][key]
+                cmd = {'execute': 'query-block'}
+                returned_json = connection.cmd_obj(cmd)
+                device_present = False
+                for device in returned_json['return']:
+                    if device['device'] == drive:
+                        device_present = True
+                        location = device['inserted']['image']['filename']
+                        print(location+" By "+target)
+
+                if not device_present:
+                    print ("No such drive in guest", file=sys.stderr)
+                    sys.exit(1)
+
     def guest_remove_wrapper(self, args):
         """
-        Wrapper for __guest_remove method.
+        Wrapper for _guest_remove method.
         """
         guest_name = args.guest
-        self.__guest_remove(guest_name)
+        self._guest_remove(guest_name)
         self.write_config()
 
     def list(self, args):
@@ -167,24 +227,27 @@ class BackupTool(object):
 
     def guest_add_wrapper(self, args):
         """
-        Wrapper for __quest_add method
+        Wrapper for _quest_add method
         """
-        if args.tcp is False:
-            self.__guest_add(args.guest, args.qmp, False)
-        else:
-            self.__guest_add(args.guest, args.qmp, True)
+        self._guest_add(args.guest, args.qmp)
 
     def drive_add_wrapper(self, args):
         """
-        Wrapper for __drive_add method
+        Wrapper for _drive_add method
         """
-        self.__drive_add(args.id, args.guest, args.target)
+        self._drive_add(args.id, args.guest, args.target)
 
     def fullbackup_wrapper(self, args):
         """
-        Wrapper for __full_backup method
+        Wrapper for _full_backup method
         """
-        self.__full_backup(args.guest)
+        self._full_backup(args.guest)
+
+    def restore_wrapper(self, args):
+        """
+        Wrapper for restore
+        """
+        self._restore(args.guest)
 
 
 def main():
@@ -205,9 +268,6 @@ def main():
                                   help='Name of the guest')
     guest_add_parser.add_argument('--qmp', action='store', type=str,
                                   help='Path of socket')
-    guest_add_parser.add_argument('--tcp', nargs='?', type=bool,
-                                  default=False,
-                                  help='Specify if socket is tcp')
     guest_add_parser.set_defaults(func=backup_tool.guest_add_wrapper)
 
     guest_remove_parser = guest_subparsers.add_parser('remove',
@@ -237,6 +297,11 @@ def main():
                                type=str, help='Name of the guest')
     backup_parser.set_defaults(func=backup_tool.fullbackup_wrapper)
 
+    backup_parser = subparsers.add_parser('restore', help='Restores drives')
+    backup_parser.add_argument('--guest', action='store',
+                               type=str, help='Name of the guest')
+    backup_parser.set_defaults(func=backup_tool.restore_wrapper)
+
     args = parser.parse_args()
     args.func(args)
 
-- 
2.7.4
