Received: from eggs.gnu.org ([2001:4830:134:3::10]:53327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDJab-0008GD-Up
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 20:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDJaa-0001Cv-Ic
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 20:56:18 -0400
References: <20180419164642.9536-1-f4bug@amsat.org>
	<20180419164642.9536-3-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <35f1a36e-e5a8-cf49-7b87-417b8fbf6068@redhat.com>
Date: Mon, 30 Apr 2018 20:56:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180419164642.9536-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/7] avocado: Update python scripts to
 upstream codebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel@nongnu.org, Alistair Francis <alistair23@gmail.com>, Max Reitz <mreitz@redhat.com>

On 04/19/2018 12:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> QEMUMachine arguments member is called '_args'.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/qemu.py                    | 14 +++++++-------
>  tests/avocado/avocado_qemu/test.py | 12 ++++++------
>  tests/qemu-iotests/iotests.py      | 28 ++++++++++++++--------------
>  3 files changed, 27 insertions(+), 27 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index bd66620f45..0eecc44d09 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -81,7 +81,7 @@ class QEMUMachine(object):
>          self._qemu_log_file =3D None
>          self._popen =3D None
>          self._binary =3D binary
> -        self.args =3D list(args)     # Force copy args in case we modi=
fy them
> +        self._args =3D list(args)     # Force copy args in case we mod=
ify them
>          self._wrapper =3D wrapper
>          self._events =3D []
>          self._iolog =3D None
> @@ -109,8 +109,8 @@ class QEMUMachine(object):
>      # This can be used to add an unused monitor instance.
>      def add_monitor_telnet(self, ip, port):
>          args =3D 'tcp:%s:%d,server,nowait,telnet' % (ip, port)
> -        self.args.append('-monitor')
> -        self.args.append(args)
> +        self._args.append('-monitor')
> +        self._args.append(args)
> =20
>      def add_fd(self, fd, fdset, opaque, opts=3D''):
>          '''Pass a file descriptor to the VM'''
> @@ -120,8 +120,8 @@ class QEMUMachine(object):
>          if opts:
>              options.append(opts)
> =20
> -        self.args.append('-add-fd')
> -        self.args.append(','.join(options))
> +        self._args.append('-add-fd')
> +        self._args.append(','.join(options))
>          return self
> =20
>      def send_fd_scm(self, fd_file_path):
> @@ -184,7 +184,7 @@ class QEMUMachine(object):
>                  '-display', 'none', '-vga', 'none']
> =20
>      def _create_console(self, console_address):
> -        for item in self.args:
> +        for item in self._args:
>              for option in ['isa-serial', 'spapr-vty', 'sclpconsole']:
>                  if option in item:
>                      return []
> @@ -274,7 +274,7 @@ class QEMUMachine(object):
>          bargs =3D self._base_args()
>          bargs.extend(self._create_console(console_address))
>          self._qemu_full_args =3D (self._wrapper + [self._binary] +
> -                                bargs + self.args)
> +                                bargs + self._args)
>          self._popen =3D subprocess.Popen(self._qemu_full_args,
>                                         stdin=3Ddevnull,
>                                         stdout=3Dself._qemu_log_file,
> diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado=
_qemu/test.py
> index 5a08dace45..1ead917014 100644
> --- a/tests/avocado/avocado_qemu/test.py
> +++ b/tests/avocado/avocado_qemu/test.py
> @@ -297,8 +297,8 @@ class _VM(qemu.QEMUMachine):
>          port =3D self.ports.find_free_port()
>          newvm =3D _VM(self.qemu_dst_bin, self._arch, username=3Dself.u=
sername,
>                      password=3Dself.password)
> -        newvm.args =3D self.args
> -        newvm.args.extend(['-incoming', 'tcp:0:%s' % port])
> +        newvm._args =3D self._args
> +        newvm._args.extend(['-incoming', 'tcp:0:%s' % port])
>          newvm.username =3D self.username
>          newvm.password =3D self.password
> =20
> @@ -329,7 +329,7 @@ class _VM(qemu.QEMUMachine):
>          :param extra: Extra parameters to the -drive option
>          """
>          file_option =3D 'file=3D%s' % path
> -        for item in self.args:
> +        for item in self._args:
>              if file_option in item:
>                  logging.error('Image %s already present', path)
>                  return
> @@ -340,7 +340,7 @@ class _VM(qemu.QEMUMachine):
>          if snapshot:
>              file_option +=3D ',snapshot=3Don'
> =20
> -        self.args.extend(['-drive', file_option])
> +        self._args.extend(['-drive', file_option])
> =20
>          if username is not None:
>              self.username =3D username
> @@ -387,7 +387,7 @@ class _VM(qemu.QEMUMachine):
>          process.run("%s -output %s -volid cidata -joliet -rock %s %s" =
%
>                      (geniso_bin, iso_path, metadata_path, userdata_pat=
h))
> =20
> -        self.args.extend(['-cdrom', iso_path])
> +        self._args.extend(['-cdrom', iso_path])
> =20
>  class QemuTest(Test):
> =20
> @@ -415,4 +415,4 @@ class QemuTest(Test):
>          if machine_kvm_type is not None:
>              machine +=3D "kvm-type=3D%s," % machine_kvm_type
>          if machine:
> -            self.vm.args.extend(['-machine', machine])
> +            self.vm._args.extend(['-machine', machine])
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> index a2e4f03743..b25d48a91b 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -293,18 +293,18 @@ class VM(qtest.QEMUQtestMachine):
>          self._num_drives =3D 0
> =20
>      def add_object(self, opts):
> -        self.args.append('-object')
> -        self.args.append(opts)
> +        self._args.append('-object')
> +        self._args.append(opts)
>          return self
> =20
>      def add_device(self, opts):
> -        self.args.append('-device')
> -        self.args.append(opts)
> +        self._args.append('-device')
> +        self._args.append(opts)
>          return self
> =20
>      def add_drive_raw(self, opts):
> -        self.args.append('-drive')
> -        self.args.append(opts)
> +        self._args.append('-drive')
> +        self._args.append(opts)
>          return self
> =20
>      def add_drive(self, path, opts=3D'', interface=3D'virtio', format=3D=
imgfmt):
> @@ -322,27 +322,27 @@ class VM(qtest.QEMUQtestMachine):
> =20
>          if format =3D=3D 'luks' and 'key-secret' not in opts:
>              # default luks support
> -            if luks_default_secret_object not in self.args:
> +            if luks_default_secret_object not in self._args:
>                  self.add_object(luks_default_secret_object)
> =20
>              options.append(luks_default_key_secret_opt)
> =20
> -        self.args.append('-drive')
> -        self.args.append(','.join(options))
> +        self._args.append('-drive')
> +        self._args.append(','.join(options))
>          self._num_drives +=3D 1
>          return self
> =20
>      def add_blockdev(self, opts):
> -        self.args.append('-blockdev')
> +        self._args.append('-blockdev')
>          if isinstance(opts, str):
> -            self.args.append(opts)
> +            self._args.append(opts)
>          else:
> -            self.args.append(','.join(opts))
> +            self._args.append(','.join(opts))
>          return self
> =20
>      def add_incoming(self, addr):
> -        self.args.append('-incoming')
> -        self.args.append(addr)
> +        self._args.append('-incoming')
> +        self._args.append(addr)
>          return self
> =20
>      def pause_drive(self, drive, event=3DNone):
>=20

Well, this is basically a revert of parts of this patch:

  https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03446.html

There was some previous discussions on this topic, basically regarding
two conflicting points:

1) The fact that other instances of scripts.qemu.QEMUMachine (such as
the _VM instances created by avocado_qemu.tests.QemuTest) need access to
the QEMU args;

2) That attributes prefixed with (single) underscore should only be
accessed by code in the class itself.

The discussion then orbited around the usefulness (or not) of a "dumb"
wrapper for a list.  For the record, I'm in favor of exposing the list
directly, until/if some extra functionality is needed.
