Received: from eggs.gnu.org ([2001:4830:134:3::10]:55469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebozE-0004dN-0u
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebozD-0004Bu-2O
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:46:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180117114430.19110-1-marcandre.lureau@redhat.com>
References: <20180117114430.19110-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 17 Jan 2018 15:46:39 +0100
Message-ID: <CAJ+F1CKraKBj2JY2JLvGMaEwHnzfxsTnaKMAZ0H-Yyt6WvyfUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: QEMU <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Wed, Jan 17, 2018 at 12:44 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Python GDB support may use Python 2 or 3.
>
> Inferior.read_memory() may return a buffer with Python 2 or a
> memoryview with Python 3 (see also
> https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)
>
> The elf.add_vmcoreinfo_note() method expect a byte string, but Python 2
> buffer doesn't provide the tobyes() method. Wrap the read_memory()
> result to a memoryview, available in Python 2.7. (if the return object
> is already a memoryview, this adds a useless identity view on top)
>
> Fixes a regression introduced with commit
> d23bfa91b7789534d16ede6cb7d925bfac3f3c4c ("add vmcoreinfo").

CC stable (commit d23bfa91b778 is part of v2.11.0., suggested by Laszlo)

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
> index 09bec92b50..6f7e1a83b3 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -564,7 +564,9 @@ shape and this command should mostly work."""
>
>          vmcoreinfo =3D self.phys_memory_read(addr, size)
>          if vmcoreinfo:
> -            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
> +            # Python 2.7 returns a buffer
> +            vmciview =3D memoryview(vmcoreinfo)
> +            self.elf.add_vmcoreinfo_note(vmciview.tobytes())
>
>      def invoke(self, args, from_tty):
>          """Handles command invocation from gdb."""
> --
> 2.16.0.rc1.1.gef27df75a1
>
>



--=20
Marc-Andr=C3=A9 Lureau
