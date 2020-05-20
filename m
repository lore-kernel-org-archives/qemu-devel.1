Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E562C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E7620874
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtXMF3a0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E7620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQ3W-0005Z6-DE
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbQ2U-00047h-KU
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:49:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbQ2T-0003GR-SC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589986184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCBFCuwWrE8U1JtrmxKKwpXmqfdIRt92FhNz+GH8WBc=;
 b=BtXMF3a0Ck6r8QflNtvH4aaDNGze9xslvDjQ30p8NvnBL88CigiS1C6P3QMw7joRm2DgBX
 dp2LE+IZKcApYREaGdCwq+NWksl/dFfWKy5n0dmWOO5cYMEd0yCaiE4LaMLDZmvEPhCHmu
 shF8Er0T99aTdFq3lpwAXLh0lebEoMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-SDO8-tJMO7mQDOEcDZIMdA-1; Wed, 20 May 2020 10:49:43 -0400
X-MC-Unique: SDO8-tJMO7mQDOEcDZIMdA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CA1D835B52
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 14:49:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF9F95C1D3;
 Wed, 20 May 2020 14:49:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 75FAD11358BC; Wed, 20 May 2020 16:49:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 38/55] microbit: Tidy up sysbus_init_child_obj() @child
 argument
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-39-armbru@redhat.com>
 <3bb39878-b422-954b-5c78-49e61b4fee7a@redhat.com>
Date: Wed, 20 May 2020 16:49:40 +0200
In-Reply-To: <3bb39878-b422-954b-5c78-49e61b4fee7a@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 20 May 2020 14:06:05
 +0200")
Message-ID: <87tv0apsor.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/19/20 4:55 PM, Markus Armbruster wrote:
>> The callers of sysbus_init_child_obj() commonly pass either &child,
>> sizeof(child), or pchild, sizeof(*pchild).  Tidy up two that don't,
>> mostly to keep future commits simpler.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/arm/microbit.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
>> index ef213695bd..72fab429c4 100644
>> --- a/hw/arm/microbit.c
>> +++ b/hw/arm/microbit.c
>> @@ -39,7 +39,7 @@ static void microbit_init(MachineState *machine)
>>       Object *soc =3D OBJECT(&s->nrf51);
>>       Object *i2c =3D OBJECT(&s->i2c);
>>   -    sysbus_init_child_obj(OBJECT(machine), "nrf51", soc,
>> sizeof(s->nrf51),
>> +    sysbus_init_child_obj(OBJECT(machine), "nrf51", &s->nrf51, sizeof(s=
->nrf51),
>>                             TYPE_NRF51_SOC);
>>       qdev_prop_set_chr(DEVICE(&s->nrf51), "serial0", serial_hd(0));
>>       object_property_set_link(soc, OBJECT(system_memory), "memory",
>> @@ -51,7 +51,7 @@ static void microbit_init(MachineState *machine)
>>        * hack until we implement the nRF51 TWI controller properly and t=
he
>>        * magnetometer/accelerometer devices.
>>        */
>> -    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", i2c,
>> +    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", &s->i2c,
>>                             sizeof(s->i2c), TYPE_MICROBIT_I2C);
>>       object_property_set_bool(i2c, true, "realized", &error_fatal);
>
> i2c is only used once now, maybe you can remove it and directly use
> in-place.

Twice.  After PATCH 47, both uses will be SYS_BUS_DEVICE(i2c).  I think
I should either eliminate the variable, or change it to SysBusDevice *.

>           Regardless:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

>>       mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(i2c), 0);
>>


