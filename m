Received: from eggs.gnu.org ([2001:4830:134:3::10]:37787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgqMC-0005BI-UX
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgqM7-0003Sw-V5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:10:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgqM7-0003Sd-LA
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:10:35 -0500
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
	<CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
Date: Thu, 23 Feb 2017 11:10:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
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



On 23/02/2017 11:02, Peter Maydell wrote:
> On 23 February 2017 at 08:35, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>>
>>
>> On 23/02/2017 05:20, Alexey Kardashevskiy wrote:
>>> First, Paolo is right and ram_device_mem_ops::endianness should be
>>> host-endian which happens to be little in our test case (ppc64le)
>>
>> So you tested a ppc64 BE guest and it works?
>>
>>> Keep things where they are in the VFIO department and just fix
>>> ram_device_mem_ops::endianness?
>>
>> I would fix the ram_device_mem_ops.  Either by introducing
>> DEVICE_HOST_ENDIAN(*) or with Yongji's patch.
>>
>> (*) DEVICE_NATIVE_ENDIAN is special cased all over the place
>>     because the same device (in a file that's compiled just once)
>>     can be either little- or big-endian.  DEVICE_HOST_ENDIAN can
>>     be a simple #define to either DEVICE_LITTLE_ENDIAN or
>>     DEVICE_BIG_ENDIAN, because host endianness is the same for
>>     all QEMU binaries.  It's literally half a dozen lines of code.
>=20
> I'm really not convinced we need DEVICE_HOST_ENDIAN. RAM
> areas should be target-endian (you can probably define
> "target endianness" as "the endianness that RAM areas have".)

This is not RAM.  This is MMIO, backed by a MMIO area in the host.  The
MemoryRegionOps read from the MMIO area (so the data has host
endianness) and do not do any further swap:

        data =3D *(uint16_t *)(mr->ram_block->host + addr);

Here, the dereference is basically the same as ldl_he_p.

If you wanted to make the MemoryRegion use DEVICE_NATIVE_ENDIAN, you'd
need to tswap around the access.  Or you can use ldl_le_p and
DEVICE_LITTLE_ENDIAN (this is what Yongji's patch open codes), or
ldl_be_p and DEVICE_BIG_ENDIAN.  They are all the same in the end.

Paolo
