Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A19BC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450B62064C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JrdXaXCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450B62064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3ei-00009R-DG
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jT3dv-0007of-B2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jT3dp-00008S-Jm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:17:50 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:36995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jT3do-0008N4-N2; Mon, 27 Apr 2020 09:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=ogBT2rrSCQ7EQ93e2xZwJuDkK6OjRkxaGx11ZmypBWw=; 
 b=JrdXaXCVY/k1oJZBXYRF2u6AumViRX2R3Z6bYj1GGiHK9l6cy2k4tutvHUgBJIkBXcTsbwryQ5U3SJmzVZPJ/D4Asz5aHkVAvWEdg9XW7Ns5a+ggHqMysNjVMkZWtQo1smYlkFfPMnCsBGuyTEGOUvmnShf6BoGmVAFXziL3mLG22VpUlr4HYxISnASzR8ogKgvZwNNGWZlvC+ha9voX0YHFqTqCDeTD1IgFFvGIbIOdABIyjCgi7bB2VJkHjGeORfcrDufq9hIICCcJPH5ZmQ7N24E3oUWO602dhon4WwERoQg3nxhEkxPoBkJtSHPxD1A/1wvmQAoiexQc3KMzTg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jT3dQ-0007xA-Of; Mon, 27 Apr 2020 15:17:20 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jT3dQ-0000Et-F7; Mon, 27 Apr 2020 15:17:20 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 23/30] qcow2: Update L2 bitmap in
 qcow2_alloc_cluster_link_l2()
In-Reply-To: <15b848ef-3e86-91f4-4ef6-5adde7ac750d@redhat.com>
References: <cover.1584468723.git.berto@igalia.com>
 <6ffd3ee7ca1e53272705ad34d2ea7ac10b50ade0.1584468723.git.berto@igalia.com>
 <15b848ef-3e86-91f4-4ef6-5adde7ac750d@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 27 Apr 2020 15:17:20 +0200
Message-ID: <w51mu6xt6e7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 09:17:22
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 24 Apr 2020 09:39:25 PM CEST, Eric Blake wrote:
>> +        /* Update bitmap with the subclusters that were just written */
>> +        if (has_subclusters(s)) {
>> +            unsigned written_from = m->cow_start.offset;
>> +            unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes ?:
>> +                m->nb_clusters << s->cluster_bits;
>> +            uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
>> +            int sc;
>> +            for (sc = 0; sc < s->subclusters_per_cluster; sc++) {
>> +                int sc_off = i * s->cluster_size + sc * s->subcluster_size;
>> +                if (sc_off >= written_from && sc_off < written_to) {
>> +                    l2_bitmap |= QCOW_OFLAG_SUB_ALLOC(sc);
>> +                    l2_bitmap &= ~QCOW_OFLAG_SUB_ZERO(sc);
>> +                }
>> +            }
>
> Are there more efficient ways to set this series of bits than iterating 
> one bit at a time, while still remaining legible?  For example, what if 
> we had something like:
>
> l2_bitmap = get_l2_bitmap(...);
> int sc_from = OFFSET_TO_SC(written_from);
> int sc_to = OFFSET_TO_SC(written_to - 1);
> l2_bitmap |= QCOW_OFLAG_SUB_ALLOC_RANGE(sc_from, sc_to);
> l2_bitmap &= ~QCOW_OFLAG_SUB_ZERO_RANGE(sc_from, sc_to);

That's a very good suggestion, thanks!

Berto

