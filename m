Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84120C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514CB208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QwxePHnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514CB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmSZ-0007ha-HD
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBmRl-0007Bu-VN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBmRk-0005K6-9Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:29:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBmRk-0005J3-1t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:29:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ALOTPs003063;
 Tue, 10 Mar 2020 21:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KkPZFmykhUwlfBzqSWVZ3QYJznH9JEVJtiYnK+6jNxM=;
 b=QwxePHnwsSqjOI1FWqKdTjEPkLGkPOZFn+s9UyR0WIlf6i8jHE+9Dq4TWOuhEWsYDf8z
 u0poQ1Wa80pGmsnHFjK6EfJdH0ZnptORD+aHLANCselAi1Upf1vH4Qq9Fpm6BQyIO7Ef
 qgnDeyKHBJTQ6CqcB/LO7UDfUZV5Q0RoEjUVHnESlmXcRFHUhFa7EtSZyhNMyZsQmNlm
 nOyCs6XHXunTjfxiXxSgvGjIMLOlySlSFuo/zOfvoMAm5JG82QU15CozwJKewMgVBCBK
 ElgQZ/qZGDUDz+754iRYaAAj+bg1AHYhaDgML9D+Ko3yZBWd0J03W0gu07Q7bjfN2JSm lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yp9v638fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 21:29:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ALMRE6106133;
 Tue, 10 Mar 2020 21:29:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yp8nvufcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 21:29:49 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02ALTk8G023777;
 Tue, 10 Mar 2020 21:29:46 GMT
Received: from [192.168.14.112] (/79.181.212.171) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Tue, 10 Mar 2020 14:29:46 -0700
USER-AGENT: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <b191ba0e-a864-fdc2-a029-c22783eb0106@oracle.com>
Date: Tue, 10 Mar 2020 14:29:42 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 00/16]: hw/i386/vmport: Bug fixes and improvements
References: <20200310165332.140774-1-liran.alon@oracle.com>
 <20200310133932-mutt-send-email-mst@kernel.org>
 <bcf7f439-7954-a6dc-322e-f8cbddd51d24@oracle.com>
 <20200310164239-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200310164239-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100127
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
Cc: nikita.leshchenko@oracle.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/03/2020 22:56, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 08:09:09PM +0200, Liran Alon wrote:
>> On 10/03/2020 19:44, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 06:53:16PM +0200, Liran Alon wrote:
>>>> Hi,
>>>>
>>>> This series aims to fix several bugs in VMPort and improve it by supporting
>>>> more VMPort commands and make command results more configurable to
>>>> user via QEMU command-line.
>>>>
>>>> This functionality was proven to be useful to run various VMware VMs
>>>> when attempting to run them as-is on top of QEMU/KVM.
>>>>
>>>> For more details, see commit messages.
>>> Well two versions in one day and some review comments weren't addressed.
>> There is a single review comment that wasn't addressed which is replacing an
>> enum with a comment. And I explicitly mentioned that it's because I want
>> additional opinion on this.
>> I don't see why such a small thing should block review for 15 patches...
>> All the rest of the comments (Which were great) have been addressed. Unless
>> I have mistakenly missed something, which please point it out if I did.
> OK I just took a quick peek, two things quickly jumped out at me.
Thanks for having a look.
>
> version property really should be a boolean and have some documentation
> saying what functionality enables.
I thought that having a version number approach is more generic and easy 
to maintain going forward.
If I understand correctly, this is also the approach taken by qxl & qxl-vga.

The more elaborate alternative could have been introducing compat_flags 
(As PVSCSI does) but it seems like it will pollute the property space 
with a lot of useless VMPort properties.
(E.g. x-read-eax-bug, x-no-report-unsupported-cmd, x-no-report-vmx-type 
and etc.).

What is the advantage of having a boolean such as "x-vmport-v2" instead 
of having a single "version" property?
Will it suffice if I would just add documentation above "version" 
property on what is was the functionality in "version==1"?
(Though, it's just easy to scan the vmport.c code for if's involving 
">version"... "version" is more of an internal field for machine-type 
compatibility and not really meant to be used by user)

Which approach do you prefer?

> userspace properties should use the non-abbreviated
> vm-executable since vmx is easy to confuse with vm extensions.
I really wish you would reconsider this. VMX is a really common term in 
VMware terminology.
It is found in binary names, ".vmx" file, ".vmx" file properties, VMware 
Tools prints, open-vm-tools source code and etc.

In contrast, even though I have dealt for many years with VMware 
technologies, I have never known that VMX==vm-executable.
I still think it will introduce much confusion. On the other hard, I 
don't see much confusing with this use of VMX with Intel VT-x
because it is only used inside vmport.c and in vmport properties names. 
And the properties names match the names of the guest
code that interface with vmport in open-vm-tools source code.

If you still have a strong opinion on this, I will change it as you say 
in v3... But please consider above arguments.
>
> That's just a quick look.
>
>
>>> Some people do this, try to wear the maintainers out by sheer volume.
>>> It works sometimes but it's not a nice tactic. I personally think it's
>>> worth taking the time to think harder about ways to address all
>>> comments, not try to dismiss them.
>> That's not what I tried to do. I carefully fixed all comments I saw in the
>> review discussion and run tests.
>> The only thing which wasn't addressed is removing an enum and replacing it
>> with a comment.
>> The hint that I try to manipulate maintainers is disrespectful. I assume
>> that this isn't your intention, as we all just want to collaborate together
>> here. No need to make this a personal discussion.
>>
>> If you think that replacing the enum with a comment is a blocker for v2
>> patch-series, I will go ahead and submit v3 with that change.
> Yes IMHO it needs to be fixed but please go over the comments and try to
> address them all as best you can, instead of looking for an explanation
> why the comments were irrelevant and can be dismissed.

I'm not trying to finding explanation on why the comments are irrelevant 
and can be dismissed... It's not my first time contributing code to 
QEMU/KVM...

> Sure someone
> might propose you introduce a bug, and that can't just be addressed, but
> that's not the case here.  Also please do not send multiple revisions of
> a large patchset in a day.  People need time for review.
OK. I will make note of that for next time.
I would have thought maintainers prefer to always have ability to pick 
up the latest version that is ready to avoid reviewing old code that was 
already discussed. Assuming all previous comments were addressed.

Thanks,
-Liran



