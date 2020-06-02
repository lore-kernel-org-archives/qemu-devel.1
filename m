Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7007BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45331206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45331206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg7qW-0005eU-Fb
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 10:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jg7pq-0004x8-QY; Tue, 02 Jun 2020 10:24:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jg7pp-0001Vg-II; Tue, 02 Jun 2020 10:24:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 052E4cd4117335; Tue, 2 Jun 2020 10:24:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31dr0h9979-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2020 10:24:05 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 052E4f36117594;
 Tue, 2 Jun 2020 10:24:05 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31dr0h996k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2020 10:24:05 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052EA5Aw012293;
 Tue, 2 Jun 2020 14:24:04 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 31bf48tf4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2020 14:24:04 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 052EO33E52101522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jun 2020 14:24:03 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFE60112067;
 Tue,  2 Jun 2020 14:24:03 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC198112064;
 Tue,  2 Jun 2020 14:24:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  2 Jun 2020 14:24:03 +0000 (GMT)
Subject: Re: [PATCH v3 1/4] acpi: Convert build_tpm2() to build_append* API
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200601095737.32671-1-eric.auger@redhat.com>
 <20200601095737.32671-2-eric.auger@redhat.com>
 <46c71777-b588-ce1f-eb8d-de1c5b3e2186@linux.ibm.com>
 <6bd7f3a0-5a40-823e-bf67-309c9995e18e@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <a85cc67e-2d8a-2034-3b85-6e8c8d7dcad6@linux.ibm.com>
Date: Tue, 2 Jun 2020 10:24:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6bd7f3a0-5a40-823e-bf67-309c9995e18e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-02_13:2020-06-02,
 2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 impostorscore=0 cotscore=-2147483648 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020097
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 10:08:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 9:55 AM, Auger Eric wrote:
> Hi Stefan,
> On 6/2/20 3:30 PM, Stefan Berger wrote:
>> On 6/1/20 5:57 AM, Eric Auger wrote:
>>> In preparation of its move to the generic acpi code,
>>> let's convert build_tpm2() to use build_append API. This
>>> latter now is prefered in place of direct ACPI struct field
>>> settings with manual endianness conversion.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>    hw/i386/acpi-build.c | 28 +++++++++++++++++++---------
>>>    1 file changed, 19 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index b5669d6c65..f0d35d7b17 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -2298,30 +2298,40 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker
>>> *linker, GArray *tcpalog)
>>>    static void
>>>    build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>>>    {
>>> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
>>> +    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data,
>>> sizeof(AcpiTableHeader));
>> And now you want to build the data structure by pushing fields? I would
>> definitely NOT do this.
> If I didn't misinterpret things, this was recommended by Drew and Igor
> as buid_append* API avoids to take care of endianness and this is the
> API now used in the generic ACPI code. Besides I also think that in that
> case it does not simplify things but maybe I did that the wrong way? Or
> maybe I didn't understand your remark?


If that's what they are saying... I would prefer filling out data 
structures with functions like cpu_to_acpi16() because that seems to be 
less error prone.


>>
>>>        unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
>>>        unsigned log_addr_offset =
>>>            (char *)&tpm2_ptr->log_area_start_address - table_data->data;
>>> +    uint8_t start_method_params[12] = {};
>>>    -    tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
>>> +    /* platform class */
>>> +    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
>>> +    /* reserved */
>>> +    build_append_int_noprefix(table_data, 0, 2);
>>>        if (TPM_IS_TIS_ISA(tpm_find())) {
>>> -        tpm2_ptr->control_area_address = cpu_to_le64(0);
>>> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
>>> +        /* address of control area */
>>> +        build_append_int_noprefix(table_data, 0, 8);
>>> +        /* start method */
>>> +        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO,
>>> 4);
>>>        } else if (TPM_IS_CRB(tpm_find())) {
>>> -        tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
>>> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
>>> +        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
>>> +        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
>>>        } else {
>>>            g_warn_if_reached();
>>>        }
>>>    -    tpm2_ptr->log_area_minimum_length =
>>> -        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
>>> +    /* platform specific parameters */
>>> +    g_array_append_vals(table_data, &start_method_params, 12);

Maybe this should be wrapped in an inline function like 
build_append_array() or so.


>>>    -    acpi_data_push(tcpalog,
>>> le32_to_cpu(tpm2_ptr->log_area_minimum_length));
>>> +    /* log area minimum length */
>>> +    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
>>> +
>>> +    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);


At this point we have a double-allocation of log memory on x86_64. You'd 
need the patch I posted to create the TCPA table only for TPM 1.2.



>>>        bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE,
>>> tcpalog, 1,
>>>                                 false);
>>>          /* log area start address to be filled by Guest linker */
>>> +    build_append_int_noprefix(table_data, 0, 8);
>>>        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>>>                                       log_addr_offset, log_addr_size,
>>>                                       ACPI_BUILD_TPMLOG_FILE, 0);
>>



