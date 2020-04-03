Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52801C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2416320757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2416320757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKG96-0000Ff-8l
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 02:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <t.lamprecht@proxmox.com>) id 1jKG8N-0007YG-8M
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <t.lamprecht@proxmox.com>) id 1jKG8L-0001WI-43
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:48:55 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:5232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <t.lamprecht@proxmox.com>)
 id 1jKG8H-0001PD-QE; Fri, 03 Apr 2020 02:48:49 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 083A342980;
 Fri,  3 Apr 2020 08:48:39 +0200 (CEST)
Subject: Re: bdrv_drained_begin deadlock with io-threads
To: Kevin Wolf <kwolf@redhat.com>, Dietmar Maurer <dietmar@proxmox.com>
References: <20200401103748.GA4680@linux.fritz.box>
 <997901084.0.1585755465486@webmail.proxmox.com>
 <20200401181256.GB27663@linux.fritz.box>
 <1403939459.52.1585765681569@webmail.proxmox.com>
 <20200401184431.GD27663@linux.fritz.box>
 <903538836.29.1585818619688@webmail.proxmox.com>
 <20200402121403.GB4006@linux.fritz.box>
 <20200402142524.GD4006@linux.fritz.box>
 <1043934808.59.1585842050330@webmail.proxmox.com>
 <20200402164744.GE4006@linux.fritz.box>
 <20200402171007.GF4006@linux.fritz.box>
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
Message-ID: <45d640cb-a8bc-1bee-127e-ef28188a5623@proxmox.com>
Date: Fri, 3 Apr 2020 08:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200402171007.GF4006@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 7:10 PM, Kevin Wolf wrote:
> Am 02.04.2020 um 18:47 hat Kevin Wolf geschrieben:
>> So I think this is the bug: Calling blk_wait_while_drained() from
>> anywhere between blk_inc_in_flight() and blk_dec_in_flight() is wrong
>> because it will deadlock the drain operation.
>>
>> blk_aio_read/write_entry() take care of this and drop their reference
>> around blk_wait_while_drained(). But if we hit the race condition that
>> drain hasn't yet started there, but it has when we get to
>> blk_co_preadv() or blk_co_pwritev_part(), then we're in a buggy code
>> path.
> 
> With the following patch, it seems to survive for now. I'll give it some
> more testing tomorrow (also qemu-iotests to check that I didn't
> accidentally break something else.)
> 

So I only followed the discussion loosely, but tried some simple reproducing
to ensure it was an issue independent of some artifacts on Dietmar's setup.

Before that patch I got always a hang before reaching the fifth drive-backup
+ block-job-cancel cycle. With your patch applied I had no hang so far,
currently into >885 cycles (and yes I confirmed stress -d 5 was really
running).

So, FWIW, the patch definitively fixes the issue or at least the symptoms
here, I cannot comment on its correctness or the like at all, as I'm
currently missing to much background.

cheers,
Thomas


