Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7C3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 05:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46C920758
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 05:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPjxjW0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46C920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jauUc-0005sT-VX
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 01:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jauU6-0005N9-Ov
 for qemu-devel@nongnu.org; Tue, 19 May 2020 01:08:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49477
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jauU5-0002Cu-Bw
 for qemu-devel@nongnu.org; Tue, 19 May 2020 01:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589864886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05fy5QBWpQqNOvMArKDHlPqvIT3zaM+y1dJ26VLPbBk=;
 b=EPjxjW0SlatjD3jI9HALviw9v9/0wmvO/ZU07A+YwzBuLUyxm61KObneA1qrOP4nrtbrXn
 5WU2zu/KZ8rUPWDQIp0wmzNH/1dZoDhsdkSA75RWQf0KbUJzvJ46zYPSN0uRJOg83C4IPy
 J0yx2etoeY2g4DsCSf1Mq31tNI3+2NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-Q48XvQCRM9aT7o6PSdapCg-1; Tue, 19 May 2020 01:08:05 -0400
X-MC-Unique: Q48XvQCRM9aT7o6PSdapCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBFCD107ACCA;
 Tue, 19 May 2020 05:08:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7931710013D9;
 Tue, 19 May 2020 05:08:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F0D6A11358BC; Tue, 19 May 2020 07:08:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH 01/24] arm/stm32f405: Fix realization of "stm32f2xx-adc"
 devices
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-2-armbru@redhat.com>
 <CAKmqyKOun2FyT+JR8cyrP9eQn9xFDAppFb4W12ym-TPGt9h7Hg@mail.gmail.com>
Date: Tue, 19 May 2020 07:08:01 +0200
In-Reply-To: <CAKmqyKOun2FyT+JR8cyrP9eQn9xFDAppFb4W12ym-TPGt9h7Hg@mail.gmail.com>
 (Alistair Francis's message of "Mon, 18 May 2020 09:48:56 -0700")
Message-ID: <87d0707bri.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alistair Francis <alistair23@gmail.com> writes:

> On Sun, May 17, 2020 at 10:06 PM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> stm32f405_soc_initfn() creates six such devices, but
>> stm32f405_soc_realize() realizes only one.  Affects machine
>> netduinoplus2.
>>
>> I wonder how this ever worked.  If the "device becomes real only on
>> realize" thing actually works, then we've always been missing five of
>> six such devices, yet nobody noticed.
>
> I must have just been testing the first ADC.
>
>>
>> Fix stm32f405_soc_realize() to realize all six.  Visible in "info
>> qtree":
>>
>>      bus: main-system-bus
>>        type System
>>        dev: stm32f405-soc, id ""
>>          cpu-type = "cortex-m4-arm-cpu"
>>        dev: stm32f2xx-adc, id ""
>>          gpio-out "sysbus-irq" 1
>>     -    mmio ffffffffffffffff/00000000000000ff
>>     +    mmio 0000000040012000/00000000000000ff
>>        dev: stm32f2xx-adc, id ""
>>          gpio-out "sysbus-irq" 1
>>     -    mmio ffffffffffffffff/00000000000000ff
>>     +    mmio 0000000040012000/00000000000000ff
>>        dev: stm32f2xx-adc, id ""
>>          gpio-out "sysbus-irq" 1
>>     -    mmio ffffffffffffffff/00000000000000ff
>>     +    mmio 0000000040012000/00000000000000ff
>>        dev: stm32f2xx-adc, id ""
>>          gpio-out "sysbus-irq" 1
>>     -    mmio ffffffffffffffff/00000000000000ff
>>     +    mmio 0000000040012000/00000000000000ff
>>        dev: stm32f2xx-adc, id ""
>>          gpio-out "sysbus-irq" 1
>>          mmio 0000000040012000/00000000000000ff
>>        dev: stm32f2xx-adc, id ""
>>          gpio-out "sysbus-irq" 1
>>     -    mmio ffffffffffffffff/00000000000000ff
>>     +    mmio 0000000040012000/00000000000000ff
>>        dev: armv7m, id ""
>>
>> The mmio addresses look suspicious.
>
> Good catch, thanks :)

I'd love to squash in corrections, but I don't know the correct
addresses.  Can you help?

>>
>> Fixes: 529fc5fd3e18ace8f739afd02dc0953354f39442
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: qemu-arm@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!


