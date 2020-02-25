Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4DBC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376D221744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="U2b0PxMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376D221744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Wsd-0006WT-8O
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6Wpi-00045c-E5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6Wph-0004FD-Ar
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:48:54 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:47646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1j6Wpc-0004CZ-BJ; Tue, 25 Feb 2020 04:48:48 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id CE84B96EF0;
 Tue, 25 Feb 2020 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582624126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8MdC2LhTkV3RoqTUKGy+InLFT7ikd+X4LK90zRntMvE=;
 b=U2b0PxMr6oc7t3IBF3v0Z/hXDvjtGls82BxbLcgif2gafvqY/iofWcW+oHnn5c00PearJX
 r12jIIOMaZT6dIKJiNSMB4KwjEnqUOy5dmsWNQ6mggb49A3fzJtsv/IHu8RZMjk64x+shj
 +Xz8p7l5BoRcB/fVVPU7D8fT+y+4tRI=
Subject: Re: [PATCH v7 1/9] hw/core/clock: introduce clock object
To: Alistair Francis <alistair23@gmail.com>
References: <20200224170301.246623-1-damien.hedde@greensocs.com>
 <20200224170301.246623-2-damien.hedde@greensocs.com>
 <CAKmqyKP1LR3e5TmUvNWKub21sA7q6u2fK=saEH93i64furcpTQ@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <51fcca2b-2258-80d7-a29d-7d7da8551ebd@greensocs.com>
Date: Tue, 25 Feb 2020 10:48:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP1LR3e5TmUvNWKub21sA7q6u2fK=saEH93i64furcpTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582624126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8MdC2LhTkV3RoqTUKGy+InLFT7ikd+X4LK90zRntMvE=;
 b=4dGRfGjx0szAOqMr81/hFXTaHvH0u9QgVb8EdabdSek2o2nOYSHjjYvUOStrQGY6K6rUjn
 dtH1TbymTgaSYCNO41iQQyg3hc/ULPYHu5fA/VSAQ97MMuUBQTzqd/MhQll3kj2ggUrnG9
 gNDQhFZiI1YBzfjXYSCnoSk9QJFwdKg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582624126; a=rsa-sha256; cv=none;
 b=R7fNxCT/zwG7E3WtJr5V4DTIRKSfv+IpqOFtgq/VAhqF4Iz6S9ICybnUTVZgDfilaTEBqu
 RuOJrmcoInXPQxqDC9CS2vGGsD3wQHR15tXrt6JQwSYGa90xRuJ/E9n/AWpnT94XiQer6q
 G108wxRC0ymVLKpD4egcWXQWKDz6x/g=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/25/20 1:02 AM, Alistair Francis wrote:
> On Mon, Feb 24, 2020 at 9:05 AM Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> This object may be used to represent a clock inside a clock tree.
>>
>> A clock may be connected to another clock so that it receives update,
>> through a callback, whenever the source/parent clock is updated.
>>
>> Although only the root clock of a clock tree controls the values
>> (represented as periods) of all clocks in tree, each clock holds
>> a local state containing the current value so that it can be fetched
>> independently. It will allows us to fullfill migration requirements
>> by migrating each clock independently of others.
>>
>> This is based on the original work of Frederic Konrad.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> --
>>
>> v7:
>> + merge ClockIn & ClockOut into a single type Clock
>> + switch clock state to a period with 2^-32ns unit
>> + add some Hz and ns helpers
>> + propagate clock period when setting the source so that
>>   clocks with fixed period are easy to handle.
>> ---
>>  include/hw/clock.h    | 216 ++++++++++++++++++++++++++++++++++++++++++
>>  hw/core/clock.c       | 131 +++++++++++++++++++++++++
>>  hw/core/Makefile.objs |   2 +
>>  hw/core/trace-events  |   7 ++
>>  4 files changed, 356 insertions(+)
>>  create mode 100644 include/hw/clock.h
>>  create mode 100644 hw/core/clock.c
>>
>> diff --git a/include/hw/clock.h b/include/hw/clock.h
>> new file mode 100644
>> index 0000000000..30ac9a9946
>> --- /dev/null
>> +++ b/include/hw/clock.h
>> @@ -0,0 +1,216 @@

[...]

> 
>> +    clock_disconnect(clk);
>> +
>> +    g_free(clk->canonical_path);
>> +    clk->canonical_path = NULL;
> 
> You shouldn't need to set this to NULL.

ok.

> 
>> +}
>> +
>> +static const TypeInfo clock_info = {
>> +    .name              = TYPE_CLOCK,
>> +    .parent            = TYPE_OBJECT,
>> +    .instance_size     = sizeof(Clock),
>> +    .instance_init     = clock_initfn,
>> +    .instance_finalize = clock_finalizefn,
>> +};
>> +
>> +static void clock_register_types(void)
>> +{
>> +    type_register_static(&clock_info);
>> +}
>> +
>> +type_init(clock_register_types)
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index 6215e7c208..d7080edf89 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -7,10 +7,12 @@ common-obj-y += hotplug.o
>>  common-obj-y += vmstate-if.o
>>  # irq.o needed for qdev GPIO handling:
>>  common-obj-y += irq.o
>> +common-obj-y += clock.o
>>
>>  common-obj-$(CONFIG_SOFTMMU) += reset.o
>>  common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
>>  common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
>> +common-obj-$(CONFIG_SOFTMMU) += hotplug.o
> 
> I don't think this should be here.
Oops, I missed this rebase artifact.

Thanks,
Damien

