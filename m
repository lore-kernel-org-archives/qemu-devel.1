Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9761DC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64777222C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZPJynd5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64777222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBhvr-0003Kn-Kp
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBhv3-0002kl-GI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBhv0-0001z1-Be
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:39:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBhv0-0001tu-2S
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:39:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcSbg085225;
 Tue, 10 Mar 2020 16:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oUb2nCCNXsO9G/XCAxVioFQIQyvpY3T4Rp8zayM9v7k=;
 b=ZPJynd5vAmuQMV7MPaftCRpZy4rwxWDB7tM9z/kCNxa6mxT94MyfdGDfo2KsNDKKRHNv
 CJ55iXS5dTpOMY8UNtTxYjIJ+xyW1vkZJ++Tg4XqJfGvGzoo4VvR8/K0ed7Fm/L07Vu9
 hLXWLLuCngGyp7jjI+8qrfSvfup1dGmC1ixUYKY6S94hY5H4It3SxEjTOCljjUjIsWQa
 iYVf191eC8IR4BmA25iIADJaiuQzMUJLqM0slH/X0YK+MToHrftXGlUYzlp8A7BDUF5I
 NJuXQavOkpd3iCH+YI6PR9hm82xECWKAu6F/jTFwh8PhUME7gdX0GMwK/FwJ0ZJRSIA/ QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2ym31uer8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:39:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcCue054106;
 Tue, 10 Mar 2020 16:39:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yp8psehm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:39:40 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGddj2032444;
 Tue, 10 Mar 2020 16:39:39 GMT
Received: from Lirans-MacBook-Pro.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:39:39 -0700
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
 <20200310094350-mutt-send-email-mst@kernel.org>
 <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
 <20200310104713-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <8c856884-a5f1-d522-b0be-9edee6623ca4@oracle.com>
Date: Tue, 10 Mar 2020 18:39:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310104713-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
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


On 10/03/2020 17:10, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 04:46:19PM +0200, Liran Alon wrote:
>> On 10/03/2020 16:08, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 03:35:25PM +0200, Liran Alon wrote:
>>>> On 10/03/2020 14:53, Michael S. Tsirkin wrote:
>>>>> On Tue, Mar 10, 2020 at 02:43:51PM +0200, Liran Alon wrote:
>>>>>> On 10/03/2020 14:35, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Mar 10, 2020 at 02:25:28PM +0200, Liran Alon wrote:
>>>>>>>> On 10/03/2020 14:14, Michael S. Tsirkin wrote:
>>>>>>>>> On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
>>> But in this case, the names are confusing,
>>> violate our coding style, I could go on.
>> The only thing that violates the coding style is "VMX_Type" enum type name
>> instead of "VMXType".
> All enum names too. Supposed to be CamelCase. Again VMX is

Looking at other enums defined in QEMU, it doesn't seem that constant 
names are CamelCase. Only the enum type name.
E.g. PVSCSIRegOffset, BiosAtaTranslation and etc.

>>> No you also copy names and comments. Which might make sense in the
>>> context of the original project but seem to make no sense here.
>>> E.g. for vmware a given product is deprecated but why does QEMU care?
>> What is the harm in specifying that? It gives more context.
>>> enum values are not even listed. What is poor user supposed to do -
>>> take out a calculator to figure it out?
>> What do you mean by listed?
> So imagine: as a user, I want to set this to some reasonable value.
>
> Supposedly this is why you have the enum there in the
> 1st place right? Let's see how does all this help me:
>
> - first enum is VMX_TYPE_UNSET. Unset? I guess that's
> the default. I want to set it, make sure it's a good value.
> - next one is VMX_TYPE_EXPRESS. comment says deprecated though.
>    I will keep clear.
> - Next enum is VMX_TYPE_SCALABLE_SERVER. Hmm that says ESX.
> I guess it's good! However what's scalable server?
> There's no vmware in sight,
> brings up unrelated search results.
> Scalable server? No I need to research that.
> I guess I will just ignore all this and go by the comments.
> Okay! Wait so what is the value I need to supply to the
> property?
> Oh right I need to recall that enum values are sequential.
> So first one it says is 0. Let me count. It's 2 I guess.
>
> Okay I will try ...

The person who is expected to manipulate this property is quite advance 
to begin with...
The process described above is quite simple for such person.

>>>
>>>> I'm not sure I understand what you are
>>>> suggesting.
>>>>
>>>> -Liran
>>> Something like the below.
>>>
>>> /*
>>>    * Most guests are fine with the default.
>>>    * Some legacy guests hard-code a given type.
>>>    * See https://urldefense.com/v3/__https://github.com/vmware/open-vm-tools/blob/master/open-vm-tools/lib/include/vm_vmx_type.h__;!!GqivPVa7Brio!M9wko4CSBSs3xFA2QY7MIL_jvAxlU5aRZE1jN2hzG5jnk8rdlpYCDs2ymrkJ8GE$
>>>    * for an up-to-date list of values.
>>>    *
>>>    * Reasonable options:
>>>    * 0 - unset?
>>>    * 1 - VMware Express (deprecated)
>>>    * 2 - VMware ESX server
>>>    * 3 - VMware Workstation
>>>    * 4 - ACE 1.x (deprecated)
>>>    */
>>>
>>> DEFINE_PROP_UINT8("vm-executable-type", VMPortState, vm_executable_type, 2 /* VMware ESX server */),
>>>
>> Why is it better to specify a list of all options in a comment than an enum?
> Because that lets you use english. Look you didn't even list options.
> User's supposed to do the math in his/her head. Why is that?
Figuring out an enum value from definition is trivial. If you wish, I 
can change those to #define to make it more clear but error-prone.
> Oh because we lifted this wholesale from some other header.
That's not the reason.
>> Isn't enum invented exactly for enumerating all possible values of a field?
> No - it just assigns names to constants. If you then proceed not to use
> the names, then it's pointless.
It's not. It exactly lists all the various possible values. In contrast 
to directing the reader to a link (which may be broken in the future),
to figure out from there what should be the values. That seems more 
annoying to me as a reader.
>> Note that even in this simple case, you needed to write "VMware ESX server"
>> twice instead of referring to an enum constant. It doesn't seem more elegant
>> to me.
> I felt this bears repetition.
> But sure, you can drop it in DEFINE_PROP_UINT8 if you like.
> If you really feel you must, do:
>
> #define VM_PORT_DEFAULT_VM_EXECUTABLE 2
> near the comment.

Why not just define the entire enum then?...

This approach seems quite common for all device emulation code.
E.g. BTSTAT_HATIMEOUT in HostBusAdapterStatus, 
PVSCSI_REG_OFFSET_LAST_STS_3 in PVSCSIRegOffset, VMXNET3_CMD_UPDATE_IML 
in vmxnet3.h and etc.

>> And again, I disagree with renaming the field to "vm-executable-type"
>> instead of "vmx-type".
>>
>> -Liran
> Acronims is a bad idea in user interfaces if avoidable, or unless
> universal. Either these interfaces are needed or they aren't.
> I question their usefulness, but if they are useful they should
> have names that do not require guesswork to understand.
>
Giving new names to existing terminology that can be matched against 
existing guest code which interface with your device emulation is what 
requires guesswork.
Using names matching the guest code driver is what doesn't require 
guesswork and is more intuitive to understand.

Let's agree that I will fix coding convention issue (VMX_Type -> 
VMXType) and link to open-vm-tools but remain with the enum.
And see what other maintainers have to see about this on v2.

-Liran



