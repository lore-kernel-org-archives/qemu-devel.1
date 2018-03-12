Received: from eggs.gnu.org ([2001:4830:134:3::10]:53752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evNZq-0000M8-W5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evNZp-00042Y-WC
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:33:22 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evNZp-000418-Pb
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:33:21 -0400
Received: by mail-wr0-x244.google.com with SMTP id v65so15689327wrc.11
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:33:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312131806.23209-1-stefanha@redhat.com>
References: <20180312131806.23209-1-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 14:33:19 +0100
Message-ID: <CAJ+F1CJAizAo34R7g0LgOZ7UTe+xsFBOw=eCo-U1iRRfui49NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Mar 12, 2018 at 2:18 PM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> Warn if files are added/renamed/deleted without MAINTAINERS file
> changes.  This has helped me in Linux and we could benefit from this
> check in QEMU.
>
> This patch is a manual cherry-pick of Linux commit
> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning on
> file add/move/delete") by Joe Perches <joe@perches.com>.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

nice,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> Note the 80-char lines are from upstream code.  Keep them as-is.
>
>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d1fe79bcc4..d0d8f63d48 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1177,6 +1177,7 @@ sub process {
>         our $clean =3D 1;
>         my $signoff =3D 0;
>         my $is_patch =3D 0;
> +       my $reported_maintainer_file =3D 0;
>
>         our @report =3D ();
>         our $cnt_lines =3D 0;
> @@ -1379,6 +1380,24 @@ sub process {
>                         }
>                 }
>
> +# Check if MAINTAINERS is being updated.  If so, there's probably no nee=
d to
> +# emit the "does MAINTAINERS need updating?" message on file add/move/de=
lete
> +               if ($line =3D~ /^\s*MAINTAINERS\s*\|/) {
> +                       $reported_maintainer_file =3D 1;
> +               }
> +
> +# Check for added, moved or deleted files
> +               if (!$reported_maintainer_file &&
> +                   ($line =3D~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> +                    $line =3D~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
> +                    ($line =3D~ /\{\s*([\w\/\.\-]*)\s*\=3D\>\s*([\w\/\.\=
-]*)\s*\}/ &&
> +                     (defined($1) || defined($2))))) {
> +                       $is_patch =3D 1;
> +                       $reported_maintainer_file =3D 1;
> +                       WARN("added, moved or deleted file(s), does MAINT=
AINERS need updating?\n" .
> +                               $herecurr);
> +               }
> +
>  # Check for wrappage within a valid hunk of the file
>                 if ($realcnt !=3D 0 && $line !~ m{^(?:\+|-| |\\ No newlin=
e|$)}) {
>                         ERROR("patch seems to be corrupt (line wrapped?)\=
n" .
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
