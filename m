Received: from eggs.gnu.org ([2001:4830:134:3::10]:57425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elF8m-0001wy-W7
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elF8i-00033N-Nt
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:31:33 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:44752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1elF8i-000326-J7
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:31:28 -0500
Received: by mail-qk0-f170.google.com with SMTP id n188so18553303qkn.11
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 06:31:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180212142506.28445-2-danielhb@linux.vnet.ibm.com>
References: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
	<20180212142506.28445-2-danielhb@linux.vnet.ibm.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 12 Feb 2018 15:31:26 +0100
Message-ID: <CAMxuvaxj=1cz2oiMWBX=jtTMaR_ERweu2meuVSNzd=NX2sDE=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/1] dump.c: allow fd_write_vmcore to
 return errno on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>, Yasmin Beatriz <yasmins@linux.vnet.ibm.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Hi

On Mon, Feb 12, 2018 at 3:25 PM, Daniel Henrique Barboza
<danielhb@linux.vnet.ibm.com> wrote:
> From: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
>
> fd_write_vmcore can fail to execute for a lot of reasons that can be
> retrieved by errno, but it only returns -1. This makes difficult for
> the caller to know what happened and only a generic error message is
> propagated back to the user. This is an example using dump-guest-memory:
>
> (qemu) dump-guest-memory /home/yasmin/mnt/test.dump
> dump: failed to save memory
>
> All callers of fd_write_vmcore of dump.c does error handling via
> error_setg(), so at first it seems feasible to add the Error pointer as
> an argument of fd_write_vmcore. This proved to be more complex than it
> first looked. fd_write_vmcore is used by write_elf64_notes and
> write_elf32_notes as a WriteCoreDumpFunction prototype. WriteCoreDumpFunc=
tion
> is declared in include/qom/cpu.h and is used all around the code. This
> leaves us with few alternatives:
>
> - change the WriteCoreDumpFunction prototype to include an error pointer.
> This would require to change all functions that implements this prototype
> to also receive an Error pointer;
>
> - change both write_elf64_notes and write_elf32_notes to no use the
> WriteCoreDumpFunction. These functions use not only fd_write_vmcore
> but also buf_write_note, so this would require to change buf_write_note
> to handle an Error pointer. Considerable easier than the alternative
> above, but it's still a lot of code just for the benefit of the callers
> of fd_write_vmcore.
>
> This patch presents an easier solution that benefits all fd_write_vmcore
> callers:
>
> - instead of returning -1 on error, return -errno. All existing callers
> already checks for ret < 0 so there is no need to change the caller's
> logic too much. This also allows the retrieval of the errno.
>
> - all callers were updated to use error_setg_errno instead of just
> errno_setg. Now that fd_write_vmcore can return an errno, let's update
> all callers so they can benefit from a more detailed error message.
>
> This is the same dump-guest-memory example with this patch applied:
>
> (qemu) dump-guest-memory /home/yasmin/mnt/test.dump
> dump: failed to save memory: No space left on device
> (qemu)
>
> This example illustrates an error of fd_write_vmcore when called
> from write_data. All other callers will benefit from better
> error messages as well.
>
> Reported-by: yilzhang@redhat.com
> Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

lgtm,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  dump.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/dump.c b/dump.c
> index 7b13baa413..171ff8a3b8 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -107,7 +107,7 @@ static int fd_write_vmcore(const void *buf, size_t si=
ze, void *opaque)
>
>      written_size =3D qemu_write_full(s->fd, buf, size);
>      if (written_size !=3D size) {
> -        return -1;
> +        return -errno;
>      }
>
>      return 0;
> @@ -140,7 +140,7 @@ static void write_elf64_header(DumpState *s, Error **=
errp)
>
>      ret =3D fd_write_vmcore(&elf_header, sizeof(elf_header), s);
>      if (ret < 0) {
> -        error_setg(errp, "dump: failed to write elf header");
> +        error_setg_errno(errp, -ret, "dump: failed to write elf header")=
;
>      }
>  }
>
> @@ -171,7 +171,7 @@ static void write_elf32_header(DumpState *s, Error **=
errp)
>
>      ret =3D fd_write_vmcore(&elf_header, sizeof(elf_header), s);
>      if (ret < 0) {
> -        error_setg(errp, "dump: failed to write elf header");
> +        error_setg_errno(errp, -ret, "dump: failed to write elf header")=
;
>      }
>  }
>
> @@ -194,7 +194,8 @@ static void write_elf64_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
>
>      ret =3D fd_write_vmcore(&phdr, sizeof(Elf64_Phdr), s);
>      if (ret < 0) {
> -        error_setg(errp, "dump: failed to write program header table");
> +        error_setg_errno(errp, -ret,
> +                         "dump: failed to write program header table");
>      }
>  }
>
> @@ -217,7 +218,8 @@ static void write_elf32_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
>
>      ret =3D fd_write_vmcore(&phdr, sizeof(Elf32_Phdr), s);
>      if (ret < 0) {
> -        error_setg(errp, "dump: failed to write program header table");
> +        error_setg_errno(errp, -ret,
> +                         "dump: failed to write program header table");
>      }
>  }
>
> @@ -237,7 +239,8 @@ static void write_elf64_note(DumpState *s, Error **er=
rp)
>
>      ret =3D fd_write_vmcore(&phdr, sizeof(Elf64_Phdr), s);
>      if (ret < 0) {
> -        error_setg(errp, "dump: failed to write program header table");
> +        error_setg_errno(errp, -ret,
> +                         "dump: failed to write program header table");
>      }
>  }
>
> @@ -302,7 +305,8 @@ static void write_elf32_note(DumpState *s, Error **er=
rp)
>
>      ret =3D fd_write_vmcore(&phdr, sizeof(Elf32_Phdr), s);
>      if (ret < 0) {
> -        error_setg(errp, "dump: failed to write program header table");
> +        error_setg_errno(errp, -ret,
> +                         "dump: failed to write program header table");
>      }
>  }
>
> @@ -355,7 +359,8 @@ static void write_elf_section(DumpState *s, int type,=
 Error **errp)
>
>      ret =3D fd_write_vmcore(&shdr, shdr_size, s);
>      if (ret < 0) {
> -        error_setg(errp, "dump: failed to write section header table");
> +        error_setg_errno(errp, -ret,
> +                         "dump: failed to write section header table");
>      }
>  }
>
> @@ -365,7 +370,7 @@ static void write_data(DumpState *s, void *buf, int l=
ength, Error **errp)
>
>      ret =3D fd_write_vmcore(buf, length, s);
>      if (ret < 0) {
> -        error_setg(errp, "dump: failed to save memory");
> +        error_setg_errno(errp, -ret, "dump: failed to save memory");
>      } else {
>          s->written_size +=3D length;
>      }
> --
> 2.14.3
>
