Received: from eggs.gnu.org ([2001:4830:134:3::10]:58358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0x4M-00049V-At
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0x4J-0004NN-7c
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:27:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f0x4J-0004N6-2Y
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:27:51 -0400
Received: by mail-it0-f65.google.com with SMTP id j137-v6so1239516ita.1
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 15:27:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180327202152.1799131-1-eblake@redhat.com>
References: <20180327202152.1799131-1-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Mar 2018 00:27:49 +0200
Message-ID: <CAMxuvayh20TQem5X=NNqWauLaRJdFhcOELhs+Aaq4Ji66b71rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] dump: Fix build with newer gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org

On Tue, Mar 27, 2018 at 10:21 PM, Eric Blake <eblake@redhat.com> wrote:
> gcc 8 on rawhide is picky enough to complain:
>
> /home/dummy/qemu/dump.c: In function 'create_header32':
> /home/dummy/qemu/dump.c:817:5: error: 'strncpy' output truncated before t=
erminating nul copying 8 bytes from a string of the same length [-Werror=3D=
stringop-truncation]
>      strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> But we already have SIG_LEN defined as the right length without needing
> to do a strlen(), and memcpy() is better than strncpy() when we know
> we do not want a trailing NUL byte.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  dump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/dump.c b/dump.c
> index 669f715274d..b54cd42b217 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -814,7 +814,7 @@ static void create_header32(DumpState *s, Error **err=
p)
>      size =3D sizeof(DiskDumpHeader32);
>      dh =3D g_malloc0(size);
>
> -    strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
> +    memcpy(dh->signature, KDUMP_SIGNATURE, SIG_LEN);
>      dh->header_version =3D cpu_to_dump32(s, 6);
>      block_size =3D s->dump_info.page_size;
>      dh->block_size =3D cpu_to_dump32(s, block_size);
> @@ -926,7 +926,7 @@ static void create_header64(DumpState *s, Error **err=
p)
>      size =3D sizeof(DiskDumpHeader64);
>      dh =3D g_malloc0(size);
>
> -    strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
> +    memcpy(dh->signature, KDUMP_SIGNATURE, SIG_LEN);
>      dh->header_version =3D cpu_to_dump32(s, 6);
>      block_size =3D s->dump_info.page_size;
>      dh->block_size =3D cpu_to_dump32(s, block_size);
> --
> 2.14.3
>
