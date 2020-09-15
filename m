Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17689C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381AA20735
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8u4u8Cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381AA20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICcF-0003UC-VT
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICaf-0001gK-TO
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICab-0008QU-Vj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600182589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BaQQA/qSC0BIW0TthJIoq2xOXoCFsvNaO7vrDyNZCHE=;
 b=e8u4u8CrdvQYUQnHgDWkDz+ZtT8M4vh9EuIUAJGY0NDS6oVgPq0rzWzsKtlSSR+wALtjn7
 VOst2L4M65z0ZmMqzWhi4da97Qghu6YcSy/AiSpGCnBPdwiIWKmRaFCqElamU1A07a8rqM
 gmoFsty5YNqlh7IHb+XAoVHtI8ORIMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-45Ukr6r5MDGjY0h5AVM3bg-1; Tue, 15 Sep 2020 11:09:41 -0400
X-MC-Unique: 45Ukr6r5MDGjY0h5AVM3bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F06C3801AFD;
 Tue, 15 Sep 2020 15:09:02 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 970CA60BE2;
 Tue, 15 Sep 2020 15:09:02 +0000 (UTC)
Date: Tue, 15 Sep 2020 15:57:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 13/13] block: Convert 'block_resize' to coroutine
Message-ID: <20200915145733.GF629589@stefanha-x1.localdomain>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-14-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909151149.490589-14-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 11:09:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 05:11:49PM +0200, Kevin Wolf wrote:
> @@ -2456,8 +2456,7 @@ void qmp_block_resize(bool has_device, const char *=
device,
>          return;
>      }
> =20
> -    aio_context =3D bdrv_get_aio_context(bs);
> -    aio_context_acquire(aio_context);
> +    old_ctx =3D bdrv_co_move_to_aio_context(bs);
> =20
>      if (size < 0) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a >0 siz=
e");

Is it safe to call blk_new() outside the BQL since it mutates global state?

In other words, could another thread race with us?

> @@ -2479,8 +2478,8 @@ void qmp_block_resize(bool has_device, const char *=
device,
>      bdrv_drained_end(bs);
> =20
>  out:
> +    aio_co_reschedule_self(old_ctx);
>      blk_unref(blk);
> -    aio_context_release(aio_context);

The following precondition is violated by the blk_unref -> bdrv_drain ->
AIO_WAIT_WHILE() call if blk->refcnt is 1 here:

 * The caller's thread must be the IOThread that owns @ctx or the main loop
 * thread (with @ctx acquired exactly once).

blk_unref() is called from the main loop thread without having acquired
blk's AioContext.

Normally blk->refcnt will be > 1 so bdrv_drain() won't be called, but
I'm not sure if that can be guaranteed.

The following seems safer although it's uglier:

  aio_context =3D bdrv_get_aio_context(bs);
  aio_context_acquire(aio_context);
  blk_unref(blk);
  aio_context_release(aio_context);

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9g1l0ACgkQnKSrs4Gr
c8hXLAgAqexrb88YwxkWNAmtIlYDLLRbeOmhZR5SURw41OjGYQkP8Tj0ZR4sZ2QV
5KQ5m/88lmby8mPfkVXO98XtViNSpXvaO4BZiNaaf0OU1hYDAhFn8QhZJLr3OpqR
F5MdN1KGSlLG82B8VgYqlqeqQDp7+J6pz1/9pXMWWqm3Yj5XZhm54Zc8NRMQhDff
YNVsLg0b5agudZPtI6moETpW2ZNiZ9fL81aMd1rnwl+8IhxgsaFMlLxsaO6CzptI
SPmrfQdLmrhQj8EUV8YvyMAuez57XaWDWdP2ZgRBZtIWMI31gEJb1M51r07tu7qM
Y3IRlD4vFNAX3abN5nYRHdtdY0RvOA==
=AgNc
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--


