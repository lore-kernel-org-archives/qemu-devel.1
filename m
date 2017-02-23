Received: from eggs.gnu.org ([2001:4830:134:3::10]:43381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgsuH-0006s4-Pz
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgsuE-000455-LX
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:54:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgsuE-00044v-Ck
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:53:58 -0500
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
	<CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
	<5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
	<CAFEAcA99xi4k57h2XGw2deGO24E95AS5jyGL+4GzjqNgMb9wcg@mail.gmail.com>
	<92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
	<CAFEAcA8769a_8xwk57FS6Ko+Lioud20+70JRSafeEic6GB_RAw@mail.gmail.com>
	<3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
	<CAFEAcA9gcArSqhbRi6-YdR=5eE9dtq66C7N0qTbCuBiY_Zr+tA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41630a89-e645-7d7e-b7c2-356fd6dcadee@redhat.com>
Date: Thu, 23 Feb 2017 13:53:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9gcArSqhbRi6-YdR=5eE9dtq66C7N0qTbCuBiY_Zr+tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>



On 23/02/2017 13:26, Peter Maydell wrote:
> On 23 February 2017 at 11:43, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>> On 23/02/2017 12:34, Peter Maydell wrote:
>>> We should probably update the doc comment to note that the
>>> pointer is to host-endianness memory (and that this is not
>>> like normal RAM which is target-endian)...
>>
>> I wouldn't call it host-endianness memory, and I disagree that normal
>> RAM is target-endian---in both cases it's just a bunch of bytes.
>>
>> However, the access done by the MemoryRegionOps callbacks needs to mat=
ch
>> the endianness declared by the MemoryRegionOps themselves.
>=20
> Well, if the guest stores a bunch of integers to the memory, which
> way round do you see them when you look at the bunch of bytes?

You see them in whatever endianness the guest used.  So let's say a
little-endian guest is writing 0x12345678 to a register.  With
DEVICE_HOST_ENDIAN, some examples are:

- little-endian host, little-endian device.  The guest will write
0x12345678, QEMU will write 0x12345678 which becomes 0x78 0x56 0x34
0x12.  The little-endian device is happy because it sees it as 0x12345678=
.

- little-endian host, big-endian device.  The guest will write
0x78563412 to account for the different endianness of the host.  QEMU
will also write 0x78563412 which becomes 0x12 0x34 0x56 0x78.  The
big-endian device is happy because it sees it as 0x12345678.

- big-endian host, little-endian device.  The guest will write
0x12345678, memory.c will flip it and QEMU will write 0x78563412.  In
bytes this becomes 0x78 0x56 0x34 0x12.  The little-endian device is
happy because it sees it as 0x12345678.

- big-endian host, big-endian device.  The guest will write 0x78563412
to account for the different endianness of the host.  Memory.c will flip
it and QEMU will write 0x12345678, which becomes 0x12 0x34 0x56 0x78.
The big-endian device is happy because it sees it as 0x12345678.

With DEVICE_LITTLE_ENDIAN you add two flips on big-endian hosts; with
DEVICE_BIG_ENDIAN you add two flips on little-endian hosts.

Paolo

> The answer is different for the two things, so something is different
> about their endianness...
