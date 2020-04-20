Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6B1C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06B6214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QmiFBagt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06B6214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQX1m-0007e9-4L
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40782 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQX0X-0006oJ-Gn
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:02:45 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQX0X-0002JI-4e
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:02:45 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:44330)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jQX0V-0002CT-EE; Mon, 20 Apr 2020 10:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=DOrn63tUs5rod4dJzQJOYVRjM2FWTvlRjNn+Okzns9Y=; 
 b=QmiFBagtwM9YxK1gsuP4hzOPpbOM07mYJKoq/GsgBBZUxjngecktiRJAraUdE3gC4AtBpvYr5omCK8O6blcvxwUktaveaK9W+52xtposQzSBxFIy3qdTk29fByYLAbNXv7beS957u6YOAj+Q9jF7otpDqHHg0i96FUBjohpidEpywyK4KpU9g/Wk51M4yhKB4uzcjTGVX2or18YUUHIk/DkNT3PFvzXE3QPukymCikwLYBWdRhcdpuhDByPV3frBLDrDARqBiN26Olt6mXq2ZKwmd3Cs15KHQ+aXolTCWeZY5kQf4W2V6Ia0QSdS4ssjvclXzeEDnKDPOry7S5oG4Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jQX0R-00086f-QM; Mon, 20 Apr 2020 16:02:39 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jQX0R-0000zp-GZ; Mon, 20 Apr 2020 16:02:39 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v4 4/9] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
In-Reply-To: <20200420133214.28921-5-kwolf@redhat.com>
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-5-kwolf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 20 Apr 2020 16:02:39 +0200
Message-ID: <w51zhb6p85c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 08:31:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 20 Apr 2020 03:32:09 PM CEST, Kevin Wolf wrote:
> If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> qcow2_cluster_zeroize() with flags=0 does the right thing: It doesn't
> undo any previous preallocation, but just adds the zero flag to all
> relevant L2 entries. If an external data file is in use, a write_zeroes
> request to the data file is made instead.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

