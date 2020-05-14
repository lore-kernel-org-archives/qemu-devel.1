Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A193B2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A193B2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDoQ-0001vz-PW
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1jZDnm-0001LA-Cq; Thu, 14 May 2020 09:21:30 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:53667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1jZDnl-0000ky-0q; Thu, 14 May 2020 09:21:29 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D621142E1C;
 Thu, 14 May 2020 15:21:14 +0200 (CEST)
Subject: Re: [RFC PATCH 0/3] block: Synchronous bdrv_*() from coroutine in
 different AioContext
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200512144318.181049-1-kwolf@redhat.com>
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
Message-ID: <6d78bc78-0c44-d703-6f9f-e048ea34fdd9@proxmox.com>
Date: Thu, 14 May 2020 15:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200512144318.181049-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 09:21:15
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
Cc: qemu-devel@nongnu.org, s.reiter@proxmox.com, armbru@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 4:43 PM, Kevin Wolf wrote:
> Stefan (Reiter), after looking a bit closer at this, I think there is no
> bug in QEMU, but the bug is in your coroutine code that calls block
> layer functions without moving into the right AioContext first. I've
> written this series anyway as it potentially makes the life of callers
> easier and would probably make your buggy code correct.

> However, it doesn't feel right to commit something like patch 2 without
> having a user for it. Is there a reason why you can't upstream your
> async snapshot code?

I mean I understand what you mean, but it would make the interface IMO so
much easier to use, if one wants to explicit schedule it beforehand they
can still do. But that would open the way for two styles doing things, not
sure if this would seen as bad. The assert about from patch 3/3 would be
already really helping a lot, though.

Regarding upstreaming, there was some historical attempt to upstream it
from Dietmar, but in the time frame of ~ 8 to 10 years ago or so.
I'm not quite sure why it didn't went through then, I see if I can get some
time searching the mailing list archive.

We'd be naturally open and glad to upstream it, what it effectively allow
us to do is to not block the VM to much during snapshoting it live.

I pushed a tree[0] with mostly just that specific code squashed together (hope
I did not break anything), most of the actual code is in commit [1].
It'd be cleaned up a bit and checked for coding style issues, but works good
here.

Anyway, thanks for your help and pointers!

[0]: https://github.com/ThomasLamprecht/qemu/tree/savevm-async
[1]: https://github.com/ThomasLamprecht/qemu/commit/ffb9531f370ef0073e4b6f6021f4c47ccd702121


