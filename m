Received: from eggs.gnu.org ([2001:4830:134:3::10]:41392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esqA3-0006g0-WE
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esqA2-0007By-S8
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:28:15 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:33229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esqA2-0007BV-N6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:28:14 -0500
Received: by mail-oi0-x236.google.com with SMTP id e9so5357335oii.0
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 05:28:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 13:27:53 +0000
Message-ID: <CAFEAcA9xKJxWrdkU7cTW7YgJSMG3f5ZfqD5vP8wtFUYEX5SRQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/37] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2018 at 18:54, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 86f4c7e05b1c44dbe1b329a51f311f10aef6ff34:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180302' into staging (2018-03-02 14:37:10 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 9d9b4b640f9e583ff4b24dc762630945f3ccc16d:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2018-03-02' into queue-block (2018-03-02 18:45:03 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>

This gives me a clang sanitizer error while running 'make check':

e104462:xenial:clang$ UBSAN_OPTIONS=print_stacktrace=1
QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
QTEST_QEMU_IMG=qemu-img tests/ide-test
/i386/ide/identify: OK
/i386/ide/flush: OK
/i386/ide/bmdma/setup: OK
/i386/ide/bmdma/simple_rw: OK
/i386/ide/bmdma/trim: OK
/i386/ide/bmdma/short_prdt: OK
/i386/ide/bmdma/one_sector_short_prdt: OK
/i386/ide/bmdma/long_prdt: OK
/i386/ide/bmdma/no_busmaster: OK
/i386/ide/bmdma/teardown: OK
/i386/ide/flush/nodev: OK
/i386/ide/flush/empty_drive:
/home/petmay01/linaro/qemu-for-merges/block.c:3926:16: runtime error:
member access within null pointer of type 'const BlockDriverState'
(aka 'const struct BlockDriverState')
    #0 0x5560b5776f48 in bdrv_get_node_name
/home/petmay01/linaro/qemu-for-merges/block.c:3926:16
    #1 0x5560b587fc92 in send_qmp_error_event
/home/petmay01/linaro/qemu-for-merges/block/block-backend.c:1621:36
    #2 0x5560b587fc92 in blk_error_action
/home/petmay01/linaro/qemu-for-merges/block/block-backend.c:1655
    #3 0x5560b52619e6 in ide_handle_rw_error
/home/petmay01/linaro/qemu-for-merges/hw/ide/core.c:836:5
    #4 0x5560b5278d7b in ide_flush_cb
/home/petmay01/linaro/qemu-for-merges/hw/ide/core.c:1067:13
    #5 0x5560b58822ac in blk_aio_complete
/home/petmay01/linaro/qemu-for-merges/block/block-backend.c:1286:9
    #6 0x5560b5a04417 in aio_bh_poll
/home/petmay01/linaro/qemu-for-merges/util/async.c:118:13
    #7 0x5560b5a10cef in aio_dispatch
/home/petmay01/linaro/qemu-for-merges/util/aio-posix.c:436:5
    #8 0x5560b5a062fa in aio_ctx_dispatch
/home/petmay01/linaro/qemu-for-merges/util/async.c:261:5
    #9 0x7f9786667196 in g_main_context_dispatch
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4a196)
    #10 0x5560b5a0dd08 in glib_pollfds_poll
/home/petmay01/linaro/qemu-for-merges/util/main-loop.c:214:9
    #11 0x5560b5a0dd08 in os_host_main_loop_wait
/home/petmay01/linaro/qemu-for-merges/util/main-loop.c:261
    #12 0x5560b5a0dd08 in main_loop_wait
/home/petmay01/linaro/qemu-for-merges/util/main-loop.c:515
    #13 0x5560b4fdebf2 in main_loop
/home/petmay01/linaro/qemu-for-merges/vl.c:1942:9
    #14 0x5560b4fdebf2 in main /home/petmay01/linaro/qemu-for-merges/vl.c:4772
    #15 0x7f97843ec82f in __libc_start_main
/build/glibc-Cl5G7W/glibc-2.23/csu/../csu/libc-start.c:291
    #16 0x5560b4b456c8 in _start
(/home/petmay01/linaro/qemu-for-merges/build/clang/i386-softmmu/qemu-system-i386+0xe5c6c8)

OK
/i386/ide/flush/retry_pci: OK
/i386/ide/flush/retry_isa: OK
/i386/ide/cdrom/pio: OK
/i386/ide/cdrom/pio_large: OK
/i386/ide/cdrom/dma: OK


thanks
-- PMM
