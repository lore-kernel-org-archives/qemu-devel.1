Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88698C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 00:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5233520738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 00:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D6UnmQC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5233520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Bpw-0002AG-Ak
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 20:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8Bjp-00076o-Ji; Tue, 18 Aug 2020 20:13:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8Bjn-0000VP-CU; Tue, 18 Aug 2020 20:13:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07J01s2Q023059; Tue, 18 Aug 2020 20:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Z0KxpXAk+xPpuSvVyDgLts5DhE8KXkmN5125/lfVYG0=;
 b=D6UnmQC3xaWDkuH0Ht+tQR5KjbP0BuewcKSeM+HOuJKXeK0ynJ3f/c4icEM8S+nDO++X
 oedft+h3LMsQCgSw3VY7p2D+xpDTklce+xYps4j3IH6Hd+Bo7hDX2AqconmbalrYOf1w
 goP6wSzTOn+P9WoqBNtXTWTW203iKllep9KyvpeA2fatCr+3mrnbAOviyi5hzshjJFkP
 +ChihJv3WHAHHK4LpFVv4w/IFmiAFOWpojS/0Stcj8dCF1ATcRrfEiXd/5LnRTFmQ9LT
 G98n9zWUYQXkEeNNYhxsNjgPeGJgVIn2YbOhVO980WnGgzYlHwqk72z2i4QgcrKtOqny Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304tek8ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 20:13:07 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07J029qw023920;
 Tue, 18 Aug 2020 20:13:07 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304tek8ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 20:13:07 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07J0AEgC021968;
 Wed, 19 Aug 2020 00:13:06 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03wdc.us.ibm.com with ESMTP id 3304cdyxxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 00:13:06 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07J0D5VZ54657530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2020 00:13:05 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 894C4AC065;
 Wed, 19 Aug 2020 00:13:05 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E930FAC060;
 Wed, 19 Aug 2020 00:12:58 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.41.251])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Aug 2020 00:12:58 +0000 (GMT)
References: <20200818033323.336912-1-bauerman@linux.ibm.com>
 <20200818033323.336912-6-bauerman@linux.ibm.com>
 <8c454fa8-12a6-0258-04e8-6f3c093eb333@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 5/8] mips/cps: Use start-powered-off CPUState property
In-reply-to: <8c454fa8-12a6-0258-04e8-6f3c093eb333@redhat.com>
Date: Tue, 18 Aug 2020 21:12:54 -0300
Message-ID: <871rk3mr21.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-18_16:2020-08-18,
 2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180166
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 19:07:17
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/18/20 5:33 AM, Thiago Jung Bauermann wrote:
>> Instead of setting CPUState::halted to 1 in main_cpu_reset(), use the
>> start-powered-off property which makes cpu_common_reset() initialize it
>> to 1 in common code.
>>
>> Also change creation of CPU object from cpu_create() to object_new() and
>> qdev_realize() because cpu_create() realizes the CPU and it's not possib=
le to
>> set a property after the object is realized.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  hw/mips/cps.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
>> index 615e1a1ad2..be85357dc0 100644
>> --- a/hw/mips/cps.c
>> +++ b/hw/mips/cps.c
>> @@ -52,9 +52,6 @@ static void main_cpu_reset(void *opaque)
>>      CPUState *cs =3D CPU(cpu);
>>
>>      cpu_reset(cs);
>> -
>> -    /* All VPs are halted on reset. Leave powering up to CPC. */
>> -    cs->halted =3D 1;
>>  }
>>
>>  static bool cpu_mips_itu_supported(CPUMIPSState *env)
>> @@ -76,7 +73,9 @@ static void mips_cps_realize(DeviceState *dev, Error *=
*errp)
>>      bool saar_present =3D false;
>>
>>      for (i =3D 0; i < s->num_vp; i++) {
>> -        cpu =3D MIPS_CPU(cpu_create(s->cpu_type));
>> +        Error *err =3D NULL;
>> +
>> +        cpu =3D MIPS_CPU(object_new(s->cpu_type));
>>
>>          /* Init internal devices */
>>          cpu_mips_irq_init_cpu(cpu);
>> @@ -89,7 +88,16 @@ static void mips_cps_realize(DeviceState *dev, Error =
**errp)
>>              env->itc_tag =3D mips_itu_get_tag_region(&s->itu);
>>              env->itu =3D &s->itu;
>>          }
>> +        /* All VPs are halted on reset. Leave powering up to CPC. */
>> +        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
>> +                                 &error_abort);
>>          qemu_register_reset(main_cpu_reset, cpu);
>> +
>> +        if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
>> +            error_report_err(err);
>> +            object_unref(OBJECT(cpu));
>> +            exit(EXIT_FAILURE);
>> +        }
>
> Here errp is available, so we can propagate the error to the caller:
>
>            if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
>                return;
>            }

Ah, nice. I made this change (using qdev_realize_and_unref()).

I also changed object_property_set_bool() to use errp as well instead of
&error_abort (and also early return on error).

> For example in hw/mips/boston.c:
>
>     object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_MIPS_CP=
S);
>     object_property_set_str(OBJECT(&s->cps), "cpu-type", machine->cpu_typ=
e,
>                             &error_fatal);
>     object_property_set_int(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
>                             &error_fatal);
>     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
>
> This will be propagated here ---------------^^^^^^^^^^^^^

Interesting. Thanks for the explanation.

--
Thiago Jung Bauermann
IBM Linux Technology Center

