Received: from eggs.gnu.org ([209.51.188.92]:33830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjSmQ-0004Hs-Pw
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjSmO-0000oq-RM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:45:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjSmF-0000dQ-Ok
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:45:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CD878EA48
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 17:45:17 +0000 (UTC)
Date: Tue, 15 Jan 2019 17:45:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190115174506.GV16157@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547573562-32754-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547573562-32754-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] seccomp: Work-around GCC 4.x bug in gnu99
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Tue, Jan 15, 2019 at 06:32:42PM +0100, Thomas Huth wrote:
> We'd like to compile QEMU with -std=3Dgnu99, but GCC 4.8 currently
> fails to compile qemu-seccomp.c in this mode:
>=20
> qemu-seccomp.c:45:1: error: initializer element is not constant
>  };
>  ^
> qemu-seccomp.c:45:1: error: (near initialization for =E2=80=98sched_set=
scheduler_arg[0]=E2=80=99)
>=20
> This is due to a compiler bug which has just been fixed in GCC 5.0:
>=20
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D63567
>=20
> Since we still want to support GCC 4.8 for a while and also want to use
> gnu99 mode, work-around the issue by expanding the macro manually.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-seccomp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index 5c73e6a..36d5829 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -41,7 +41,8 @@ struct QemuSeccompSyscall {
>  };
> =20
>  const struct scmp_arg_cmp sched_setscheduler_arg[] =3D {
> -    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
> +    /* was SCMP_A1(SCMP_CMP_NE, SCHED_IDLE), but expanded due to GCC 4=
.x bug */
> +    { .arg =3D 1, .op =3D SCMP_CMP_NE, .datum_a =3D SCHED_IDLE }
>  };

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
