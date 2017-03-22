Received: from eggs.gnu.org ([2001:4830:134:3::10]:48953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cqkBg-0001lY-Md
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cqkBf-0005kb-MA
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:36:44 -0400
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:33385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cqkBf-0005kD-H4
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:36:43 -0400
Received: by mail-vk0-x22a.google.com with SMTP id d188so131059905vka.0
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 10:36:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170322091000.GA25375@lemon.lan>
References: <CAO_EM_kn4QEw=+j23F7e+LzLW2_TPwNENoopqyBb-hdKYAow9w@mail.gmail.com>
	<20170321052602.GA2785@lemon>
	<CAO_EM_=RbB7FopO9z6NOGhFgLSd-hWz-oNf406fCB=sqOgP=-w@mail.gmail.com>
	<20170321125025.GA19060@lemon.lan>
	<CAO_EM_kLdLfQQjEZ4pzptStGearFNzV0gSYkER4PwKAdge=oCA@mail.gmail.com>
	<20170322091000.GA25375@lemon.lan>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed, 22 Mar 2017 10:36:02 -0700
Message-ID: <CAO_EM_mzAVYmNkELXMeAqy3BjGzej5a6K4mo8G5WYVqhTKWSTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Assertion failure taking external snapshot with
 virtio drive + iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 22, 2017 at 2:19 AM, Fam Zheng <famz@redhat.com> wrote:
> On Tue, 03/21 06:05, Ed Swierk wrote:
>> Actually running snapshot_blkdev command in the text monitor doesn't
>> trigger this assertion (I mixed up my notes). Instead it's triggered
>> by the following sequence in qmp-shell:
>>
>> (QEMU) blockdev-snapshot-sync device=drive0 format=qcow2
>> snapshot-file=/x/snap1.qcow2
>> {"return": {}}
>> (QEMU) block-commit device=drive0
>> {"return": {}}
>> (QEMU) block-job-complete device=drive0
>> {"return": {}}
>>
>> > Is there a backtrace?
>>
>> #0  0x00007ffff3757067 in raise () from /lib/x86_64-linux-gnu/libc.so.6
>> #1  0x00007ffff3758448 in abort () from /lib/x86_64-linux-gnu/libc.so.6
>> #2  0x00007ffff3750266 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>> #3  0x00007ffff3750312 in __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
>> #4  0x0000555555b4b0bb in bdrv_drain_recurse
>> (bs=bs@entry=0x555557bd6010)  at /x/qemu/block/io.c:164
>> #5  0x0000555555b4b7ad in bdrv_drained_begin (bs=0x555557bd6010)  at
>> /x/qemu/block/io.c:231
>> #6  0x0000555555b4b802 in bdrv_parent_drained_begin
>> (bs=0x5555568c1a00)  at /x/qemu/block/io.c:53
>> #7  bdrv_drained_begin (bs=bs@entry=0x5555568c1a00)  at /x/qemu/block/io.c:228
>> #8  0x0000555555b4be1e in bdrv_co_drain_bh_cb (opaque=0x7fff9aaece40)
>> at /x/qemu/block/io.c:190
>> #9  0x0000555555bb431e in aio_bh_call (bh=0x55555750e5f0)  at
>> /x/qemu/util/async.c:90
>> #10 aio_bh_poll (ctx=ctx@entry=0x555556718090)  at /x/qemu/util/async.c:118
>> #11 0x0000555555bb72eb in aio_poll (ctx=0x555556718090,
>> blocking=blocking@entry=true)  at /x/qemu/util/aio-posix.c:682
>> #12 0x00005555559443ce in iothread_run (opaque=0x555556717b80)  at
>> /x/qemu/iothread.c:59
>> #13 0x00007ffff3ad50a4 in start_thread () from
>> /lib/x86_64-linux-gnu/libpthread.so.0
>> #14 0x00007ffff380a87d in clone () from /lib/x86_64-linux-gnu/libc.so.6
>
> Hmm, looks like a separate bug to me. In addition please apply this (the
> assertion here is correct I think, but all callers are not audited yet):
>
> diff --git a/block.c b/block.c
> index 6e906ec..447d908 100644
> --- a/block.c
> +++ b/block.c
> @@ -1737,6 +1737,9 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
>  {
>      BlockDriverState *old_bs = child->bs;
>
> +    if (old_bs && new_bs) {
> +        assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
> +    }
>      if (old_bs) {
>          if (old_bs->quiesce_counter && child->role->drained_end) {
>              child->role->drained_end(child);
> diff --git a/block/mirror.c b/block/mirror.c
> index ca4baa5..a23ca9e 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1147,6 +1147,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
>          return;
>      }
>      mirror_top_bs->total_sectors = bs->total_sectors;
> +    bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
>
>      /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
>       * it alive until block_job_create() even if bs has no parent. */

With this patch, I'm seeing either assertions or hangs when I run
blockdev-snapshot-sync, block-commit and block-job-complete
repeatedly. The exact assertion seems to depend on timing and/or what
combination of your other patches I apply. They include:

/x/qemu/hw/virtio/virtio.c:212: vring_get_region_caches: Assertion
`caches != ((void *)0)' failed.

/x/qemu/block/mirror.c:350: mirror_iteration: Assertion `sector_num >=
0' failed.

/x/qemu/block/mirror.c:865: mirror_run: Assertion
`((&bs->tracked_requests)->lh_first == ((void *)0))' failed.

We don't appear to be converging on a solution here. Perhaps I should
instead focus on implementing automated tests so that you or anyone
else can easily reproduce these problems. The only tricky part is
extending qemu-iotests to include booting a guest to generate block IO
and trigger race conditions, but I have some ideas about how to do
this with a minimal (< 5 MB) Linux kernel+rootfs.

--Ed
