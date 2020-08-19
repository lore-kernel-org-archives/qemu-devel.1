Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8459C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A1C20897
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eXI2Q7Kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A1C20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Q13-00068p-RZ
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8Q0D-0004gY-47; Wed, 19 Aug 2020 11:27:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8Q09-00011I-Bj; Wed, 19 Aug 2020 11:27:48 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07JF5sY3049098; Wed, 19 Aug 2020 11:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Gw8Z17rQPOMpQRdSu01gz13ze+J8ctBmjOln6LBHLes=;
 b=eXI2Q7KnbiTXZZXOgNndCOaf1o5By3Vauom1i0/QgS3Yf5NUQSNuOCbUyZEWDTuj/L77
 njkn8MWmRqDEd2wUJR8132kHAls0kMFstU7+gjJeBKkkO19vDlRlSYglbDw5Y6pLxu17
 DwRYpNvYnik3sdescZ4Dk3X/v0LcJAjAW7uTfUET++rlgYk8MLHfVGsWZp8ozWU1Zu1U
 hdJlOSaL2XmDoZqc9knQXFQt3VkN6LdcZ9NCNymj9weMYYpDA/u1XHE52ZR7namPnNO2
 NcAaHzSgBbn1uDfNtuttlRD/i/MaLl8nxssj8f+mUAsona5+uXIADooJJr+dm3kkaehk xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304r4mjet-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 11:27:08 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07JF6IZi050172;
 Wed, 19 Aug 2020 11:27:07 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304r4mje5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 11:27:07 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JF9Q9u019182;
 Wed, 19 Aug 2020 15:27:06 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 3304ccr8fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 15:27:06 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07JFR5c355574806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2020 15:27:05 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B11C4AC05B;
 Wed, 19 Aug 2020 15:27:05 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60D23AC059;
 Wed, 19 Aug 2020 15:26:59 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.41.171])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Aug 2020 15:26:59 +0000 (GMT)
References: <20200819024220.587612-1-bauerman@linux.ibm.com>
 <20200819024220.587612-8-bauerman@linux.ibm.com>
 <350a0f8f-8db7-2e91-28e3-e114fc05c340@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 7/8] sparc/sun4m: Use start-powered-off CPUState
 property
In-reply-to: <350a0f8f-8db7-2e91-28e3-e114fc05c340@redhat.com>
Date: Wed, 19 Aug 2020 12:26:56 -0300
Message-ID: <87mu2qejwf.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_08:2020-08-19,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190131
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 11:27:43
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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


Hi Philippe,

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/19/20 4:42 AM, Thiago Jung Bauermann wrote:
>> Instead of setting CPUState::halted to 1 in secondary_cpu_reset(), use t=
he
>> start-powered-off property which makes cpu_common_reset() initialize it
>> to 1 in common code.
>>
>> This makes secondary_cpu_reset() unnecessary, so remove it.
>>
>> Also remove setting of cs->halted from cpu_devinit(), which seems out of
>> place when compared to similar code in other architectures (e.g.,
>> ppce500_init() in hw/ppc/e500.c).
>>
>> Finally, change creation of CPU object from cpu_create() to object_new()
>> and qdev_realize_and_unref() because cpu_create() realizes the CPU and i=
t's
>> not possible to set a property after the object is realized.
>>
>> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  hw/sparc/sun4m.c | 21 +++++----------------
>>  1 file changed, 5 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 22c51dac8a..1925f415e7 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -218,15 +218,6 @@ static void dummy_cpu_set_irq(void *opaque, int irq=
, int level)
>>  {
>>  }
>>
>> -static void secondary_cpu_reset(void *opaque)
>> -{
>> -    SPARCCPU *cpu =3D opaque;
>> -    CPUState *cs =3D CPU(cpu);
>> -
>> -    cpu_reset(cs);
>> -    cs->halted =3D 1;
>> -}
>> -
>>  static void cpu_halt_signal(void *opaque, int irq, int level)
>>  {
>>      if (level && current_cpu) {
>> @@ -810,21 +801,19 @@ static const TypeInfo ram_info =3D {
>>  static void cpu_devinit(const char *cpu_type, unsigned int id,
>>                          uint64_t prom_addr, qemu_irq **cpu_irqs)
>>  {
>> -    CPUState *cs;
>>      SPARCCPU *cpu;
>>      CPUSPARCState *env;
>>
>> -    cpu =3D SPARC_CPU(cpu_create(cpu_type));
>> +    cpu =3D SPARC_CPU(object_new(cpu_type));
>>      env =3D &cpu->env;
>>
>>      cpu_sparc_set_id(env, id);
>> -    if (id !=3D 0) {
>> -        qemu_register_reset(secondary_cpu_reset, cpu);
>> -        cs =3D CPU(cpu);
>> -        cs->halted =3D 1;
>> -    }
>> +    object_property_set_bool(OBJECT(cpu), "start-powered-off", id !=3D =
0,
>> +                             &error_fatal);
>
> Why not call here:
>
>        qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
>
> ?

I can do that. I was unsure about whether qemu_allocate_irqs() could
come after realize, but now that you pointed it out it obviously can
since this code was working with cpu_create(). I'll send a v6 with that
change.

>>      *cpu_irqs =3D qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
>>      env->prom_addr =3D prom_addr;
>> +
>> +    qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
>>  }
>>
>>  static void dummy_fdc_tc(void *opaque, int irq, int level)
>>


--
Thiago Jung Bauermann
IBM Linux Technology Center

