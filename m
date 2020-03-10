Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A5C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2002C2467F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i/9Uqswo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2002C2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBciK-0005PK-7z
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBchF-0004j8-9c
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBchE-0002Z3-18
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:05:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBchD-0002Rm-Mq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:05:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AArYLA138588;
 Tue, 10 Mar 2020 11:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kjxtGt381xEWr46cxCDE0e/18knpLT2qq8GsB25UPjk=;
 b=i/9Uqswo8mumMb6A4bVsMQL8R4ku7TsWHb2E9lr8TIChwr80WGTfLyFc5TCa+YXOV7ys
 +aSmNF2iCo0TytaSEle0eUGoQSDjPotZakCJUC+UWqM/OmuQ6+SfYiNDWeIMk5urj+Pc
 T70sy9C3uteQlUb6XYNPnr+Ib7U8y9VBoByiwJhZSMxg23Fqaz9me57BCrvONo2GlOjQ
 ZAPcQvgj6BXUiHOExpDXhobNP31lCabPajX5aIEufupo5WSY7XHjFNOvmRxzfqrAWy/u
 hai9v7M9bOKyNIE7FQ3VAIsQ/2O16TKxz7N1VKsWmPVahjZZ6TKpZX4BBb/4L4YX1V75 kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2yp7hm183a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:05:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AB3WQT135596;
 Tue, 10 Mar 2020 11:05:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yp8rhf2nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:05:08 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AB56D8006757;
 Tue, 10 Mar 2020 11:05:07 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 04:05:06 -0700
Subject: Re: [PATCH 04/14] hw/i386/vmport: Introduce vmx-version property
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-5-liran.alon@oracle.com>
 <20200310053210-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <0dd22d9c-e1d2-db1e-372e-5009be705dab@oracle.com>
Date: Tue, 10 Mar 2020 13:05:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310053210-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100073
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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


On 10/03/2020 11:32, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 01:54:01AM +0200, Liran Alon wrote:
>> Instead of hard-coding the VMX version, make it a VMPORT object property.
>> This would allow user to control it's value via "-global vmport.vmx-version=X".
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> More detail on why this is useful?
It's more useful than returning a hard-coded "6" as the vmx-version...
We have used it to preserve compatibility for some VMware guests that we 
run as-is on top of QEMU/KVM which expects specific vmx-version or else 
they fail to run properly.

-Liran

>
>> ---
>>   hw/i386/vmport.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>> index 7c21e56081b0..a2c8ff4b59cf 100644
>> --- a/hw/i386/vmport.c
>> +++ b/hw/i386/vmport.c
>> @@ -44,6 +44,8 @@ typedef struct VMPortState {
>>       MemoryRegion io;
>>       VMPortReadFunc *func[VMPORT_ENTRIES];
>>       void *opaque[VMPORT_ENTRIES];
>> +
>> +    uint32_t vmx_version;
>>   } VMPortState;
>>   
>>   static VMPortState *port_state;
>> @@ -112,7 +114,7 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
>>       X86CPU *cpu = X86_CPU(current_cpu);
>>   
>>       cpu->env.regs[R_EBX] = VMPORT_MAGIC;
>> -    return 6;
>> +    return port_state->vmx_version;
>>   }
>>   
>>   static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
>> @@ -169,6 +171,8 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
>>   }
>>   
>>   static Property vmport_properties[] = {
>> +    /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
>> +    DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> -- 
>> 2.20.1

