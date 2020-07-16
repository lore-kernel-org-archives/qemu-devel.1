Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE913C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD69220760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h40TvnSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD69220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzAy-0006oZ-2m
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1jvz8B-00030h-2y
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:20:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1jvz88-0000JQ-HJ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594887634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERsZ0qsVUxErlNvpTdbzXdybHfikO8guDnV8/TdKtFw=;
 b=h40TvnSHb/M4Yx51zXYIwugb1rDH4T6oneIT6gOHJUuB610ujsEiuMisQ+fcp+AH2bB7Hx
 60xJ16oedQ0cKlgBT2uAzfSfoF/4NQGtX3dbYinXJXGcjfW2DGsHN+b9vzATZb1zkFp4iI
 hHBCE8BERxus/nWXq1f6dWVFkMpB/vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-j4iwPWKDPBO1tP3-u6vcsg-1; Thu, 16 Jul 2020 04:20:30 -0400
X-MC-Unique: j4iwPWKDPBO1tP3-u6vcsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB98918A1DE8;
 Thu, 16 Jul 2020 08:20:29 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1F7872E4A;
 Thu, 16 Jul 2020 08:20:29 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id E6C393E047D; Thu, 16 Jul 2020 10:20:27 +0200 (CEST)
Date: Thu, 16 Jul 2020 10:20:27 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2] crypto: use a stronger private key for tests
Message-ID: <20200716082027.GB11047@paraplu>
References: <20200715154701.1041325-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200715154701.1041325-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 04:47:01PM +0100, Daniel P. Berrangé wrote:
> The unit tests using the x509 crypto functionality have started
> failing in Fedora 33 rawhide with a message like
> 
>       The certificate uses an insecure algorithm
> 
> This is result of Fedora changes to support strong crypto [1]. RSA

It looks like the reference [1] is supposed to resolve to the following
URL:

    https://fedoraproject.org/wiki/Changes/StrongCryptoSettings2

Whoever is applying the patch might want to tweak the commit. FWIW:

    Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>    

> with 1024 bit key is viewed as legacy and thus insecure. Generate
> a new private key which is 3072 bits long and reasonable future
> proof.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> Changed in v2:
> 
>  - ALso fix the I/O tests key
>  - Use RSA key again instead of EC, since it is needed
>    for the real TLS sessions in the I/O tests
> 
>  tests/crypto-tls-x509-helpers.c | 59 ++++++++++++++++++++++-----------
>  tests/qemu-iotests/common.tls   | 57 +++++++++++++++++++++----------
>  2 files changed, 79 insertions(+), 37 deletions(-)
> 
[...]

-- 
/kashyap


