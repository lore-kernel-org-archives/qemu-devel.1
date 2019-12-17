Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1109C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA312067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VedcHy5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA312067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih9ij-00031U-J4
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 05:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ih9i6-0002UI-Ku
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ih9i1-00069F-P7
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:04:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ih9i1-00069B-Kh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576577044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTdJ9BlYlKA52aob596FqEnZ+Y7D0Vb4IPmF21pH2xE=;
 b=VedcHy5Mg2DJfe34cwxHcfkDLxtoi1poqRXvzu5lc91CVgDk4zHaJBj53c1i89kuzH5OHA
 wF8W92iuqXG/7HZNR/Fz1QzZmbwqUje3R34dNQh+yYK1wX5mQPbWf0kXYDSbMSNmDOuoOx
 kBHgKTMwY0+wt0yFst4OSPyuJ1qBkoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-ct_whX23NC2rkIxa7qnbow-1; Tue, 17 Dec 2019 05:04:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C012107ACC7;
 Tue, 17 Dec 2019 10:04:02 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D3A37C836;
 Tue, 17 Dec 2019 10:04:01 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] hw/arm/smmuv3: Correct stream ID and event address
 handling
To: Simon Veith <sveith@amazon.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1576509312-13083-1-git-send-email-sveith@amazon.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e0a55905-e76e-40d2-3d9b-06ea5b917001@redhat.com>
Date: Tue, 17 Dec 2019 11:03:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1576509312-13083-1-git-send-email-sveith@amazon.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ct_whX23NC2rkIxa7qnbow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 12/16/19 4:15 PM, Simon Veith wrote:
> While working on the Linux SMMUv3 driver, I noticed a few cases where the QEMU
> SMMUv3 behavior relating to stream tables was inconsistent with our hardware.
> 
> Also, when debugging those differences, I found that the errors reported through
> the QEMU SMMUv3 event queue contained the address fields in an incorrect
> position.
> 
> These patches correct the QEMU SMMUv3 behavior to match the specification (and
> the behavior that I observed in our hardware). Linux guests normally will not
> notice these issues, but other SMMUv3 driver implementations might.
> 
> Changes in v2:
> 
> * New patch "hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value" added
> * Updated patch "hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE"
> * Updated patch "hw/arm/smmuv3: Align stream table base address to table size"
> 
> Changes in v3:
> 
> * No changes, but sending again to correct a patch submission mishap that
>   confused Patchew
> 
> Simon Veith (6):
>   hw/arm/smmuv3: Apply address mask to linear strtab base address
>   hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value
>   hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE
>   hw/arm/smmuv3: Align stream table base address to table size
>   hw/arm/smmuv3: Use correct bit positions in EVT_SET_ADDR2 macro
>   hw/arm/smmuv3: Report F_STE_FETCH fault address in correct word
>     position

The series looks good to me. Also tested against non regression.

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


> 
>  hw/arm/smmuv3-internal.h |  6 +++---
>  hw/arm/smmuv3.c          | 28 +++++++++++++++++++++-------
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 


