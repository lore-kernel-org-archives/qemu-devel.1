Received: from eggs.gnu.org ([2001:4830:134:3::10]:35883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1daqcQ-00059J-Nk
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 17:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1daqcN-0008V0-HE
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 17:46:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48924
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1daqcN-0008Uk-C9
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 17:46:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RLhmAY085232
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 17:46:50 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2byktnbsq1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 17:46:50 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Jul 2017 17:46:49 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170726214010.420-3-f4bug@amsat.org>
References: <20170726214010.420-1-f4bug@amsat.org>
	<20170726214010.420-3-f4bug@amsat.org>
Date: Thu, 27 Jul 2017 16:46:40 -0500
Message-Id: <150119200092.22858.16636453463604434143@loki>
Subject: Re: [Qemu-devel] [PATCH for 2.10 2/4] fdt: check fdt_required
 condition can be satisfied _after_ testing libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Arbuckle <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: James Hogan <james.hogan@imgtec.com>, Juan Quintela <quintela@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

Quoting Philippe Mathieu-Daud=C3=A9 (2017-07-26 16:40:08)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Previously we failed if fdt_required and the user had built with
--disable-fdt.  For anything other than --disable-fdt, we'd force
the compile check afterward, and then fail if it's not available.

With this patch, we now probe libfdt if --disable-fdt isn't
specified, regardless of whether or not it's required by the
build. It still seems to behave correctly, but I'm not sure
what bug this re-arrangement fixes. Was there some other case
that was missed prior to this patch?

Also, with patch 4 applied on top of this, if they happen to have
a dtc submodule checked out that doesn't build, they will get a
configure error even if they are building a target where where
fdt_required=3D"no".

> ---
>  configure | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> =

> diff --git a/configure b/configure
> index 063de32773..0d5bdb3ae9 100755
> --- a/configure
> +++ b/configure
> @@ -3558,15 +3558,6 @@ for target in $target_list; do
>    esac
>  done
> =

> -if test "$fdt_required" =3D "yes"; then
> -  if test "$fdt" =3D "no"; then
> -    error_exit "fdt disabled but some requested targets require it." \
> -      "You can turn off fdt only if you also disable all the system emul=
ation" \
> -      "targets which need it (by specifying a cut down --target-list)."
> -  fi
> -  fdt=3Dyes
> -fi
> -
>  if test "$fdt" !=3D "no" ; then
>    fdt_libs=3D"-lfdt"
>    # explicitly check for libfdt_env.h as it is missing in some stable in=
stalls
> @@ -3603,6 +3594,15 @@ EOF
>    fi
>  fi
> =

> +if test "$fdt_required" =3D "yes"; then
> +  if test "$fdt" =3D "no"; then
> +    error_exit "fdt disabled but some requested targets require it." \
> +      "You can turn off fdt only if you also disable all the system emul=
ation" \
> +      "targets which need it (by specifying a cut down --target-list)."
> +  fi
> +  fdt=3Dyes
> +fi
> +
>  libs_softmmu=3D"$libs_softmmu $fdt_libs"
> =

>  ##########################################
> -- =

> 2.13.3
> =

>=20
