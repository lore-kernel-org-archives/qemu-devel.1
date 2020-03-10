Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4430FC18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE532469C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOUZ0wDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE532469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBeFm-0005vl-Af
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBeEs-0005Ir-Em
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBeEq-0004Ml-Tp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:44:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBeEq-0004IZ-Kk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:44:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ACgPEQ025776;
 Tue, 10 Mar 2020 12:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hTyV5ARkYpVwRO2g1gg00hnstV/PdRz2KQqxa9tFBfk=;
 b=iOUZ0wDeN9arSgMt2vZhdgocr5B2+kD1mZJXq4BUXCY4cCzYKvGtbu0PCN1kZhQIA1t1
 cDGsoPoOD78L3IMMYPJvIrOJVfNfJuT2f+e4CwHm7nvlEG8nabfemJ+o0Sv0tyCSRebw
 /BOwb/hEoTuaMXbzwzdez8rr8s2u+Bd2N54aZCHWmqxNjTOdRJqVLTT8aK1LPFiiOmcN
 KTOWcLlqC6DiIXaIx+h86/rq31gOIemCzOjorjpv46AiA5P4wAAh6etPz66IIqeNTdKd
 cYwKXfxQDx5B/gE2/PpxTTIQ8gjapyXP2d71pdESOA+wNQecc4QN4nkyeN1BJWSGBFzY iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2yp9v60cdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 12:43:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ACg9ct173329;
 Tue, 10 Mar 2020 12:43:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yp8pra6vp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 12:43:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AChtIU024075;
 Tue, 10 Mar 2020 12:43:55 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 05:43:54 -0700
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
Date: Tue, 10 Mar 2020 14:43:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310082730-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100085
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


On 10/03/2020 14:35, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 02:25:28PM +0200, Liran Alon wrote:
>> On 10/03/2020 14:14, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
>>>> As can be seen from VmCheck_GetVersion() in open-vm-tools code,
>>>> CMD_GETVERSION should return VMX type in ECX register.
>>>>
>>>> Default is to fake host as VMware ESX server. But user can control
>>>> this value by "-global vmport.vmx-type=X".
>>>>
>>>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>> ---
>>>>    hw/i386/vmport.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>>>> index a2c8ff4b59cf..c03f57f2f636 100644
>>>> --- a/hw/i386/vmport.c
>>>> +++ b/hw/i386/vmport.c
>>>> @@ -36,6 +36,15 @@
>>>>    #define VMPORT_ENTRIES 0x2c
>>>>    #define VMPORT_MAGIC   0x564D5868
>>>> +typedef enum {
>>>> +   VMX_TYPE_UNSET = 0,
>>>> +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware Express */
>>>> +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
>>>> +   VMX_TYPE_WGS,        /* Deprecated type used for VMware Server */
>>>> +   VMX_TYPE_WORKSTATION,
>>>> +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for ACE 1.x */
>>>> +} VMX_Type;
>>>> +
>>> Is this really VMX type? And do users care what it is?
>> This enum is copied from open-vm-tools source code
>> (lib/include/vm_version.h). This is how it's called in VMware Tools
>> terminology... Don't blame me :)
> I don't even want to go look at it to check license compatibility, but
> IMHO that's just another reason to avoid copying it.
> Copying bad code isn't a good idea unless needed for
> compatibility.
Preserving original VMware terminology makes sense and is preferred in 
my opinion. I think diverging from it is more confusing.
>
>
>>> Also, how about friendlier string values so people don't need to
>>> figure out code numbers?
>> I could have defined a new PropertyInfo struct in hw/core/qdev-properties.c
>> for this enum and then define a proper macro in qdev-properties.h.
>> But it seems like an overkill for a value that is suppose to rarely be
>> changed. So I thought this should suffice for now for user-experience
>> perspective.
>> If you think otherwise, I can do what I just suggested above.
>>
>> -Liran
> I think that's better, and this allows you to use official
> product names that people can relate to.
Ok. Will do...
>
> Alternatively just drop this enum completely.  As far as you are
> concerned it's just a number VM executable gives together with the
> version, right?  We don't even need the enum, just set it to 2 and add a
> code comment saying it's esx server.
I could do the latter alternative but why? It just hides information 
original patch author (myself) know about where this value comes from.
I don't see a reason to hide information from future code maintainers. 
Similar to defining all flags of a given flag-field even if we use only 
a subset of it.

-Liran



