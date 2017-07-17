Received: from eggs.gnu.org ([2001:4830:134:3::10]:46215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dX0Ir-0001iz-Ly
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dX0Io-0007oj-Bd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:18:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dX0Io-0007oT-27
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:18:46 -0400
Date: Mon, 17 Jul 2017 15:18:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170717071835.GD22872@lemon>
References: <1500151401-30863-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500151401-30863-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [RFC] RFC on Backup tool
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

On Sun, 07/16 02:13, Ishani Chugh wrote:
> This is a Request For Comments patch for qemu backup tool. As an
> Outreachy intern, I am assigned to the project for creating a backup
> tool. qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. 

Only full backup is implemented in this patch, is the plan to add incremental
backup on top?  I'm curious because you have target file path set during drive
add, but in the incremental case, it should be possible that each backup creates
a new target file that chains up with earlier ones, so I think the target file
should be an option for "backup" command as well.

> It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action. The tool writes details of
> guest in a configuration file and the data is retrieved from the file
> while creating a backup. The usage is as follows:
> Add a guest
> python qemu-backup.py guest add --guest <guest_name> --qmp <socket_path> [--tcp]
> 
> Add a drive for backup in a specified guest
> python qemu-backup.py drive add --guest <guest_name> --id <drive_id> [--target <target_file_path>]
> 
> Create backup of the added drives:
> python qemu-backup.py backup --guest <guest_name>
> 
> List all guest configs in configuration file:
> python qemu-backup.py guest list

Please put these examples into the help output of the command, this way users
can read it as well.

> 
> I will be obliged by any feedback.

Thanks for doing this!

> 
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  contrib/backup/qemu-backup.py | 244 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 244 insertions(+)
>  create mode 100644 contrib/backup/qemu-backup.py
> 
> diff --git a/contrib/backup/qemu-backup.py b/contrib/backup/qemu-backup.py
> new file mode 100644
> index 0000000..9c3dc53
> --- /dev/null
> +++ b/contrib/backup/qemu-backup.py
> @@ -0,0 +1,244 @@
> +#!/usr/bin/python
> +# -*- coding: utf-8 -*-

You need a copyright header here (the default choice for QEMU is GPLv2 but there
is no strict restrictions for scripts). See examples in other *.py files.

> +"""
> +This file is an implementation of backup tool
> +"""
> +from argparse import ArgumentParser
> +import os
> +import errno
> +from socket import error as socket_error
> +import configparser

Python2 has ConfigParser while python3 has configparser. Please be specific
about the python compatibility level of this script - my system (Fedora) has
python2 as /usr/bin/python, so the shebang and your example command in the
commit message don't really work. "six" module can handle python 2/3
differentiations, or you can use '#!/usr/bin/env python2' to specify a python
version explicitly.

> +import sys
> +sys.path.append('../../scripts/qmp')

This expects the script to be invoked from its local directory? It's better to
use the __file__ trick to allow arbitrary workdir:

$ git grep __file__
scripts/device-crash-test:sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'scripts'))
scripts/qemu-gdb.py:sys.path.append(os.path.dirname(__file__))
tests/migration/guestperf/engine.py:sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', '..', 'scripts'))
tests/qemu-iotests/iotests.py:sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))

> +from qmp import QEMUMonitorProtocol
> +
> +
> +class BackupTool(object):
> +    """BackupTool Class"""
> +    def __init__(self, config_file='backup.ini'):

Is it better to put this in a more predictable place such as
"$HOME/.qemu-backup.ini" and/or make it a command line option?

> +        self.config_file = config_file
> +        self.config = configparser.ConfigParser()
> +        self.config.read(self.config_file)
> +
> +    def write_config(self):
> +        """
> +        Writes configuration to ini file.
> +        """
> +        with open(self.config_file, 'w') as config_file:
> +            self.config.write(config_file)
> +
> +    def get_socket_path(self, socket_path, tcp):
> +        """
> +        Return Socket address in form of string or tuple
> +        """
> +        if tcp is False:
> +            return os.path.abspath(socket_path)
> +        return (socket_path.split(':')[0], int(socket_path.split(':')[1]))
> +
> +    def __full_backup(self, guest_name):

I think double underscore attributes are special:

https://www.python.org/dev/peps/pep-0008/#id47

If it's not intended, perhaps it's enough to just stick to one "_". The same
applies to a few more below.

> +        """
> +        Performs full backup of guest
> +        """
> +        if guest_name not in self.config.sections():
> +            print ("Cannot find specified guest")
> +            return
> +        if self.is_guest_running(guest_name, self.config[guest_name]['qmp'],
> +                                 self.config[guest_name]['tcp']) is False:
> +            return
> +        connection = QEMUMonitorProtocol(
> +                                         self.get_socket_path(
> +                                             self.config[guest_name]['qmp'],
> +                                             self.config[guest_name]['tcp']))
> +        connection.connect()
> +        cmd = {"execute": "transaction", "arguments": {"actions": []}}
> +        for key in self.config[guest_name]:
> +            if key.startswith("drive_"):
> +                drive = key[key.index('_')+1:]
> +                target = self.config[guest_name][key]
> +                sub_cmd = {"type": "drive-backup", "data": {"device": drive,
> +                                                            "target": target,
> +                                                            "sync": "full"}}
> +                cmd['arguments']['actions'].append(sub_cmd)
> +        print (connection.cmd_obj(cmd))
> +
> +    def __drive_add(self, drive_id, guest_name, target=None):
> +        """
> +        Adds drive for backup
> +        """
> +        if target is None:
> +            target = os.path.abspath(drive_id) + ".img"
> +
> +        if guest_name not in self.config.sections():
> +            print ("Cannot find specified guest")

Error messages should go to stderr.

> +            return
> +
> +        if "drive_"+drive_id in self.config[guest_name]:

Whitespace around "+"?

> +            print ("Drive already marked for backup")
> +            return
> +
> +        if self.is_guest_running(guest_name, self.config[guest_name]['qmp'],
> +                                 self.config[guest_name]['tcp']) is False:
> +            return
> +
> +        connection = QEMUMonitorProtocol(
> +                                         self.get_socket_path(
> +                                             self.config[guest_name]['qmp'],
> +                                             self.config[guest_name]['tcp']))
> +        connection.connect()
> +        cmd = {'execute': 'query-block'}
> +        returned_json = connection.cmd_obj(cmd)
> +        device_present = False
> +        for device in returned_json['return']:
> +            if device['device'] == drive_id:
> +                device_present = True
> +                break
> +
> +        if device_present is False:
> +            print ("No such drive in guest")
> +            return
> +
> +        drive_id = "drive_" + drive_id
> +        for id in self.config[guest_name]:

I think id is a python built-in function, please avoid using it as variable
name.

> +            if self.config[guest_name][id] == target:
> +                print ("Please choose different target")
> +                return
> +        self.config.set(guest_name, drive_id, target)
> +        self.write_config()
> +        print("Successfully Added Drive")
> +
> +    def is_guest_running(self, guest_name, socket_path, tcp):
> +        """
> +        Checks whether specified guest is running or not
> +        """
> +        try:
> +            connection = QEMUMonitorProtocol(
> +                                             self.get_socket_path(
> +                                                  socket_path, tcp))
> +            connection.connect()
> +        except socket_error:
> +            if socket_error.errno != errno.ECONNREFUSED:
> +                print ("Connection to guest refused")
> +            return False
> +        except:
> +            print ("Unable to connect to guest")
> +            return False
> +        return True
> +
> +    def __guest_add(self, guest_name, socket_path, tcp):
> +        """
> +        Adds a guest to the config file
> +        """
> +        if self.is_guest_running(guest_name, socket_path, tcp) is False:
> +            return
> +
> +        if guest_name in self.config.sections():
> +            print ("ID already exists. Please choose a different guestname")

"guest name".

> +            return
> +
> +        self.config[guest_name] = {'qmp': socket_path}
> +        self.config.set(guest_name, 'tcp', str(tcp))
> +        self.write_config()
> +        print("Successfully Added Guest")
> +
> +    def __guest_remove(self, guest_name):
> +        """
> +        Removes a guest from config file
> +        """
> +        if guest_name not in self.config.sections():
> +            print("Guest Not present")
> +            return
> +        self.config.remove_section(guest_name)
> +        print("Guest successfully deleted")
> +
> +    def guest_remove_wrapper(self, args):
> +        """
> +        Wrapper for __guest_remove method.
> +        """
> +        guest_name = args.guest
> +        self.__guest_remove(guest_name)
> +        self.write_config()
> +
> +    def list(self, args):
> +        """
> +        Prints guests present in Config file
> +        """
> +        for guest_name in self.config.sections():
> +            print(guest_name)
> +
> +    def guest_add_wrapper(self, args):
> +        """
> +        Wrapper for __quest_add method
> +        """
> +        if args.tcp is False:
> +            self.__guest_add(args.guest, args.qmp, False)
> +        else:
> +            self.__guest_add(args.guest, args.qmp, True)
> +
> +    def drive_add_wrapper(self, args):
> +        """
> +        Wrapper for __drive_add method
> +        """
> +        self.__drive_add(args.id, args.guest, args.target)
> +
> +    def fullbackup_wrapper(self, args):
> +        """
> +        Wrapper for __full_backup method
> +        """
> +        self.__full_backup(args.guest)
> +
> +
> +def main():
> +    backup_tool = BackupTool()
> +    parser = ArgumentParser()
> +    subparsers = parser.add_subparsers(title='Subcommands',
> +                                       description='Valid Subcommands',
> +                                       help='Subcommand help')
> +    guest_parser = subparsers.add_parser('guest', help='Adds or \
> +                                                   removes and lists guest(s)')
> +    guest_subparsers = guest_parser.add_subparsers(title='Guest Subparser')
> +    guest_list_parser = guest_subparsers.add_parser('list',
> +                                                    help='Lists all guests')
> +    guest_list_parser.set_defaults(func=backup_tool.list)
> +
> +    guest_add_parser = guest_subparsers.add_parser('add', help='Adds a guest')
> +    guest_add_parser.add_argument('--guest', action='store', type=str,
> +                                  help='Name of the guest')
> +    guest_add_parser.add_argument('--qmp', action='store', type=str,
> +                                  help='Path of socket')
> +    guest_add_parser.add_argument('--tcp', nargs='?', type=bool,
> +                                  default=False,
> +                                  help='Specify if socket is tcp')
> +    guest_add_parser.set_defaults(func=backup_tool.guest_add_wrapper)
> +
> +    guest_remove_parser = guest_subparsers.add_parser('remove',
> +                                                      help='removes a guest')
> +    guest_remove_parser.add_argument('--guest', action='store', type=str,
> +                                     help='Name of the guest')
> +    guest_remove_parser.set_defaults(func=backup_tool.guest_remove_wrapper)
> +
> +    drive_parser = subparsers.add_parser('drive',
> +                                         help='Adds drive(s) for backup')
> +    drive_subparsers = drive_parser.add_subparsers(title='Add subparser',
> +                                                   description='Drive \
> +                                                                subparser')
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
> +    backup_parser = subparsers.add_parser('backup', help='Creates backup')
> +    backup_parser.add_argument('--guest', action='store',
> +                               type=str, help='Name of the guest')
> +    backup_parser.set_defaults(func=backup_tool.fullbackup_wrapper)
> +
> +    args = parser.parse_args()
> +    args.func(args)

All exit points should report a status code (zero for success and non-zero for
failures). This way the user or upper layer software know if backup has
succeeded.

> +
> +if __name__ == '__main__':
> +    main()
> -- 

Nice patch, thanks!

Fam
