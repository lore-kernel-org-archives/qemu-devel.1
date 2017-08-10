Received: from eggs.gnu.org ([2001:4830:134:3::10]:39757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfnDG-0005NC-OD
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfnDD-00077c-8r
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:09:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dfnDC-00077C-VB
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:09:19 -0400
Date: Thu, 10 Aug 2017 14:09:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170810130906.GA23806@stefanha-x1.localdomain>
References: <1502307387-19671-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1502307387-19671-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH] QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 01:06:27AM +0530, Ishani Chugh wrote:
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action. The tool writes details of
> guest in a configuration file and the data is retrieved from the file
> while creating a backup. The location of config file can be set as an
> environment variable QEMU_BACKUP_CONFIG. The usage is as follows:
>=20
> Add a guest
> python qemu-backup.py guest add --guest <guest_name> --qmp <socket_path>
>=20
> Add a drive for backup in a specified guest
> python qemu-backup.py drive add --guest <guest_name> --id <drive_id> [--t=
arget <target_file_path>]
>=20
> Create backup of the added drives:
> python qemu-backup.py backup --guest <guest_name>
>=20
> List all guest configs in configuration file:
> python qemu-backup.py guest list
>=20
> Restore operation
> python qemu-backup.py restore --guest <guest-name>
>=20
> Remove a guest
> python qemu-backup.py guest remove --guest <guest_name>
>=20
>=20
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  contrib/backup/qemu-backup.py | 217 +++++++++++++++++++++++++++---------=
------
>  1 file changed, 141 insertions(+), 76 deletions(-)

Hi Ishani,
This patch is a diff that is based on an existing qemu-backup.py file.
The file doesn't exist in qemu.git/master yet so this patch cannot be
applied without the missing file.

Did you mean to send a new patch series consisting of patches for:
1. qemu-backup.py
2. man page
3. test case
?

I suggest using "git rebase -i origin/master" to move your patches onto
the latest qemu.git/master and reorder/squash them into a series of
logical code changes.

> diff --git a/contrib/backup/qemu-backup.py b/contrib/backup/qemu-backup.py
> index 9c3dc53..9bbbdb7 100644
> --- a/contrib/backup/qemu-backup.py
> +++ b/contrib/backup/qemu-backup.py
> @@ -1,22 +1,54 @@
>  #!/usr/bin/python
>  # -*- coding: utf-8 -*-
> +#
> +# Copyright (C) 2013 Red Hat, Inc.

Feel free to add your copyright:

  Copyright (C) 2017 Ishani Chugh <chugh.ishani@research.iiit.ac.in>

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
>  """
>  This file is an implementation of backup tool
>  """
> +from __future__ import print_function
>  from argparse import ArgumentParser
>  import os
>  import errno
>  from socket import error as socket_error
> -import configparser
> +try:
> +    import configparser
> +except ImportError:
> +    import ConfigParser as configparser
>  import sys
> -sys.path.append('../../scripts/qmp')
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..',
> +                             'scripts', 'qmp'))
>  from qmp import QEMUMonitorProtocol
> =20
> =20
>  class BackupTool(object):
>      """BackupTool Class"""
> -    def __init__(self, config_file=3D'backup.ini'):
> -        self.config_file =3D config_file
> +    def __init__(self,
> +                 config_file=3Dos.path.expanduser('~')+'/.qemu/backup/co=
nfig'):

Please use os.path.join() instead of appending strings.

You could consider using a variable to avoid repeating this particular
path since it is used several times in the code:

  DEFAULT_CONFIG_FILE =3D os.path.join(os.path.expanduser('~'),
                                     '.qemu', 'backup', 'config')

The XDG Base Directory Specification would use ~/.config/qemu instead of
~/.qemu:
https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

Modern applications tend to follow this spec.

> +        if "QEMU_BACKUP_CONFIG" in os.environ:
> +            self.config_file =3D os.environ["QEMU_BACKUP_CONFIG"]
> +        else:
> +            self.config_file =3D config_file
> +            try:
> +                if not os.path.isdir(os.path.expanduser('~')+'/.qemu/bac=
kup'):

os.path.dirname(DEFAULT_CONFIG_FILE)

> +                    os.makedirs(os.path.expanduser('~')+'/.qemu/backup')

os.path.dirname(DEFAULT_CONFIG_FILE)

> +            except:
> +                print("Cannot find the config file", file=3Dsys.stderr)

This error message doesn't match the try-catch block's purpose.  The
issue was that the config directory couldn't be created.

> +                exit(1)
>          self.config =3D configparser.ConfigParser()
>          self.config.read(self.config_file)
> =20
> @@ -24,66 +56,70 @@ class BackupTool(object):
>          """
>          Writes configuration to ini file.
>          """
> -        with open(self.config_file, 'w') as config_file:
> -            self.config.write(config_file)
> +        config_file =3D open(self.config_file+".tmp", 'w')
> +        self.config.write(config_file)
> +        config_file.flush()
> +        os.fsync(config_file.fileno())
> +        config_file.close()
> +        os.rename(self.config_file+".tmp", self.config_file)
> =20
> -    def get_socket_path(self, socket_path, tcp):
> +    def get_socket_address(self, socket_address):
>          """
>          Return Socket address in form of string or tuple
>          """
> -        if tcp is False:
> -            return os.path.abspath(socket_path)
> -        return (socket_path.split(':')[0], int(socket_path.split(':')[1]=
))
> +        if socket_address.startswith('tcp'):
> +            return (socket_address.split(':')[1],
> +                    int(socket_address.split(':')[2]))
> +        return socket_address.split(':',2)[1]
> =20
> -    def __full_backup(self, guest_name):
> +    def _full_backup(self, guest_name):
>          """
>          Performs full backup of guest
>          """
>          if guest_name not in self.config.sections():
> -            print ("Cannot find specified guest")
> -            return
> -        if self.is_guest_running(guest_name, self.config[guest_name]['qm=
p'],
> -                                 self.config[guest_name]['tcp']) is Fals=
e:
> -            return
> +            print ("Cannot find specified guest", file=3Dsys.stderr)

print() is a function, there shouldn't be a space before the parentheses:

  print("message")

> +            exit(1)
> +
> +        self.verify_guest_running(guest_name)
>          connection =3D QEMUMonitorProtocol(
> -                                         self.get_socket_path(
> -                                             self.config[guest_name]['qm=
p'],
> -                                             self.config[guest_name]['tc=
p']))
> +                                         self.get_socket_address(
> +                                             self.config[guest_name]['qm=
p']))
>          connection.connect()
>          cmd =3D {"execute": "transaction", "arguments": {"actions": []}}
>          for key in self.config[guest_name]:
>              if key.startswith("drive_"):
> -                drive =3D key[key.index('_')+1:]
> +                drive =3D key[len('drive_'):]
>                  target =3D self.config[guest_name][key]
>                  sub_cmd =3D {"type": "drive-backup", "data": {"device": =
drive,
>                                                              "target": ta=
rget,
>                                                              "sync": "ful=
l"}}
>                  cmd['arguments']['actions'].append(sub_cmd)
> -        print (connection.cmd_obj(cmd))
> +        connection.cmd_obj(cmd)
> +        if connection.pull_event(wait=3DTrue)['event'] =3D=3D 'BLOCK_JOB=
_COMPLETED':
> +            print("Backup Complete")
> +        else:
> +            print("Cannot complete backup", file=3Dsys.stderr)

A loop is needed here because innocent QMP events can occur like a VNC
client connection.  BLOCK_JOB_ERROR is an interesting event to report.
Perhaps SHUTDOWN is interesting too.  Other than that we need to loop
waiting for events and must not exit early.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZjFryAAoJEJykq7OBq3PIW4IH/1FnQsLxn7f1uJmrEaJI4wmJ
IzMiMpYj402VMKFPBt3JBZcykdB/zZFnPEbiZAX5Ig+8tngEZ5u6hxE+zA5PQYno
ojmqymR5t9o6OwTjFcYB6NC/U5/cjI0f6krEcO7jPaNv+8GmbzbxCvqdIGIRdzEw
S2bQg/cMpOn1voWOg0kJFOCvA8WI/FwN+VF0IWTSr7jn+3Xm8e+rvVVApdJLlPaK
l63TUj1itSN5X1TyfxW/dVPpJ2+BauHxU8b7NDpKa+OYL21jkh+W3hgZ6BHXR0vk
gWKaDU+wTE9mvFRKAXsuoz05JXMoDSl0AIzZUkVzTdU0aIiJ6Bu3Ds/AUUAxCDU=
=bvMc
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
