Received: from eggs.gnu.org ([2001:4830:134:3::10]:34241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnEj7-0002ST-G5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnEj2-0004Mb-Rk
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnEj2-0004MU-Gh
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:56:56 -0400
Date: Thu, 31 Aug 2017 09:56:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831015647.GD17741@lemon.lan>
References: <1504120538-9309-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504120538-9309-3-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504120538-9309-3-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH 2/3] Backup Tool: Support for Incremental
 Backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, stefanha@redhat.com

On Thu, 08/31 00:45, Ishani Chugh wrote:
> Adds incremental backup functionality.
> 
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  contrib/backup/qemu-backup.py | 101 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/backup/qemu-backup.py b/contrib/backup/qemu-backup.py
> index 248ca9f..7a3077a 100644
> --- a/contrib/backup/qemu-backup.py
> +++ b/contrib/backup/qemu-backup.py
> @@ -24,11 +24,13 @@ from __future__ import print_function
>  from argparse import ArgumentParser
>  import os
>  import errno
> +from string import Template
>  from socket import error as socket_error
>  try:
>      import configparser
>  except ImportError:
>      import ConfigParser as configparser
> +from configparser import NoOptionError
>  import sys
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..',
>                               'scripts', 'qmp'))
> @@ -41,7 +43,6 @@ class BackupTool(object):
>                   '/.config/qemu/qemu-backup-config'):
>          if "QEMU_BACKUP_CONFIG" in os.environ:
>              self.config_file = os.environ["QEMU_BACKUP_CONFIG"]
> -
>          else:
>              self.config_file = config_file
>              try:
> @@ -129,6 +130,97 @@ class BackupTool(object):
>                          drive_list.remove(event['data']['device'])
>          print("Backup Complete")
>  
> +    def _inc_backup(self, guest_name):
> +        """
> +        Performs Incremental backup
> +        """
> +        if guest_name not in self.config.sections():
> +            print ("Cannot find specified guest", file=sys.stderr)

s/print (/print(/

> +            exit(1)
> +
> +        self.verify_guest_running(guest_name)
> +        connection = QEMUMonitorProtocol(
> +                                         self.get_socket_address(
> +                                             self.config[guest_name]['qmp']))
> +        connection.connect()
> +        backup_cmd = {"execute": "transaction",
> +                      "arguments": {"actions": [], "properties":
> +                                    {"completion-mode": "grouped"}}}
> +        bitmap_cmd = {"execute": "transaction", "arguments": {"actions": []}}
> +        for key in self.config[guest_name]:

>From here on the indentation level is launched straight into outer space. Please
either extract code blocks into functions, or at least try to rearrange it like:

> +            if key.startswith("drive_"):

               if not key.startswith("drive_"):
                   continue

               drive = ...
               ...
> +                drive = key[len('drive_'):]
> +                target = self.config.get(guest_name, key).rsplit('/', 1)[0]
> +                inc_backup_pattern = Template('${drive}_inc_${N}')
> +                bitmap = 'qemu_backup_'+guest_name

Whitespaces missing around +.

> +                try:
> +                    query_block_cmd = {'execute': 'query-block'}
> +                    returned_json = connection.cmd_obj(query_block_cmd)
> +                    device_present = False
> +                    for device in returned_json['return']:
> +                        if device['device'] == drive:

                           if device['device'] != drive:
                               continue
                           device_present = True
                           ...
> +                            device_present = True
> +                            bitmap_present = False
> +                            for bitmaps in device['dirty-bitmaps']:
> +                                if bitmap == bitmaps['name']:

                                   if bitmap != bitmaps['name']:
                                       continue
                                   bitmap_present = True
                                   ...
> +                                    bitmap_present = True
> +                                    if os.path.isfile(self.config.get(
> +                                                      guest_name,
> +                                                      'inc_'+drive)) is False:
> +                                        print("Initial Backup does not exist")
> +                                        bitmap_remove = {"execute":
> +                                                         "block-dirty" +
> +                                                         "-bitmap-remove",

Please fix the indentation level and join the string: "block-dirty-bitmap-remove".

Even if you cannot control the indentation level, long line is still better than
cutting it into halves. It makes the code hard to read and unfriendly to grep.

> +                                                         "arguments":
> +                                                         {"node": drive,
> +                                                          "name":
> +                                                          "qemu_backup_" +
> +                                                          guest_name}}
> +                                        connection.cmd_obj(bitmap_remove)
> +                                        bitmap_present = False
> +                            if bitmap_present is False:

Please "don't compare boolean values to True or False using ==", or "is":

s/bitmap_present is False/not bitmap_present/

> +                                raise NoOptionError(guest_name, 'inc_'+drive)
> +                            break
> +
> +                    if not device_present:
> +                        print("No such drive in guest", file=sys.stderr)
> +                        sys.exit(1)
> +                    N = int(self.config.get(guest_name, drive+'_N'))+1
> +                    target = self.config.get(guest_name, key).rsplit(
> +                                                                    '/', 1)[0]\
> +                        + '/' + inc_backup_pattern.substitute(drive=drive, N=N)
> +                    os.system("qemu-img create -f qcow2 " + target + " -b " +
> +                              self.config.get(guest_name, 'inc_' +
> +                                              drive) + " -F qcow2")
> +                    sub_cmd = {"type": "drive-backup",
> +                               "data": {"device": drive, "bitmap": bitmap,
> +                                        "mode": "existing",
> +                                        "sync": "incremental",
> +                                        "target": target}}
> +                    backup_cmd['arguments']['actions'].append(sub_cmd)
> +                    self.config.set(guest_name, drive+'_N',
> +                                    str(int(self.config.get(guest_name,
> +                                                            drive+'_N'))+1))
> +                    self.config.set(guest_name, 'inc_'+drive, target)
> +                except (NoOptionError, KeyError) as e:
> +                    target = self.config.get(guest_name, key).rsplit(
> +                                                                    '/', 1)[0]\
> +                        + '/' + inc_backup_pattern.substitute(drive=drive, N=0)
> +                    sub_cmd_1 = {"type": "block-dirty-bitmap-add",
> +                                 "data": {"node": drive, "name": bitmap,
> +                                          "persistent": True,
> +                                          "autoload": True}}
> +                    sub_cmd_2 = {"type": "drive-backup",
> +                                 "data": {"device": drive, "target": target,
> +                                          "sync": "full", "format": "qcow2"}}
> +                    self.config.set(guest_name, drive+'_N', '0')
> +                    self.config.set(guest_name, 'inc_'+drive, target)
> +                    bitmap_cmd['arguments']['actions'].append(sub_cmd_1)
> +                    bitmap_cmd['arguments']['actions'].append(sub_cmd_2)
> +        connection.cmd_obj(bitmap_cmd)
> +        connection.cmd_obj(backup_cmd)
> +        self.write_config()
> +
>      def _drive_add(self, drive_id, guest_name, target=None):
>          """
>          Adds drive for backup
> @@ -275,7 +367,10 @@ class BackupTool(object):
>          """
>          Wrapper for _full_backup method
>          """
> -        self._full_backup(args.guest)
> +        if args.inc is False:
> +            self._full_backup(args.guest)
> +        else:
> +            self._inc_backup(args.guest)

    if not args.inc:
        self._full_backup(...)
    else:
        ...

>  
>      def restore_wrapper(self, args):
>          """
> @@ -329,6 +424,8 @@ def main():
>      backup_parser = subparsers.add_parser('backup', help='Creates backup')
>      backup_parser.add_argument('--guest', action='store',
>                                 type=str, help='Name of the guest')
> +    backup_parser.add_argument('--inc', nargs='?',
> +                               default=False, help='Destination path')
>      backup_parser.set_defaults(func=backup_tool.fullbackup_wrapper)
>  
>      backup_parser = subparsers.add_parser('restore', help='Restores drives')
> -- 
> 2.7.4
> 
> 
