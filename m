Received: from eggs.gnu.org ([2001:4830:134:3::10]:60245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsON-0008Ct-33
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsOH-0005Q5-1z
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:43:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTsOG-0005Pz-SG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:43:12 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFB442F4EED
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:43:12 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:43:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118154310.GK30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xsn3knLL3qrmRbVI"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-11-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/16] block: explicitly acquire aiocontext
 in timers that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--Xsn3knLL3qrmRbVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2017 at 02:17:25PM +0100, Paolo Bonzini wrote:
> diff --git a/block/null.c b/block/null.c
> index b300390..356209a 100644
> --- a/block/null.c
> +++ b/block/null.c
> @@ -141,7 +141,11 @@ static void null_bh_cb(void *opaque)
>  static void null_timer_cb(void *opaque)
>  {
>      NullAIOCB *acb = opaque;
> +    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
> +
> +    aio_context_acquire(ctx);
>      acb->common.cb(acb->common.opaque, 0);
> +    aio_context_release(ctx);
>      timer_deinit(&acb->timer);
>      qemu_aio_unref(acb);

Is qemu_aio_unref() thread-safe?

--Xsn3knLL3qrmRbVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf40OAAoJEJykq7OBq3PIB5IH/16yJoiu/IWbls5T5cDjldJ+
9EkYYc4zZ28Db218ehIV7gkq5bE6zRZ/N6rmTQixX20VVt4Ku/IpGa0fFwkOs5G0
DWI/YQyJaCuevhjcVd7srfjyXiIUnC6TYO8jf4P2B8eb4oe85mDeqiGQU61wRB2c
PorsZwSbOtqYC0d2kli4SP2vJRcQfthiLlQLFGwy1cke4P+kb4EyKBCN1fUC5VIl
6EKTJJ3wG96hlY7yOrgJwINOLKCxBOvcXKtDFrNXpdIvCuyDHEPLD84wy0Uqfj6d
yYdEo4mB3SVUr+B24VCgu0nTc2+0osiDDBDsLaMfaXXlG7nyHg+wdq77wG0WNZI=
=pL/B
-----END PGP SIGNATURE-----

--Xsn3knLL3qrmRbVI--
