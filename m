Received: from eggs.gnu.org ([2001:4830:134:3::10]:41863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvPDR-0004Av-Sj
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvPDO-0005F9-N6
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:13:49 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvPDO-0005Ed-D7
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:13:46 -0400
Received: by mail-wm0-x230.google.com with SMTP id y22so26790084wmh.0
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 07:13:46 -0700 (PDT)
References: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
	<20170403165755.GF3539@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170403165755.GF3539@stefanha-x1.localdomain>
Date: Tue, 04 Apr 2017 15:13:44 +0100
Message-ID: <87zifw9s6f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] New iotest repros failures on virtio
 external snapshot with iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Wed, Mar 29, 2017 at 07:01:38PM -0700, Ed Swierk wrote:
>> Parts of qemu's block code have changed a lot in recent months but are
>> not well exercised by current tests.
<snip>
>
> 4. How to automate tests with real Linux guests?  This is a complex
> topic and probably what we should discuss in this email thread.
>
> The buildroot + busybox approach is good for a small set of sanity
> tests.  There was a similar attempt here:
> https://github.com/stsquad/qemu-jeos
>
> Building from source becomes a challenge when other people want to add
> software to test other areas of QEMU.  The process also requires
> attention to maintain the image over time (e.g. as host build
> environments change).
>
> There are image builder tools like virt-builder and mkosi for building
> bootable virtual machine images based on standard Linux distros:
> http://libguestfs.org/virt-builder.1.html
> https://github.com/systemd/mkosi
>
> This eliminates the build-from-source hassles and gives us a full Linux
> guest environment.  Booting is very fast with mkosi so the advantage to
> custom building a minimal image is negligible.

Does it entirely? If your building a ARM guest on x86 how do you ensure
the cross-compilers are correct for the kernel and userspace?

> My suggestion is:
>
> Let's pick an image builder tool like virt-builder and keep a single
> build script per guest architecture (e.g.  build-test-os-x86_64.sh).
> All tests for that architecture run against the same disk image.
>
> It's easy to add additional software to the disk image by modifying the
> build script.
>
> A Makefile ensures that the image file gets rebuilt if the build script
> has changed.

I have experimented building LTP for foreign guests inside docker
images. I expect the docker build image could be extended to build full
kernel and file-systems in a known environment, possibly using
virt-builder to do it.

>
>>
>> I made some minor changes to the test infrastructure so the new iotest
>> can deal gracefully with qemu hanging--the test script itself
>> shouldn't hang. And in all failure modes the test needs to expose
>> enough console output and other information to diagnose the problem.
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


--
Alex Bennée
