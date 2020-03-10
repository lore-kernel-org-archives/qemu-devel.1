Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693CCC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365E6205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nPnLnK9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365E6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcvW-0003I7-EF
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBcuY-00022i-7k
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBcuU-0008Vh-EN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:18:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBcuU-0008T1-25
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:18:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABITiw103833;
 Tue, 10 Mar 2020 11:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=I3kC12+JUdp2XOxjKfc83zEPtbYA2A2Ywa44Rv+p2Gg=;
 b=nPnLnK9mY8PpRYizr9ofEvkre5g5A7u7M7ZzMl3nKCdDIRrS/Co4QAaZZSXjKN2iNvUu
 hoJtmber5LJFBlSrSuHAvxAt/5NiDNLWVHWQuunEtXZXqpCl9qfAnm8QEoq/wL9RH/KP
 ongMafbDNkaahjG7KxupZWwbhT7J2Ta816IsAKxgrmLmSiX+/1qkjPaityJE5Rijioeh
 sHKCCetkgAP+4a0+FytO3bFJ3DKWS/8qnIff17fpaGOQyDxXJkSzXeCD2gKM69/iXaRD
 eWRyopNxwp+S10FX8Q28kSxjq4qCHg8xaksOpLE8X6LrSdpygfqBoEHrFmu30/Kg+EVJ eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yp9v600e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:18:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABCeUb129026;
 Tue, 10 Mar 2020 11:18:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2yp8ns3y3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:18:50 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ABImdm014080;
 Tue, 10 Mar 2020 11:18:48 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 04:18:48 -0700
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310051738-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <742df43c-d188-5aa3-f9a3-89ba540283a9@oracle.com>
Date: Tue, 10 Mar 2020 13:18:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310051738-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100076
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/03/2020 11:20, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
>> As can be seen from VmCheck_GetVersion() in open-vm-tools code,
>> CMD_GETVERSION should return VMX type in ECX register.
>>
>> Default is to fake host as VMware ESX server. But user can control
>> this value by "-global vmport.vmx-type=X".
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>>   hw/i386/vmport.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>> index a2c8ff4b59cf..c03f57f2f636 100644
>> --- a/hw/i386/vmport.c
>> +++ b/hw/i386/vmport.c
>> @@ -36,6 +36,15 @@
>>   #define VMPORT_ENTRIES 0x2c
>>   #define VMPORT_MAGIC   0x564D5868
>>   
>> +typedef enum {
>> +   VMX_TYPE_UNSET = 0,
>> +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware Express */
>> +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
>> +   VMX_TYPE_WGS,        /* Deprecated type used for VMware Server */
>> +   VMX_TYPE_WORKSTATION,
>> +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for ACE 1.x */
>> +} VMX_Type;
>> +
> Can names be prefixed with VMPort pls? VMX has specific unrelated meaning.
>
> Same everywhere.
I didn't thought it matters much given that this enum is only defined 
locally in vmport.c.
But sure I can rename it in v2.

-Liran

>
>>   #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
>>   
>>   typedef struct VMPortState {
>> @@ -46,6 +55,7 @@ typedef struct VMPortState {
>>       void *opaque[VMPORT_ENTRIES];
>>   
>>       uint32_t vmx_version;
>> +    uint8_t vmx_type;
>>   } VMPortState;
>>   
>>   static VMPortState *port_state;
>> @@ -114,6 +124,7 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
>>       X86CPU *cpu = X86_CPU(current_cpu);
>>   
>>       cpu->env.regs[R_EBX] = VMPORT_MAGIC;
>> +    cpu->env.regs[R_ECX] = port_state->vmx_type;
>>       return port_state->vmx_version;
>>   }
>>   
>> @@ -173,6 +184,8 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
>>   static Property vmport_properties[] = {
>>       /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
>>       DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
>> +    DEFINE_PROP_UINT8("vmx-type", VMPortState, vmx_type,
>> +                      VMX_TYPE_SCALABLE_SERVER),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> -- 
>> 2.20.1

