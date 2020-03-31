Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F4CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B73F20714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B73F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFqK-0004GX-G2
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJFp4-0003EX-8n
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJFp2-0005pr-VC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:16:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28906
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jJFp2-0005pA-Pj
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:16:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02VC4JwR108887
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 08:16:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 303vwj5vqf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 08:16:47 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Tue, 31 Mar 2020 13:16:44 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 31 Mar 2020 13:16:40 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02VCGeWw35848252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2020 12:16:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 233474C046;
 Tue, 31 Mar 2020 12:16:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65E3A4C044;
 Tue, 31 Mar 2020 12:16:39 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.66.74])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 31 Mar 2020 12:16:39 +0000 (GMT)
Subject: Re: [PATCH/RFC] vl/s390: fixup ram sizes for compat machines
To: David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Cornelia Huck <cohuck@redhat.com>
References: <20200331120238.15786-1-borntraeger@de.ibm.com>
 <0a34ca71-8ff3-6084-dbba-18faefc1b25f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Tue, 31 Mar 2020 14:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0a34ca71-8ff3-6084-dbba-18faefc1b25f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20033112-0028-0000-0000-000003EF5851
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033112-0029-0000-0000-000024B4DACB
Message-Id: <24a84acd-5ab0-7622-582f-2b1da5d0ec6f@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_04:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310106
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 02VC4JwR108887
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 31.03.20 14:13, David Hildenbrand wrote:
> On 31.03.20 14:02, Christian Borntraeger wrote:
>> compat machines did fixup the ram size to match what can be reported v=
ia
>> sclp. We need to mimic those for machines 4.2 and older to not fail on
>> inbound migration.
>>
>> Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 12 ++++++++++++
>>  hw/s390x/sclp.c            | 10 ----------
>>  include/hw/boards.h        |  1 +
>>  softmmu/vl.c               |  3 +++
>>  4 files changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 3cf19c99f3..748c08b157 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -579,6 +579,17 @@ static void s390_nmi(NMIState *n, int cpu_index, =
Error **errp)
>>      s390_cpu_restart(S390_CPU(cs));
>>  }
>> =20
>> +#define MAX_STORAGE_INCREMENTS                  1020
>> +static ram_addr_t s390_align_ram(ram_addr_t sz)
>> +{
>> +    /* same logic as in sclp.c */
>> +    int increment_size =3D 20;
>> +    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
>> +        increment_size++;
>> +    }
>> +    return sz >> increment_size << increment_size;
>> +}
>> +
>>  static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>> @@ -808,6 +819,7 @@ static void ccw_machine_4_2_instance_options(Machi=
neState *machine)
>>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>>  {
>>      ccw_machine_5_0_class_options(mc);
>> +    mc->machine_align_ram =3D s390_align_ram;
>>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_l=
en);
>>  }
>>  DEFINE_CCW_MACHINE(4_2, "4.2", false);
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index d8ae207731..0a6ff2be82 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -372,16 +372,6 @@ static void sclp_memory_init(SCLPDevice *sclp)
>>          increment_size++;
>>      }
>>      sclp->increment_size =3D increment_size;
>> -
>> -    /* The core memory area needs to be aligned with the increment si=
ze.
>> -     * In effect, this can cause the user-specified memory size to be=
 rounded
>> -     * down to align with the nearest increment boundary. */
>> -    initial_mem =3D initial_mem >> increment_size << increment_size;
>> -
>> -    machine->ram_size =3D initial_mem;
>> -    machine->maxram_size =3D initial_mem;
>> -    /* let's propagate the changed ram size into the global variable.=
 */
>> -    ram_size =3D initial_mem;
>>  }
>> =20
>>  static void sclp_init(Object *obj)
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 236d239c19..e3574f4b5f 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -218,6 +218,7 @@ struct MachineClass {
>>                                                           unsigned cpu=
_index);
>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machi=
ne);
>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int id=
x);
>> +    ram_addr_t (*machine_align_ram)(ram_addr_t size);
>>  };
>> =20
>>  /**
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index 1d33a28340..12b5758d12 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -2601,6 +2601,9 @@ static bool set_memory_options(uint64_t *ram_slo=
ts, ram_addr_t *maxram_size,
>>      }
>> =20
>>      sz =3D QEMU_ALIGN_UP(sz, 8192);
>> +    if (mc->machine_align_ram) {
>> +        sz =3D mc->machine_align_ram(sz);
>> +    }
>>      ram_size =3D sz;
>>      if (ram_size !=3D sz) {
>>          error_report("ram size too large");
>>
>=20
> 1. You're missing the maxram changes from my patch.

Yes, will fixup the remaining things.=20
>=20
> 2. Shouldn't we error out in case ram_size is not aligned in sclp.c (ne=
w
> machines)?

I think its perfectly fine to have slightly larger ram than what sclp rep=
orts. Maybe a future
sclp extension will improve this? (In fact since we no longer have sclp m=
emory hotplug we COULD
use more than 1020 increments)





