Received: from eggs.gnu.org ([2001:4830:134:3::10]:39155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmi2m-0004Kq-RU
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmi2h-0007Px-AZ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:03:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dmi2h-0007Pi-3m
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:03:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15BED7E436
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 15:03:02 +0000 (UTC)
Date: Tue, 29 Aug 2017 18:02:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170829180219-mutt-send-email-mst@kernel.org>
References: <20170829144805.28872-1-marcandre.lureau@redhat.com>
	<20170829144805.28872-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170829144805.28872-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost-user-bridge: fix resume
 regression (since 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, victork@redhat.com

On Tue, Aug 29, 2017 at 04:48:05PM +0200, Marc-Andr=E9 Lureau wrote:
> Commit e10e798c85c2331 switched to libvhost-user which lacked support
> for resuming the avail_idx based on used_idx.
>=20
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1485867
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Can we add a test for reconnect to catch the regression?

> ---
>  tests/vhost-user-bridge.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index 1e5b5ca3da..dca48512ba 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -466,11 +466,18 @@ vubr_panic(VuDev *dev, const char *msg)
>      vubr->quit =3D 1;
>  }
> =20
> +static bool
> +vubr_queue_resume_to_used(VuDev *dev, int qidx)
> +{
> +    return true;
> +}
> +
>  static const VuDevIface vuiface =3D {
>      .get_features =3D vubr_get_features,
>      .set_features =3D vubr_set_features,
>      .process_msg =3D vubr_process_msg,
>      .queue_set_started =3D vubr_queue_set_started,
> +    .queue_resume_to_used =3D vubr_queue_resume_to_used,
>  };
> =20
>  static void
> --=20
> 2.14.1.146.gd35faa819
