Received: from eggs.gnu.org ([2001:4830:134:3::10]:35560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKU31-0003dt-Rf
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKU30-00068K-TW
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:26:43 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKU30-000687-LF
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:26:42 -0400
Received: by mail-wr0-x230.google.com with SMTP id g76so105602858wrd.1
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 11:26:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170608115643.18859-1-famz@redhat.com>
References: <20170608115643.18859-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 19:26:19 +0100
Message-ID: <CAFEAcA-myF7ZP19hcfJpJ2j8BBkvFyJofecp7v39FJJ10DO10w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/23] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 June 2017 at 12:56, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 64175afc695c0672876fbbfc31b299c86d562cb4:
>
>   arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06-07 17:21:44 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/docker-and-block-pull-request
>
> for you to fetch changes up to 383226d7f90e83fd2b4ea5fbedf67bd9d3173221:
>
>   block: make accounting thread-safe (2017-06-08 19:09:23 +0800)
>
> ----------------------------------------------------------------
>
> v3: Update Paolo's series to fix make check on OSX.
>
> ----------------------------------------------------------------

This still fails on OSX:

  GTESTER tests/test-blockjob
qemu: qemu_mutex_lock: Invalid argument

The backtrace is different from last time:

* thread #1: tid = 0x7f066a, 0x00007fffc611ad42
libsystem_kernel.dylib`__pthread_kill + 10, queue =
'com.apple.main-thread', stop reason = signal SIGABRT
  * frame #0: 0x00007fffc611ad42 libsystem_kernel.dylib`__pthread_kill + 10
    frame #1: 0x00007fffc6208457 libsystem_pthread.dylib`pthread_kill + 90
    frame #2: 0x00007fffc6080420 libsystem_c.dylib`abort + 129
    frame #3: 0x00000001000c1265
test-blockjob`error_exit(err=<unavailable>, msg=<unavailable>) + 53 at
qemu-thread-posix.c:36
    frame #4: 0x00000001000c1327
test-blockjob`qemu_mutex_lock(mutex=<unavailable>) + 151 at
qemu-thread-posix.c:63
    frame #5: 0x000000010005eef7
test-blockjob`bdrv_do_release_matching_dirty_bitmap [inlined]
bdrv_dirty_bitmaps_lock(bs=0x0000000101806000) + 39 at
dirty-bitmap.c:58
    frame #6: 0x000000010005eee7
test-blockjob`bdrv_do_release_matching_dirty_bitmap(bs=0x0000000101806000,
bitmap=0x0000000000000000, only_named=true) + 23 at dirty-bitmap.c:349
    frame #7: 0x000000010000962d test-blockjob`bdrv_delete [inlined]
bdrv_close(bs=0x0000000101806000) + 32 at block.c:3042
    frame #8: 0x000000010000960d
test-blockjob`bdrv_delete(bs=0x0000000101806000) + 61 at block.c:3229
    frame #9: 0x0000000100043da2
test-blockjob`blk_remove_bs(blk=0x0000000100d0a7d0) + 98 at
block-backend.c:607
    frame #10: 0x0000000100001318 test-blockjob`test_job_ids [inlined]
destroy_blk(blk=0x0000000100d0a7d0) + 29 at test-blockjob.c:83
    frame #11: 0x00000001000012fb test-blockjob`test_job_ids + 411 at
test-blockjob.c:140
    frame #12: 0x000000010070d91d
libglib-2.0.0.dylib`g_test_run_suite_internal + 626
    frame #13: 0x000000010070dae1
libglib-2.0.0.dylib`g_test_run_suite_internal + 1078
    frame #14: 0x000000010070d198 libglib-2.0.0.dylib`g_test_run_suite + 266
    frame #15: 0x0000000100001148
test-blockjob`main(argc=<unavailable>, argv=<unavailable>) + 88 at
test-blockjob.c:152
    frame #16: 0x00007fffc5fec235 libdyld.dylib`start + 1
    frame #17: 0x00007fffc5fec235 libdyld.dylib`start + 1

thanks
-- PMM
