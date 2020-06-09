Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9211207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBzmcTd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9211207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYKq-0002JY-43
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiYK8-0001ol-88
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:05:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20774
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiYK6-000324-GV
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591686325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JEFNBdjqK1KqRZqhBh5HwLOu2eZrPvFuWp/aLK2i1uU=;
 b=hBzmcTd+KM4GI/VmcoXG0Ws19/Ddous4fgXMVDDporbJTcB7iXLmfqNRSRTvSOMr0V1vhF
 PdRBFzQmAvP8yHOe5xJMM21IBAdoECdNIFQyn++hB0MsEfMV69dvIaI/Oh6zZdvBQ00qYr
 T+zfZYDiViHfqR34wDCHsX6KAczWkE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-FBeSjJuwNy2GQjlEx0gUWQ-1; Tue, 09 Jun 2020 03:05:21 -0400
X-MC-Unique: FBeSjJuwNy2GQjlEx0gUWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9CA48014D4;
 Tue,  9 Jun 2020 07:05:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 029778202E;
 Tue,  9 Jun 2020 07:05:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84EB111386A6; Tue,  9 Jun 2020 09:05:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-10-armbru@redhat.com>
 <CAFEAcA8qWmMfn765D+fXZGqOoDyb59vaha=wsRjhZPiNG7MVkA@mail.gmail.com>
Date: Tue, 09 Jun 2020 09:05:18 +0200
In-Reply-To: <CAFEAcA8qWmMfn765D+fXZGqOoDyb59vaha=wsRjhZPiNG7MVkA@mail.gmail.com>
 (Peter Maydell's message of "Mon, 8 Jun 2020 15:25:25 +0100")
Message-ID: <87a71csor5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Thu, 28 May 2020 at 12:13, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> cuda_init() creates a "mos6522-cuda" device, but it's never realized.
>> Affects machines mac99 with via=cuda (default) and g3beige.
>>
>> pmu_init() creates a "mos6522-pmu" device, but it's never realized.
>> Affects machine mac99 with via=pmu and via=pmu-adb,
>>
>> In theory, a device becomes real only on realize.  In practice, the
>> transition from unreal to real is a fuzzy one.  The work to make a
>> device real can be spread between realize methods (fine),
>> instance_init methods (wrong), and board code wiring up the device
>> (fine as long as it effectively happens on realize).  Depending on
>> what exactly is done where, a device can work even when we neglect
>> to realize it.
>>
>> These onetwo appear to work.  Nevertheless, it's a clear misuse of the
>> interface.  Even when it works today (more or less by chance), it can
>> break tomorrow.
>>
>> Fix by realizing them in cuda_realize() and pmu_realize(),
>> respectively.
>>
>> Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/misc/macio/cuda.c | 10 +++++-----
>>  hw/misc/macio/pmu.c  | 10 +++++-----
>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
>> index e0cc0aac5d..763a785f1a 100644
>> --- a/hw/misc/macio/cuda.c
>> +++ b/hw/misc/macio/cuda.c
>> @@ -33,6 +33,7 @@
>>  #include "hw/misc/macio/cuda.h"
>>  #include "qemu/timer.h"
>>  #include "sysemu/runstate.h"
>> +#include "qapi/error.h"
>>  #include "qemu/cutils.h"
>>  #include "qemu/log.h"
>>  #include "qemu/module.h"
>> @@ -523,15 +524,14 @@ static void cuda_realize(DeviceState *dev, Error **errp)
>>  {
>>      CUDAState *s = CUDA(dev);
>>      SysBusDevice *sbd;
>> -    MOS6522State *ms;
>> -    DeviceState *d;
>>      struct tm tm;
>>
>> +    object_property_set_bool(OBJECT(&s->mos6522_cuda), true, "realized",
>> +                             &error_abort);
>
> Still disagree with barfing on failure when we have a perfectly
> good way to return the failure indication.

My patch is a strict improvement: it fixes a bug, and it does not add
ways to fail (the object_property_set_bool() above can't actually fail).

You're asking for additional improvement.  "One may always ask, and one
may always say no."

Since there is nothing to clean up here, I'll stick in the useless error
handling so we can move on.

If the error handling you ask for involved cleanup, I'd say no.

Incorrect unreachable cleanup is worse than &error_abort.  I'm not going
to waste time on unreachable and untestable error handling unless it's
utterly trivial, and I'm certainly not going to waste time on creating
more elaborate time bombs.  I *am* going to waste time managing
expectations, if I have to :)

I feel I have to now, because I feel I've once again stretched my
employer's (awesomely generous!) patience with me doing work that won't
ever go into any of our products to the limit.


