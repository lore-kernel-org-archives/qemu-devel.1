Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A48AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 23:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0612C2065D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 23:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ESoRYMA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0612C2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8AiD-0005bP-AM
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 19:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8AhO-0004xb-4B; Tue, 18 Aug 2020 19:07:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8AhL-0000HL-R4; Tue, 18 Aug 2020 19:07:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07IN1tUE120604; Tue, 18 Aug 2020 19:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=S48EIvtTnLLRemw3xGbSTwV+oo1+wGqeoMTX9VWlt2Y=;
 b=ESoRYMA7Fd2FN3J9DeTd577QXDBNU9qUtUNBmcqRr/k1R+Ncslthehdriwn/hyty5iVB
 mHE459EYZFT9Rn+j12V6MnBNqmhB8hfR6m+mAkippMzlgASN/vJRDFGVMWmF53o+0Q2g
 LIMgdMA08MRvVDP+Rwdkp+WWR6XUTn2gtkxoZ4j3GtGQacOe5UEj1Bccy1pMxsjRoJ1Z
 PaxRdkXpahHJao1lGPq9YWSeMoTTGyVVwCLObQpjsMzovQ4ihUXSI2ZZUUFG12glO+az
 OWSIqd3TDjb7snZCMwrVVZiNPrUMeEBNpjHtjRSfUR4jgqvI4i88Nq9BE3Zq8cVLvvuQ 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304tehxhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 19:06:40 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07IN24I4121086;
 Tue, 18 Aug 2020 19:06:40 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304tehxgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 19:06:39 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07IN5VBU002589;
 Tue, 18 Aug 2020 23:06:36 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02dal.us.ibm.com with ESMTP id 3304cchgus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 23:06:36 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07IN6WZ325428332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 23:06:32 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A240DC6055;
 Tue, 18 Aug 2020 23:06:34 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8D08C605F;
 Tue, 18 Aug 2020 23:06:29 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.41.251])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 18 Aug 2020 23:06:29 +0000 (GMT)
References: <20200818033323.336912-1-bauerman@linux.ibm.com>
 <20200818033323.336912-5-bauerman@linux.ibm.com>
 <83c5045d-ee26-9433-46a3-4919bcea7cd3@redhat.com>
 <65395b58-82d7-fd6b-ebc2-3fa7cb25d324@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 4/8] ppc/e500: Use start-powered-off CPUState property
In-reply-to: <65395b58-82d7-fd6b-ebc2-3fa7cb25d324@redhat.com>
Date: Tue, 18 Aug 2020 20:06:26 -0300
Message-ID: <874kozmu4t.fsf@morokweng.localdomain>
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
 definitions=main-2008180160
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


Hello Philippe,

Thanks for your review.

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/18/20 9:22 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 8/18/20 5:33 AM, Thiago Jung Bauermann wrote:
>>> Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
>>> the start-powered-off property which makes cpu_common_reset() initializ=
e it
>>> to 1 in common code.
>>>
>>> Also change creation of CPU object from cpu_create() to object_new() and
>>> qdev_realize() because cpu_create() realizes the CPU and it's not possi=
ble
>>> to set a property after the object is realized.
>>>
>>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>> ---
>>>  hw/ppc/e500.c | 19 +++++++++++++++----
>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>>> index ab9884e315..0077aca74d 100644
>>> --- a/hw/ppc/e500.c
>>> +++ b/hw/ppc/e500.c
>>> @@ -704,9 +704,6 @@ static void ppce500_cpu_reset_sec(void *opaque)
>>>
>>>      cpu_reset(cs);
>>>
>>> -    /* Secondary CPU starts in halted state for now. Needs to change w=
hen
>>> -       implementing non-kernel boot. */
>>> -    cs->halted =3D 1;
>>>      cs->exception_index =3D EXCP_HLT;
>>>  }
>>>
>>> @@ -864,8 +861,9 @@ void ppce500_init(MachineState *machine)
>>>          PowerPCCPU *cpu;
>>>          CPUState *cs;
>>>          qemu_irq *input;
>>> +        Error *err =3D NULL;
>>>
>>> -        cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>>> +        cpu =3D POWERPC_CPU(object_new(machine->cpu_type));
>>>          env =3D &cpu->env;
>>>          cs =3D CPU(cpu);
>>>
>>> @@ -897,6 +895,19 @@ void ppce500_init(MachineState *machine)
>>>          } else {
>>>              /* Secondary CPUs */
>>>              qemu_register_reset(ppce500_cpu_reset_sec, cpu);
>>> +
>>> +            /*
>>> +             * Secondary CPU starts in halted state for now. Needs to =
change
>>> +             * when implementing non-kernel boot.
>>> +             */
>>> +            object_property_set_bool(OBJECT(cs), "start-powered-off", =
true,
>>> +                                     &error_abort);
>>
>> [*]
>>
>>> +        }
>>> +
>>> +        if (!qdev_realize(DEVICE(cs), NULL, &err)) {
>>> +            error_report_err(err);
>>> +            object_unref(OBJECT(cs));
>>> +            exit(EXIT_FAILURE);
>>>          }
>>
>> The last 4 lines are equivalent to:
>>
>>            qdev_realize(DEVICE(cs), NULL, &error_fatal)) {
>
> I meant:
>
>              qdev_realize(DEVICE(cs), NULL, &error_fatal);

Ah! Thanks for pointing it out. I'll use that (along with
qdev_realize_and_unref()).

>
>>
>> This is also the preferred form, as we can not propagate errors
>> from the machine_init() handler.
>>
>> Since you use &error_abort in [*], maybe you want to use it here too.

I think &error_fatal is better since it preserves the behavior from
cpu_create().

--
Thiago Jung Bauermann
IBM Linux Technology Center

