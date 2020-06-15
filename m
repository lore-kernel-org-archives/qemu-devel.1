Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F60C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0585B2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0585B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrLq-000202-3W
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jkrKK-0001Dq-A8; Mon, 15 Jun 2020 11:47:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18842
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jkrKH-00065K-5N; Mon, 15 Jun 2020 11:47:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05FFaAvo193609; Mon, 15 Jun 2020 11:47:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31mtxf2qqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 11:47:07 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FFgHCn020142;
 Mon, 15 Jun 2020 11:47:06 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31mtxf2qqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 11:47:06 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FFaCbg011963;
 Mon, 15 Jun 2020 15:47:06 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 31mpe8bjmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 15:47:06 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05FFl59Z50200886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2020 15:47:05 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B79E124055;
 Mon, 15 Jun 2020 15:47:05 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23B7D124053;
 Mon, 15 Jun 2020 15:47:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.157.70])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Mon, 15 Jun 2020 15:47:05 +0000 (GMT)
Subject: Re: [PATCH v2 3/8] s390/sclp: rework sclp boundary and length checks
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-4-walling@linux.ibm.com>
 <2db81475-f4cd-448f-561a-fa545db1ae9d@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <ab57df6d-4e0d-1581-1a7f-e11c7402a87f@linux.ibm.com>
Date: Mon, 15 Jun 2020 11:47:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2db81475-f4cd-448f-561a-fa545db1ae9d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_06:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 cotscore=-2147483648
 bulkscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:37:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 8:56 AM, Thomas Huth wrote:
> On 16/05/2020 00.20, Collin Walling wrote:
>> Rework the SCLP boundary check to account for different SCLP commands
>> (eventually) allowing different boundary sizes.
>>
>> Move the length check code into a separate function, and introduce a
>> new function to determine the length of the read SCP data (i.e. the size
>> from the start of the struct to where the CPU entries should begin).
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c | 57 ++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 49 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 2bd618515e..987699e3c4 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -49,6 +49,34 @@ static inline bool sclp_command_code_valid(uint32_t code)
>>      return false;
>>  }
>>  
>> +static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
>> +                                    SCCBHeader *header)
>> +{
>> +    uint64_t current_len = sccb_addr + be16_to_cpu(header->length);
>> +    uint64_t allowed_len = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
>> +
>> +    switch (code & SCLP_CMD_CODE_MASK) {
>> +    default:
>> +        if (current_len <= allowed_len) {
>> +            return true;
>> +        }
>> +    }
>> +    header->response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>> +    return false;
>> +}
>> +
>> +/* Calculates sufficient SCCB length to store a full Read SCP/CPU response */
>> +static bool sccb_has_sufficient_len(SCCB *sccb, int num_cpus, int data_len)
>> +{
>> +    int required_len = data_len + num_cpus * sizeof(CPUEntry);
>> +
>> +    if (be16_to_cpu(sccb->h.length) < required_len) {
>> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>>  static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>>  {
>>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
>> @@ -66,6 +94,16 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>>      }
>>  }
>>  
>> +/*
>> + * The data length denotes the start of the struct to where the first
>> + * CPU entry is to be allocated. This value also denotes the offset_cpu
>> + * field.
>> + */
>> +static int get_read_scp_info_data_len(void)
>> +{
>> +    return offsetof(ReadInfo, entries);
>> +}
>> +
>>  /* Provide information about the configuration, CPUs and storage */
>>  static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>  {
>> @@ -74,16 +112,16 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      int cpu_count;
>>      int rnsize, rnmax;
>>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>> +    int data_len = get_read_scp_info_data_len();
>>  
>> -    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
>> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +    if (!sccb_has_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
>>          return;
>>      }
>>  
>>      /* CPU information */
>>      prepare_cpu_entries(machine, read_info->entries, &cpu_count);
>>      read_info->entries_cpu = cpu_to_be16(cpu_count);
>> -    read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
>> +    read_info->offset_cpu = cpu_to_be16(data_len);
>>      read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
>>  
>>      read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
>> @@ -132,16 +170,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>>  {
>>      MachineState *machine = MACHINE(qdev_get_machine());
>>      ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
>> +    int data_len = offsetof(ReadCpuInfo, entries);
> 
> Is there a reason for not using get_read_scp_info_data_len() here?
> 
>  Thomas
> 
> 

That function is for Read SCP Info.

Read CPU Info does not face the complications that come with new
features intruding on the space used for CPU entries (thankfully), so
there's no need for a function to determine its data length.

-- 
Regards,
Collin

Stay safe and stay healthy

