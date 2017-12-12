Received: from eggs.gnu.org ([2001:4830:134:3::10]:55893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOoQJ-0008Bx-14
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOoQD-0002nf-8Q
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:32:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eOoQC-0002n2-Ve
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:32:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26B373D95D
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 17:32:48 +0000 (UTC)
References: <20171212172208.13588-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <91c30ae2-e391-a4bc-a17b-86f574939b51@redhat.com>
Date: Tue, 12 Dec 2017 18:32:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171212172208.13588-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] dump-guest-memory.py: fix "You can't do
 that without a process to debug"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 12/12/17 18:22, Marc-Andr=C3=A9 Lureau wrote:
> If the script is run with a core (no running process), it produces an
> error:
>=20
> (gdb)  dump-guest-memory /tmp/vmcore X86_64
> guest RAM blocks:
> target_start     target_end       host_addr        message count
> ---------------- ---------------- ---------------- ------- -----
> 0000000000000000 00000000000a0000 00007f7935800000 added       1
> 00000000000a0000 00000000000b0000 00007f7934200000 added       2
> 00000000000c0000 00000000000ca000 00007f79358c0000 added       3
> 00000000000ca000 00000000000cd000 00007f79358ca000 joined      3
> 00000000000cd000 00000000000e8000 00007f79358cd000 joined      3
> 00000000000e8000 00000000000f0000 00007f79358e8000 joined      3
> 00000000000f0000 0000000000100000 00007f79358f0000 joined      3
> 0000000000100000 0000000080000000 00007f7935900000 joined      3
> 00000000fd000000 00000000fe000000 00007f7934200000 added       4
> 00000000fffc0000 0000000100000000 00007f7935600000 added       5
> Python Exception <class 'gdb.error'> You can't do that without a proces=
s to debug.:
> Error occurred in Python command: You can't do that without a process
> to debug.
>=20
> Replace the object_resolve_path_type() function call call with a
> local volatile variable.

Patch looks great and the above is fine with me too -- I just note we
have "call call", which could be improved. But, I don't insist.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>=20
> v2:
>  - use a vmcoreinfo_realize() local volatile variable
>  - tweak commit message
>=20
> scripts/dump-guest-memory.py | 3 +--
>  hw/misc/vmcoreinfo.c         | 3 +++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> index 1af26c1a45..09bec92b50 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -546,8 +546,7 @@ shape and this command should mostly work."""
>          return None
> =20
>      def add_vmcoreinfo(self):
> -        vmci =3D '(VMCoreInfoState *)' + \
> -               'object_resolve_path_type("", "vmcoreinfo", 0)'
> +        vmci =3D 'vmcoreinfo_realize::vmcoreinfo_state'
>          if not gdb.parse_and_eval("%s" % vmci) \
>             or not gdb.parse_and_eval("(%s)->has_vmcoreinfo" % vmci):
>              return
> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
> index 31db57ab44..a2805527cb 100644
> --- a/hw/misc/vmcoreinfo.c
> +++ b/hw/misc/vmcoreinfo.c
> @@ -35,6 +35,8 @@ static void vmcoreinfo_realize(DeviceState *dev, Erro=
r **errp)
>  {
>      VMCoreInfoState *s =3D VMCOREINFO(dev);
>      FWCfgState *fw_cfg =3D fw_cfg_find();
> +    /* for gdb script dump-guest-memory.py */
> +    static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;
> =20
>      /* Given that this function is executing, there is at least one VM=
COREINFO
>       * device. Check if there are several.
> @@ -56,6 +58,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Erro=
r **errp)
>                               &s->vmcoreinfo, sizeof(s->vmcoreinfo), fa=
lse);
> =20
>      qemu_register_reset(vmcoreinfo_reset, dev);
> +    vmcoreinfo_state =3D s;
>  }
> =20
>  static const VMStateDescription vmstate_vmcoreinfo =3D {
>=20
