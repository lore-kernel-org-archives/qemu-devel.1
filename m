Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5E9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 06:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4477B2078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 06:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt41kFMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4477B2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd6ZE-0005Wa-Bq
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 02:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd6YJ-00050r-BL
 for qemu-devel@nongnu.org; Mon, 25 May 2020 02:25:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43537
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd6YH-0008JN-Hi
 for qemu-devel@nongnu.org; Mon, 25 May 2020 02:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590387931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4t5L2kiuQXodLstMq8/yHzwVtOdcs/IM8mwHrpAUS74=;
 b=Xt41kFMJIf+GE663YHBA1bYWiU1vwjsOB1OOY6RLvr+GPLNfbqJwPzNcb4x9jSFZukXe/5
 kTlkT8ifUde7OAAqyh/6kbtE4vbIp5DUUoXhq1GWouYGMcIvb7lCkSUZ1wc1K8aWLoW85D
 MdTgfcrvG43kA+R0nBSIqbcfZkEM7MU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-IpiNKflCMwCdqjCwsSP8Dg-1; Mon, 25 May 2020 02:25:25 -0400
X-MC-Unique: IpiNKflCMwCdqjCwsSP8Dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC899872FE2;
 Mon, 25 May 2020 06:25:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 666E38384C;
 Mon, 25 May 2020 06:25:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9A5A113864A; Mon, 25 May 2020 08:25:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-10-armbru@redhat.com>
 <CAFEAcA_S_JsuPG4UN-_zhhdZppBhiwm3-4bocO7O1XdjxC9bAw@mail.gmail.com>
Date: Mon, 25 May 2020 08:25:22 +0200
In-Reply-To: <CAFEAcA_S_JsuPG4UN-_zhhdZppBhiwm3-4bocO7O1XdjxC9bAw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 21 May 2020 17:26:50 +0100")
Message-ID: <87367oh6p9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 00:06:24
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 18 May 2020 at 06:12, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> cuda_init() creates a "mos6522-cuda" device, but it's never realized.
>> Affects machines mac99 with via=cuda (default) and g3beige.
>>
>> pmu_init() creates a "mos6522-pmu" device, but it's never realized.
>> Affects machine mac99 with via=pmu and via=pmu-adb,
>>
>> I wonder how this ever worked.  If the "device becomes real only on
>> realize" thing actually works, then we've always been missing these
>> devices, yet nobody noticed.
>
> Same remark as elsewhere: the devices aren't missing, we just
> got lucky that using them in a half-initialized state happens
> to work for these devices. Could you update the commit messages
> when you reroll this series, please?

Of course.  What about something like this:

    In theory, a device becomes real only on realize.  In practice, the
    transition from unreal to real is a fuzzy one.  The work to make a
    device real can be spread between realize methods (fine),
    instance_init methods (wrong), and board code wiring up the device
    (fine as long as it effectively happens on realize).  Depending on
    what exactly is done where, a device can work even when we neglect
    to realize it.  Nevertheless, it's a clear misuse of the interface.
    Even when it works today (more or less by chance), it can break
    tomorrow.

>> Fix by realizing them in cuda_realize() and pmu_realize(),
>> respectively.
>>
>> Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/misc/macio/cuda.c | 8 +++-----
>>  hw/misc/macio/pmu.c  | 8 +++-----
>>  2 files changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
>> index e0cc0aac5d..6d4d135f71 100644
>> --- a/hw/misc/macio/cuda.c
>> +++ b/hw/misc/macio/cuda.c
>> @@ -523,15 +523,13 @@ static void cuda_realize(DeviceState *dev, Error **errp)
>>  {
>>      CUDAState *s = CUDA(dev);
>>      SysBusDevice *sbd;
>> -    MOS6522State *ms;
>> -    DeviceState *d;
>>      struct tm tm;
>>
>> +    qdev_init_nofail(DEVICE(&s->mos6522_cuda));
>
> Since we init the device with sysbus_init_child_obj() and
> we're in a position here to propagate any realize error
> back up to our caller, it would be nicer to do this via
> setting the realize property rather than qdev_init_nofail().

The error handling will be unreachable.

The proper way to say "error not possible" is of course &error_abort,
not qdev_init_nofail()'s &error_fatal.

Many realize methods misuse the Error interface this way.  NULL instead
of &error_abort is also common.  Cleaning this up is yet another big
task.  But that's no excuse for making it bigger now.

Laurent, would you prefer unreachable error handling or &error_abort?

> That's what this patch from March does:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg04260.html
> (we seem to have let that series drop accidentally,
> probably because it was halfway through release and
> because it touches several architectures at once).

Pity.


