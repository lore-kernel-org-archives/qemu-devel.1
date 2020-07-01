Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AEDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9D0206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilHW93dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9D0206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqX7b-0005dx-MR
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 03:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqX6p-0004Jj-ER
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:24:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56737
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqX6m-0001jA-Np
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593588279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6NGbLPSGzlX9KxhD31PWetFn9mttU3V+FbD7IH0c8gE=;
 b=ilHW93dQA0UuYbGFSKSycKrGtg3hvkQB2ZO42AxqVMwTnyGE8waGRQdemK7lWQFd9D/mjI
 iDojSyg0/Ien6kCGyPOPFIEsZkoKgXk4UbwJPQN586RYv1fPQRgVYhyl62ym2Ql4nXofOj
 IdWgTXtPsr0T5RYu9qYoq2bIy8egPZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-stIJLYXhN7OG0S8gg5Ju_w-1; Wed, 01 Jul 2020 03:24:37 -0400
X-MC-Unique: stIJLYXhN7OG0S8gg5Ju_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CD8484E248;
 Wed,  1 Jul 2020 07:24:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B95B2B47C;
 Wed,  1 Jul 2020 07:24:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FEE311384A6; Wed,  1 Jul 2020 09:24:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 22/26] arm/stm32f205 arm/stm32f405: Fix realize error
 API violation
References: <20200630090351.1247703-1-armbru@redhat.com>
 <20200630090351.1247703-23-armbru@redhat.com>
 <1c6d230c-cddb-9859-0a53-723db7c52e0f@amsat.org>
Date: Wed, 01 Jul 2020 09:24:28 +0200
In-Reply-To: <1c6d230c-cddb-9859-0a53-723db7c52e0f@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 30 Jun 2020 11:14:47
 +0200")
Message-ID: <87r1tvbsur.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 6/30/20 11:03 AM, Markus Armbruster wrote:
>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>> pointer to a variable containing NULL.  Passing an argument of the
>> latter kind twice without clearing it in between is wrong: if the
>> first call sets an error, it no longer points to NULL for the second
>> call.
>>=20
>> stm32f205_soc_realize() and stm32f405_soc_realize() are wrong that
>> way: they pass &err to object_property_set_int() without checking it,
>> and then to qdev_realize().  Harmless, because the former can't
>> actually fail here.
>>=20
>> Fix by passing &error_abort instead.
>>=20
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: qemu-arm@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  hw/arm/stm32f205_soc.c | 2 +-
>>  hw/arm/stm32f405_soc.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
>> index 19487544f0..56aef686c9 100644
>> --- a/hw/arm/stm32f205_soc.c
>> +++ b/hw/arm/stm32f205_soc.c
>> @@ -154,7 +154,7 @@ static void stm32f205_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>> =20
>>      /* ADC 1 to 3 */
>>      object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
>> -                            "num-lines", &err);
>> +                            "num-lines", &error_abort);
>>      qdev_realize(DEVICE(s->adc_irqs), NULL, &err);
>
> qdev_realize() coult take &error_abort too then.

Think so.  I went for the minimal patch.

> Anyway:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!

>>      if (err !=3D NULL) {
>>          error_propagate(errp, err);
>> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
>> index c12d9f999d..cf9228d8e7 100644
>> --- a/hw/arm/stm32f405_soc.c
>> +++ b/hw/arm/stm32f405_soc.c
>> @@ -172,7 +172,7 @@ static void stm32f405_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>>          return;
>>      }
>>      object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
>> -                            "num-lines", &err);
>> +                            "num-lines", &error_abort);
>>      qdev_realize(DEVICE(&s->adc_irqs), NULL, &err);
>>      if (err !=3D NULL) {
>>          error_propagate(errp, err);
>>=20


