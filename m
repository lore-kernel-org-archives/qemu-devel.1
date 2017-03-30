Received: from eggs.gnu.org ([2001:4830:134:3::10]:45386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1ctPPo-0008FJ-G9
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1ctPPn-00030S-Be
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:02:20 -0400
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:33612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1ctPPn-0002zy-7J
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:02:19 -0400
Received: by mail-vk0-x22f.google.com with SMTP id d188so38665634vka.0
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:02:18 -0700 (PDT)
MIME-Version: 1.0
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed, 29 Mar 2017 19:01:38 -0700
Message-ID: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] New iotest repros failures on virtio external snapshot
 with iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Parts of qemu's block code have changed a lot in recent months but are
not well exercised by current tests.

Subtle bugs have crept in causing assertion failures, hangs and other
crashes in a variety of situations: immediately on start, on first
guest activity, on external snapshot create or commit, on qmp quit
command.

Reproducing these bugs has proved tricky, as each may occur only with
a specific combination of qemu version, block device type (virtio-blk
or virtio-scsi) and iothread enabled or not. In some cases the bug
occurs only after several external snapshot operations. And in some
cases the bug only manifests when a guest is accessing the block
device simultaneously.

I've written an iotest (number 176, for now) that attempts to cover
many of these configurations. Currently it only exercises the external
snapshot create and commit lifted from iotest 118. The new iotest does
this repeatedly in each of 16 combinations:
- no guest / guest
- virtio-blk / virtio-scsi
- no iothread / iothread
- single / repeated external snapshot create+commit

I made some minor changes to the test infrastructure so the new iotest
can deal gracefully with qemu hanging--the test script itself
shouldn't hang. And in all failure modes the test needs to expose
enough console output and other information to diagnose the problem.

The main departure from existing iotests is running a real guest. I
used buildroot to generate a small (~4 MB) Linux kernel with built-in
initrd containing a busybox-based userland. After the iotest launches
qemu, the guest loops writing to the block device, while the test
performs snapshot operations.

I ran the new iotest on 3 qemu versions: 2.7.1, stable-2.8-staging and
2.9.0-rc2. The latter two fail several test cases, all
iothread-enabled. Only 2.7.1 passes all the cases.

Here is the code for the new iotest (I didn't dare email patches with
a 4 MB blob):
https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.7
https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.8
https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.9

And here is the buildroot I used to generate the guest Linux kernel+initrd:
https://github.com/skyportsystems/buildroot-1/commits/qemu-iotests

Please check out the code and try the new test--particularly anyone
who can also help figure out these failures. (Note that since half the
test cases use an iothread, /dev/kvm must be readable and writable.)

* stable-2.8-staging
- guest, virtio-blk, iothread, single snapshot create+commit: hang on
quit (intermittent)
- guest, virtio-blk, iothread, repeated snapshot create+commit: hang
after 1 iteration
- guest, virtio-scsi, iothread, single snapshot create+commit: hang on
quit (intermittent)
- guest, virtio-scsi, iothread, repeated snapshot create+commit: hang
after 1 iteration

* 2.9.0-rc2
- guest, virtio-blk, iothread, single snapshot create+commit:
"include/block/aio.h:457: aio_enable_external: Assertion
`ctx->external_disable_cnt > 0' failed." after snapshot create
- guest, virtio-blk, iothread, repeated snapshot create+commit: same as above
- guest, virtio-scsi, iothread, single snapshot create+commit: same as above
- guest, virtio-scsi, iothread, repeated snapshot create+commit: same as above
- no guest, virtio-blk, iothread, repeated snapshot create+commit: same as above
- no guest, virtio-scsi, iothread, single snapshot create+commit: same as above
- no guest, virtio-scsi, iothread, repeated snapshot create+commit:
same as above

--Ed
