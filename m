Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5D9C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 21:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FC9207CD
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 21:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FC9207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9arq-00050K-R7
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 17:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1k9ar8-0004WQ-SJ
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 17:15:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:10550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1k9ar5-00020I-LH
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 17:15:18 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CB6D9746335;
 Sat, 22 Aug 2020 23:15:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A44AF745712; Sat, 22 Aug 2020 23:15:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A22D2745702;
 Sat, 22 Aug 2020 23:15:01 +0200 (CEST)
Date: Sat, 22 Aug 2020 23:15:01 +0200 (CEST)
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] ati-vga: Fix checks in ati_2d_blt() to avoid crash
In-Reply-To: <2041026f-7a88-d8f7-8738-968e1394e8c6@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2008222259320.91574@zero.eik.bme.hu>
References: <20200406204029.19559747D5D@zero.eik.bme.hu>
 <2041026f-7a88-d8f7-8738-968e1394e8c6@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-361680149-1598130901=:91574"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Prasad J Pandit <pjp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-361680149-1598130901=:91574
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 22 Aug 2020, Philippe Mathieu-Daudé wrote:
> On 4/6/20 10:34 PM, BALATON Zoltan wrote:
>> In some corner cases (that never happen during normal operation but a
>> malicious guest could program wrong values) pixman functions were
>> called with parameters that result in a crash. Fix this and add more
>> checks to disallow such cases.
>
> (Fair) question on IRC. Is this patch fixing CVE-2020-24352?
>
> Public on August 14, 2020
>
> Description
>
> An out-of-bounds memory access flaw was found in the ATI VGA device
> implementation of the QEMU emulator. This flaw occurs in the
> ati_2d_blt() routine while handling MMIO write operations through the
> ati_mm_write() callback. A malicious guest could use this flaw to crash
> the QEMU process on the host, resulting in a denial of service.

Probably this patch does not fix all possible malicious register writes a 
guest could do. This was fixing problems reported earlier but then I got 
some more reports around 5.1.0 freeze about some more overruns which I 
could not yet look at and nobody else was fixing it either so it's 
possible some bugs are still left in the checks.

However this is hardly security critical as ati-vga is experimental and 
not fully implemented yet so anyone using it will likely get other 
problems (such as drivers not loading) before a guest could exploit this. 
I think QEMU only considers bugs in parts that are used for virtualisation 
via KVM as security problems so maybe this does not even need a CVE and 
could be normally reported/discussed on the mailing list.

Basically what needs to be done is go through the checks again to verify 
that we don't pass params to pixman or set_dirty that result in access 
outside the video ram area. Probably there's still an off by one error or 
some other mistake. I'll eventually may try to fix it but if anyone is 
sending a patch earlier that's welcome. I don't have much time for QEMU 
now.

Regards,
BALATON Zoltan
--3866299591-361680149-1598130901=:91574--

