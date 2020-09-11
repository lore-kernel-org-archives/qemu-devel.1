Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEBAC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6D6208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9u96e0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6D6208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgY0-0001Kz-6X
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGgXS-0000p3-5k
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:44:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26549
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGgXQ-0002Wt-9y
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599821054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0y3h5pYABed696b2C0ZsXZIHj5Ts2oW+VvPbGD5Ud7k=;
 b=A9u96e0WSpizc4KGqtXZVGD37+0MwIOTJFwkFqTVr5pcEslLtCSENyon7ZBFnDZkli5xxu
 AtravLvTWdUtG+8+8XvuxgT4NoVSs1oe82DkVfm8YDfojyY7LNeOIhf/aIRQrOVWqQeBXC
 627CqPirX9QbflBaNf1Yf9O2hSPh300=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-zn0QqmUWNQiRR7OZ4zbYlQ-1; Fri, 11 Sep 2020 06:44:12 -0400
X-MC-Unique: zn0QqmUWNQiRR7OZ4zbYlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B912718A2248;
 Fri, 11 Sep 2020 10:44:11 +0000 (UTC)
Received: from localhost (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 521BE81C44;
 Fri, 11 Sep 2020 10:44:11 +0000 (UTC)
Date: Fri, 11 Sep 2020 11:44:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: flatview_write_continue global mutex deadlock
Message-ID: <20200911104410.GK94280@stefanha-x1.localdomain>
References: <3abe8579-3540-72fd-c452-3cc52d7fcf26@virtuozzo.com>
 <d8bb04e7-6edd-8b3d-8896-31c4d4075006@redhat.com>
 <242c6d2e-9c9a-7a73-aa47-c2283c3d3a1e@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <242c6d2e-9c9a-7a73-aa47-c2283c3d3a1e@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2feizKym29CxAecD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2020 at 06:42:12PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> But still, is it OK to do blk_drain holding the global mutex? Drain may take a relatively long time, and vm is not responding due to global mutex locked in cpu thread..

This is a fundamental problem in QEMU. Unfortunately I/O requests cannot
be canceled quickly (some protocols do not support cancelation at all).

There are code paths like device reset or monitor commands where drain
can hang for an unbounded amount of time :(.

Stefan

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9bVPoACgkQnKSrs4Gr
c8gFgAf/VJq8Xl9E6C17tmtj3KtQfgRoL23mHzi1scBSpzGWIIEjWZnWakgEVlRZ
WD2P6E87GcF944+Az9NBdoKdY5xtqvh5NmXywtQSS60+s6yWcOEhIn9aisRDCN5Y
ys1Ie4yJ9V5qVLuXmhHpqXvumVGsTLkdydtc3xC49XoLeNms6A+jBzaCzGemh+rh
5Cd49v7TgKzxdUTO4OiLjzlaLq+UclnH5NVe0vIEnZA5O56tWeETz26wSSx2zhrF
qR31oKMHhxpnX0BqWxvvGT2bYo5jaLOgv3/kFnDhayqOEyo35jlxBponATN3wPVV
GIFL4qaJsWVmiMpUFAF8cm7KbUFzNg==
=r9LW
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--


