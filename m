Received: from eggs.gnu.org ([2001:4830:134:3::10]:49063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f43rg-0007kp-QR
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f43rd-0005F7-IM
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:19:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1f43rd-0005Et-C2
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:19:37 -0400
References: <20180405104834.10457-1-pagupta@redhat.com>
	<20180405104834.10457-4-pagupta@redhat.com>
	<ad08ca09-71ee-08d5-3479-8b3d06380a03@redhat.com>
	<416823501.16310251.1522930166070.JavaMail.zimbra@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <782ac7e2-b8d9-139d-6182-cb4e2d082458@redhat.com>
Date: Thu, 5 Apr 2018 14:19:25 +0200
MIME-Version: 1.0
In-Reply-To: <416823501.16310251.1522930166070.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, riel@surriel.com, niteshnarayanlal@hotmail.com, mst@redhat.com, ross zwisler <ross.zwisler@intel.com>, hch@infradead.org, stefanha@redhat.com, imammedo@redhat.com, marcel@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com


>>
>> So right now you're just using some memdev for testing.
>=20
> yes.
>=20
>>
>> I assume that the memory region we will provide to the guest will be a
>> simple memory mapped raw file. Dirty tracking (using the kvm slot) wil=
l
>> be used to detect which blocks actually changed and have to be flushed
>> to disk.
>=20
> Not really, we will perform fsync on raw file. As this file is created
> on regular storage and not nvdimm, so host page cache radix tree would =
have=20
> the dirty pages information which will be used for fsync.

Ah right. That makes things a lot easier!

>   =20
>>
>> Will this raw file already have the "disk information header" (no idea
>> how that stuff is called) encoded? Are there any plans/possible ways t=
o
>>
>> a) automatically create the headers? (if that's even possible)
>=20
> Its raw. Right now we are just supporting raw format. =20
>=20
> As this is direct mapping of memory into guest address space, I don't
> think we can have an abstraction of headers for block specific features=
.
> Or may be we can get opinion of others(Qemu block people) it is at all =
possible?
>=20
>> b) support anything but raw files?
>>
>> Please note that under x86, a KVM memory slot still has a (in my
>> opinion) fairly big overhead depending on the size of the slot (rmap,
>> page_track). We might have to optimize that.
>=20
> I have not tried/observed this. Right now I just used single memory slo=
t and cold add
> few MB's of memory in Qemu. Can you please provide more details on this=
?
>=20

You can have a look at kvm_arch_create_memslot() in arch/x86/kvm/x86.c.

"npages" is used to allocate certain arrays (rmap for shadow page
tables). Also kvm_page_track_create_memslot() allocates data for page_tra=
ck.

Having a big disk involves a lot of memory overhead due to the big kvm
memory slot. This is already the case for NVDIMMs as of now.

Other architectures (e.g. s390x) don't have this "problem". They don't
allocate any such data depending on the size of a memory slot.

This is certainly something to work on in the future.

--=20

Thanks,

David / dhildenb
