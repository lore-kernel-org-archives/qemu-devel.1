Received: from eggs.gnu.org ([2001:4830:134:3::10]:57013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ctjjd-00026l-3a
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ctjjb-0007BU-M1
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:44:09 -0400
References: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
	<67b441ce-ee18-c6d5-df5f-224439214ab8@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <17228443-4187-8922-05a9-12e771eaff03@redhat.com>
Date: Fri, 31 Mar 2017 01:43:53 +0200
MIME-Version: 1.0
In-Reply-To: <67b441ce-ee18-c6d5-df5f-224439214ab8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] New iotest repros failures on virtio external
 snapshot with iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 03/30/17 04:16, Eric Blake wrote:
> On 03/29/2017 09:01 PM, Ed Swierk via Qemu-devel wrote:
>> Parts of qemu's block code have changed a lot in recent months but are
>> not well exercised by current tests.
>>
>> Subtle bugs have crept in causing assertion failures, hangs and other
>> crashes in a variety of situations: immediately on start, on first
>> guest activity, on external snapshot create or commit, on qmp quit
>> command.
>>
>> Reproducing these bugs has proved tricky, as each may occur only with
>> a specific combination of qemu version, block device type (virtio-blk
>> or virtio-scsi) and iothread enabled or not. In some cases the bug
>> occurs only after several external snapshot operations. And in some
>> cases the bug only manifests when a guest is accessing the block
>> device simultaneously.
>>
>> I've written an iotest (number 176, for now) that attempts to cover
> 
> At least one other thread has already proposed a test 176.  It's
> somewhat straightforward to renumber things, but I'm wondering if there
> is some even-more-efficient way of reserving test numbers, perhaps
> through the wiki, since we are finding that test numbers get reserved
> several weeks before actually getting merged into the tree.

UEFI / edk2 solves this problem elegantly by naming everything with
globally unique identifiers, so if you need a new thing, just run
"uuidgen". No coordination required.

In practice it would result in subjects like

[Qemu-devel] [PATCH for-2.9] iotests: Fix test
3dec30b6-f69b-4eb0-8f89-87063433c830

I shall now retreat to my cave.

Laszlo
;)

> 
>> many of these configurations. Currently it only exercises the external
>> snapshot create and commit lifted from iotest 118. The new iotest does
>> this repeatedly in each of 16 combinations:
>> - no guest / guest
>> - virtio-blk / virtio-scsi
>> - no iothread / iothread
>> - single / repeated external snapshot create+commit
>>
>> I made some minor changes to the test infrastructure so the new iotest
>> can deal gracefully with qemu hanging--the test script itself
>> shouldn't hang. And in all failure modes the test needs to expose
>> enough console output and other information to diagnose the problem.
> 
> Some of those changes sound like they are worth posting to the list
> as-is, separate from the actual new test.
> 
>>
>> The main departure from existing iotests is running a real guest. I
>> used buildroot to generate a small (~4 MB) Linux kernel with built-in
>> initrd containing a busybox-based userland. After the iotest launches
>> qemu, the guest loops writing to the block device, while the test
>> performs snapshot operations.
>>
>> I ran the new iotest on 3 qemu versions: 2.7.1, stable-2.8-staging and
>> 2.9.0-rc2. The latter two fail several test cases, all
>> iothread-enabled. Only 2.7.1 passes all the cases.
>>
>> Here is the code for the new iotest (I didn't dare email patches with
>> a 4 MB blob):
>> https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.7
>> https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.8
>> https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.9
>>
>> And here is the buildroot I used to generate the guest Linux kernel+initrd:
>> https://github.com/skyportsystems/buildroot-1/commits/qemu-iotests
>>
>> Please check out the code and try the new test--particularly anyone
>> who can also help figure out these failures. (Note that since half the
>> test cases use an iothread, /dev/kvm must be readable and writable.)
>>
>> * stable-2.8-staging
>> - guest, virtio-blk, iothread, single snapshot create+commit: hang on
>> quit (intermittent)
>> - guest, virtio-blk, iothread, repeated snapshot create+commit: hang
>> after 1 iteration
>> - guest, virtio-scsi, iothread, single snapshot create+commit: hang on
>> quit (intermittent)
>> - guest, virtio-scsi, iothread, repeated snapshot create+commit: hang
>> after 1 iteration
>>
>> * 2.9.0-rc2
>> - guest, virtio-blk, iothread, single snapshot create+commit:
>> "include/block/aio.h:457: aio_enable_external: Assertion
>> `ctx->external_disable_cnt > 0' failed." after snapshot create
> 
> It would be nice if we could get to the root cause and squash that one
> before 2.9.
> 
>> - guest, virtio-blk, iothread, repeated snapshot create+commit: same as above
>> - guest, virtio-scsi, iothread, single snapshot create+commit: same as above
>> - guest, virtio-scsi, iothread, repeated snapshot create+commit: same as above
>> - no guest, virtio-blk, iothread, repeated snapshot create+commit: same as above
>> - no guest, virtio-scsi, iothread, single snapshot create+commit: same as above
>> - no guest, virtio-scsi, iothread, repeated snapshot create+commit:
>> same as above
>>
>> --Ed
>>
>>
> 
