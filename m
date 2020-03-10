Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CF4C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8E2208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UMxOhDwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8E2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdLU-0005jW-RY
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBdK2-000426-0z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBdK0-0002xD-PS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:45:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBdK0-0002qk-GE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:45:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABgV3p110369;
 Tue, 10 Mar 2020 11:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BeWgHpvQgABJexu1jc92Dixi6q+XF5WQdywht74f2FI=;
 b=UMxOhDwTB4JKzHG2nmYbCTFu0ftBrR3/jNEjvt2Swr4Ll1mSztCh6n3GOiSLfd/WmB5J
 GVXNRQodmOFqfJEfcvRjO/TOb8zxMn1Y7ShIkI699JILOPaSmqBpmQsaz+GOYGN7RwuP
 xvciURltDzVZfFwPj2B6Ee4z8rTEed0RpnaQOt0FLOrddnve6upRPX+6tvFzRP28KsWn
 /XZed/qzgrqFS6/vgWsvHRHa71IwiTRTkM/eXvpkfgo4+k+LF+vuH4HubPT6nQI+HMa+
 sajFd9Tq3H/AEntXEnI44WiXv93oGOfMiiFWn6ixopB2lTXUz9Y7kbj//FJLfh0K7tqd Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2ym31ud1g5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:45:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABgj8S178481;
 Tue, 10 Mar 2020 11:45:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yp8ns6pt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:45:12 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ABjCPb008012;
 Tue, 10 Mar 2020 11:45:12 GMT
Received: from [192.168.14.112] (/79.181.212.171) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Tue, 10 Mar 2020 04:44:58 -0700
USER-AGENT: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <c9374d4c-4d63-9302-0896-958950029ec5@oracle.com>
Date: Tue, 10 Mar 2020 04:44:54 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-8-liran.alon@oracle.com>
 <20200310052226-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200310052226-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100079
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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


On 10/03/2020 11:22, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 01:54:04AM +0200, Liran Alon wrote:
>> This is VMware documented functionallity that some guests rely on.
>> Returns the BIOS UUID of the current virtual machine.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>>   hw/i386/vmport.c     | 14 ++++++++++++++
>>   include/hw/i386/pc.h |  1 +
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>> index 2ae5afc42b50..7687f3368a55 100644
>> --- a/hw/i386/vmport.c
>> +++ b/hw/i386/vmport.c
>> @@ -26,6 +26,7 @@
>>   #include "hw/i386/pc.h"
>>   #include "hw/input/i8042.h"
>>   #include "hw/qdev-properties.h"
>> +#include "sysemu/sysemu.h"
>>   #include "sysemu/hw_accel.h"
>>   #include "qemu/log.h"
>>   #include "trace.h"
>> @@ -121,6 +122,18 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
>>       return port_state->vmx_version;
>>   }
>>   
>> +static uint32_t vmport_cmd_get_bios_uuid(void *opaque, uint32_t addr)
>> +{
>> +    X86CPU *cpu = X86_CPU(current_cpu);
>> +    uint32_t *uuid_parts = (uint32_t*)(qemu_uuid.data);
>> +
>> +    cpu->env.regs[R_EAX] = uuid_parts[0];
>> +    cpu->env.regs[R_EBX] = uuid_parts[1];
>> +    cpu->env.regs[R_ECX] = uuid_parts[2];
>> +    cpu->env.regs[R_EDX] = uuid_parts[3];
>> +    return cpu->env.regs[R_EAX];
>> +}
>> +
> Should be LE here?

No. This is how the UUID is expected to be returned to guest.

-Liran



