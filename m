Received: from eggs.gnu.org ([2001:4830:134:3::10]:43318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMwAL-0004S7-Le
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMwAI-00063t-Iw
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:52:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dMwAI-00063F-9O
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:52:22 -0400
References: <20170615203735.19649-1-rth@twiddle.net>
	<7998cb6b-018e-8069-9d11-a3e1e4e70380@redhat.com>
	<429793f7-a3c1-91ec-9a83-908ee779e703@redhat.com>
	<9362010b-5c05-c29f-6e67-c182d2ae57ec@de.ibm.com>
	<e348f832-9a78-fffd-b425-426b5e66f8e6@redhat.com>
	<7b96196c-8bdf-c308-280c-97dda21062ed@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <304b2577-2d58-e61f-be67-6e55340c6ff4@redhat.com>
Date: Mon, 19 Jun 2017 14:52:18 +0200
MIME-Version: 1.0
In-Reply-To: <7b96196c-8bdf-c308-280c-97dda21062ed@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

On 19.06.2017 14:47, Christian Borntraeger wrote:
> On 06/19/2017 02:41 PM, David Hildenbrand wrote:
>> On 19.06.2017 14:33, Christian Borntraeger wrote:
>>> On 06/19/2017 02:05 PM, David Hildenbrand wrote:
>>>> On 19.06.2017 12:03, David Hildenbrand wrote:
>>>>> On 15.06.2017 22:37, Richard Henderson wrote:
>>>>>> There are no uses in a Linux system with which to test,
>>>>>> but it Looks Right by my reading of the PoO.
>>>>>
>>>>> I am using next.git/master with this patch applied:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=8aa8680aa383bf6e2ac
>>>>>
>>>>> I am using QEMU with the mvcos patch and your patch applied (and a patch
>>>>> that allows enabling csst/csst2).
>>>>>
>>>>> I am using the following qemu command line:
>>>>>
>>>>> #!/bin/bash
>>>>> /home/dhildenb/git/qemu/s390x-softmmu/qemu-system-s390x \
>>>>> 	-nographic -nodefaults -machine s390-ccw-virtio,accel=tcg \
>>>>> 	-cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
>>>>>           eimm=on,stckf=on,csst=on,csst2=on,ginste=on,exrl=on\
>>>>> 	-m 256M -smp 1 -chardev stdio,id=con0 \
>>>>> 	-device sclpconsole,chardev=con0 \
>>>>> 	-kernel vmlinux -initrd /home/dhildenb/initrd.debian
>>>>>
>>>>> Right now, I can start a z9 compiled kernel.
>>>>>
>>>>> When trying to start a z10 compiled kernel (which generates many csst),
>>>
>>>
>>> I would be very surprised if the kernel would contain any csst. gcc does not
>>> emit csst and the kernel source also does not contain it.
>>>
>>
>> I only did a grep on the objdump output:
>>
>> t460s: ~/git/linux-s390 next $ /usr/bin/s390x-linux-gnu-objdump -D
>> vmlinux | grep csst
>>   912826:       c8 e2 f1 7c 56 02       csst    380(%r15),1538(%r5),%r14
>>   954684:       c8 62 dc 35 2b 65       csst    3125(%r13),2917(%r2),%r6
>>   95e6e4:       c8 a2 1c 76 0a 60       csst    3190(%r1),2656,%r10
>>   95f68a:       c8 b2 c9 b3 3d 47       csst    2483(%r12),3399(%r3),%r11
>>   96067a:       c8 42 d3 59 da 50       csst    857(%r13),2640(%r13),%r4
>>   963642:       c8 72 73 c9 1a a0       csst    969(%r7),2720(%r1),%r7
>>   9656de:       c8 12 d3 09 7a a0       csst    777(%r13),2720(%r7),%r1
>>   9676a6:       c8 32 6d 97 84 7e       csst    3479(%r6),1150(%r8),%r3
>>   9d470a:       c8 a2 70 11 74 02       csst    17(%r7),1026(%r7),%r10
>>   9d6c4a:       c8 a2 de 0c 54 4a       csst    3596(%r13),1098(%r5),%r10
>>   9e3af8:       c8 a2 de 09 54 73       csst    3593(%r13),1139(%r5),%r10
>>   9e3b02:       c8 a2 de 0f 54 73       csst    3599(%r13),1139(%r5),%r10
>>   9e7992:       c8 a2 de 0c 54 d4       csst    3596(%r13),1236(%r5),%r10
>>   9e79ea:       c8 a2 40 f6 c3 0e       csst    246(%r4),782(%r12),%r10
>>   9e7e3c:       c8 a2 40 6c d1 74       csst    108(%r4),372(%r13),%r10
>>   9e8036:       c8 a2 de 0d 54 cd       csst    3597(%r13),1229(%r5),%r10
>>   9e81ea:       c8 a2 40 63 2f b8       csst    99(%r4),4024(%r2),%r10
>>   9e81fe:       c8 a2 de 0f 54 68       csst    3599(%r13),1128(%r5),%r10
>>   9e8e10:       c8 72 93 83 69 bd       csst    899(%r9),2493(%r6),%r7
>>   9e8ea4:       c8 72 c6 04 54 63       csst    1540(%r12),1123(%r5),%r7
>>   9e8eae:       c8 72 c6 f1 98 77       csst    1777(%r12),2167(%r9),%r7
>>   9e8ebc:       c8 72 93 ba f5 07       csst    954(%r9),1287(%r15),%r7
>>   a0702e:       c8 a2 14 74 6e 5f       csst    1140(%r1),3679(%r6),%r10
>>   a083ea:       c8 a2 73 08 74 da       csst    776(%r7),1242(%r7),%r10
>>   a0ec06:       c8 a2 f8 f6 c3 08       csst    2294(%r15),776(%r12),%r10
>>   a11890:       c8 a2 f8 fa 5f ac       csst    2298(%r15),4012(%r5),%r10
>>   a11b6e:       c8 a2 73 0a 74 74       csst    778(%r7),1140(%r7),%r10
>>   a11be0:       c8 a2 f8 fa 5f ac       csst    2298(%r15),4012(%r5),%r10
>>   a11ef4:       c8 a2 73 0b b3 7c       csst    779(%r7),892(%r11),%r10
>> [...]
>>  14c9e5a:       c8 02 d0 2d 00 0d       csst    45(%r13),13,%r0
>>
>>
>> That made me assume we have csst in the kernel :)
> 
> you used -D (which also disassembles data).  Do you still see any csst with -d ?
> 

... probably I should have lunch now :)

No csst, therefore the panic I am seeing is unrelated to this ...
(I wonder why CSST is a required kernel facility if nobody uses it? hm)

Thanks Christian!

-- 

Thanks,

David
