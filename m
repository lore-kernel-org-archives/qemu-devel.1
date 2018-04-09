Received: from eggs.gnu.org ([2001:4830:134:3::10]:42294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5SDo-000806-5O
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5SDk-000437-VZ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:32:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5SDk-00041A-QA
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:32:12 -0400
Date: Mon, 9 Apr 2018 09:31:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180409083154.GD18283@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180409082323.29575-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180409082323.29575-1-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: don't warn GTK if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Apr 09, 2018 at 04:23:23PM +0800, Peter Xu wrote:
> We don't need to detect GTK ABI if GTK is disabled in general.
> Otherwise we could get this warning (when host is installed with GTK AB=
I
> version 2) even when configure with "--disable-gtk":
>=20
>     WARNING: Use of GTK 2.0 is deprecated and will be removed in
>     WARNING: future releases. Please switch to using GTK 3.0
>=20
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Fam Zheng <famz@redhat.com>
> CC: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  configure | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/configure b/configure
> index 4d0e92c96c..ce67ad050e 100755
> --- a/configure
> +++ b/configure
> @@ -2537,19 +2537,18 @@ fi
>  ##########################################
>  # GTK probe
> =20
> -if test "$gtkabi" =3D ""; then
> -    # The GTK ABI was not specified explicitly, so try whether 3.0 is =
available.
> -    # Use 2.0 as a fallback if that is available.
> -    if $pkg_config --exists "gtk+-3.0 >=3D 3.0.0"; then
> -        gtkabi=3D3.0
> -    elif $pkg_config --exists "gtk+-2.0 >=3D 2.18.0"; then
> -        gtkabi=3D2.0
> -    else
> -        gtkabi=3D3.0
> -    fi
> -fi
> -
>  if test "$gtk" !=3D "no"; then
> +    if test "$gtkabi" =3D ""; then
> +        # The GTK ABI was not specified explicitly, so try whether 3.0=
 is available.
> +        # Use 2.0 as a fallback if that is available.
> +        if $pkg_config --exists "gtk+-3.0 >=3D 3.0.0"; then
> +            gtkabi=3D3.0
> +        elif $pkg_config --exists "gtk+-2.0 >=3D 2.18.0"; then
> +            gtkabi=3D2.0
> +        else
> +            gtkabi=3D3.0
> +        fi
> +    fi

Feels to me that since we've deprecated 2.0, we could just *never* auto
detect - just do     test -z "$gtkabi" && gtkabi=3D3.0

Anyone who wants gtk2 should have to use an explicit --with-gtkabi=3D2.0

>      gtkpackage=3D"gtk+-$gtkabi"
>      gtkx11package=3D"gtk+-x11-$gtkabi"
>      if test "$gtkabi" =3D "3.0" ; then


BTW, this same problem you're fixing exists for SDL too I expect

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
