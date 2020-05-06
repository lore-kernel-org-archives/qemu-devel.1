Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84339C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9C0206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="a3bZ3Ob2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9C0206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIuQ-00021H-Es
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWIp5-0008Hv-3J; Wed, 06 May 2020 08:06:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:53606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWIp2-00056T-8W; Wed, 06 May 2020 08:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Wbk+qqq35eElZcbnBBrG5M7XfMH+WAsMrJBj1+CWtPw=; 
 b=a3bZ3Ob23DPrF9ICc/oJnp5DZXUx/WG8RTl3QAlLAwR3XahElDUDIBCYQjUIBx1qeVKLAqlp/EnK8e1dAU5Mzq4vxKFyPp4HBLdTgFGrCa5kqdN7ljC0Nf3V3D3L3oRLPL+UtaN04ydwT8H1ax8ienqFiEsvKqcgkRwRCaPbVWVBbccrF9wW+pHspGtezKEqikt4NdryQGCj1QAs+kPz8f3AVa+m2guccJv279f6dK1vtolhVZqELtB1OuXFZjECRunX30CTcPG475rPOiezphKGvcxTuGJ/zj2o4KQUO3IiTQeG0hzkw9KEIkjIVFViLGY6640ABw62h4rGablZyg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jWIox-0002V2-Tc; Wed, 06 May 2020 14:06:39 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jWIox-0007DR-Jv; Wed, 06 May 2020 14:06:39 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 13/31] qcow2: Update get/set_l2_entry() and add
 get/set_l2_bitmap()
In-Reply-To: <3295e0e3-8b7b-3440-55d9-a8d9458e5e17@redhat.com>
References: <cover.1588699789.git.berto@igalia.com>
 <30130e0f4662ea8ba705c5c54afc56bfb1ae70b6.1588699789.git.berto@igalia.com>
 <3295e0e3-8b7b-3440-55d9-a8d9458e5e17@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 06 May 2020 14:06:39 +0200
Message-ID: <w51ftcd9sj4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 06:18:29
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 05 May 2020 10:04:32 PM CEST, Eric Blake wrote:
> What happens for an image whose size is not cluster-aligned?  Must the
> bits corresponding to subclusters not present in the final cluster
> always be zero, or are they instead ignored regardless of value?

Attempting to read or write beyond the end of the image returns an error
(see blk_check_byte_request()).

But let's say we have a 32k image (only 1/2 of the first cluster is
used) and we manipulate the bitmap to mark all subclusters as allocated.

In this case if you try 'read 0 32k' then count_contiguous_subclusters()
would indeed say that there are 64k of data available. However the
caller knows that we only want 32k and

    if (bytes_available > bytes_needed) {
        bytes_available = bytes_needed;
    }

so in the end it doesn't really matter.

I think in practice it's the same as with traditional qcow2 images: once
we reach qcow2_get_host_offset() the code does not really know or care
about the size of the image or how much of the last cluster contains
actual data. It only cares about how much data the caller needs. The
limits have already been checked before.

But we could document it: "if the image size is not a multiple of the
cluster size then the bits corresponding to the subclusters beyond the
end of the image are ignored and should be set to zero", or something
like that.

Berto

