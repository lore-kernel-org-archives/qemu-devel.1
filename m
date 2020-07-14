Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F56C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386CF22515
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386CF22515
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLwe-0000lk-E2
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jvLw1-0000Gi-UQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:29:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jvLvz-0007Ml-BP
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:29:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 49BA8AC85;
 Tue, 14 Jul 2020 14:29:27 +0000 (UTC)
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
Message-ID: <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
Date: Tue, 14 Jul 2020 16:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:34:19
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
 Thomas Huth <thuth@redhat.com>, Liang Yan <lyan@suse.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I have some tiny progress in narrowing down this issue, possibly a qcow2 issue, still unclear,
but involving Kevin Wolf and Max Reitz.


The reproducer again:

> --------------------------------------------cut-------------------------------------------
> diff --git a/cpus.c b/cpus.c
> index 41d1c5099f..443b88697a 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -643,7 +643,7 @@ static void qemu_account_warp_timer(void)
>  
>  static bool icount_state_needed(void *opaque)
>  {
> -    return use_icount;
> +    return 0;
>  }
>  
>  static bool warp_timer_state_needed(void *opaque)
> --------------------------------------------cut-------------------------------------------



This issue for now appears on s390 only:

On s390 hardware, test 267 fails (both kvm and tcg) in the qcow2 backing file part, with broken migration stream data in the s390-skeys vmsave (old style).

What is new?
It is possible to work around the problem by adding back to the stream simply by extending, for example, the existing UNUSED field in the timers vmstate.

So this "fixes it", applied on top of the reproducer:

--------------------------------------------cut-------------------------------------------
@@ -728,7 +728,7 @@ static const VMStateDescription vmstate_timers = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_INT64(cpu_ticks_offset, TimersState),
-        VMSTATE_UNUSED(8),
+        VMSTATE_UNUSED(119),
         VMSTATE_INT64_V(cpu_clock_offset, TimersState, 2),
         VMSTATE_END_OF_LIST()
     },
--------------------------------------------cut-------------------------------------------


NB: Exactly 111 bytes need to be added, not one byte less.

Using VMSTATE_UNUSED(118) again breaks.
Using VMSTATE_UNUSED(120) or more is _fine_. Seems that a certain threshold needs to be reached in the stream, before the transfer of old style vmsave fields in s390-skeys is successful.

So here is the output, with some logging, of the VMSTATE_UNUSED(118) run (FAILURE, marked by error "-22"), followed by the VMSTATE_UNUSED(119) run (SUCCESS).
qemu_fflush logs when called, as well as s390 save key code, just before and just after writing the skey fields.

VMSTATE_UNUSED(118):

QA output created by 267

=== -blockdev with a backing file ===

Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-file,node-name=fmt
QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
qemu_fflush: written: 82, expected: 82 - done.
qemu_fflush: written: 78, expected: 78 - done.
qemu_fflush: - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 81907, expected: 81907 - done.
qemu_fflush: written: 36, expected: 36 - done.
saving keys to stream...
bytes_xfer=344418 xfer_limit=0 pos=344247 buf_index=331 buf_size=0
iov cnt=1
[0] base=0x2aa38733778 len=331 [~]

qemu_fflush: written: 32768, expected: 32768 - done.
saved keys to stream.
bytes_xfer=377210 xfer_limit=0 pos=377015 buf_index=355 buf_size=0
iov cnt=1
[0] base=0x2aa38733778 len=355 []

qemu_fflush: written: 16201, expected: 16201 - done.
qemu_fflush: - done.
qemu_fflush: - done.
(qemu) info snapshots
List of snapshots present on all disks:
ID        TAG                     VM SIZE                DATE       VM CLOCK
--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
(qemu) loadvm snap0
Unexpected storage key flag data: 0
error while loading state for instance 0x0 of device 's390-skeys'
qemu_fflush: not writable!
Error: Error -22 while loading VM state
(qemu) quit

*** done



===================================================================================================================================



VMSTATE_UNUSED(119):


QA output created by 267

=== -blockdev with a backing file ===

Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-file,node-name=fmt
QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
qemu_fflush: written: 82, expected: 82 - done.
qemu_fflush: written: 78, expected: 78 - done.
qemu_fflush: - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 32768, expected: 32768 - done.
qemu_fflush: written: 81907, expected: 81907 - done.
qemu_fflush: written: 36, expected: 36 - done.
saving keys to stream...
bytes_xfer=344419 xfer_limit=0 pos=344247 buf_index=332 buf_size=0
iov cnt=1
[0] base=0x2aa1bc41778 len=332 [~]

qemu_fflush: written: 32768, expected: 32768 - done.
saved keys to stream.
bytes_xfer=377211 xfer_limit=0 pos=377015 buf_index=356 buf_size=0
iov cnt=1
[0] base=0x2aa1bc41778 len=356 []

qemu_fflush: written: 16202, expected: 16202 - done.
qemu_fflush: - done.
qemu_fflush: - done.
(qemu) info snapshots
List of snapshots present on all disks:


=================================================

Here is the diff between failed and successful runs:

--- bad_extra_118.txt   2020-07-14 09:52:48.054023509 -0400
+++ good_extra_119.txt  2020-07-14 09:48:30.823977732 -0400
@@ -21,17 +21,17 @@
 qemu_fflush: written: 81907, expected: 81907 - done.
 qemu_fflush: written: 36, expected: 36 - done.
 saving keys to stream...
-bytes_xfer=344418 xfer_limit=0 pos=344247 buf_index=331 buf_size=0
+bytes_xfer=344419 xfer_limit=0 pos=344247 buf_index=332 buf_size=0
 iov cnt=1
-[0] base=0x2aa38733778 len=331 [~]
+[0] base=0x2aa1bc41778 len=332 [~]
 
 qemu_fflush: written: 32768, expected: 32768 - done.
 saved keys to stream.
-bytes_xfer=377210 xfer_limit=0 pos=377015 buf_index=355 buf_size=0
+bytes_xfer=377211 xfer_limit=0 pos=377015 buf_index=356 buf_size=0
 iov cnt=1
-[0] base=0x2aa38733778 len=355 []
+[0] base=0x2aa1bc41778 len=356 []
 
-qemu_fflush: written: 16201, expected: 16201 - done.
+qemu_fflush: written: 16202, expected: 16202 - done.
 qemu_fflush: - done.
 qemu_fflush: - done.
 (qemu) info snapshots
@@ -39,10 +39,7 @@
 ID        TAG                     VM SIZE                DATE       VM CLOCK
 --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
-Unexpected storage key flag data: 0
-error while loading state for instance 0x0 of device 's390-skeys'
 qemu_fflush: not writable!
-Error: Error -22 while loading VM state
 (qemu) quit
 
 *** done

=================================================


If someone has a good idea let me know - first attempts to reproduce on x86 failed, but maybe more work could lead to it.

Thanks,

Claudio



On 7/13/20 11:11 AM, Claudio Fontana wrote:
> Hi Paolo,
> 
> On 7/12/20 6:11 PM, Paolo Bonzini wrote:
>> On 12/07/20 12:00, Claudio Fontana wrote:
>>> Note: only the === -blockdev with a backing file === part of test 267 fails. -blockdev with NBD is ok, like all the rest.
>>>
>>>
>>> Interesting facts about s390 in particular: its save/load code includes the transfer of "storage keys",
>>> which include a buffer of 32768 bytes of keydata in the stream.
>>>
>>> The code (hw/s390x/s390-skeys.c),
>>> is modeled similarly to RAM transfer (like in migration/ram.c), with an EOS (end of stream) marker.
>>>
>>> Countrary to RAM transfer code though, after qemu_put_be64(f, EOS), the s390 code does not qemu_fflush(f).
>>
>> 1) Are there unexpected differences in the migration stream?  That is,
>> you could modify qcow2.c to fopen/fwrite/fclose the bytes as they're
>> written and read, and see if something does not match.
> 
> I hooked qcow2_co_pwritev_task and qcow2_co_preadv_task to also write to an external file using your suggestion.
> 
> I am seeing very interesting differences with and without the reproducer patch (ie, forcing icount_state_needed to 0 or not):
> 
> * without the reproducer patch, everything past the s390-skeys data field is in order: there is the EOS, and then the next idstr follows ("cpu_common").
> 
> * with the reproducer patch, every single byte past the s390-skeys data field is ZERO. There is no EOS, there is no next idstr "cpu_common", there is absolutely nothing else than zeroes until the end of the file.
> 
> 
>>
>> 2) If it matches, are there unexpected differences other than the lack
>> of icount section when you apply the reproducer patch?
> 
> they do not match at all.
> 
> 
>>
>> The fflush part makes me put more hope in the first, but both could help
>> you debug it.
>>
>> Thanks,
>>
>> Paolo
>>
> 
> Thanks,
> 
> Claudio
> 


