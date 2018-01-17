Received: from eggs.gnu.org ([2001:4830:134:3::10]:41659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eboYE-0004WF-Al
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:18:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eboY8-0003Mp-FO
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:18:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eboY8-0003Lk-8U
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:18:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18A4E61D1F
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 14:18:43 +0000 (UTC)
References: <20180117114430.19110-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a9bc4b35-23b3-515f-9ba1-71f41a95b9e7@redhat.com>
Date: Wed, 17 Jan 2018 15:18:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180117114430.19110-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory.py: fix python 2 support
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

On 01/17/18 12:44, Marc-Andr=C3=A9 Lureau wrote:
> Python GDB support may use Python 2 or 3.
>=20
> Inferior.read_memory() may return a buffer with Python 2 or a
> memoryview with Python 3 (see also
> https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)
>=20
> The elf.add_vmcoreinfo_note() method expect a byte string, but Python 2
> buffer doesn't provide the tobyes() method. Wrap the read_memory()
> result to a memoryview, available in Python 2.7. (if the return object
> is already a memoryview, this adds a useless identity view on top)

OOP is awesome.

>=20
> Fixes a regression introduced with commit
> d23bfa91b7789534d16ede6cb7d925bfac3f3c4c ("add vmcoreinfo").

Do you want to CC stable? Commit d23bfa91b778 is part of v2.11.0.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> index 09bec92b50..6f7e1a83b3 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -564,7 +564,9 @@ shape and this command should mostly work."""
> =20
>          vmcoreinfo =3D self.phys_memory_read(addr, size)
>          if vmcoreinfo:
> -            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
> +            # Python 2.7 returns a buffer
> +            vmciview =3D memoryview(vmcoreinfo)
> +            self.elf.add_vmcoreinfo_note(vmciview.tobytes())
> =20
>      def invoke(self, args, from_tty):
>          """Handles command invocation from gdb."""
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Laszlo
