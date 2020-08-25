Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD90C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B21E206F0
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1r2r59N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B21E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAXIv-0000kA-EN
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAXHT-00080t-LW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:38:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAXHR-0008QC-B7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598355500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVNUEOVAbsZk9C1kywjI+zTzVKVRJxc5hkxghqExyJ8=;
 b=C1r2r59NIszrePpBugZqcMaYh3CLHqyyApCM4nX6dxhkuNvtdpEOQX7CuGeroa0YEf51Zo
 2l/HejHYjAjU4iEnhr7j6TS5Y0EO7PQ+kQObIFq4nnEsd36inL2hse5BdjMxdFavxU5PpF
 rIeE1pavdP9J6QWTuTLB9oWZFoYpfHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-C_i0PK5QOPGwNFwnEWZpFw-1; Tue, 25 Aug 2020 07:38:18 -0400
X-MC-Unique: C_i0PK5QOPGwNFwnEWZpFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F68C425D0;
 Tue, 25 Aug 2020 11:38:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-152.ams2.redhat.com [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70C8D21E78;
 Tue, 25 Aug 2020 11:38:15 +0000 (UTC)
Subject: Re: [PATCH] pc-bios: s390x: Only set lowcore iplb address on
 list-directed IPL
To: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200817141734.5109-1-jjherne@linux.ibm.com>
 <20200817183048.30cb6f9e.cohuck@redhat.com>
 <f232a187-c989-cf77-52e5-2e31678e5bed@linux.ibm.com>
 <173257e9-a6cb-48a5-62ed-794c060e3900@linux.ibm.com>
 <20200819114538.7485d580.cohuck@redhat.com>
 <81d2ca24-538a-56ba-04de-079d28a16cb3@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <133e6840-d10a-0d8d-b555-dcbe40c554f8@redhat.com>
Date: Tue, 25 Aug 2020 13:38:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <81d2ca24-538a-56ba-04de-079d28a16cb3@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: jjherne@linux.ibm.com, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/2020 12.46, Janosch Frank wrote:
> On 8/19/20 11:45 AM, Cornelia Huck wrote:
>> On Wed, 19 Aug 2020 11:32:34 +0200
>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>
>>> On 8/17/20 7:51 PM, Jason J. Herne wrote:
>>>> On 8/17/20 12:30 PM, Cornelia Huck wrote:  
>>>>> On Mon, 17 Aug 2020 10:17:34 -0400
>>>>> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
>>>>>  
>>>>>> The POP states that the IPLB location is only written to 0x14 for
>>>>>> list-directed IPL. Some operating systems expect 0x14 to not change on
>>>>>> boot and will fail IPL if it does change.
>>>>>>
>>>>>> Fixes: 9bfc04f9ef6802fff0  
>>>>>
>>>>> Should be
>>>>>
>>>>> Fixes: 9bfc04f9ef68 ("pc-bios: s390x: Save iplb location in lowcore")
>>>>>  
>>>>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>>>>> Reviewed-by: Janosch Frank <frankja@de.ibm.com>
>>>>>> ---
>>>>>>   pc-bios/s390-ccw/jump2ipl.c | 5 ++++-
>>>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
>>>>>> index 767012bf0c..5e3e13f4b0 100644
>>>>>> --- a/pc-bios/s390-ccw/jump2ipl.c
>>>>>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>>>>>> @@ -33,7 +33,10 @@ void jump_to_IPL_code(uint64_t address)
>>>>>>   {
>>>>>>       /* store the subsystem information _after_ the bootmap was loaded */
>>>>>>       write_subsystem_identification();
>>>>>> -    write_iplb_location();
>>>>>> +
>>>>>> +    if (iplb.pbt != S390_IPL_TYPE_CCW) {
>>>>>> +            write_iplb_location();
>>>>>> +    }  
>>>>>
>>>>> What happens for ipl types other than CCW and FCP? IOW, should that
>>>>> rather be a positive check for S390_IPL_TYPE_FCP?
>>>>>  
>>>>>>   
>>>>>>       /* prevent unknown IPL types in the guest */
>>>>>>       if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {  
>>>>>  
>>>>
>>>> Based on my (admittedly limited) understanding of the architecture and
>>>> code, I believe write_iplb_location() should be called at least for
>>>> S390_IPL_TYPE_FCP but I'm not 100% sure on S390_IPL_TYPE_QEMU_SCSI.
>>>> Perhaps Janosch has an idea?
>>>>
>>>> It was originally unconditional, and my new conditional excludes vfio
>>>> CCW which is definitely a step in the right direction, in any case :).  
>>>
>>> If I remember correctly the problem was that ZIPL used the IPLB lowcore
>>> ptr without checking how it was booted (CCW or FCP). That was fixed in
>>> mid of July by testing if diag308 gives back a config or not.
>>
>> So we have the problem that old zipl relies on the presence of a value
>> that must not be there if you follow the architecture? Nasty.
>>
>> (Is it really "must not change" vs "don't expect anything here"? Not
>> sure if I'm looking at the right part of the documentation.)
> 
> Well if the loaded program overwrites absolute 0x0, we shouldn't modify
> it if we are not explicitly allowed to, no?
> 
> We already talked about saving the exception new addresses and restoring
> them before jumping to the new kernel. I think we might need to go a
> step further and use a non zero prefix for the bios to avoid any changes
> to absolute 0x0.
> 
> However that wouldn't fix this dilemma.

Sorry, I'm just back from summer vacation ... so what's the conclusion
for Jason's patch here? Should it be included as-is now or do we rather
neeed another rework here instead?

 Thomas


