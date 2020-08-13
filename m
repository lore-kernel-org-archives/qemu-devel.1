Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4A0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A98620774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgIfmn8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A98620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6CO6-0005Tq-Bu
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 08:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k6CLh-00044K-M3
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:28:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k6CLf-0003Wm-7R
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597321726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJVYvQ9tE0nzuqYJUrttabXE6wAEM6W9tG/7w909+Uc=;
 b=WgIfmn8eu9g6creJTR16GSHHnTCUFKuPWKj9uDSr/C6mJhUkf4A2Xw6YN1eLsk9qI7osaw
 Jc+Em+HaEEZrO9jPSluH65RioUtHBl5F6WDim5TN09VrGJeKIsbOUsIgUC285hufPnb0li
 dF6b51xRt5uolF//o+95/18U1E90CQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-IXk86s63Ok-71SZy6pRD7g-1; Thu, 13 Aug 2020 08:28:40 -0400
X-MC-Unique: IXk86s63Ok-71SZy6pRD7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84F1E807327;
 Thu, 13 Aug 2020 12:28:39 +0000 (UTC)
Received: from localhost (ovpn-114-3.ams2.redhat.com [10.36.114.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1710219D6C;
 Thu, 13 Aug 2020 12:28:38 +0000 (UTC)
Date: Thu, 13 Aug 2020 13:28:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/3] aio-posix: keep aio_notify_me disabled during
 polling
Message-ID: <20200813122837.GD6559@stefanha-x1.localdomain>
References: <20200806131802.569478-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200806131802.569478-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 02:17:59PM +0100, Stefan Hajnoczi wrote:
> v3:
>  * Use smp_wmb() in aio_notify_accept() [Paolo]
>  * Flatten if statement in aio_poll() [Paolo]
>=20
> v2:
>  * Added smp_mb() in aio_notify_accept() [Paolo]
>  * Added comments about memory barrier pairing [Paolo]
>  * Eliminated extra aio_compute_timeout() before calling ppoll()
>=20
> This patch series eliminates ctx->notifier EventNotifier activity when
> aio_poll() is in polling mode. There is no need to use the EventNotifier =
since
> a polling handler can detect that aio_notify() has been called by monitor=
ing a
> field in memory instead.
>=20
> Optimizing out the EventNotifier calls improves null-co random read 4KB
> iodepth=3D1 IOPS by 18%.
>=20
> I have not modified docs/spin/aio_notify*.promela because I'm not familia=
r with
> the SPIN model checker.
>=20
> Stefan Hajnoczi (3):
>   async: rename event_notifier_dummy_cb/poll()
>   async: always set ctx->notified in aio_notify()
>   aio-posix: keep aio_notify_me disabled during polling
>=20
>  util/aio-posix.c | 47 +++++++++++++++++++++++++----------------------
>  util/async.c     | 36 +++++++++++++++++++++++-------------
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl81MfUACgkQnKSrs4Gr
c8hdnAgAkkfcZmxjzafgQnNETysBN8Kq0cuYXzfHmdmqW6Wp0+fePJDvL7xgiTYs
lA3hgfPd/A/s7f46dt2yaHZuXDouogwabAKhIm+6B6Mq2skMWqbYP+qheLExFxNF
wQOriiP1k4N9RLv55QM0vnIOp1SDxiD1yEfA8+4CspONp55NU5myWba3mHdT7n7U
LSOlUbTjwFjq+BIGv9sAFQ5Ys6nMjr0WznU1Gc2llHmdso83aIx7nORXU/fJ/lzw
/Xi0NcAb4y4Qgi3aOimR8hV0yg4c4h27EW03FUQ/b7toPT5EAtFM756fmSCb2Zp2
ZJNE9vBHFxi6inPMm+M3Te0jhA6tjg==
=pJWD
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--


