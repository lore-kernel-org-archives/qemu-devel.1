Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A92C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A152020661
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A152020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTwF-0004mO-S4
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1jYTvW-0003uh-Fk; Tue, 12 May 2020 08:22:26 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:45461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1jYTvV-0003dH-1Z; Tue, 12 May 2020 08:22:25 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CFAA542BF1;
 Tue, 12 May 2020 14:22:16 +0200 (CEST)
Subject: Re: [RFC] bdrv_flush: only use fast path when in owned AioContext
To: Kevin Wolf <kwolf@redhat.com>
References: <20200511165032.11384-1-s.reiter@proxmox.com>
 <20200512105719.GI5951@linux.fritz.box>
 <20200512113255.GK5951@linux.fritz.box>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <c40bb7c6-2797-8e17-8cbd-4ecc75c3a7fb@proxmox.com>
Date: Tue, 12 May 2020 14:22:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200512113255.GK5951@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=s.reiter@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 08:22:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 1:32 PM, Kevin Wolf wrote:
> Am 12.05.2020 um 12:57 hat Kevin Wolf geschrieben:
>> Am 11.05.2020 um 18:50 hat Stefan Reiter geschrieben:
>>> Just because we're in a coroutine doesn't imply ownership of the context
>>> of the flushed drive. In such a case use the slow path which explicitly
>>> enters bdrv_flush_co_entry in the correct AioContext.
>>>
>>> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
>>> ---
>>>
>>> We've experienced some lockups in this codepath when taking snapshots of VMs
>>> with drives that have IO-Threads enabled (we have an async 'savevm'
>>> implementation running from a coroutine).
>>>
>>> Currently no reproducer for upstream versions I could find, but in testing this
>>> patch fixes all issues we're seeing and I think the logic checks out.
>>>
>>> The fast path pattern is repeated a few times in this file, so if this change
>>> makes sense, it's probably worth evaluating the other occurences as well.
>>
>> What do you mean by "owning" the context? If it's about taking the
>> AioContext lock, isn't the problem more with calling bdrv_flush() from
>> code that doesn't take the locks?
>>
>> Though I think we have some code that doesn't only rely on holding the
>> AioContext locks, but that actually depends on running in the right
>> thread, so the change looks right anyway.

"Owning" as in it only works (doesn't hang) when bdrv_flush_co_entry 
runs on the same AioContext that the BlockDriverState it's flushing 
belongs to.

We hold the locks for all AioContexts we want to flush in our code (in 
this case called from do_vm_stop/bdrv_flush_all so we're even in a 
drained section).

> 
> Well, the idea is right, but the change itself isn't, of course. If
> we're already in coroutine context, we must not busy wait with
> BDRV_POLL_WHILE(). I'll see if I can put something together after lunch.
> 
> Kevin
> 
> 

Thanks for taking a look!


