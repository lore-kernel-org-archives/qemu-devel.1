Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA23EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42C8206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42C8206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0P1z-0003IB-VG
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k0P1G-0002df-FL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:47:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:45846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k0P1E-0003cF-4e
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:47:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DCF5EACB5;
 Tue, 28 Jul 2020 12:47:48 +0000 (UTC)
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: Max Reitz <mreitz@redhat.com>, Bruce Rogers <brogers@suse.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
 <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
 <8125b1ff-373a-aadc-eccf-27c567007a27@redhat.com>
 <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
 <1db6d502-73d1-5e3d-10d1-796d80ab8f07@suse.de>
 <13728e69-75a5-2edc-9ed3-6e08d94c722d@suse.de>
 <636bb3c4-2242-284b-30cd-299f447117c2@suse.de>
 <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
 <72ff33d4-653f-5702-fc04-9090653ab782@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <435b4387-5e8d-93b0-2d25-675476758359@suse.de>
Date: Tue, 28 Jul 2020 14:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <72ff33d4-653f-5702-fc04-9090653ab782@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 01:54:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Liang Yan <lyan@suse.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/28/20 1:10 PM, Max Reitz wrote:
> On 28.07.20 01:09, Bruce Rogers wrote:
>> On Tue, 2020-07-21 at 10:22 +0200, Claudio Fontana wrote:
>>> On 7/20/20 8:24 PM, Claudio Fontana wrote:
>>>> I have now been able to reproduce this on X86 as well.
>>>>
>>>> It happens much more rarely, about once every 10 times.
>>>>
>>>> I will sort out the data and try to make it even more reproducible,
>>>> then post my findings in detail.
>>>>
>>>> Overall I proceeded as follows:
>>>>
>>>> 1) hooked the savevm code to skip all fields with the exception of
>>>> "s390-skeys". So only s390-skeys are actually saved.
>>>>
>>>> 2) reimplemented "s390-skeys" in a common implementation in cpus.c,
>>>> used on both x86 and s390, modeling the behaviour of save/load from
>>>> hw/s390
>>>>
>>>> 3) ran ./check -qcow2 267 on both x86 and s390.
>>>>
>>>> In the case of s390, failure seems to be reproducible 100% of the
>>>> times.
>>>> On X86, it is as mentioned failing about 10% of the times.
>>>>
>>>> Ciao,
>>>>
>>>> Claudio
>>>
>>> And here is a small series of two patches that can be used to
>>> reproduce the problem.
>>>
>>> Clearly, this is not directly related to s390 or to skeys or to
>>> icount in particular, it is just an issue that happened to be more
>>> visible there.
>>>
>>> If you could help with this, please apply the attached patches.
>>>
>>> Patch 1 just adds a new "300" iotest. It is way easier to extract the
>>> relevant part out of test 267, which does a bit too much in the same
>>> file.
>>> Also this allows easier use of valgrind, since it does not "require"
>>> anything.
>>>
>>> Patch 2 hooks the savevm code to skip all fields during the snapshot
>>> with the exception of "s390-skeys", a new artificial field
>>> implemented to
>>> model what the real s390-skeys is doing.
>>>
>>> After applying patch 1 and patch 2, you can test (also on X86), with:
>>>
>>> ./check -qcow2 300
>>>
>>> On X86 many runs will be successful, but a certain % of them will
>>> instead fail like this:
>>>
>>>
>>> claudio@linux-ch70:~/git/qemu-pristine/qemu-build/tests/qemu-iotests> 
>>> ./check -qcow2 300
>>> QEMU          -- "/home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
>>> -nodefaults -display none -accel qtest
>>> QEMU_IMG      -- "/home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/../../qemu-img" 
>>> QEMU_IO       -- "/home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio
>>> threads -f qcow2
>>> QEMU_NBD      -- "/home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/../../qemu-nbd" 
>>> IMGFMT        -- qcow2 (compat=1.1)
>>> IMGPROTO      -- file
>>> PLATFORM      -- Linux/x86_64 linux-ch70 4.12.14-lp151.28.36-default
>>> TEST_DIR      -- /home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/scratch
>>> SOCK_DIR      -- /tmp/tmp.gdcUu3l0SM
>>> SOCKET_SCM_HELPER -- /home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/socket_scm_helper
>>>
>>> 300      fail       [10:14:05] [10:14:06]      (last: 0s)    output
>>> mismatch (see 300.out.bad)
>>> --- /home/claudio/git/qemu-pristine/qemu/tests/qemu-
>>> iotests/300.out     2020-07-21 10:03:54.468104764 +0200
>>> +++ /home/claudio/git/qemu-pristine/qemu-build/tests/qemu-
>>> iotests/300.out.bad   2020-07-21 10:14:06.098090543 +0200
>>> @@ -12,6 +12,9 @@
>>>  ID        TAG                 VM SIZE                DATE       VM
>>> CLOCK
>>>  --        snap0                  SIZE yyyy-mm-dd
>>> hh:mm:ss   00:00:00.000
>>>  (qemu) loadvm snap0
>>> +Unexpected storage key data: 0
>>> +error while loading state for instance 0x0 of device 's390-skeys'
>>> +Error: Error -22 while loading VM state
>>>  (qemu) quit
>>>  
>>>  *** done
>>> Failures: 300
>>> Failed 1 of 1 iotests
>>>
>>>
>>> At this point somebody more knowledgeable about QCOW2, coroutines and
>>> backing files could chime in?
>>>
>> <trim>
>>
>> I used the reproducer you provide here to do a git bisect as I assume
>> whatever is now broken wasn't always broken, and it pointed to the
>> following commit:
>>
>> commit df893d25ceea3c0dcbe6d6b425309317fab6b22e (refs/bisect/bad)
>> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Date:   Tue Jun 4 19:15:13 2019 +0300
>>
>>     block/qcow2: implement .bdrv_co_preadv_part
>>
>> Indeed, I am currently able to reliable reproduce the issue with this
>> commit applied, and not reproduce it without it.
>>
>> That said, I've not been able to identify exactly what is going wrong.
>> I'm fairly confident the savevm data is correctly written out, but on
>> the loadvm side, somehow the last part of the s390 data is not
>> correctly read in the data (it's in the second pass through the while
>> loop in qcow2_co_preadv_part() where that happens.)
>>
>> If anyone familiar with this code can have a look or provide some
>> pointers, it would be much appreciated.
> 
> Thanks for both your investigation.  Does the attached patch help?
> 
> Max
> 

Hello Max,

yes, this solves the problem everywhere (on s390, on X86, based on all the reproducers so far).

Thanks a lot for the help!

Claudio

