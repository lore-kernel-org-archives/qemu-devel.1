Received: from eggs.gnu.org ([209.51.188.92]:34709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gxCHH-0000C3-6d
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gxCF5-0007aC-JS
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gxCF5-00069v-9c
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:55:59 -0500
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QVxaW3tezjBN9owJHsxzE9h8_qcaeRr5zHHKxKJOeFnkQ@mail.gmail.com>
	<CAJSP0QVXoZJ9MJ0qp4RM_m2fGJ8iFSyJMAU_X7mdiQvpOK59KA@mail.gmail.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
	<VI1PR0602MB32457D7D0D6C05E83F14FE75A47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed1ffe8b-305b-9ae7-aa42-127f657622d7@redhat.com>
Date: Fri, 22 Feb 2019 15:55:16 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR0602MB32457D7D0D6C05E83F14FE75A47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Fernando_Casas_Sch=c3=b6ssow?= <casasfernando@outlook.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Natanael Copa <ncopa@alpinelinux.org>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

On 22/02/19 15:43, Fernando Casas Sch=C3=B6ssow wrote:
> Hi all,
>=20
> Indeed I can confirm this issue occurs with the stock, unmodified
> QEMU binary provided with Alpine since at least Alpine 3.6 up to
> 3.9.
>=20
> Is there any compiler flag I can tweak, add or remove to rebuild qemu
> and try to repro to confirm a possible workaround?

Nope, not yet.  However, I can try some experiments if you can provide
some information on how to rebuild an apk.

Paolo

> Thanks.
>=20
> Fernando
>=20
> Sent from my iPhone
>=20
>> On 22 Feb 2019, at 15:04, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Fri, Feb 22, 2019 at 12:57 PM Fernando Casas Sch=C3=B6ssow
>> <casasfernando@outlook.com> wrote:
>>
>> I have CCed Natanael Copa, qemu package maintainer in Alpine Linux.
>>
>> Fernando: Can you confirm that the bug occurs with an unmodified
>> Alpine Linux qemu binary?
>>
>> Richard: Commit 7db2145a6826b14efceb8dd64bfe6ad8647072eb ("bswap: Add
>> host endian unaligned access functions") introduced the unaligned
>> memory access functions in question here.  Please see below for
>> details on the bug - basically QEMU code assumes they are atomic, but
>> that is not guaranteed :(.  Any ideas for how to fix this?
>>
>> Natanael: It seems likely that the qemu package in Alpine Linux
>> suffers from a compilation issue resulting in a broken QEMU.  It may
>> be necessary to leave the compiler optimization flag alone in APKBUILD
>> to work around this problem.
>>
>> Here are the details.  QEMU relies on the compiler turning
>> memcpy(&dst, &src, 2) turning into a load instruction in
>> include/qemu/bswap.h:lduw_he_p() (explanation below):
>>
>> /* Any compiler worth its salt will turn these memcpy into native unal=
igned
>>   operations.  Thus we don't need to play games with packed attributes=
, or
>>   inline byte-by-byte stores.  */
>>
>> static inline int lduw_he_p(const void *ptr)
>> {
>>    uint16_t r;
>>    memcpy(&r, ptr, sizeof(r));
>>    return r;
>> }
>>
>> Here is the disassembly snippet of virtqueue_pop() from Fedora 29 that
>> shows the load instruction:
>>
>>  398166:       0f b7 42 02             movzwl 0x2(%rdx),%eax
>>  39816a:       66 89 43 32             mov    %ax,0x32(%rbx)
>>
>> Here is the instruction sequence in the Alpine Linux binary:
>>
>>  455562:    ba 02 00 00 00           mov    $0x2,%edx
>>  455567:    e8 74 24 f3 ff           callq  3879e0 <memcpy@plt>
>>  45556c:    0f b7 44 24 42           movzwl 0x42(%rsp),%eax
>>  455571:    66 41 89 47 32           mov    %ax,0x32(%r15)
>>
>> It's calling memcpy instead of using a load instruction.
>>
>> Fernando found that QEMU's virtqueue_pop() function sees bogus values
>> when loading a 16-bit guest RAM location.  Paolo figured out that the
>> bogus value can be produced by memcpy() when another thread is
>> updating the 16-bit memory location simultaneously.  This is a race
>> condition between one thread loading the 16-bit value and another
>> thread storing it (in this case a guest vcpu thread).  Sometimes
>> memcpy() may load one old byte and one new byte, resulting in a bogus
>> value.
>>
>> The symptom that Fernando experienced is a "Virtqueue size exceeded"
>> error message from QEMU and then the virtio-blk or virtio-scsi device
>> stops working.  This issue potentially affects other device emulation
>> code in QEMU as well, not just virtio devices.
>>
>> For the time being, I suggest tweaking the APKBUILD so the memcpy() is
>> not generated.  Hopefully QEMU can make the code more portable in the
>> future so the compiler always does the expected thing, but this may
>> not be easily possible.
>>
>> Stefan
