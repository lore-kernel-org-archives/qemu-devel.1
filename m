Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EE4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF71620715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF71620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajcm-0001Vp-1r
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jajbP-00007P-G9; Mon, 18 May 2020 13:30:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33362
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jajbO-0003aT-Ba; Mon, 18 May 2020 13:30:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04IH1G9c176493; Mon, 18 May 2020 13:30:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312c63j1cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 13:30:56 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04IH1O10177324;
 Mon, 18 May 2020 13:30:56 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312c63j1c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 13:30:56 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04IHUULo029105;
 Mon, 18 May 2020 17:30:55 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 313wgs0h38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 17:30:55 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04IHUrXf27066806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2020 17:30:53 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B33566E052;
 Mon, 18 May 2020 17:30:53 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BFF06E053;
 Mon, 18 May 2020 17:30:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.206.55])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 18 May 2020 17:30:52 +0000 (GMT)
Subject: Re: [PATCH v2 1/8] s390/sclp: get machine once during read scp/cpu
 info
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-2-walling@linux.ibm.com>
 <ac621482-f297-db5b-2df0-4da086155b39@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <93fb02ee-6dd0-69c0-92ff-2545a6eb450f@linux.ibm.com>
Date: Mon, 18 May 2020 13:30:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ac621482-f297-db5b-2df0-4da086155b39@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-18_06:2020-05-15,
 2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 cotscore=-2147483648
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 10:31:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 4:38 AM, David Hildenbrand wrote:
> On 16.05.20 00:20, Collin Walling wrote:
>> Functions within read scp/cpu info will need access to the machine
>> state. Let's make a call to retrieve the machine state once and
>> pass the appropriate data to the respective functions.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index ede056b3ef..61e2e2839c 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -49,9 +49,8 @@ static inline bool sclp_command_code_valid(uint32_t code)
>>      return false;
>>  }
>>  
>> -static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *count)
>> +static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>>  {
>> -    MachineState *ms = MACHINE(qdev_get_machine());
>>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
>>      int i;
>>  
>> @@ -77,7 +76,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>>  
>>      /* CPU information */
>> -    prepare_cpu_entries(sclp, read_info->entries, &cpu_count);
>> +    prepare_cpu_entries(machine, read_info->entries, &cpu_count);
>>      read_info->entries_cpu = cpu_to_be16(cpu_count);
>>      read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
>>      read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
>> @@ -132,10 +131,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>  /* Provide information about the CPU */
>>  static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>>  {
>> +    MachineState *machine = MACHINE(qdev_get_machine());
>>      ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
>>      int cpu_count;
>>  
>> -    prepare_cpu_entries(sclp, cpu_info->entries, &cpu_count);
>> +    prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
>>      cpu_info->nr_configured = cpu_to_be16(cpu_count);
>>      cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
>>      cpu_info->nr_standby = cpu_to_be16(0);
>>
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks!

-- 
Regards,
Collin

Stay safe and stay healthy

