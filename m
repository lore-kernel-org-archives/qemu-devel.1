Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9063C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E232467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ut0H1ufJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E232467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBf3P-0006R7-Vt
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBf2m-00062R-B6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBf2k-00024M-H5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:35:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBf2k-0001yY-5A
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:35:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ADXPpK148464;
 Tue, 10 Mar 2020 13:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OyFvYNvT21hjOYCcc4ZNgNOB3v/Nx9YwikaK0xh5cPU=;
 b=Ut0H1ufJ9/bfp3pOMhjclQbp+JD02dB9+lOc7hvmFAR8VcdpFSxjwQ09y8/ycMLTgcm3
 flwpaPBlgvhhYRxfTSvBqRofJe6OXlFrk87gzMHxNpw6i2XJLLqo9fjq2szT1SQt7dS1
 /P+cggdGqCjSEd3fr3psasdz4sKqZCly0ob1B4aPNfT1MsfXJvki1GB+i+imU99H5sBU
 swS0P5GbbrGqxWYi663NKMccoUWD+Re/6GNEwCPm/2uFqTctJKhqW/3ItpcSqLGKtgKt
 QcUnkgVoBRpjqGavOnBjNmBiAWvceoin3vZIbdLmWZlAN5j04R/zQ1RDOs1Hq1O/Vv6C 6w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2yp7hm1x87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 13:35:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ADXAK9060684;
 Tue, 10 Mar 2020 13:35:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yp8nsqq8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 13:35:30 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02ADZT2M007233;
 Tue, 10 Mar 2020 13:35:29 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 06:35:29 -0700
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
Date: Tue, 10 Mar 2020 15:35:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310084758-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100091
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


On 10/03/2020 14:53, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 02:43:51PM +0200, Liran Alon wrote:
>> On 10/03/2020 14:35, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 02:25:28PM +0200, Liran Alon wrote:
>>>> On 10/03/2020 14:14, Michael S. Tsirkin wrote:
>>>>> On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
>>>>>> As can be seen from VmCheck_GetVersion() in open-vm-tools code,
>>>>>> CMD_GETVERSION should return VMX type in ECX register.
>>>>>>
>>>>>> Default is to fake host as VMware ESX server. But user can control
>>>>>> this value by "-global vmport.vmx-type=X".
>>>>>>
>>>>>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>>>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>>>> ---
>>>>>>     hw/i386/vmport.c | 13 +++++++++++++
>>>>>>     1 file changed, 13 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>>>>>> index a2c8ff4b59cf..c03f57f2f636 100644
>>>>>> --- a/hw/i386/vmport.c
>>>>>> +++ b/hw/i386/vmport.c
>>>>>> @@ -36,6 +36,15 @@
>>>>>>     #define VMPORT_ENTRIES 0x2c
>>>>>>     #define VMPORT_MAGIC   0x564D5868
>>>>>> +typedef enum {
>>>>>> +   VMX_TYPE_UNSET = 0,
>>>>>> +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware Express */
>>>>>> +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
>>>>>> +   VMX_TYPE_WGS,        /* Deprecated type used for VMware Server */
>>>>>> +   VMX_TYPE_WORKSTATION,
>>>>>> +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for ACE 1.x */
>>>>>> +} VMX_Type;
>>>>>> +
>>>>> Is this really VMX type? And do users care what it is?
>>>> This enum is copied from open-vm-tools source code
>>>> (lib/include/vm_version.h). This is how it's called in VMware Tools
>>>> terminology... Don't blame me :)
>>> I don't even want to go look at it to check license compatibility, but
>>> IMHO that's just another reason to avoid copying it.
>>> Copying bad code isn't a good idea unless needed for
>>> compatibility.
>> Preserving original VMware terminology makes sense and is preferred in my
>> opinion. I think diverging from it is more confusing.
> Yea tell it to people who got in hot water because they copied
> some variable names to avoid confusion. Oh wait.
>
> This is not an official terminology I think.
Maybe it wasn't clear from my previous messages, but open-vm-tools is an 
official VMware open-source project...
VMX is the official name of the VMware Userspace-VMM and VMX-Type is an 
official name as-well.

I'm also not copying code here... I'm copying definitions from relevant 
header files to implement a compatible interface.
This is no different than copying constants from a Linux device driver 
to implement it's device emulation in QEMU.

> So please just make it make sense by itself, and make it
> easy to research.
I think I have made it the most easiest to research. Having exactly same 
names as VMware official project and pointing to it directly from 
comments and commit messages.
>
>>>
>>>>> Also, how about friendlier string values so people don't need to
>>>>> figure out code numbers?
>>>> I could have defined a new PropertyInfo struct in hw/core/qdev-properties.c
>>>> for this enum and then define a proper macro in qdev-properties.h.
>>>> But it seems like an overkill for a value that is suppose to rarely be
>>>> changed. So I thought this should suffice for now for user-experience
>>>> perspective.
>>>> If you think otherwise, I can do what I just suggested above.
>>>>
>>>> -Liran
>>> I think that's better, and this allows you to use official
>>> product names that people can relate to.
>> Ok. Will do...
>>> Alternatively just drop this enum completely.  As far as you are
>>> concerned it's just a number VM executable gives together with the
>>> version, right?  We don't even need the enum, just set it to 2 and add a
>>> code comment saying it's esx server.
>> I could do the latter alternative but why? It just hides information
>> original patch author (myself) know about where this value comes from.
>> I don't see a reason to hide information from future code maintainers.
>> Similar to defining all flags of a given flag-field even if we use only a
>> subset of it.
>>
>> -Liran
> That belongs in a code comment. Removes need to follow silly names from
> unrelated and possibly incompatible license.

What do you mean "unrelated"? It's an official VMware open-source 
project for VMware Tools...
I'm only copying definition of constants...

> By comparison dead code is
> dead code.
Right. That's why I think the enum PropertyInfo mechanism is an overkill 
at this point.
> But sure, if you want to code up user friendly names, that's
> ok too. But do follow official names then please, not something lifted
> from some piece of code.

These are all official names. I'm not sure I understand what you are 
suggesting.

-Liran



