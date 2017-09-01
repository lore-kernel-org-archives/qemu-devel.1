Received: from eggs.gnu.org ([2001:4830:134:3::10]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnuis-0003UD-Aj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 18:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnuil-00048F-Vf
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 18:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dnuil-000478-L3
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 18:47:27 -0400
References: <1504113297-22052-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504113297-22052-2-git-send-email-chugh.ishani@research.iiit.ac.in>
From: John Snow <jsnow@redhat.com>
Message-ID: <db264166-9b9f-31ac-321e-8436d7ae0354@redhat.com>
Date: Fri, 1 Sep 2017 18:47:20 -0400
MIME-Version: 1.0
In-Reply-To: <1504113297-22052-2-git-send-email-chugh.ishani@research.iiit.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] backup: QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

I suggest as your commit message here, something like:

"backup: Add QEMU backup tool"

A good commit message should say what applying the patch will do:

"What will happen if I apply this patch?"
"It will 'Add QEMU backup tool'"

On 08/30/2017 01:14 PM, Ishani Chugh wrote:
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action. The tool writes details of
> guest in a configuration file and the data is retrieved from the file
> while creating a backup. The location of config file can be set as an
> environment variable QEMU_BACKUP_CONFIG. The usage is as follows:
> 
> Add a guest
> python qemu-backup.py guest add --guest <guest_name> --qmp <socket_path>
> 

This should probably be organized by subcommand, so:

guest add
guest remove
guest list

drive add

backup

restore


> Add a drive for backup in a specified guest
> python qemu-backup.py drive add --guest <guest_name> --id <drive_id> [--target <target_file_path>]
> 
> Create backup of the added drives:
> python qemu-backup.py backup --guest <guest_name>
> 
> List all guest configs in configuration file:
> python qemu-backup.py guest list
> 
> Restore operation
> python qemu-backup.py restore --guest <guest-name>
> 
> Remove a guest
> python qemu-backup.py guest remove --guest <guest_name>
> 

Looks good, but the man page should perhaps be patch 01 instead of 03 so
that the usage can be reviewed outside of the commit message.

> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  contrib/backup/qemu-backup.py | 343 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 343 insertions(+)
>  create mode 100644 contrib/backup/qemu-backup.py
> 
> diff --git a/contrib/backup/qemu-backup.py b/contrib/backup/qemu-backup.py
> new file mode 100644
> index 0000000..248ca9f
> --- /dev/null
> +++ b/contrib/backup/qemu-backup.py
> @@ -0,0 +1,343 @@
> +#!/usr/bin/python
> +# -*- coding: utf-8 -*-
> +#
> +# Copyright (C) 2017 Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +"""
> +This file is an implementation of backup tool
> +"""
> +from __future__ import print_function
> +from argparse import ArgumentParser
> +import os
> +import errno
> +from socket import error as socket_error
> +try:
> +    import configparser
> +except ImportError:
> +    import ConfigParser as configparser
> +import sys
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..',
> +                             'scripts', 'qmp'))
> +from qmp import QEMUMonitorProtocol
> +
> +
> +class BackupTool(object):
> +    """BackupTool Class"""
> +    def __init__(self, config_file=os.path.expanduser('~') +
> +                 '/.config/qemu/qemu-backup-config'):
> +        if "QEMU_BACKUP_CONFIG" in os.environ:
> +            self.config_file = os.environ["QEMU_BACKUP_CONFIG"]
> +
> +        else:
> +            self.config_file = config_file
> +            try:
> +                if not os.path.isdir(os.path.dirname(self.config_file)):
> +                    os.makedirs(os.path.dirname(self.config_file))
> +            except:
> +                print("Cannot create config directory", file=sys.stderr)
> +                sys.exit(1)
> +        self.config = configparser.ConfigParser()
> +        self.config.read(self.config_file)
> +        try:
> +            if self.config.get('general', 'version') != '1.0':
> +                    print("Version Conflict in config file", file=sys.stderr)
> +                    sys.exit(1)
> +        except:
> +            self.config['general'] = {'version': '1.0'}
> +            self.write_config()
> +
> +    def write_config(self):
> +        """
> +        Writes configuration to ini file.
> +        """
> +        config_file = open(self.config_file + ".tmp", 'w')
> +        self.config.write(config_file)
> +        config_file.flush()
> +        os.fsync(config_file.fileno())
> +        config_file.close()
> +        os.rename(self.config_file + ".tmp", self.config_file)
> +
> +    def get_socket_address(self, socket_address):
> +        """
> +        Return Socket address in form of string or tuple
> +        """
> +        if socket_address.startswith('tcp'):
> +            return (socket_address.split(':')[1],
> +                    int(socket_address.split(':')[2]))
> +        return socket_address.split(':', 2)[1]
> +
> +    def _full_backup(self, guest_name):
> +        """
> +        Performs full backup of guest
> +        """
> +        if guest_name not in self.config.sections():
> +            print("Cannot find specified guest", file=sys.stderr)
> +            sys.exit(1)
> +
> +        self.verify_guest_running(guest_name)
> +        connection = QEMUMonitorProtocol(
> +                                         self.get_socket_address(
> +                                             self.config[guest_name]['qmp']))
> +        connection.connect()
> +        cmd = {"execute": "transaction", "arguments": {"actions": []}}
> +        drive_list = []
> +        for key in self.config[guest_name]:
> +            if key.startswith("drive_"):
> +                drive = key[len('drive_'):]
> +                drive_list.append(drive)
> +                target = self.config[guest_name][key]
> +                sub_cmd = {"type": "drive-backup", "data": {"device": drive,
> +                                                            "target": target,
> +                                                            "sync": "full"}}
> +                cmd['arguments']['actions'].append(sub_cmd)
> +        qmp_return = connection.cmd_obj(cmd)
> +        if 'error' in qmp_return:
> +            print(qmp_return['error']['desc'], file=sys.stderr)
> +            sys.exit(1)
> +        print("Backup Started")
> +        while drive_list:
> +            event = connection.pull_event(wait=True)
> +            if event['event'] == 'SHUTDOWN':
> +                print("The guest was SHUT DOWN", file=sys.stderr)
> +                sys.exit(1)
> +
> +            if event['event'] == 'BLOCK_JOB_COMPLETED':
> +                if event['data']['device'] in drive_list and \
> +                        event['data']['type'] == 'backup':
> +                        print("*" + event['data']['device'])
> +                        drive_list.remove(event['data']['device'])
> +
> +            if event['event'] == 'BLOCK_JOB_ERROR':
> +                if event['data']['device'] in drive_list and \
> +                        event['data']['type'] == 'backup':
> +                        print(event['data']['device'] + " Backup Failed",
> +                              file=sys.stderr)
> +                        drive_list.remove(event['data']['device'])
> +        print("Backup Complete")
> +
> +    def _drive_add(self, drive_id, guest_name, target=None):
> +        """
> +        Adds drive for backup
> +        """
> +        if target is None:
> +            target = os.path.abspath(drive_id)

Similar problem as with other commands:

jhuston@probe (review) ~/s/q/c/backup> ./qemu-backup.py drive add
Traceback (most recent call last):
  File "./qemu-backup.py", line 343, in <module>
    main()
  File "./qemu-backup.py", line 340, in main
    args.func(args)
  File "./qemu-backup.py", line 272, in drive_add_wrapper
    self._drive_add(args.id, args.guest, args.target)
  File "./qemu-backup.py", line 137, in _drive_add
    target = os.path.abspath(drive_id)
  File "/usr/lib64/python2.7/posixpath.py", line 360, in abspath
    if not isabs(path):
  File "/usr/lib64/python2.7/posixpath.py", line 54, in isabs
    return s.startswith('/')
AttributeError: 'NoneType' object has no attribute 'startswith'

This errors out if you don't tell it what drive you want to add.


Meanwhile,

jhuston@probe (review) ~/s/q/c/backup> ./qemu-backup.py drive add --id
foobar
Cannot find specified guest

Should probably error out because you didn't set the guest name at all.

> +
> +        if os.path.isdir(os.path.dirname(target)) is False:
> +            print("Cannot find target directory", file=sys.stderr)
> +            sys.exit(1)
> +
> +        if guest_name not in self.config.sections():
> +            print("Cannot find specified guest", file=sys.stderr)
> +            sys.exit(1)
> +
> +        if "drive_" + drive_id in self.config[guest_name]:
> +            print("Drive already marked for backup", file=sys.stderr)
> +            sys.exit(1)
> +
> +        self.verify_guest_running(guest_name)
> +
> +        connection = QEMUMonitorProtocol(
> +                                         self.get_socket_address(
> +                                             self.config[guest_name]['qmp']))
> +        connection.connect()
> +        cmd = {'execute': 'query-block'}
> +        returned_json = connection.cmd_obj(cmd)
> +        device_present = False
> +        for device in returned_json['return']:
> +            if device['device'] == drive_id:
> +                device_present = True
> +                break
> +
> +        if not device_present:
> +            print("No such drive in guest", file=sys.stderr)
> +            sys.exit(1)

cool!

> +
> +        drive_id = "drive_" + drive_id
> +        for d_id in self.config[guest_name]:
> +            if self.config[guest_name][d_id] == target:
> +                print("Please choose different target", file=sys.stderr)
> +                sys.exit(1)
> +        self.config.set(guest_name, drive_id, target)
> +        self.write_config()
> +        print("Successfully Added Drive")
> +
> +    def verify_guest_running(self, guest_name):
> +        """
> +        Checks whether specified guest is running or not
> +        """
> +        socket_address = self.config.get(guest_name, 'qmp')> +        try:
> +            connection = QEMUMonitorProtocol(self.get_socket_address(
> +                                             socket_address))
> +            connection.connect()
> +        except socket_error:
> +            if socket_error.errno != errno.ECONNREFUSED:

what happens if errno *IS* ECONNREFUSED?

> +                print("Connection to guest refused", file=sys.stderr)
> +                sys.exit(1)
> +
> +    def _guest_add(self, guest_name, socket_address):
> +        """
> +        Adds a guest to the config file
> +        """
> +        if guest_name in self.config.sections():
> +            print("ID already exists. Please choose a different guest name",
> +                  file=sys.stderr)
> +            sys.exit(1)
> +        self.config[guest_name] = {'qmp': socket_address}
> +        self.verify_guest_running(guest_name)
> +        self.write_config()
> +        print("Successfully Added Guest")

this function crashes if you do not provide a guest_name, it should
report an error instead.

./qemu-backup.py guest add
./qemu-backup.py guest add --guest foobar

both crash, please correct.

./qemu-backup.py guest add --guest foobar --qmp foobar

also crashes, please error gracefully if you cannot parse the QMP
argument as a valid socket.

> +
> +    def _guest_remove(self, guest_name):
> +        """
> +        Removes a guest from config file
> +        """
> +        if guest_name not in self.config.sections():
> +            print("Guest Not present", file=sys.stderr)
> +            sys.exit(1)
> +        self.config.remove_section(guest_name)
> +        print("Guest successfully deleted")
> +

If you don't supply a guest name, you get the "Guest Not present" error
message, but really we should error out as if it was a parsing error.

jhuston@probe (review) ~/s/q/c/backup> ./qemu-backup.py guest remove
--guest general
Guest successfully deleted

Whoops!

> +    def _restore(self, guest_name):
> +        """
> +        Prints Steps to perform restore operation
> +        """
> +        if guest_name not in self.config.sections():
> +            print("Cannot find specified guest", file=sys.stderr)
> +            sys.exit(1)
> +
> +        self.verify_guest_running(guest_name)
> +        connection = QEMUMonitorProtocol(
> +                                         self.get_socket_address(
> +                                             self.config[guest_name]['qmp']))
> +        connection.connect()
> +        print("To perform restore:")
> +        print("Shut down guest")
> +        for key in self.config[guest_name]:
> +            if key.startswith("drive_"):
> +                drive = key[len('drive_'):]
> +                target = self.config[guest_name][key]
> +                cmd = {'execute': 'query-block'}
> +                returned_json = connection.cmd_obj(cmd)
> +                device_present = False
> +                for device in returned_json['return']:
> +                    if device['device'] == drive:
> +                        device_present = True
> +                        location = device['inserted']['image']['filename']
> +                        print("qemu-img convert " + target + " " + location)
> +
> +                if not device_present:
> +                    print("No such drive in guest", file=sys.stderr)
> +                    sys.exit(1)
> +
> +    def guest_remove_wrapper(self, args):
> +        """
> +        Wrapper for _guest_remove method.
> +        """
> +        guest_name = args.guest
> +        self._guest_remove(guest_name)
> +        self.write_config()
> +
> +    def list(self, args):
> +        """
> +        Prints guests present in Config file
> +        """
> +        for guest_name in self.config.sections():
> +            print(guest_name)

This will print out "general" too, which I think should be exempted from
this list, as it is not actually a guest!

I propose something like this:

[general]
guests=ishanivm1 ishanivm2 ishanivm3

[guest:ishanivm]
foo=bar

[guest:ishanivm2]
foo=bar2

and so on.

("What happens if someone tries to name a guest 'guest:foobar'? Well,
then the section just gets named 'guest:guest:foobar' and we go about
our happy way.")

Whenever a guest is added or removed, you update the list and delete or
add the corresponding section appropriately.

> +
> +    def guest_add_wrapper(self, args):
> +        """
> +        Wrapper for _quest_add method

s/quest/guest/

> +        """
> +        self._guest_add(args.guest, args.qmp)
> +> +    def drive_add_wrapper(self, args):
> +        """
> +        Wrapper for _drive_add method
> +        """
> +        self._drive_add(args.id, args.guest, args.target)
> +
> +    def fullbackup_wrapper(self, args):
> +        """
> +        Wrapper for _full_backup method
> +        """
> +        self._full_backup(args.guest)
> +
> +    def restore_wrapper(self, args):
> +        """
> +        Wrapper for restore
> +        """
> +        self._restore(args.guest)
> +
> +
> +def main():
> +    backup_tool = BackupTool()
> +    parser = ArgumentParser()

The following is a pretty big block without much visual structure to
guide the eye. I'd recommend:

(1) Splitting this out into a helper function so the overall flow of
main() is easier to spot at a glance, and
(2) Adding a few comments to just visually break up the monotony.

> +    subparsers = parser.add_subparsers(title='Subcommands',
> +                                       description='Valid Subcommands',
> +                                       help='Subcommand help')       # guest
> +    guest_parser = subparsers.add_parser('guest', help='Adds or \
> +                                                   removes and lists guest(s)')

Try "Manage guest(s)" as a shorthand, or just write "add, remove, or
list guests."

"Adds (or) removes (and) lists" is an awkward construct.

> +    guest_subparsers = guest_parser.add_subparsers(title='Guest Subparser')
       # guest list
> +    guest_list_parser = guest_subparsers.add_parser('list',
> +                                                    help='Lists all guests')
> +    guest_list_parser.set_defaults(func=backup_tool.list)
> +
       # guest add
> +    guest_add_parser = guest_subparsers.add_parser('add', help='Adds a guest')
> +    guest_add_parser.add_argument('--guest', action='store', type=str,
> +                                  help='Name of the guest')
> +    guest_add_parser.add_argument('--qmp', action='store', type=str,
> +                                  help='Path of socket')
> +    guest_add_parser.set_defaults(func=backup_tool.guest_add_wrapper)
> +
       # guest remove
> +    guest_remove_parser = guest_subparsers.add_parser('remove',
> +                                                      help='removes a guest')
> +    guest_remove_parser.add_argument('--guest', action='store', type=str,
> +                                     help='Name of the guest')
> +    guest_remove_parser.set_defaults(func=backup_tool.guest_remove_wrapper)
> +
       # drive
> +    drive_parser = subparsers.add_parser('drive',
> +                                         help='Adds drive(s) for backup')
> +    drive_subparsers = drive_parser.add_subparsers(title='Add subparser',
> +                                                   description='Drive \
> +                                                                subparser')
       # drive add
> +    drive_add_parser = drive_subparsers.add_parser('add',
> +                                                   help='Adds new \
> +                                                         drive for backup')
> +    drive_add_parser.add_argument('--guest', action='store',
> +                                  type=str, help='Name of the guest')
> +    drive_add_parser.add_argument('--id', action='store',
> +                                  type=str, help='Drive ID')
> +    drive_add_parser.add_argument('--target', nargs='?',
> +                                  default=None, help='Destination path')
> +    drive_add_parser.set_defaults(func=backup_tool.drive_add_wrapper)
> +
       # backup
> +    backup_parser = subparsers.add_parser('backup', help='Creates backup')
> +    backup_parser.add_argument('--guest', action='store',
> +                               type=str, help='Name of the guest')
> +    backup_parser.set_defaults(func=backup_tool.fullbackup_wrapper)
> +
       # restore
> +    backup_parser = subparsers.add_parser('restore', help='Restores drives')
> +    backup_parser.add_argument('--guest', action='store',
> +                               type=str, help='Name of the guest')
> +    backup_parser.set_defaults(func=backup_tool.restore_wrapper)
> +

maybe something like:
       parser = buildMyParser()

?

> +    args = parser.parse_args()
> +    args.func(args)
> +
> +if __name__ == '__main__':
> +    main()
> 

Looking good overall; my advice is to try testing your tool by
intentionally omitting items and giving it bad information. Make sure
that any arguments marked as mandatory in the manpage/parser are
actually mandatory and try to eliminate stack trace dumps from your
python tool.

I stopped a little short of reviewing the entire tool this time, so
there may be more cases that are similar to the other issues I've
already pointed out.

Thanks!
