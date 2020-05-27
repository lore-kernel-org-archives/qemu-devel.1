Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D767C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED94620B80
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KoVeblNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED94620B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdskE-0003gz-4r
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdsjQ-0002gs-1O; Wed, 27 May 2020 05:52:16 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdsjO-0001QO-NT; Wed, 27 May 2020 05:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=xcsMV6x3Yw4/vt5kK3/gFxk5uz9RiZ9lcSsKizVNFiI=; 
 b=KoVeblNVAHSN/mFWkg8P2mXoo/Q8gTnatNr98zrEu5LOTV/ChhqfbL2JPLZA6Gwz6zBT6UW0TDf4DiGVLFp5H2XqSTz+R+FqYkdF3DLmGaPBJrXXyW1avIY/MPFZ5q7xsZDKL7HFJeWtWT0otDbxUH9g/6k/Ja23Qx3CksbddkuHbTyyr7tkp8oXRtpUHvXuihRmZc2/UR7fLiNErtQRYxL4ObtTQIVizPruuLooUPylcKG27hQCe4Sva3OLu48tnU/7fc+d2/Oy7yixevXrnnz64ugIAkT3BYpEs8JI5aowdIPzVkwAN2ijOrOfCmPI90JhxFY7qbuYm/hrcnkSDA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jdsiy-00081l-LY; Wed, 27 May 2020 11:51:48 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jdsiy-0003rZ-8f; Wed, 27 May 2020 11:51:48 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 14/32] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
In-Reply-To: <c423bd22-cfd3-48c6-1129-eb784017cb8a@redhat.com>
References: <cover.1590429901.git.berto@igalia.com>
 <961e6f3e3af13a25c666859b391b7ed147873d8b.1590429901.git.berto@igalia.com>
 <c423bd22-cfd3-48c6-1129-eb784017cb8a@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 27 May 2020 11:51:48 +0200
Message-ID: <w51k10xk8nf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:51:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 26 May 2020 10:32:08 PM CEST, Eric Blake wrote:
>> +/* The subcluster X [0..31] is allocated */
>> +#define QCOW_OFLAG_SUB_ALLOC(X)   (1ULL << (X))
>> +/* The subcluster X [0..31] reads as zeroes */
>> +#define QCOW_OFLAG_SUB_ZERO(X)    (QCOW_OFLAG_SUB_ALLOC(X) << 32)
>> +/* Subclusters [X, Y) (0 <= X <= Y <= 32) are allocated */
>
> As you are now using a half-open range, should this be:
>   (0 <= X < Y <= 32)

I changed the macros because I wanted to allow cases where X == Y.

The reason is the new qcow2_get_subcluster_range_type() function:

    case QCOW2_SUBCLUSTER_NORMAL:
        val = l2_bitmap | QCOW_OFLAG_SUB_ALLOC_RANGE(0, sc_from);
        return cto32(val) - sc_from;

If sc_from is 0 then the result of the macro is also 0, and 'val' equals
the lower 32 bits (allocation status bits) of the L2 bitmap, as
expected.

>> +#define QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) \
>> +    (QCOW_OFLAG_SUB_ALLOC(Y) - QCOW_OFLAG_SUB_ALLOC(X))
>
> with <= instead of <, then it is impossible to distinguish between
> QCOW_OFLAG_SUB_ALLOC_RANGE(0,0) and QCOW_OFLAG_SUB_ALLOC_RANGE(31,31)
> which both resolve to 0.

Exactly, there is no difference and there should not be.

Berto

