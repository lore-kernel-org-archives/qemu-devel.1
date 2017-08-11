Received: from eggs.gnu.org ([2001:4830:134:3::10]:35021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dg7Yz-0008Oj-92
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dg7Yv-0008Db-9E
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:53:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dg7Yu-0008Ch-Vv
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:53:05 -0400
References: <1502431076-22849-1-git-send-email-thuth@redhat.com>
	<20170811114922.2edda3a7.cohuck@redhat.com>
	<20170811121905.22bdc575.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8783416d-367e-3a7c-76b5-eb979b0c8625@redhat.com>
Date: Fri, 11 Aug 2017 12:52:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170811121905.22bdc575.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 0/2] Improvements for the pxe
 tester
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

On 11.08.2017 12:19, Cornelia Huck wrote:
> On Fri, 11 Aug 2017 11:49:22 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Fri, 11 Aug 2017 07:57:54 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> The first patch improves the buffer handling in the pxe tester a
>>> little bit by allocating a separate buffer on the heap for each
>>> architecture. This also gets rid of the huge pre-initialized
>>> array in the tester, shrinking the size of the executable by
>>> half of a megabyte!
>>> The second patch adds s390x support to the pxe tester. Starting
>>> with QEMU 2.10, the guest firmware on s390x can now net-boot via
>>> TFTP, too, so we can automatically test this code in the pxe tester.
>>>
>>> v2: Adressed Cornelia's review feedback from the first version, e.g.:
>>>  - Use g_malloc0() instead of g_malloc()
>>>  - Use sizeof with parentheses
>>>
>>> Thomas Huth (2):
>>>   tests/boot-sector: Do not overwrite the x86 buffer on other
>>>     architectures
>>>   tests/pxe: Check virtio-net-ccw on s390x
>>>
>>>  tests/Makefile.include |  1 +
>>>  tests/boot-sector.c    | 61 +++++++++++++++++++++++++++++++++++++-------------
>>>  tests/pxe-test.c       |  7 ++++++
>>>  3 files changed, 54 insertions(+), 15 deletions(-)
>>>   
>>
>> Haven't reviewed the updates yet, but tried it out (on my laptop and on
>> a z/VM guest). Laptop went fine; on the z/VM guest, I forgot to turn on
>> vm.allocate_pgste at first:
>>
>> TEST: tests/pxe-test... (pid=56084)
>>   /s390x/pxe/virtio-ccw:                                               ioctl(KVM_CREATE_VM) failed: 22 Invalid argument
>> Host kernel setup problem detected. Please verify:
>> - for kernels supporting the switch_amode or user_mode parameters, whether
>>   user space is running in primary address space
>> - for kernels supporting the vm.allocate_pgste sysctl, whether it is enabled
>> qemu-system-s390x: failed to initialize KVM: Invalid argument
>> qemu-system-s390x: Back to tcg accelerator
>> OK
>> PASS: tests/pxe-test
>>
>> It does the correct fallback (the need for allocate_pgste will go away
>> with future kernels), so this is fine. However, it prompted me to test
>> with --disable-tcg:
>>
>> TEST: tests/boot-serial-test... (pid=60499)
>>   /s390x/boot-serial/s390-ccw-virtio:                                  qemu-system-s390x: -machine accel=tcg: No accelerator found
>> socket_accept failed: Resource temporarily unavailable
>> **
>> ERROR:/root/git/qemu/tests/libqtest.c:212:qtest_init_without_qmp_handshake: assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
>> FAIL
>> GTester: last random seed: R02S83c8a1860bbd8c2658647407c7070b7e
>> (pid=60503)
>> FAIL: tests/boot-serial-test
>>
>> There are probably more tests that rely on tcg always being available,
>> which is no longer true. (Also, the boot-serial test should probably
>> check if qemu even started rather than run into in a timeout.)
>>
>> [Your patches are fine, but I think we really need to consider tests
>> and accelerators.]
> 
> A quick test on x86_64 with --disable-tcg showed no further problems
> than boot-serial-test, so at least it's only the one for now (and it
> might make sense to simply use accel=tcg:kvm for it).

$ grep -rl accel=tcg tests/
tests/pnv-xscom-test.c
tests/boot-serial-test.c
tests/prom-env-test.c

... so the other problematic tests are for ppc only - which does not
support --disable-tcg yet.

 Thomas
