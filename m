Received: from eggs.gnu.org ([2001:4830:134:3::10]:50372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eQuwY-0006jz-2K
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eQuwX-0000j4-41
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:54:54 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eQuwW-0000iH-TE
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:54:53 -0500
Received: by mail-wr0-x241.google.com with SMTP id y21so13958701wrc.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 04:54:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <abddfb99-c6ca-70ba-eae9-16f57f60b41d@redhat.com>
References: <20171215181810.4122-1-marcandre.lureau@redhat.com>
	<abddfb99-c6ca-70ba-eae9-16f57f60b41d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Dec 2017 13:54:50 +0100
Message-ID: <CAJ+F1C+3u+yy+LHxkv8DjxMTeCi7oon8s01g2YYMoRB4sNuv1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn when using volatile with
 a comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Fam Zheng <famz@redhat.com>

Hi

On Mon, Dec 18, 2017 at 1:49 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 15/12/2017 19:18, Marc-Andr=C3=A9 Lureau wrote:
>> Instead of an error, lower to a warning message, assuming the comment
>> gives some justification.
>>
>> Discussed in:
>> '[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that witho=
ut a process to debug"'
>>
>> Suggested-by: Fam Zheng <famz@redhat.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> We can drop the error at all if there is a comment.  Also, "volatile sig_=
atomic_t" is probably self-explanatory and usually correct.  So what about =
this:
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f5a523af10..3dc27d9656 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2475,13 +2475,11 @@ sub process {
>
>  # no volatiles please
>                 my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|v=
olatile)\b};
> -               if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/=
) {
> -                       my $msg =3D "Use of volatile is usually wrong: se=
e Documentation/volatile-considered-harmful.txt\n" . $herecurr;
> -                       if (ctx_has_comment($first_line, $linenr)) {
> -                               WARN($msg);
> -                       } else {
> -                               ERROR($msg);
> -                       }
> +               if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/=
 &&
> +                    $line !~ /sig_atomic_t/ &&
> +                    !ctx_has_comment($first_line, $linenr)) {
> +                       my $msg =3D "Use of volatile is usually wrong, pl=
ease add a comment\n" . $herecurr;
> +                        ERROR($msg);
>                 }
>

Fine for me, can you send a proper patch?

Thanks



--=20
Marc-Andr=C3=A9 Lureau
