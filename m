Received: from eggs.gnu.org ([2001:4830:134:3::10]:39897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1covkn-0007cU-Le
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1covkm-0005Mr-JW
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:33:29 -0400
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:35004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1covkm-0005MZ-Dg
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:33:28 -0400
Received: by mail-vk0-x234.google.com with SMTP id x75so44628041vke.2
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 10:33:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d54e7c6e-d261-dff0-9038-8f62283c91a4@redhat.com>
References: <CAO_EM_kn4QEw=+j23F7e+LzLW2_TPwNENoopqyBb-hdKYAow9w@mail.gmail.com>
	<f8f478b3-70a0-b67b-c4df-3f68ac66308a@redhat.com>
	<d54e7c6e-d261-dff0-9038-8f62283c91a4@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Fri, 17 Mar 2017 10:32:47 -0700
Message-ID: <CAO_EM_=8-nnrz+BygPUnhkgrrRzYiPwE=ji7ncUXyHwZxVkAkw@mail.gmail.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Fri, Mar 17, 2017 at 10:15 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 17/03/2017 18:11, Paolo Bonzini wrote:
>>
>>
>> On 17/03/2017 17:55, Ed Swierk wrote:
>>> I'm running into the same problem taking an external snapshot with a
>>> virtio-blk drive with iothread, so it's not specific to virtio-scsi.
>>> Run a Linux guest on qemu master
>>>
>>>   qemu-system-x86_64 -nographic -enable-kvm -monitor
>>> telnet:0.0.0.0:1234,server,nowait -m 1024 -object
>>> iothread,id=iothread1 -drive file=/x/drive.qcow2,if=none,id=drive0
>>> -device virtio-blk-pci,iothread=iothread1,drive=drive0
>>>
>>> Then in the monitor
>>>
>>>   snapshot_blkdev drive0 /x/snap1.qcow2
>>>
>>> qemu bombs with
>>>
>>>   qemu-system-x86_64: /x/qemu/include/block/aio.h:457:
>>> aio_enable_external: Assertion `ctx->external_disable_cnt > 0' failed.
>>>
>>> whereas without the iothread the assertion failure does not occur.
>>
>> Please try this patch:
>
> Hmm, no.  I'll post the full fix on top of John Snow's patches.

OK. Incidentally, testing with virtio-blk I bisected the assertion
failure to b2c2832c6140cfe3ddc0de2d77eeb0b77dea8fd3 ("block: Add Error
parameter to bdrv_append()").

--Ed
