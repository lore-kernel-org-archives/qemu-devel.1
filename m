Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17211C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 01:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B3B20679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 01:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="amHt+wi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B3B20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2QV2-0006Xa-3M
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 21:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1i2QU4-0005yZ-VB
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 21:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i2QU2-0004PZ-F6
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 21:41:19 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1i2QU2-0004Oo-2t
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 21:41:18 -0400
Received: by mail-pl1-x641.google.com with SMTP id z3so10958949pln.6
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 18:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7U/jn/R+vO/afFRwuNlwaRI8TjPylRvxnb84Zsc1Dl8=;
 b=amHt+wi/8cfk0Cf+9MsxouIKDsBiAyCSP3dZhMO0SqAJt2079o0kojs+LtTV7/iHBi
 H6N2LPrhTLeTKXbQ6WZ72z96HGshK4kP5hA0+C09XoYnHYd4eo6/fIUB58oQD8HPb0AT
 +Wq+pB1Y6HQbpLdfADLlMovpWw+8xmHY2dghw+qK+pY+Pz3mZ+r8qX44EYpHSDbEahhe
 4w5ufxxFyBfsSQysOeKQ3V4AEPSAyMViWD5baisGan3+epBw4FvL5Z5pGeVm2cKYz6ng
 xZOsqoj393xBhTbWxkvc8C2SVfZ7MmoQluA/QVJs00AIWOQDnnMC3T+RpbJqMB09OeQp
 3nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7U/jn/R+vO/afFRwuNlwaRI8TjPylRvxnb84Zsc1Dl8=;
 b=sAXxCd0deBldLoBF8JzMFjiNZ+s+jIK6uQLgl9RcXZT9uTjoKSWnlrXPDs4RdGMUDO
 yKzHPKw/GOSuRLc/EhukqHwWc8v8Nfx4r7Zww0boqIEE1dUuOP142G9iWLAX5J8Bb04c
 SvYFdCkh0PivzOqjskTw8WS++QptyOtRjU0Vf5vdyfWs/36l2TqduVh3CaXSz/bczSHd
 lojfa+rFjGW5JSa0rhbJu8R3BUljzbUw57NLPI16wQ3OI80EyKK1ASTZS/3Lrc096o/8
 44uOl5dgtklGc5wxoyisFpdeNwXxxIOvAATPgn1nTBVn9JzvdQARDCHDNtHOu6E6BgI7
 qXNg==
X-Gm-Message-State: APjAAAWPbjyTifNX8ZspkxStwQdT5Zf3LjnrLwCYONbgZEzgqGwoDr3M
 X0aP3BuqwMOwpX6FAsM4tvnZo2AZDAU=
X-Google-Smtp-Source: APXvYqzwoFyKTrNtQbXLr1AfeOHrEOhEKZgbysEsZZcOrV640f5H+qpVakE3IS8Cybro2JyHsjaG2A==
X-Received: by 2002:a17:902:a981:: with SMTP id
 bh1mr21287259plb.236.1566870077075; 
 Mon, 26 Aug 2019 18:41:17 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v15sm12599891pfn.69.2019.08.26.18.41.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 18:41:16 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190826043126.11589-1-aik@ozlabs.ru>
 <20190826074431.GA28081@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4692fae3-bcae-4221-6c1b-064a02111d1f@ozlabs.ru>
Date: Tue, 27 Aug 2019 11:41:13 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826074431.GA28081@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH qemu] spapr: Render full FDT on ibm,
 client-architecture-support
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 26/08/2019 17:44, David Gibson wrote:
> On Mon, Aug 26, 2019 at 02:31:26PM +1000, Alexey Kardashevskiy wrote:
>> The ibm,client-architecture-support call is a way for the guest to
>> negotiate capabilities with a hypervisor. It is implemented as:
>> - the guest calls SLOF via client interface;
>> - SLOF calls QEMU (H_CAS hypercall) with an options vector from the guest;
>> - QEMU returns a device tree diff (which uses FDT format with
>> an additional header before it);
>> - SLOF walks through the partial diff tree and updates its internal tree
>> with the values from the diff.
>>
>> This changes QEMU to simply re-render the entire tree and send it as
>> an update. SLOF can handle this already mostly, [1] is needed before this
>> can be applied.
>>
>> The benefit is reduced code size as there is no need for another set of
>> DT rendering helpers such as spapr_fixup_cpu_dt().
>>
>> The downside is that the updates are bigger now (as they include all
>> nodes and properties) but the difference on a '-smp 256,threads=1' system
>> before/after is 2.35s vs. 2.5s.
>>
>> While at this, add a missing g_free(fdt) if the resulting tree is bigger
>> than the space allocated by SLOF. Also, store the resulting tree in
>> the spapr machine to have the latest valid FDT copy possible (this should
>> not matter much as H_UPDATE_DT happens right after that but nevertheless).
>>
>> [1] https://patchwork.ozlabs.org/patch/1152915/
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Can you wrap that up with the SLOF update in a pull request for me?


Yup, I'll just wait a little bit more for replies about the RTAS log 
extension patch. Cheers,



-- 
Alexey

