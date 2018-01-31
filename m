Received: from eggs.gnu.org ([2001:4830:134:3::10]:46031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1egpvA-0003q6-LP
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 05:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1egpv5-0005e3-Ly
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 05:47:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1egpv5-0005dU-G2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 05:47:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C743DC001F28
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 10:47:09 +0000 (UTC)
References: <20180131104120.16708-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <414b4919-291f-0f3e-733f-417a4c03c890@redhat.com>
Date: Wed, 31 Jan 2018 11:47:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180131104120.16708-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory.py: skip vmcoreinfo
 section if not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 01/31/18 11:41, Marc-Andr=C3=A9 Lureau wrote:
> On some architectures, qemu doesn't support vmcoreinfo device,
> and dump-guest-memory fails:
>=20
> (gdb) dump-guest-memory /tmp/vmcore  ppc64-le
> guest RAM blocks:
> target_start     target_end       host_addr        message count
> ---------------- ---------------- ---------------- ------- -----
> 0000000000000000 0000000200000000 00003ffd86980000 added       1
> 0000200080000000 0000200080800000 00003ffd86170000 added       2
> Python Exception <class 'gdb.error'> No symbol "vmcoreinfo_realize" in =
current context.:
> Error occurred in Python command: No symbol "vmcoreinfo_realize" in cur=
rent context.
>=20
> Check that vmcoreinfo_realize symbol exists before evaluating an
> expression with it.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> index 03fbf69f8a..51acfcd0c0 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -546,6 +546,8 @@ shape and this command should mostly work."""
>          return None
> =20
>      def add_vmcoreinfo(self):
> +        if gdb.lookup_symbol("vmcoreinfo_realize")[0] is None:
> +            return
>          vmci =3D 'vmcoreinfo_realize::vmcoreinfo_state'
>          if not gdb.parse_and_eval("%s" % vmci) \
>             or not gdb.parse_and_eval("(%s)->has_vmcoreinfo" % vmci):
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
