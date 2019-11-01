Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F72ECA9ED0
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5082086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="hofPKqQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5082086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQUd3-00075q-3b
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iQUZc-00055m-4e
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iQUZb-00014V-4r
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:54:32 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:59162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iQUZX-00011I-Sa; Fri, 01 Nov 2019 06:54:28 -0400
Received: from [192.168.43.155] (unknown [92.184.112.163])
 by beetle.greensocs.com (Postfix) with ESMTPSA id C042E96EF0;
 Fri,  1 Nov 2019 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1572605665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QYoQrIWBow58DQDXI3UidWuFOSJ+UeGFYx2xyHe/Mg=;
 b=hofPKqQRy+TDCePlPViU79rmY5/fCBFWsrvxKCwCYXyfjfles9wPDlBm1ji0cxKec2i/aN
 FReoma+RU+OGBIPfQlFiNVkD1UhNy6FbDoieGqBqgyd6MRdiWQi3s3o29BG6O7Lu7EUQkd
 enQvi/BNgRFjVUViahhPwFg62hIDEjk=
Subject: Re: [PATCH] hw/arm/pxa2xx: rebuild hflags cache when modifying CPU
 state
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191101103232.3692818-1-luc.michel@greensocs.com>
 <CAFEAcA96tfJNVrnQzKyzooy7sJ__WKWWHXdAy_TNy=hSB_DOQQ@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <67fc0feb-a765-7215-1e47-a2e112342915@greensocs.com>
Date: Fri, 1 Nov 2019 11:54:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA96tfJNVrnQzKyzooy7sJ__WKWWHXdAy_TNy=hSB_DOQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1572605665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QYoQrIWBow58DQDXI3UidWuFOSJ+UeGFYx2xyHe/Mg=;
 b=FBS8X01AbRknYA7QDnqd59uHCkpoi6yCgE20lJkTfPZcSlsKMP5FGa9WoMkH80NC3WaYaT
 b/XzPzhMHdbPf61HV+lrwwcyDCNv/9gZ3NkIMSVke1AUFha9cw77IMDvZmTC8lUr3Dgb5K
 0ayu0GSZKIqRbBC7UkpHkcjl48ebLms=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1572605665; a=rsa-sha256; cv=none;
 b=0sqt+AwYK/Zwj1bM+ZlrJmek11czVyishn9D/5TJeVgkWsEZLjLotnyBGBoUoSC62H8Jkm
 irMQueIhXTZpYciDFedTokvJOLQy/vfy6RbOmgnq5YjcCWoakRByp5BUVdYQQ+tsdPZ3IA
 xx0fbPyMdtAFvUOSQAwKzQ7DbDdF2Xk=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/1/19 11:42 AM, Peter Maydell wrote:
> On Fri, 1 Nov 2019 at 10:32, Luc Michel <luc.michel@greensocs.com> wrote:
>>
>> This machine modifies the CPU state when simulating suspend mode. This
>> commit adds a missing call to arm_rebuild_hflags after those
>> modifications.
>>
>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> ---
>> I came over this missing hflags rebuild while reviewing Edgar's similar
>> fix in hw/arm/boot.c. I could not find any other place where it would be
>> missing but I may be wrong.
> 
> pxa2xx_pwrmode_write() is a cp14 coprocessor register write
> function, so I think that the hflags rebuild that is done by
> translate.c:disas_coproc_insn() after a cp register write
> should already handle this case ?
OK. I missed the fact that it was a co-processor write callback.

> 
> 
> The other place that might need checking is the PSCI/etc
> code for doing CPU power on/off (and other callers to the
> power up/down functions like the imx6 power control regs).
> Richard, did you look at that code to see if it needed hflags updates?
> 
> thanks
> -- PMM
> 

