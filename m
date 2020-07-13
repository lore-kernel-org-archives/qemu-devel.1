Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0788C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A084B20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A084B20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwpp-0003TQ-TU
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juwoV-0002Wf-66
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:40:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:48696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juwoT-0002Ho-0W
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:40:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 553B1ADF2;
 Mon, 13 Jul 2020 11:40:01 +0000 (UTC)
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <20200713110333.GE3122@work-vm>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <c5878d54-e8b5-b1e7-a664-2d2ab36015e6@suse.de>
Date: Mon, 13 Jul 2020 13:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200713110333.GE3122@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 00:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 7/13/20 1:03 PM, Dr. David Alan Gilbert wrote:
> * Claudio Fontana (cfontana@suse.de) wrote:
>> Hello all,
>>
>> during unrelated work for splitting QTest from the TCG instruction counting module,
>>
>> I encountered what seems to be a migration stream issue, which is apparent only on s390, and only shows in block test 267.
>>
>> ./check -qcow2 267
>>
>> when it comes to snapshot save and load using backing file.
>>
>> Here is a minimal reproducer patch that causes the issue on s390 only.
>>
>> --------------------------------------------cut-------------------------------------------
>> diff --git a/cpus.c b/cpus.c
>> index 41d1c5099f..443b88697a 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -643,7 +643,7 @@ static void qemu_account_warp_timer(void)
>>  
>>  static bool icount_state_needed(void *opaque)
>>  {
>> -    return use_icount;
>> +    return 0;
>>  }
> 
> That's weird; I mean that's just turning a subsection on and off;
> so you'd hope if this is a test that generates it's own snapshot and
> then uses it then it should be consistent.

Indeed.

> 
>>  static bool warp_timer_state_needed(void *opaque)
>> --------------------------------------------cut-------------------------------------------
>>
>> config.status configure line:
>> exec '/home/cfontana/qemu-build/../qemu/configure' '--enable-tcg' '--disable-kvm' '--disable-hax' '--target-list=s390x-softmmu' '--enable-debug'
>>
>> $ make check-block
>>
>> TEST    iotest-qcow2: 267 [fail]
>> QEMU          -- "/home/cfontana/qemu-build/tests/qemu-iotests/../../s390x-softmmu/qemu-system-s390x" -nodefaults -display none -accel qtest
>> QEMU_IMG      -- "/home/cfontana/qemu-build/tests/qemu-iotests/../../qemu-img" 
>> QEMU_IO       -- "/home/cfontana/qemu-build/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio threads -f qcow2
>> QEMU_NBD      -- "/home/cfontana/qemu-build/tests/qemu-iotests/../../qemu-nbd" 
>> IMGFMT        -- qcow2 (compat=1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/s390x s390zp13 5.3.18-21-default
>> TEST_DIR      -- /home/cfontana/qemu-build/tests/qemu-iotests/scratch
>> SOCK_DIR      -- /tmp/tmp.bLJcJVtzk5
>> SOCKET_SCM_HELPER -- /home/cfontana/qemu-build/tests/qemu-iotests/socket_scm_helper
>>
>> --- /home/cfontana/qemu/tests/qemu-iotests/267.out	2020-07-12 05:10:07.948262675 -0400
>> +++ /home/cfontana/qemu-build/tests/qemu-iotests/267.out.bad	2020-07-12 05:27:03.358362781 -0400
>> @@ -137,6 +137,9 @@
>>  ID        TAG                 VM SIZE                DATE       VM CLOCK
>>  --        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>>  (qemu) loadvm snap0
>> +Unexpected storage key flag data: 0
>> +error while loading state for instance 0x0 of device 's390-skeys'
>> +Error: Error -22 while loading VM state
>>  (qemu) quit
>>  
>>  
>> -----------
>>
>>
>> Not run: 172 186 192 259 287
>> Failures: 267
>> Failed 1 of 115 iotests
>> make: *** [/home/cfontana/qemu/tests/Makefile.include:880: check-tests/check-block.sh] Error 1
>>
>> -----------
>>
>> Note: only the === -blockdev with a backing file === part of test 267 fails. -blockdev with NBD is ok, like all the rest.
>>
>>
>> Interesting facts about s390 in particular: its save/load code includes the transfer of "storage keys",
>> which include a buffer of 32768 bytes of keydata in the stream.
>>
>> The code (hw/s390x/s390-skeys.c),
>> is modeled similarly to RAM transfer (like in migration/ram.c), with an EOS (end of stream) marker.
>>
>> Countrary to RAM transfer code though, after qemu_put_be64(f, EOS), the s390 code does not qemu_fflush(f).
>>
>> ----------
>> Observation: the migration/qemu-file.c shows an IO_BUF_SIZE of 32768.
>>
>> --
>>
>> The following workarounds hide the problem (make the test pass):
>>
>> 1) always including the icount field in the (unrelated) timers field that are sent before in the migration stream (ie not applying the reproducer patch).
>>
>> 2) increasing the IO_BUF_SIZE also hides the problem:
>>
>> ----------------------cut--------------------------
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index be21518c57..f81d1272eb 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -30,7 +30,7 @@
>>  #include "trace.h"
>>  #include "qapi/error.h"
>>  
>> -#define IO_BUF_SIZE 32768
>> +#define IO_BUF_SIZE 65536
>>  #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
>>  
>>  struct QEMUFile {
>> ----------------------cut--------------------------
>>
>> 3) adding a qemu_fflush in hw/s390x/s390-skeys.c after EOS also "fixes" the problem:
>>
>> ----------------------cut--------------------------
>> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
>> index 1e036cc602..47c9a015af 100644
>> --- a/hw/s390x/s390-skeys.c
>> +++ b/hw/s390x/s390-skeys.c
>> @@ -252,6 +252,8 @@ static const TypeInfo qemu_s390_skeys_info = {
>>      .class_size    = sizeof(S390SKeysClass),
>>  };
>>  
>> +extern void qemu_fflush(QEMUFile *f);
>> +
>>  static void s390_storage_keys_save(QEMUFile *f, void *opaque)
>>  {
>>      S390SKeysState *ss = S390_SKEYS(opaque);
>> @@ -302,6 +304,7 @@ static void s390_storage_keys_save(QEMUFile *f, void *opaque)
>>      g_free(buf);
>>  end_stream:
>>      qemu_put_be64(f, eos);
>> +    qemu_fflush(f);
>>  }
>>  
>>  static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
>> ----------------------cut--------------------------
>>
>> Do any of you with better understanding of migration/, block and s390 have a suggestion on what could be the issue here,
>> and what could be the next step in the investigation?
>>
>> Is the fact that migration/ram.c always does fflush after writing the EOS have any relevance here? why does it do it,
>> and should s390 code also follow the same pattern?
> 
> I didn't think it was required.
> And qemu_put_buffer loops if needed and calls qemu_fflush internally.

This detail probably does not help in this case, because the buffer itself is fine (32678 zero bytes is actually correct).

The End Of Stream marker written just after with qemu_put_be64 is not ok,
and anything past that point is just a whole bunch of zeroes in the stream when we hookup the calls to

qcow2_co_pwritev_task and qcow2_co_preadv_task

(see my response to Paolo in this thread).


> It's possible here that the storage key code is just the canary - the
> first thing that detects that the stream is invalid after it all goes
> wrong.

Seems the exact opposite to me, ie, the stream seems just fine up to the point where the EOS marker after the keydata in "s390-skeys" should be.

Thanks!

Claudio

> 
> Dave
> 
> 
>> Thanks,
>>
>> Claudio
>>
>>
>> -- 
>> Claudio Fontana
>> Engineering Manager Virtualization, SUSE Labs Core
>>
>> SUSE Software Solutions Italy Srl
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 


