Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF65FC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3B821927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vWP1I3a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3B821927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmtc-0002Qt-SY
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBmt0-0001zx-Ep
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBmsx-0003bY-VH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:58:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBmsx-0003YJ-Kc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:57:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ALrQeB012845;
 Tue, 10 Mar 2020 21:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xnrBl1SshimyqCHk7oI2BoVEGCesVGLpW3RcIa7YksA=;
 b=vWP1I3a4UKC66uaLTkEwdj4VvxnroEWXpDHbYZ12xJZxJZG5F6R2AVO2eN2y4soyBXRz
 Zej0w82BrzfNOqAa4T/vYknLDD3Ir41WVoZOZrOfqYc/d0Lnx3CJn2KuYqyXmI1Vpi/m
 5Du2wNRR/qmZ592kdSy02I2akStuYbfaI6LhTPZPO5waneQA8Gg4cFlLR8y3HD+qgkba
 5rWoJwnhjj1cUOpeG8SF33pn7o26o/VSUsfX2zwXr4+7p473ByElr6ONdJvXmxnMc/kS
 SRw51JvInFvZgiUA9CKD4jvfVeY5y1hOdZvxaFOAbNcsVCX1gs+Wsdhhi8q1fYbbkzBZ mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yp7hm4n00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 21:57:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ALmBjA084010;
 Tue, 10 Mar 2020 21:57:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yp8pua5ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 21:57:55 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ALvsXp001147;
 Tue, 10 Mar 2020 21:57:54 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 14:57:54 -0700
Subject: Re: [PATCH v2 00/16]: hw/i386/vmport: Bug fixes and improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
 <20200310133932-mutt-send-email-mst@kernel.org>
 <bcf7f439-7954-a6dc-322e-f8cbddd51d24@oracle.com>
 <20200310164239-mutt-send-email-mst@kernel.org>
 <b191ba0e-a864-fdc2-a029-c22783eb0106@oracle.com>
 <20200310173020-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <95fdfa38-1ef1-8735-2d50-e24c8a909144@oracle.com>
Date: Tue, 10 Mar 2020 23:57:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310173020-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100129
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
Cc: nikita.leshchenko@oracle.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/03/2020 23:44, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 02:29:42PM -0700, Liran Alon wrote:
>> On 10/03/2020 22:56, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 08:09:09PM +0200, Liran Alon wrote:
>>>> On 10/03/2020 19:44, Michael S. Tsirkin wrote:
>>>>> On Tue, Mar 10, 2020 at 06:53:16PM +0200, Liran Alon wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This series aims to fix several bugs in VMPort and improve it by supporting
>>>>>> more VMPort commands and make command results more configurable to
>>>>>> user via QEMU command-line.
>>>>>>
>>>>>> This functionality was proven to be useful to run various VMware VMs
>>>>>> when attempting to run them as-is on top of QEMU/KVM.
>>>>>>
>>>>>> For more details, see commit messages.
>>>>> Well two versions in one day and some review comments weren't addressed.
>>>> There is a single review comment that wasn't addressed which is replacing an
>>>> enum with a comment. And I explicitly mentioned that it's because I want
>>>> additional opinion on this.
>>>> I don't see why such a small thing should block review for 15 patches...
>>>> All the rest of the comments (Which were great) have been addressed. Unless
>>>> I have mistakenly missed something, which please point it out if I did.
>>> OK I just took a quick peek, two things quickly jumped out at me.
>> Thanks for having a look.
>>> version property really should be a boolean and have some documentation
>>> saying what functionality enables.
>> I thought that having a version number approach is more generic and easy to
>> maintain going forward.
>> If I understand correctly, this is also the approach taken by qxl & qxl-vga.
>>
>> The more elaborate alternative could have been introducing compat_flags (As
>> PVSCSI does) but it seems like it will pollute the property space with a lot
>> of useless VMPort properties.
>> (E.g. x-read-eax-bug, x-no-report-unsupported-cmd, x-no-report-vmx-type and
>> etc.).
>>
>> What is the advantage of having a boolean such as "x-vmport-v2" instead of
>> having a single "version" property?
> It's not clear what should happen going forward. Let's say version is
> incremented again. This then becomes challenging for downstreams to
> backport.
As all conditions are in the form of "if (s->version > X)" then 
incrementing version from 1 to 2 doesn't break any condition of "if 
(s->version > 1)".
What is the challenge of backporting I'm missing?

>
>> Will it suffice if I would just add documentation above "version" property
>> on what is was the functionality in "version==1"?
>> (Though, it's just easy to scan the vmport.c code for if's involving
>> ">version"... "version" is more of an internal field for machine-type
>> compatibility and not really meant to be used by user)
>>
>> Which approach do you prefer?
> I just dislike versions, they are hard to maintain.
>
> Individual ones is cleanest imho. Self-documenting.
I agree. That's the PVSCSI approach of compat_flags. Have many 
properties but each define bit in a compat_flags that specifies behavior.
The disadvantage it have is that it over-complicates code and introduce 
many properties that will never be used as it's just for internal 
binding to machine-type.
> But if not, I'd do something like "x-vmport-fixes" and
> set bits there for each bugfix.
Hmm this could a nice and simple approach.
Will it be OK then in this case to define "x-vmport-fixes" value in 
hw_compat_4_2[] to a hard-coded value (e.g. "20") without directly 
encoding each individual bit via vmport.h constants?
I will note though that it seems this "x-vmport-fixes" bitmap seems to 
be the first of it's kind. But I'm OK with this approach.
>
>
>>> userspace properties should use the non-abbreviated
>>> vm-executable since vmx is easy to confuse with vm extensions.
>> I really wish you would reconsider this. VMX is a really common term in
>> VMware terminology.
>> It is found in binary names, ".vmx" file, ".vmx" file properties, VMware
>> Tools prints, open-vm-tools source code and etc.
> Well that at least is easy to google.
>
> 	.vmx
>
> 	<vmname>.vmx
>
> 	This is the primary configuration file, which stores settings
> 	chosen in the New Virtual Machine Wizard or virtual machine settings
> 	editor. If you created the virtual machine under an earlier version of
> 	VMware Workstation on a Linux host, this file may have a .cfg extension
>
> so .vmx as used here has nothing to do with VM Executable version or
> type. Looks like it's just a source of confusion on the vmware
> side too :)
Well, the ".vmx" file is the configuration file for the VM given to VMX. 
But I agree VMware terminology is weird. :)
>> In contrast, even though I have dealt for many years with VMware
>> technologies, I have never known that VMX==vm-executable.
> Well you said that's what it stands for. I have no idea.  From what you
> say now maybe vmx basically is being used as a prefix for all things
> vmware.
No. It's just use to specify things related to VMX. i.e. The host VMM.
> In that case vmport-version and vmport-type or even
> vmware-version and vmware-type will do just as well.
vmware-version is also confusing. As one could confuse it with the 
product version number.
VMware called this field "vmx-version" and "vmx-type". I don't know if 
they have another field that maybe is called "vmware-version"...
>> I still think it will introduce much confusion. On the other hard, I don't
>> see much confusing with this use of VMX with Intel VT-x
>> because it is only used inside vmport.c and in vmport properties names. And
>> the properties names match the names of the guest
>> code that interface with vmport in open-vm-tools source code.
>>
>> If you still have a strong opinion on this, I will change it as you say in
>> v3... But please consider above arguments.
> I'm just saying don't use vmx. It's too late to try to give
> it a different meaning.
We are giving it here the same meaning VMware gave it. In the context of 
VMware VMPort.
>   Figure out what it's supposed to
> stand for and write it out in full.
VMX stands for the host VMM. But I don't see why I need to be in the 
position explaining the reason behind VMware terminology.
I'm just suggesting to use it as-is to avoid confusion.

It seems you are still not convinced by above arguments, so I will 
change this in v3 to what you preferred "vm-exec-version" & "vm-exec-type".
I think this is a mistake but you have the final call as the maintainer 
and I accept that.

-Liran



