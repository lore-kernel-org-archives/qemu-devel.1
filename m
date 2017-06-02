Received: from eggs.gnu.org ([2001:4830:134:3::10]:49618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGor8-0002iI-0B
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGor7-0002pm-2j
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:51:18 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGor6-0002pT-T9
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:51:17 -0400
Received: by mail-wr0-x234.google.com with SMTP id v104so9112273wrb.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 08:51:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170602081120.3497-1-famz@redhat.com>
References: <20170602081120.3497-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 16:50:54 +0100
Message-ID: <CAFEAcA-PFs2hXqoGjqVpif2JQUqBcwdVj7U95=YDU0tCqGfuSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/22] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 2 June 2017 at 09:10, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 43771d5d92312504305c19abe29ec5bfabd55f01:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-05-31' into staging (2017-06-01 16:39:16 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/docker-and-block-pull-request
>
> for you to fetch changes up to 4ab2cbc128f1938355a12970c9b6e419a63fcab6:
>
>   block: make accounting thread-safe (2017-06-02 15:59:32 +0800)
>
> ----------------------------------------------------------------
>
> v2: Fix building on OSX and BSD.
>
> ----------------------------------------------------------------
>
> Fam Zheng (4):
>   docker: Run tests with current user
>   docker: Add bzip2 and hostname to fedora image
>   docker: Add libaio to fedora image
>   docker: Add flex and bison to centos6 image
>
> Paolo Bonzini (18):
>   block: access copy_on_read with atomic ops
>   block: access quiesce_counter with atomic ops
>   block: access io_limits_disabled with atomic ops
>   block: access serialising_in_flight with atomic ops
>   block: access wakeup with atomic ops
>   block: access io_plugged with atomic ops
>   throttle-groups: only start one coroutine from drained_begin
>   throttle-groups: do not use qemu_co_enter_next
>   throttle-groups: protect throttled requests with a CoMutex
>   util: add stats64 module
>   block: use Stat64 for wr_highest_offset
>   block: access write_gen with atomics
>   block: protect tracked_requests and flush_queue with reqs_lock
>   block: introduce dirty_bitmap_mutex
>   migration/block: reset dirty bitmap before reading
>   block: protect modification of dirty bitmaps with a mutex
>   block: introduce block_account_one_io
>   block: make accounting thread-safe

Fails 'make check' on OSX:
  GTESTER tests/test-blockjob
qemu: qemu_mutex_destroy: Invalid argument

Backtrace:

(lldb) bt
* thread #1: tid = 0x442e6f, 0x00007fffc611ad42
libsystem_kernel.dylib`__pthread_kill + 10, queue =
'com.apple.main-thread', stop reason = signal SIGABRT
  * frame #0: 0x00007fffc611ad42 libsystem_kernel.dylib`__pthread_kill + 10
    frame #1: 0x00007fffc6208457 libsystem_pthread.dylib`pthread_kill + 90
    frame #2: 0x00007fffc6080420 libsystem_c.dylib`abort + 129
    frame #3: 0x00000001000c1335
test-blockjob`error_exit(err=<unavailable>, msg=<unavailable>) + 53 at
qemu-thread-posix.c:36
    frame #4: 0x00000001000c135d
test-blockjob`qemu_mutex_destroy(mutex=<unavailable>) + 29 at
qemu-thread-posix.c:54
    frame #5: 0x000000010004411d test-blockjob`blk_unref [inlined]
blk_delete(blk=0x0000000100c0c360) + 215 at block-backend.c:298
    frame #6: 0x0000000100044046
test-blockjob`blk_unref(blk=0x0000000100c0c360) + 38 at
block-backend.c:336
    frame #7: 0x0000000100005ffa
test-blockjob`bdrv_open_inherit(filename=<unavailable>,
reference=<unavailable>, options=0x000000010100c000,
flags=<unavailable>, parent=<unavailable>, child_role=<unavailable>,
errp=<unavailable>) + 4346 at block.c:2546
    frame #8: 0x0000000100006a07
test-blockjob`bdrv_open(filename=<unavailable>,
reference=<unavailable>, options=<unavailable>, flags=<unavailable>,
errp=<unavailable>) + 23 at block.c:2632
    frame #9: 0x0000000100001949
test-blockjob`create_blk(name=0x0000000000000000) + 73 at
test-blockjob.c:61
    frame #10: 0x00000001000016f5 test-blockjob`test_job_ids + 21 at
test-blockjob.c:92
    frame #11: 0x000000010070d91d
libglib-2.0.0.dylib`g_test_run_suite_internal + 626
    frame #12: 0x000000010070dae1
libglib-2.0.0.dylib`g_test_run_suite_internal + 1078
    frame #13: 0x000000010070d198 libglib-2.0.0.dylib`g_test_run_suite + 266
    frame #14: 0x00000001000016c8
test-blockjob`main(argc=<unavailable>, argv=<unavailable>) + 88 at
test-blockjob.c:152
    frame #15: 0x00007fffc5fec235 libdyld.dylib`start + 1
    frame #16: 0x00007fffc5fec235 libdyld.dylib`start + 1


thanks
-- PMM
