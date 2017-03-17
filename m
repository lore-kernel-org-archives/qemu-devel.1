Received: from eggs.gnu.org ([2001:4830:134:3::10]:49371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cowKp-0001Hr-V1
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cowKm-0001tO-PT
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:10:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cowKm-0001t8-JN
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:10:40 -0400
References: <CAO_EM_kn4QEw=+j23F7e+LzLW2_TPwNENoopqyBb-hdKYAow9w@mail.gmail.com>
	<f8f478b3-70a0-b67b-c4df-3f68ac66308a@redhat.com>
	<d54e7c6e-d261-dff0-9038-8f62283c91a4@redhat.com>
	<CAO_EM_=8-nnrz+BygPUnhkgrrRzYiPwE=ji7ncUXyHwZxVkAkw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8116d3a-295b-e75f-9f67-f544a3cbd08b@redhat.com>
Date: Fri, 17 Mar 2017 19:10:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAO_EM_=8-nnrz+BygPUnhkgrrRzYiPwE=ji7ncUXyHwZxVkAkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 17/03/2017 18:32, Ed Swierk wrote:
> On Fri, Mar 17, 2017 at 10:15 AM, Paolo Bonzini <pbonzini@redhat.com> w=
rote:
>>
>>
>> On 17/03/2017 18:11, Paolo Bonzini wrote:
>>>
>>>
>>> On 17/03/2017 17:55, Ed Swierk wrote:
>>>> I'm running into the same problem taking an external snapshot with a
>>>> virtio-blk drive with iothread, so it's not specific to virtio-scsi.
>>>> Run a Linux guest on qemu master
>>>>
>>>>   qemu-system-x86_64 -nographic -enable-kvm -monitor
>>>> telnet:0.0.0.0:1234,server,nowait -m 1024 -object
>>>> iothread,id=3Diothread1 -drive file=3D/x/drive.qcow2,if=3Dnone,id=3D=
drive0
>>>> -device virtio-blk-pci,iothread=3Diothread1,drive=3Ddrive0
>>>>
>>>> Then in the monitor
>>>>
>>>>   snapshot_blkdev drive0 /x/snap1.qcow2
>>>>
>>>> qemu bombs with
>>>>
>>>>   qemu-system-x86_64: /x/qemu/include/block/aio.h:457:
>>>> aio_enable_external: Assertion `ctx->external_disable_cnt > 0' faile=
d.
>>>>
>>>> whereas without the iothread the assertion failure does not occur.
>>>
>>> Please try this patch:
>>
>> Hmm, no.  I'll post the full fix on top of John Snow's patches.
>=20
> OK. Incidentally, testing with virtio-blk I bisected the assertion
> failure to b2c2832c6140cfe3ddc0de2d77eeb0b77dea8fd3 ("block: Add Error
> parameter to bdrv_append()").

And in particular to this:

+    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }

     change_parent_backing_link(bs_top, bs_new);
-    /* FIXME Error handling */
-    bdrv_set_backing_hd(bs_new, bs_top, &error_abort);


Paolo
