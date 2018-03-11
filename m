Received: from eggs.gnu.org ([2001:4830:134:3::10]:38855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ev4zn-0007lX-Qt
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 13:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ev4zj-00020U-UE
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 13:42:55 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ev4zj-0001zh-Ph
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 13:42:51 -0400
Received: by mail-qk0-f195.google.com with SMTP id s198so9070454qke.5
	for <qemu-devel@nongnu.org>; Sun, 11 Mar 2018 10:42:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520615003-20869-1-git-send-email-wei@redhat.com>
References: <1520615003-20869-1-git-send-email-wei@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 11 Mar 2018 18:42:49 +0100
Message-ID: <CAMxuvayOHENoibkYscXP5x-u8iTBYrLWkfL0eBuXX2YPBi5nYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] dump: Update correct kdump phys_base
 field for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi

On Fri, Mar 9, 2018 at 6:03 PM, Wei Huang <wei@redhat.com> wrote:
> For guest kernel that supports KASLR, the load address can change every
> time when guest VM runs. To find the physical base address correctly,
> current QEMU dump searches VMCOREINFO for the string "NUMBER(phys_base)=
=3D".
> However this string pattern is only available on x86_64. AArch64 uses a
> different field, called "NUMBER(PHYS_OFFSET)=3D". This patch makes sure
> QEMU dump uses the correct string on AArch64.
>
> Signed-off-by: Wei Huang <wei@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  dump.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/dump.c b/dump.c
> index 097e60b..6bdb0db 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -1609,10 +1609,18 @@ static void vmcoreinfo_update_phys_base(DumpState=
 *s)
>
>      lines =3D g_strsplit((char *)vmci, "\n", -1);
>      for (i =3D 0; lines[i]; i++) {
> -        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=3D")) {
> -            if (qemu_strtou64(lines[i] + 18, NULL, 16,
> +        const char *prefix =3D NULL;
> +
> +        if (s->dump_info.d_machine =3D=3D EM_X86_64) {
> +            prefix =3D "NUMBER(phys_base)=3D";
> +        } else if (s->dump_info.d_machine =3D=3D EM_AARCH64) {
> +            prefix =3D "NUMBER(PHYS_OFFSET)=3D";
> +        }
> +
> +        if (prefix && g_str_has_prefix(lines[i], prefix)) {
> +            if (qemu_strtou64(lines[i] + strlen(prefix), NULL, 16,
>                                &phys_base) < 0) {
> -                warn_report("Failed to read NUMBER(phys_base)=3D");
> +                warn_report("Failed to read %s", prefix);
>              } else {
>                  s->dump_info.phys_base =3D phys_base;
>              }
> --
> 1.8.3.1
>
