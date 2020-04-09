Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882CCC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518402051A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q1bJ4v0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518402051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYRz-00008B-FP
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jMYRI-00085s-TE
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jMYRH-00070H-Ds
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:45:56 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jMYRH-0006z4-5V; Thu, 09 Apr 2020 10:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=vCJuvbGEXOyQ+Z2ILvGgG2n7hg4j+b7qq3nEOfERyb4=; 
 b=Q1bJ4v0Ox17ohXbIEvylu8DIgN13lplthKR1iBtQXhknK4rzB/XE/TnGp3HuUxqwoZoZFXb1dV0pmTHocIlyWGh+gnwT1VgsRsynPvYovJR8dVJ8A6g3x+oDqID5zsTt2Uk361I4NYGb/jR2ZQ1ie9jiyrdUOUHagHCmIfyITxLXMl8UwBwQvoCr549G3Yes0lVrMQHCUQ0sa8gfixIhERF4o2+aQS+7yuLa+Srzy+LtJ7TU+FvSAhCMfqxa2/aOUxm8uOgMj5Lhclyp3/pQbS+PTCJxiVf9N7TfUjhEVqukFckEtQhYIEwjDWXM9hroSpSAtncz89680cuCWC/Dzg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jMYRD-0000Vv-6G; Thu, 09 Apr 2020 16:45:51 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jMYRC-00067P-T5; Thu, 09 Apr 2020 16:45:50 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 02/30] qcow2: Convert qcow2_get_cluster_offset() into
 qcow2_get_host_offset()
In-Reply-To: <71d9c655-90c9-f22d-a640-12551ac690a6@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <65243debd4a41e1ebd13877c2e6c665759c37b38.1584468723.git.berto@igalia.com>
 <71d9c655-90c9-f22d-a640-12551ac690a6@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 09 Apr 2020 16:45:50 +0200
Message-ID: <w518sj43eg1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
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
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 09 Apr 2020 09:50:52 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>       case QCOW2_CLUSTER_ZERO_PLAIN:
>>       case QCOW2_CLUSTER_UNALLOCATED:
>>           /* how many empty clusters ? */
>>           c = count_contiguous_clusters_unallocated(bs, nb_clusters,
>>                                                     &l2_slice[l2_index], type);
>> -        *cluster_offset = 0;
>> +        *host_offset = 0;
>
> Actually, dead assignment now.. But I feel that better to keep it.
>
> Hmm. May be, drop the first assignment of zero to host_offset? We
> actually don't need it, user should not rely on host_offset if we
> return an error.

Yeah, I'll drop the first one and keep this one.

>> @@ -3735,7 +3726,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
>>           offset = QEMU_ALIGN_DOWN(offset, s->cluster_size);
>>           bytes = s->cluster_size;
>
> Unrelated to the patch, but.. Why we change bytes?? So, we can finish
> with success, but zero-out only first cluster?
>
> Ah, found, generic block-layer take care of it and never issue
> unaligned requests crossing cluster boundary.

That's right, hence the assert(head + bytes <= s->cluster_size); a few
lines before.

Berto

