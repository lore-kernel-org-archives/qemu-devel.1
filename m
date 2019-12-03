Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF8C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070BA206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ZFbZY0Zz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070BA206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icAFm-0003Bo-18
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 10:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1icA6P-0000H2-SY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1icA6N-0000pv-Ij
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:28:36 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:41968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1icA6D-0000G9-NK; Tue, 03 Dec 2019 10:28:26 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 1E7B096EF0;
 Tue,  3 Dec 2019 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575386897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yERPzRJQrw1BP5h162NpfWzRvwpbb+McaU1URc4BXlc=;
 b=ZFbZY0ZzmVolddP5etGi1xVETJbXnQGewqpWk4Ieb/mwEyQGp1kMlyuU7jS1S/Pc7xzE8A
 zMiRgBsBm3y+Ialwpile/0xPnn/r6VHUNmUwDkobqz92SFNczV+6XTKvM474QcZDpiHPHQ
 lHUFcQhGi9o4tWwnpiu1x95awyZcRjs=
Subject: Re: [PATCH v6 1/9] hw/core/clock: introduce clock objects
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-2-damien.hedde@greensocs.com>
 <CAFEAcA99wzV9-dQ6oWxs7OPjxZ4vQWD_FXRLnBg7H-N1W2BMLA@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <b16cd9f0-f1b5-4e21-a5ec-a930874adbc0@greensocs.com>
Date: Tue, 3 Dec 2019 16:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99wzV9-dQ6oWxs7OPjxZ4vQWD_FXRLnBg7H-N1W2BMLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575386897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yERPzRJQrw1BP5h162NpfWzRvwpbb+McaU1URc4BXlc=;
 b=PPLZUPuNfrmcELa2SaBimi7sz6SO28AzOGtjJ6+lQrJt5Okqx5I3p9FABqL0zGPJ5W6cut
 5MV3huYpUTNx4Gkj4/iTcm9DseWuP6sDOiDd7KcK6YQv6fmipGUqE3DMYv6R3yGt3AQOrj
 BIIwdPTbOLQ0rc1i8cpcS5c/7y5hkmI=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575386897; a=rsa-sha256; cv=none;
 b=5XK1zhFzLtTDBCrD31s1z2O09n2QbD4oI9JEQ5/0miQ7+E8xFDIZBDYokdqLuCBJov8vFv
 QeOaHv5Xu4y/tVLLUYXTVX5gv2y9MVBlyU/hiWb+aNzyqL+re7qYmRA1jSCYOrPhcRZLyM
 0+gAG4ZWQro3kLN750LIPJbSOfzi61Y=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/2/19 2:42 PM, Peter Maydell wrote:
> On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Introduce clock objects: ClockIn and ClockOut.
>>
>> These objects may be used to distribute clocks from an object to several
>> other objects. Each ClockIn object contains the current state of the
>> clock: the frequency; it allows an object to migrate its input clock state
>> independently of other objects.
>>
>> A ClockIn may be connected to a ClockOut so that it receives update,
> 
> "updates" (or "an update")
> 
>> through a callback, whenever the Clockout is updated using the
>> ClockOut's set function.
>>
>> This is based on the original work of Frederic Konrad.
>>
>> +
>> +#define CLOCK_PATH(_clk) (_clk->canonical_path)
> 
> Don't use leading underscores in identifiers, please.

ok

> 
>> +
>> +void clock_init_frequency(ClockIn *clk, uint64_t freq)
>> +{
>> +    assert(clk);
> 
> This sort of assert isn't necessary. Asserts are good
> when they help to make a bug visible sooner and more
> obviously -- when they avoid "something goes wrong
> much later on and further from the site of the actual
> error". In this case, if the assert was not present
> then the code would just segfault on the next line:
> 
>> +
>> +    clk->frequency = freq;
> 
> which is already a very easy bug to diagnose and
> where the offending caller will be in the backtrace.
> 
> If the parameter isn't supposed to be NULL, and the
> method doesn't actually do anything that would
> dereference it, that might be a good candidate to
> assert on.
> 
> The same kind of unnecessary assert is also in some of
> the other functions here (and probably in other patches).

I'll take a look.

> 
>> diff --git a/include/hw/clock.h b/include/hw/clock.h
>> new file mode 100644
>> index 0000000000..fd11202ba4
>> --- /dev/null
>> +++ b/include/hw/clock.h
>> @@ -0,0 +1,124 @@
>> +#ifndef QEMU_HW_CLOCK_H
>> +#define QEMU_HW_CLOCK_H
> 
> All new files need a copyright-and-license comment header (could
> you check the rest of the patchset for this, please?).

Sure.

> 
>> +
> 
>> +/**
>> + * clock_get_frequency:
>> + * @clk: the clk to fetch the clock
>> + *
>> + * @return: the current frequency of @clk in Hz. If @clk is NULL, return 0.
>> + */
>> +static inline uint64_t clock_get_frequency(const ClockIn *clk)
>> +{
>> +    return clk ? clk->frequency : 0;
>> +}
> 
> Is there a use case where we want to support "pass in NULL"
> rather than just making it a programming error for the caller
> to try that ?

No, it's probably a remnant of previous version where input and output
shared some code. I'll remove it.

--
Damien

