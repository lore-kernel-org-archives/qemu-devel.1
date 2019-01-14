Received: from eggs.gnu.org ([209.51.188.92]:36637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gj3pC-0003oY-2a
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gj3pA-0007Zh-Bu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:06:49 -0500
Date: Mon, 14 Jan 2019 15:06:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190114150630.GL3686@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547477388-22494-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547477388-22494-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] configure: Work-around a bug in
 libiscsi 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

On Mon, Jan 14, 2019 at 03:49:48PM +0100, Thomas Huth wrote:
> The header "scsi-lowlevel.h" of libiscsi 1.9.0 contains some bad
> "inline" prototype definitions which GCC refuses to compile in its
> gnu99 mode:
>=20
> In file included from block/iscsi.c:52:0:
> /usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
> =E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror]
>  inline void scsi_set_uint16(unsigned char *c, uint16_t val);
>              ^
> /usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
> =E2=80=98scsi_set_uint32=E2=80=99 declared but never defined [-Werror]
>  inline void scsi_set_uint32(unsigned char *c, uint32_t val);
>              ^
>=20
> This has been fixed by upstream libiscsi in version 1.10.0 (see
> https://github.com/sahlberg/libiscsi/commit/7692027d6c11 ), but
> since we still want to support 1.9.0 for CentOS 7 / RHEL7, we
> have to work-around the issue by compiling with "-Wno-error"
> in this case instead.
>=20
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use "-Wno-error" instead of "-fgnu89-inline"
>=20
>  configure | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/configure b/configure
> index 2b9ba7d..9514533 100755
> --- a/configure
> +++ b/configure
> @@ -4562,6 +4562,11 @@ if test "$libiscsi" !=3D "no" ; then
>      libiscsi=3D"yes"
>      libiscsi_cflags=3D$($pkg_config --cflags libiscsi)
>      libiscsi_libs=3D$($pkg_config --libs libiscsi)
> +    if $pkg_config --exact-version=3D1.9.0 libiscsi; then
> +      # There are some bad inline declarations in scsi-lowlevel.h of
> +      # libiscsi 1.9.0 which don't work in gnu99 mode, so we need this=
:
> +      libiscsi_cflags=3D"-Wno-error $libiscsi_cflags"
> +    fi
>    else
>      if test "$libiscsi" =3D "yes" ; then
>        feature_not_found "libiscsi" "Install libiscsi >=3D 1.9.0"

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
