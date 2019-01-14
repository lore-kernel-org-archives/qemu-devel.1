Received: from eggs.gnu.org ([209.51.188.92]:45786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj2iv-0004gJ-6e
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj2ez-0002RB-MW
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:52:14 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj2ez-0002Qv-IT
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:52:13 -0500
Received: by mail-ot1-x343.google.com with SMTP id i20so19374717otl.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 05:52:13 -0800 (PST)
MIME-Version: 1.0
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1547473614-20033-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 13:52:01 +0000
Message-ID: <CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Qemu-block <qemu-block@nongnu.org>

On Mon, 14 Jan 2019 at 13:47, Thomas Huth <thuth@redhat.com> wrote:
>
> The header "scsi-lowlevel.h" of libiscsi 1.9.0 contains some bad
> "inline" prototype definitions which GCC refuses to compile in its
> gnu99 mode:
>
> In file included from block/iscsi.c:52:0:
> /usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
> =E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror]
>  inline void scsi_set_uint16(unsigned char *c, uint16_t val);
>              ^
> /usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
> =E2=80=98scsi_set_uint32=E2=80=99 declared but never defined [-Werror]
>  inline void scsi_set_uint32(unsigned char *c, uint32_t val);
>              ^
>
> This has been fixed by upstream libiscsi in version 1.10.0 (see
> https://github.com/sahlberg/libiscsi/commit/7692027d6c11 ), but
> since we still want to support 1.9.0 for CentOS 7 / RHEL7, we
> have to work-around the issue by compiling with "-fgnu89-inline"
> in this case instead.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/configure b/configure
> index 2b9ba7d..aa80c17 100755
> --- a/configure
> +++ b/configure
> @@ -4562,6 +4562,11 @@ if test "$libiscsi" !=3D "no" ; then
>      libiscsi=3D"yes"
>      libiscsi_cflags=3D$($pkg_config --cflags libiscsi)
>      libiscsi_libs=3D$($pkg_config --libs libiscsi)
> +    if $pkg_config --exact-version=3D=3D1.9.0 libiscsi; then
> +      # There are some bad inline declarations in scsi-lowlevel.h of
> +      # libiscsi 1.9.0 which don't work in gnu99 mode without this:
> +      libiscsi_cflags=3D"-fgnu89-inline $libiscsi_cflags"
> +    fi

Can we suppress the warnings with #pragma instead ?
That would avoid compiling the .o file with different
C semantics.

thanks
-- PMM
