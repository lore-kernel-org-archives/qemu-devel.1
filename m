Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DB6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D49207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D49207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgqPP-0000zB-Nu
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgqOs-0000UN-Bu
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:59:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:57742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgqOq-0001uF-4e
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:59:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5C1EF746335;
 Thu,  4 Jun 2020 15:59:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3BBD874632C; Thu,  4 Jun 2020 15:59:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 39E9A74632B;
 Thu,  4 Jun 2020 15:59:05 +0200 (CEST)
Date: Thu, 4 Jun 2020 15:59:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3] ati-vga: check mm_index before recursive call
 (CVE-2020-13800)
In-Reply-To: <20200604134727.h7z6lfqvlawofpfi@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.22.395.2006041550070.92788@zero.eik.bme.hu>
References: <20200604090830.33885-1-ppandit@redhat.com>
 <20200604134727.h7z6lfqvlawofpfi@sirius.home.kraxel.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 09:59:05
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Ren Ding <rding@gatech.edu>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020, Gerd Hoffmann wrote:
>> +        } else if (s->regs.mm_index > MM_DATA + 3) {
>>              val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);
>
> MM_INDEX is 0
> MM_DATA  is 4
> "normal" registers start at 8.
>
> So we want allow indirect access for offset 8 and above and deny offsets
> 0-7.  mm_index is interpreted with an offset, see "- MM_DATA" in the
> call above.

MM_INDEX is the register to read, addr - MM_DATA is an offset for 
unaligned access (when guest reads MM_DATA + 1, size=2 then we need to 
return regs[valueof(MM_INDEX) + 1], size=2.

> Not clear to me why this offset is 4, that doesn't make sense to me.
> I'd expect either no offset or offset being 8.  BALATON, can you
> double-check that with the specs?

We check that valueof(MM_INDEX) is at least MM_DATA + 4 = 8

> Assuming offset 4 is correct we must require mm_index being larger than
> MM_DATA + MM_DATA + 3 ( == 11) to compensate for the offset.

I don't get this, I think you're confusing value of MM_INDEX and offset of 
reading MM_DATA reg itself which together define what register is read 
with what offset during recursion. We don't want to recurse if clients 
tries to access either MM_INDEX or MM_DATA via these regs themselves to 
avoid infinite recursion.

Regards,
BALATON Zoltan

