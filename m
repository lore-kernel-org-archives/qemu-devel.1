Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2285C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 22:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E0D20674
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 22:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qmsGBCg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E0D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8AIg-0006ul-PI
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 18:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8AHo-00062L-Ez; Tue, 18 Aug 2020 18:40:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8AHm-0005L0-Cv; Tue, 18 Aug 2020 18:40:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07IMX6b9126812; Tue, 18 Aug 2020 18:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=k5tRPBXC6ZWh3D1kgQocfGXxPiOsuUbSX5/ZRJeKx4E=;
 b=qmsGBCg5f3kFjrGMo/DvA9kPbJaYUC+o8Ytl3jUKsFKddQgEwBOE5YjrCFnh3SfRcWCb
 jUR1Bois5QFZ7EBGF4iw5SaTlaG04PiUGL28xNdewNUczNHVJPMZ/y8qPtm2K2l5ZyHs
 B9NMBEo33S/erZuJf3mgReb2/4UgwyCrREusAM3Xg3dRqcEWT4C5rybPo+i524poXKKq
 WXsNzmq2dbhmltbuNT0LuNShxCuemoDk0A3E/ocvULrqLpGiu0NKJDv5c3QD0flVDbQz
 4zvMrNuxZgyLHXA0kPCcxjmqG3NV5fWpAecCeEcVcGu2WvNWk9PxuyFzozP+SbVg7v+u xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304swsebh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 18:40:24 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07IMXQ6M128090;
 Tue, 18 Aug 2020 18:40:24 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304swseb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 18:40:24 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07IMJTjs006579;
 Tue, 18 Aug 2020 22:40:23 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma03dal.us.ibm.com with ESMTP id 3304cchah7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 22:40:23 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07IMeMcA17760730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 22:40:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A4D1BE075;
 Tue, 18 Aug 2020 22:40:22 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C6B0BE074;
 Tue, 18 Aug 2020 22:40:17 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.41.251])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 18 Aug 2020 22:40:17 +0000 (GMT)
References: <20200818033323.336912-1-bauerman@linux.ibm.com>
 <20200818033323.336912-5-bauerman@linux.ibm.com>
 <20200818130243.38d00c5d@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 4/8] ppc/e500: Use start-powered-off CPUState property
In-reply-to: <20200818130243.38d00c5d@redhat.com>
Date: Tue, 18 Aug 2020 19:40:13 -0300
Message-ID: <875z9fmvci.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-18_16:2020-08-18,
 2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=2 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180158
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 18:40:51
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David
 Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Cornelia
 Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, David
 Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Igor,

Thank you for reviewing these patches, and the tips you provided here
and on other messages on how to fix the refcount issues.

Igor Mammedov <imammedo@redhat.com> writes:

> On Tue, 18 Aug 2020 00:33:19 -0300
> Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
>
> [...]
>
>> Also change creation of CPU object from cpu_create() to object_new() and
>> qdev_realize() because cpu_create() realizes the CPU and it's not possible
>> to set a property after the object is realized.
>
> cpu_create was introduced to remove code duplication in simple cases where
> we do not need to set properties on created cpu.
>
> returning back to manual object_new + realize() is fine if it 's only
> small set of of boards. If it's tree-wide change then that would bring
> back all code duplication that cpu_create() got rid of.

This is only necessary for boards where the secondary CPUs start powered
off, so it's not a tree-wide change.

> An alternative way is to use 'hotplug' callbacks to let board set
> additional properties before cpu's realize is called.
>
> example:
>   hw/ppc/spapr.c:
>    spapr_machine_class_init()
>      mc->get_hotplug_handler = spapr_get_hotplug_handler;
>      hc->pre_plug = spapr_machine_device_pre_plug;
>    ...
>    static const TypeInfo spapr_machine_info = {
>    ...
>         { TYPE_HOTPLUG_HANDLER },
>
> that might work in generic case if it is put into generic machine code,
> and existing users of mc->get_hotplug_handler/hc->pre_plug were taken care of.
> In which case board would only need to set MachineClass:cpu-start-powered-of
> to gate property setting.

Thank you for this idea. Though if possible I'd like to keep the new
code as similar as possible to the original code to minimize unwanted
"perturbations" in how and when objects are created and initialized.

>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  hw/ppc/e500.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index ab9884e315..0077aca74d 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -704,9 +704,6 @@ static void ppce500_cpu_reset_sec(void *opaque)
>>
>>      cpu_reset(cs);
>>
>> -    /* Secondary CPU starts in halted state for now. Needs to change when
>> -       implementing non-kernel boot. */
>> -    cs->halted = 1;
>>      cs->exception_index = EXCP_HLT;
>>  }
>>
>> @@ -864,8 +861,9 @@ void ppce500_init(MachineState *machine)
>>          PowerPCCPU *cpu;
>>          CPUState *cs;
>>          qemu_irq *input;
>> +        Error *err = NULL;
>>
>> -        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
>> +        cpu = POWERPC_CPU(object_new(machine->cpu_type));
>>          env = &cpu->env;
>>          cs = CPU(cpu);
>>
>> @@ -897,6 +895,19 @@ void ppce500_init(MachineState *machine)
>>          } else {
>>              /* Secondary CPUs */
>>              qemu_register_reset(ppce500_cpu_reset_sec, cpu);
>> +
>> +            /*
>> +             * Secondary CPU starts in halted state for now. Needs to change
>> +             * when implementing non-kernel boot.
>> +             */
>> +            object_property_set_bool(OBJECT(cs), "start-powered-off", true,
>> +                                     &error_abort);
>> +        }
>> +
>> +        if (!qdev_realize(DEVICE(cs), NULL, &err)) {
>> +            error_report_err(err);
>> +            object_unref(OBJECT(cs));
>> +            exit(EXIT_FAILURE);
>>          }
>
> btw:
> board leaks cpu reference (from cpu_create()/object_new()) since qdev_realize()
> adds it's own and the caller of object_new() is suposed to free the original one.
>
> in this case qdev_realize_and_unref() fits nicely.

I will make this change.
--
Thiago Jung Bauermann
IBM Linux Technology Center

