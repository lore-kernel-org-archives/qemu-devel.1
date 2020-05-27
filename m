Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF72BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700F120890
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iuj1Fwrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700F120890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsMN-0003rl-Ly
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdsLp-0003MF-Jh
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:27:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdsLo-00075V-5a
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590571670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gu7tCcOQndpVsfwYXHLEQEBaPS2sslrrMYmtb49HGwc=;
 b=Iuj1FwrhsUOJbB8x2AopA8o1kvCBOhFU0dBzWDTaXhJPYQBC/gJzsU41D8VY5H91N/7/E8
 roUGbjE/Kia1PUwEU7xW0Pcd+2HGQpCB0Erl414R80PVvYzTNTbAlvLxp3jhSYYFvCWmwD
 WxMXOLb8NwcfF5LcHhsP9XXSJEhdlQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-gPNSU_juPD2KXFyYqur7xg-1; Wed, 27 May 2020 05:27:49 -0400
X-MC-Unique: gPNSU_juPD2KXFyYqur7xg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E73C81855A0D;
 Wed, 27 May 2020 09:27:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 875D412A4D;
 Wed, 27 May 2020 09:27:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0E8E4113864A; Wed, 27 May 2020 11:27:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH 01/24] arm/stm32f405: Fix realization of "stm32f2xx-adc"
 devices
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-2-armbru@redhat.com>
 <CAKmqyKOun2FyT+JR8cyrP9eQn9xFDAppFb4W12ym-TPGt9h7Hg@mail.gmail.com>
 <87d0707bri.fsf@dusky.pond.sub.org>
 <CAKmqyKM3oOLfAxupqfabrj_epQCCE_YbwnkU4cRd5mtg8+7_yg@mail.gmail.com>
Date: Wed, 27 May 2020 11:27:46 +0200
In-Reply-To: <CAKmqyKM3oOLfAxupqfabrj_epQCCE_YbwnkU4cRd5mtg8+7_yg@mail.gmail.com>
 (Alistair Francis's message of "Tue, 19 May 2020 15:20:15 -0700")
Message-ID: <87blm9ralp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Mon, May 18, 2020 at 10:08 PM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Alistair Francis <alistair23@gmail.com> writes:
>>
>> > On Sun, May 17, 2020 at 10:06 PM Markus Armbruster <armbru@redhat.com> wrote:
>> >>
>> >> stm32f405_soc_initfn() creates six such devices, but
>> >> stm32f405_soc_realize() realizes only one.  Affects machine
>> >> netduinoplus2.
>> >>
>> >> I wonder how this ever worked.  If the "device becomes real only on
>> >> realize" thing actually works, then we've always been missing five of
>> >> six such devices, yet nobody noticed.
>> >
>> > I must have just been testing the first ADC.
>> >
>> >>
>> >> Fix stm32f405_soc_realize() to realize all six.  Visible in "info
>> >> qtree":
>> >>
>> >>      bus: main-system-bus
>> >>        type System
>> >>        dev: stm32f405-soc, id ""
>> >>          cpu-type = "cortex-m4-arm-cpu"
>> >>        dev: stm32f2xx-adc, id ""
>> >>          gpio-out "sysbus-irq" 1
>> >>     -    mmio ffffffffffffffff/00000000000000ff
>> >>     +    mmio 0000000040012000/00000000000000ff
>> >>        dev: stm32f2xx-adc, id ""
>> >>          gpio-out "sysbus-irq" 1
>> >>     -    mmio ffffffffffffffff/00000000000000ff
>> >>     +    mmio 0000000040012000/00000000000000ff
>> >>        dev: stm32f2xx-adc, id ""
>> >>          gpio-out "sysbus-irq" 1
>> >>     -    mmio ffffffffffffffff/00000000000000ff
>> >>     +    mmio 0000000040012000/00000000000000ff
>> >>        dev: stm32f2xx-adc, id ""
>> >>          gpio-out "sysbus-irq" 1
>> >>     -    mmio ffffffffffffffff/00000000000000ff
>> >>     +    mmio 0000000040012000/00000000000000ff
>> >>        dev: stm32f2xx-adc, id ""
>> >>          gpio-out "sysbus-irq" 1
>> >>          mmio 0000000040012000/00000000000000ff
>> >>        dev: stm32f2xx-adc, id ""
>> >>          gpio-out "sysbus-irq" 1
>> >>     -    mmio ffffffffffffffff/00000000000000ff
>> >>     +    mmio 0000000040012000/00000000000000ff
>> >>        dev: armv7m, id ""
>> >>
>> >> The mmio addresses look suspicious.
>> >
>> > Good catch, thanks :)
>>
>> I'd love to squash in corrections, but I don't know the correct
>> addresses.  Can you help?
>
> Yep, thanks for squashing it in.
>
> The three addresses are:
>
> 0x40012000
> 0x40012100
> 0x40012200
>
> and they all share interrupt number 18.

An the other three?  There are six devices in total...

> Let me know if you want me to do it.


