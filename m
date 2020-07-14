Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45FCC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C6522464
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C6522464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-jedi.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKPs-0005Sx-SG
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@the-jedi.co.uk>)
 id 1jvKOy-0004Gf-6i
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:51:16 -0400
Received: from vps.the-jedi.co.uk ([93.93.130.107]:36126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@the-jedi.co.uk>)
 id 1jvKOv-0002kw-Py
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:51:15 -0400
Received: by vps.the-jedi.co.uk (Postfix, from userid 111)
 id 3BC6342D28; Tue, 14 Jul 2020 13:51:11 +0100 (BST)
Received: from [192.168.0.5] (host86-179-4-163.range86-179.btcentralplus.com
 [86.179.4.163])
 by vps.the-jedi.co.uk (Postfix) with ESMTPSA id 2B3FF42B57;
 Tue, 14 Jul 2020 13:51:10 +0100 (BST)
To: qemu-devel@nongnu.org
References: 
Subject: Re: [PATCH v2 for-5.1] acpi-pm-tmr: allow any small-size reads
From: Simon John <git@the-jedi.co.uk>
Message-ID: <36e5f632-8b08-d6bc-0092-e53f42f69ed3@the-jedi.co.uk>
Date: Tue, 14 Jul 2020 13:51:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=93.93.130.107; envelope-from=git@the-jedi.co.uk;
 helo=vps.the-jedi.co.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 08:51:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 07:10:14 -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 14, 2020 at 01:51:13PM +0300, Michael Tokarev wrote:
>> As found in LP#1886318, MacOS Catalina performs 2-byte reads
>> on the acpi timer address space while the spec says it should
>> be 4-byte. Allow any small reads.
>> 
>> Reported-By: Simon John <git@the-jedi.co.uk>
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Simon's explanation about the history is good to have here,
> and I guess Fixes tags (both what you found and what Simon found)
> can't hurt either. I would CC stable too.
> 
> Simon do you have the time to iterate on this patch or would
> you rather have Michael do it?

Sorry, I seem to not be getting all of these emails but trying to watch 
the list archive.

I just tested Michael's v2 patch and it works fine:

static const MemoryRegionOps acpi_pm_tmr_ops = {
     .read = acpi_pm_tmr_read,
     .write = acpi_pm_tmr_write,
     .impl.min_access_size = 4,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
};

I'm happy for Michael to proceed with the patch, he's mentioned me and 
linked to the launchpad bug where the history is.

Regards.

-- 
Simon John

