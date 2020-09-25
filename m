Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C459C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8569221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScPFmgtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8569221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqa5-0003Uf-QU
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLqGT-0005N2-1C
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLqGQ-0004Lq-0E
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:08:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601050080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iw1gWC5GW3AuHGJTIbuLqmMQjqTiUSF+r9QKoQ/zpYw=;
 b=ScPFmgtX6y8W+VwzN9zP6hUDtjn6yyzK+bTvAw8n29slxNXbMOfRmg+O1qLSiGyFPyv2fG
 bdBLsqUgzkWL3WFbXu5yv5Ohnc/0FSL0XurxhA2AaoNpVkFaE1gzCHQj6OD03BlRMJLjXh
 MJp+nOed41K9I9IVtYuDh2A9okukHX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410--nUvBH1LNYGJKEOIpXKQyA-1; Fri, 25 Sep 2020 12:07:57 -0400
X-MC-Unique: -nUvBH1LNYGJKEOIpXKQyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B0531882FB3;
 Fri, 25 Sep 2020 16:07:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-83.ams2.redhat.com [10.36.114.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED09B60CCC;
 Fri, 25 Sep 2020 16:07:51 +0000 (UTC)
Date: Fri, 25 Sep 2020 18:07:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v7 13/13] block: Convert 'block_resize' to coroutine
Message-ID: <20200925160750.GJ5731@linux.fritz.box>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-14-kwolf@redhat.com>
 <20200915145733.GF629589@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200915145733.GF629589@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.09.2020 um 16:57 hat Stefan Hajnoczi geschrieben:
> On Wed, Sep 09, 2020 at 05:11:49PM +0200, Kevin Wolf wrote:
> > @@ -2456,8 +2456,7 @@ void qmp_block_resize(bool has_device, const char=
 *device,
> >          return;
> >      }
> > =20
> > -    aio_context =3D bdrv_get_aio_context(bs);
> > -    aio_context_acquire(aio_context);
> > +    old_ctx =3D bdrv_co_move_to_aio_context(bs);
> > =20
> >      if (size < 0) {
> >          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a >0 s=
ize");
>=20
> Is it safe to call blk_new() outside the BQL since it mutates global stat=
e?
>=20
> In other words, could another thread race with us?

Hm, probably not.

Would it be safer to have the bdrv_co_move_to_aio_context() call only
immediately before the drain?

> > @@ -2479,8 +2478,8 @@ void qmp_block_resize(bool has_device, const char=
 *device,
> >      bdrv_drained_end(bs);
> > =20
> >  out:
> > +    aio_co_reschedule_self(old_ctx);
> >      blk_unref(blk);
> > -    aio_context_release(aio_context);
>=20
> The following precondition is violated by the blk_unref -> bdrv_drain ->
> AIO_WAIT_WHILE() call if blk->refcnt is 1 here:
>=20
>  * The caller's thread must be the IOThread that owns @ctx or the main lo=
op
>  * thread (with @ctx acquired exactly once).
>=20
> blk_unref() is called from the main loop thread without having acquired
> blk's AioContext.
>=20
> Normally blk->refcnt will be > 1 so bdrv_drain() won't be called, but
> I'm not sure if that can be guaranteed.
>=20
> The following seems safer although it's uglier:
>=20
>   aio_context =3D bdrv_get_aio_context(bs);
>   aio_context_acquire(aio_context);
>   blk_unref(blk);
>   aio_context_release(aio_context);

May we actually acquire aio_context if blk is in the main thread? I
think we must only do this if it's in a different iothread because we'd
end up with a recursive lock and drain would hang.

Kevin

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9uFdYACgkQfwmycsiP
L9ZhaxAAtYSZCrYXKple59TV8i2cfoVccDk6ARiveCa80lJCRRzonkV2qysaOR9v
FdZwImJ/CHQUDvrjKxINGkXQqiUQKV+mvGiwlPmsyPDrYMxttd21qSrdcdag+2yk
NF5F5jn0mBFWd51O9Kk8yp4w5ahihENPtbnh9n/2x7sGe6eo02Ay3ueN7gLpIaPf
J6+esFWZRqbmvGDGnIdwtgjGLEyKd+hyCMCNOSoDjtzEz/2slkuLGm/vOGL/uawK
2gq3lXUoYFoyOV62yFbA54suskgfEqzafmfmcNiBstM/QIdm/N6jibkT4Oqy5MM2
+3idIK6Sw3xg8i1x17ZrXYKJQDvB+JOGFdqM573KjCRPhqd0Jy8gAMASnXPvrWx7
dFFCWHwL6BVvWa8AU4GrEPwPqpOVa/2DnQ8NphZdKCkXbk1r+7J67PCIISZv+WkD
VmEHV4h6mvuk+Djy5H6i5lqY1rNdcZWQwQ4Hy9yqtXusDrTBYtC5GDzGWSyjhJ/V
la3Ntwf0Dr2dwE+CxSIJM44IxKBdHEpOHBEizNx2cE1hq5Rpg5aInT8scRBaBgKV
IrU5lnL/IxBzDDexIay8MttF8rU6fPCUCu+c7GtQwyN9UxBSA25Tj/m3U79AQms1
P+JfolcZ7hjQDg7jQShqW6vj0hV01WGVvWe7HwfLuG1psi+W2ko=
=GZaf
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--


