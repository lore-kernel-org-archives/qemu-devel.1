Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BDCC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79BA20739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79BA20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3U6-0002PE-Tu
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jw3TZ-0001zn-3H
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:59:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jw3TX-0006Ry-5R
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:59:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C40DFAF8E;
 Thu, 16 Jul 2020 12:58:59 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
 <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
 <8125b1ff-373a-aadc-eccf-27c567007a27@redhat.com>
 <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
Message-ID: <1db6d502-73d1-5e3d-10d1-796d80ab8f07@suse.de>
Date: Thu, 16 Jul 2020 14:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 23:15:05
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Small update on this,

On 7/15/20 1:10 PM, Claudio Fontana wrote:
> Hi Thomas,
> 
> On 7/14/20 4:35 PM, Thomas Huth wrote:
>> On 14/07/2020 16.29, Claudio Fontana wrote:
>>> Hello,
>>>
>>> I have some tiny progress in narrowing down this issue, possibly a qcow2 issue, still unclear,
>>> but involving Kevin Wolf and Max Reitz.
>>>
>>>
>>> The reproducer again:
>>>
>>>> --------------------------------------------cut-------------------------------------------
>>>> diff --git a/cpus.c b/cpus.c
>>>> index 41d1c5099f..443b88697a 100644
>>>> --- a/cpus.c
>>>> +++ b/cpus.c
>>>> @@ -643,7 +643,7 @@ static void qemu_account_warp_timer(void)
>>>>  
>>>>  static bool icount_state_needed(void *opaque)
>>>>  {
>>>> -    return use_icount;
>>>> +    return 0;
>>>>  }
>>>>  
>>>>  static bool warp_timer_state_needed(void *opaque)
>>>> --------------------------------------------cut-------------------------------------------
>>>
>>> This issue for now appears on s390 only:
>>>
>>> On s390 hardware, test 267 fails (both kvm and tcg) in the qcow2 backing file part, with broken migration stream data in the s390-skeys vmsave (old style).
>> [...]
>>> If someone has a good idea let me know - first attempts to reproduce on x86 failed, but maybe more work could lead to it.
>>
> 
> small update: in the GOOD case (enough padding added) a qcow_merge() is triggered for the last write of 16202 bytes.
> In the BAD case (not enough padding added) a qcow_merge() is not triggered for the last write of 16201 bytes.
> 
> Note: manually flushing with qemu_fflush in s390-skeys vmsave also works (maybe got lost in the noise).
> 
> 
>> Two questions:
>>
>> 1) Can you also reproduce the issue manually, without running iotest
>> 267? ... I tried, but so far I failed.
> 
> Thanks for the suggestion, will try.

Currently trying to reproduce manually an environment similar to that of the test,
at the moment I am not able to reproduce the issue manually.

Not very familiar with s390,
I've been running with 

export QEMU=/home/cfontana/qemu-build/s390x-softmmu/qemu-system-s390x

$QEMU -nographic -monitor stdio -nodefaults -no-shutdown FILENAME

where FILENAME is the qcow2 produced by the test.

let me know if you have a suggestion on how to setup up something simple properly.


> 
>>
>> 2) Since all the information so far sounds like the problem could be
>> elsewhere in the code, and the skeys just catch it by accident ... have
>> you tried running with valgrind? Maybe it catches something useful?
> 
> Nothing yet, but will fiddle with the options a bit more.

Only thing I have seen so far:


+==33321== 
+==33321== Warning: client switching stacks?  SP change: 0x1ffeffe5e8 --> 0x5d9cf60
+==33321==          to suppress, use: --max-stackframe=137324009096 or greater
+==33321== Warning: client switching stacks?  SP change: 0x5d9cd18 --> 0x1ffeffe5e8
+==33321==          to suppress, use: --max-stackframe=137324009680 or greater
+==33321== Warning: client switching stacks?  SP change: 0x1ffeffe8b8 --> 0x5d9ce58
+==33321==          to suppress, use: --max-stackframe=137324010080 or greater
+==33321==          further instances of this message will not be shown.
+==33321== Thread 4:
+==33321== Conditional jump or move depends on uninitialised value(s)
+==33321==    at 0x3AEC70: process_queued_cpu_work (cpus-common.c:331)
+==33321==    by 0x2753E1: qemu_wait_io_event_common (cpus.c:1213)
+==33321==    by 0x2755CD: qemu_wait_io_event (cpus.c:1253)
+==33321==    by 0x27596D: qemu_dummy_cpu_thread_fn (cpus.c:1337)
+==33321==    by 0x725C87: qemu_thread_start (qemu-thread-posix.c:521)
+==33321==    by 0x4D504E9: start_thread (in /lib64/libpthread-2.26.so)
+==33321==    by 0x4E72BBD: ??? (in /lib64/libc-2.26.so)
+==33321== 
+==33321== Conditional jump or move depends on uninitialised value(s)
+==33321==    at 0x3AEC74: process_queued_cpu_work (cpus-common.c:331)
+==33321==    by 0x2753E1: qemu_wait_io_event_common (cpus.c:1213)
+==33321==    by 0x2755CD: qemu_wait_io_event (cpus.c:1253)
+==33321==    by 0x27596D: qemu_dummy_cpu_thread_fn (cpus.c:1337)
+==33321==    by 0x725C87: qemu_thread_start (qemu-thread-posix.c:521)
+==33321==    by 0x4D504E9: start_thread (in /lib64/libpthread-2.26.so)
+==33321==    by 0x4E72BBD: ??? (in /lib64/libc-2.26.so)
+==33321== 
+==33321== 
+==33321== HEAP SUMMARY:
+==33321==     in use at exit: 2,138,442 bytes in 13,935 blocks
+==33321==   total heap usage: 19,089 allocs, 5,154 frees, 5,187,670 bytes allocated
+==33321== 
+==33321== LEAK SUMMARY:
+==33321==    definitely lost: 0 bytes in 0 blocks
+==33321==    indirectly lost: 0 bytes in 0 blocks
+==33321==      possibly lost: 7,150 bytes in 111 blocks
+==33321==    still reachable: 2,131,292 bytes in 13,824 blocks
+==33321==         suppressed: 0 bytes in 0 blocks
+==33321== Rerun with --leak-check=full to see details of leaked memory


> 
>>
>>  Thomas
>>
> 
> Ciao,
> 
> Claudio
> 
> 

A more interesting update is what follows I think.

I was able to "fix" the problem shown by the reproducer:

@@ -643,7 +643,7 @@ static void qemu_account_warp_tim@@ -643,7 +643,7 @@ static void qemu_account_warp_timer(void)
 
 static bool icount_state_needed(void *opaque)
 {
-    return use_icount;
+    return 0;
 }
 
by just slowing down qcow2_co_pwritev_task_entry with some tight loops,
without changing any fields between runs (other than the reproducer icount field removal).

I tried to insert the same slowdown just in savevm.c at the end of save_snapshot, but that does not work, needs to be in the coroutine.

Thanks,

Claudio


