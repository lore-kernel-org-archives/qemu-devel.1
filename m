Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A692BC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8BC2464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QXrumEGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8BC2464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdSr-00050x-Nh
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBdS3-0004Vq-8E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBdS1-000768-3R
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:53:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBdRz-0006zv-IU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:53:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABqYvL019827;
 Tue, 10 Mar 2020 11:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ogwPrqSo6+v2Kwkhhda9LipbnB9RBCXxQoFDSALbpzU=;
 b=QXrumEGmnBnrXPRpOP8NtQmF/2pBVkGUrEHSOvpdGfQKlmUnzJXO9WIx8dqPjfYBI4iJ
 88KSITyi7UFBrPigpYra4dJtqpl14HeZ+K13qFRfrlL2DCBFw9TJFf8lDhoxj+i4P+Nj
 I39+YhMbxB1rCOgAwV1uYNzD2e8Qa4sJgXxQ2uTMn1csovczDAQOyyTq8IYV3pxFX16C
 fBWCHr7p9Nw+Dpr4iOlTVQL7P9lJrbrqOjlteA4vacAdIsbL9H/lLn+MLr/EYoojpPmI
 UZD1R4sLmhxedOg47mEmCvsXFBtGNdpbj2i8eU/h0Na3wErldKWdqgUX4z07Lzz4BRuE rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ym31ud2e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:53:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABrOFA085438;
 Tue, 10 Mar 2020 11:53:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yp8rhkemc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:53:27 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ABrQ7X030482;
 Tue, 10 Mar 2020 11:53:26 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 04:53:26 -0700
Subject: Re: [PATCH 04/14] hw/i386/vmport: Introduce vmx-version property
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-5-liran.alon@oracle.com>
 <20200310053210-mutt-send-email-mst@kernel.org>
 <0dd22d9c-e1d2-db1e-372e-5009be705dab@oracle.com>
 <20200310071453-mutt-send-email-mst@kernel.org>
 <10ffd04f-30f9-6333-26ef-169cd1615341@oracle.com>
 <20200310073629-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <c6eaecb4-36f7-3ee3-49c7-1a0ac6391c45@oracle.com>
Date: Tue, 10 Mar 2020 13:53:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310073629-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100080
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


On 10/03/2020 13:44, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 01:28:32PM +0200, Liran Alon wrote:
>> On 10/03/2020 13:18, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 01:05:02PM +0200, Liran Alon wrote:
>>>> On 10/03/2020 11:32, Michael S. Tsirkin wrote:
>>>>> On Tue, Mar 10, 2020 at 01:54:01AM +0200, Liran Alon wrote:
>>>>>> Instead of hard-coding the VMX version, make it a VMPORT object property.
>>>>>> This would allow user to control it's value via "-global vmport.vmx-version=X".
>>>>>>
>>>>>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>>>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>>> More detail on why this is useful?
>>>> It's more useful than returning a hard-coded "6" as the vmx-version...
>>> Maybe default should be 6 (a bit of explanation why 6 could be nice).
>> The default is indeed defined as 6. As it was before this patch.
>> There is not much to explain besides the fact that recent VMware products
>> returns 6 here.
>>
>> I don't recall any mapping between the returned version here and the
>> supported set of VMPort commands. There is a separate mechanism (which we
>> implement in another patch) to signal that a command is unsupported /
>> failed.
>>
>> The term "vmx-version" refers to the version of the Userspace-VMM of VMware
>> which is called (confusingly) "vmx".
> Short for Virtual Machine eXecutable. Sigh.  People do come up with
> names that aren't great. I don't even know whether vmware was there
> first and intel shouldn't have shortened virtual machine extensions to
> vmx, but in KVM and QEMU it's quite entrenched by now. So let's try to
> avoid this in code. If you like how about VMPortExec and
> vm-exec-version?
In my opinion, this is more confusing. Terms should be evaluated based 
on the context you read them.
It seems more confusing that this field is named "vmx-version" on 
open-vm-tools and we name it "vm-exec-version".
So if you don't strongly disagree, I prefer to remain with names similar 
to VMware.
> Also lets you use CamelCase consistently and not a mix
> of underscores and CamelCase.
Where do you refer to?

Looking at QEMU code, properties are always named with "bla-bla2-bla3" 
convention.
Also, variables of structs are also named with "bla_bla2" convention.
CamelCase are only used for type definitions.
>
>>>> We have used it to preserve compatibility for some VMware guests that we run
>>>> as-is on top of QEMU/KVM which expects specific vmx-version or else they
>>>> fail to run properly.
>>>>
>>>> -Liran
>>> Any detail on which guest it is?
>> I will need to dig in production history to find it... They are usually
>> proprietary appliances specially made to run as VMware VMs.
>>> Pretending to be a very advanced version has its pitfalls if we
>>> then don't behave the way vmware does, right?
>> In all those cases, we have taken the version number backwards, not forward.
>>> Figuring out the version number is I suspect a bit much to ask of users.
>> Most users will indeed not need to touch this. This is for advanced users,
>> such as Ravello.
>> We usually figured this out by reverse-engineering the failed guest and/or
>> examining the original VMware environment it used to run on.
>>
>> -Liran
>
> Right if you want this for debugging, prefix property with "x-" so it does
> not need to be maintained. Point being, maintaining low level interfaces
> has real cost ...

It's not for debugging. It's for being able to run real VMware VMs as-is 
on top of QEMU/KVM.
I don't see it much different than the existing ability to manipulate 
SMBIOS values from QEMU command-line or add ACPI tables to make a guest 
run properly.
(Which we also manipulated sometimes based on reverse-engineering the 
failed guest and/or examining the original VMware environment).
I can prefix it with "x-" if you wish to signal it's experimental, but I 
don't really think this is the case here.

-Liran






