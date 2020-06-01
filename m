Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5A5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65262206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TXcyfc/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65262206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfsCV-0008S8-Gu
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1jfsBQ-0007ss-8Y
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:41:24 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:39943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1jfsBN-0006hy-UG
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Y/fUHW7rJxdImoMA4MIjvnLkv+bi/FELHwDnpsx65xI=; 
 b=TXcyfc/fTO/j1fuacG7o4tI9iNakziWkD21U6NxU27aQy8D+mFx+X9H38TzHVx/lIXp0F908q4sYownGSj3blHZvh8N3OBFeetGymksyh2X8W3a2W1hD8zJtHOYijfOCGZvFwOWOA/EY7FRigeBPVnjNx6ecvpiMOVZLsQ5YRSw3lAbKVCtzvtxyWGT8ZCDeUWZCep4LFUb7FunlYYdXZgS+/Ge6Ixf1Rm+wb9lF5WZ8XW73MtYqyBlQ5Cmc32g0ElWgeI16Ta0qhWdV9AjEC9vMZVNtq9pkOobR0Oekv3ZE8MxRyCRmH6KPPwENtEcuMD2nWU57KnHCEONuB/31XQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jfsBB-0004T4-Bh; Mon, 01 Jun 2020 23:41:09 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jfsBB-0001TH-2P; Mon, 01 Jun 2020 23:41:09 +0200
From: Alberto Garcia <berto@igalia.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH] block/quorum.c: Decrease child index when del_child
In-Reply-To: <20200601201200.10e2ea59@luklap>
References: <20200601071956.18006-1-chen.zhang@intel.com>
 <w515zcbm5p3.fsf@maestria.local.igalia.com> <20200601201200.10e2ea59@luklap>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 01 Jun 2020 23:41:09 +0200
Message-ID: <w517dwqsbuy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 17:41:17
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
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 01 Jun 2020 08:12:00 PM CEST, Lukas Straub wrote:
>> As I explained a few weeks ago this patch is not correct.
>> quorum_del_child() allows you to remove any child from the Quorum
>> device, so nothing guarantees that next_child_index-1 is free.
>> 
>> https://lists.gnu.org/archive/html/qemu-block/2020-05/msg00634.html
>> 
> Hi,
> Did you have a look at my series? There it's fixed properly:
> https://lore.kernel.org/qemu-devel/9df6b3723ec30cb749ceaa555d82a29a6d79496d.1589199922.git.lukasstraub2@web.de/

Oh, I somehow overlooked that, thanks for the reminder!

Berto

