Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF9C206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFCfZJjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF9C206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqC09-0002wk-2V
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqByf-0000sp-Sy
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:50:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqBye-0000fK-4G
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593507051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LPIbR6VP+jENeQRLj9u1oukf9ucQIGKk9Hg+tZmCpA=;
 b=WFCfZJjT5IGGC3PEgBF/wtOR7i6DvGL23alG5rxftGv5CpsNw0X76dod18zyJsMt3/wW7w
 S/izMwNJgQQq0tHlSDypPF9RKph+JzLQda39d9/yUhWCVN82cRWOd7n6h/P88Vq2g/fmAq
 gBYGHh8KQpE0Vl3jdmq8RjLlNqqbAIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-ChNVLAE9P6ymyenXKr_xvQ-1; Tue, 30 Jun 2020 04:50:46 -0400
X-MC-Unique: ChNVLAE9P6ymyenXKr_xvQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D9C8100CCC0;
 Tue, 30 Jun 2020 08:50:44 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94A525D9DC;
 Tue, 30 Jun 2020 08:50:43 +0000 (UTC)
Date: Tue, 30 Jun 2020 09:50:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] util/coroutine: Cleanup start_switch_fiber_ for TSAN.
Message-ID: <20200630085042.GD81930@stefanha-x1.localdomain>
References: <20200626170001.27017-1-robert.foley@linaro.org>
 <20200629132640.GN31392@stefanha-x1.localdomain>
 <875zb9svss.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <875zb9svss.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, cota@braap.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 05:04:19PM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Fri, Jun 26, 2020 at 01:00:01PM -0400, Robert Foley wrote:
> >> This is a cleanup patch to follow-up the patch which introduced TSAN.
> >> This patch makes separate start_switch_fiber_ functions for TSAN and A=
SAN.
> >>=20
> >> This does two things:
> >> 1. Unrelated ASAN and TSAN code is separate and each function only
> >>    has arguments that are actually needed.
> >> 2. The co->tsan_caller_fiber and co->tsan_co_fiber fields are only
> >>    access from within #ifdef CONFIG_TSAN.
> >>=20
> >> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> >> ---
> >>  util/coroutine-ucontext.c | 52 +++++++++++++++++++++++++-------------=
-
> >>  1 file changed, 34 insertions(+), 18 deletions(-)
> >
> > Thank you for revisiting this patch after it was applied!
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Who takes care of coroutine patches or should this go via a different
> tree?

Commit 0aebab04b9289bd37017593b413ce7a762b54c55 ("configure: add
--enable-tsan flag + fiber annotations for coroutine-ucontext") went
through your tree. Please take this follow-up patch too.

Stefan

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl76/OIACgkQnKSrs4Gr
c8jsPAgAvQQ1ogMqXLEsnxp0+t5UA4sACrW7utuWMo2Unn7+ehgl0SX4ckbBlv+y
uMve91NTCxNULipG0D0aRk7DnqcGr/1cHheBIOFVTdEJRxA4T187dNS6kRIoq09l
V5bMvqPp+awXruLxGD/WdCLJku1s3c0281vPBH2hY0CJr4T61cyjT0FgQFlD6MFH
4qYhInHuEZ0U5biBnrxiMehvO62AOI8cGoAdcJRRbqA07msz+R4uyRCXv1MOdK0s
3lN5gcmN7syQUfMjD8fTg6m3FtglZyAUl3XPwPv2YP1GGIs8voZVn+bXdccE5rg9
jWRwNaB7qttEkVa4IAZiB0uyEyrRVg==
=EUw1
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--


