Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5608DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E171F206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e00S1YtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E171F206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHBP-0004xr-Tz
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSHAB-00044v-QH
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSHAA-0007su-3l
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602583449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PNtlWiVKUhzKJe4rxk3gcogCX6ooUH6a0gML1Rf0a9g=;
 b=e00S1YtBUxLoXoxQg3s/JuH+7OUI4rA9EQEQFUGYvxG6GCjxBy2WA7mlXA+aDHUjHuld9Q
 c03MeTY5tiDCIiUCTB8SWQ0a8VoGj1KXX5z6sfRx1N3LQGWda3KDvO33/thSio+NUrNmSt
 ldNBbXsM1ZDoZZvMDemFDNyyyzPWLzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-fjvTgDUePz2YyPd3fBwx3A-1; Tue, 13 Oct 2020 06:04:05 -0400
X-MC-Unique: fjvTgDUePz2YyPd3fBwx3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8262518A8220;
 Tue, 13 Oct 2020 10:04:04 +0000 (UTC)
Received: from localhost (ovpn-114-249.ams2.redhat.com [10.36.114.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26A5827BD2;
 Tue, 13 Oct 2020 10:04:03 +0000 (UTC)
Date: Tue, 13 Oct 2020 11:04:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?utf-8?B?546L5rSq5rWp?= <wanghonghao@bytedance.com>
Subject: Re: PING: [PATCH 2/2] coroutine: take exactly one batch from global
 pool at a time
Message-ID: <20201013100403.GC164611@stefanha-x1.localdomain>
References: <20200824043121.13421-1-wanghonghao@bytedance.com>
 <20200824043121.13421-2-wanghonghao@bytedance.com>
 <20200825145250.GB7124@stefanha-x1.localdomain>
 <CADzM5uQnVRPaH6Xtef95BMJtLRCgNq2OcaMQi0xTG-dxUjJ1Fg@mail.gmail.com>
 <CADzM5uRNSZurnZ-wm8-FG7H3y7_bg+V5oNo4AjNiFSWmMJcijA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADzM5uRNSZurnZ-wm8-FG7H3y7_bg+V5oNo4AjNiFSWmMJcijA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 11:24:14AM +0800, =E7=8E=8B=E6=B4=AA=E6=B5=A9 wrote=
:
> Hi, I'd like to know if there are any other problems with this patch,
> or if there is a better implement to improve coroutine pool.

Please rebase onto qemu.git/master and resend the patch as a top-level
email thread. I think v2 was overlooked because it was sent as a reply:
https://wiki.qemu.org/Contribute/SubmitAPatch

Thanks,
Stefan

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+Fe5IACgkQnKSrs4Gr
c8jdmwgAp+6ucLRLRI4CITp49EhWr8XmPi0CnPOJko/UNrg+t6OjK4718fXCXYpw
yv4PnRP0ONxLo8vx8BI2UCUa5s3thfbaGkj5O7MLaeAYecyLEzw1zAX1jGRWctDC
YFDSidX+IMlY+rIRVMKMqsb6rMZ3Mfp+UdrMGBaSVxyiXKiBfQ0BrWuM00NSANft
Pt6xPOuwTL61wNzUTF4pX2+WkDzdwgj4p2y2qEWB3MeL2UkZRO2dcz1mn6Jk1yVl
b5cSrIofzJqtXdoOnqv64k8LOdh79A1ECs4e7JU2ShDpMCf7xZH2di21P2ecTaQS
t7yO5i5AFgIikmSVQg+YCxB0BHbJyQ==
=szHV
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--


