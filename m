Received: from eggs.gnu.org ([2001:4830:134:3::10]:52128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ecEJ8-00046K-RU
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ecEJ3-0003up-NB
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:48:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ecEJ3-0003tQ-HQ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:48:53 -0500
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<86754966-281f-c3ed-938c-f009440de563@gmail.com>
	<CAPcyv4iH==cqVAdd8i1y-8A6SuXU75OH1EZzgNMvtA21wfxPpQ@mail.gmail.com>
	<ec5ff7c2-864e-5020-0aaa-6663e78e3756@gmail.com>
	<1511288389.1080.14.camel@redhat.com>
	<d1df875c-5b64-67d9-2b3c-4ec14c03b85b@gmail.com>
	<CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
	<654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
	<336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
	<f1ca60cc-5506-a161-b473-f0de363b7e95@redhat.com>
	<CAPcyv4j9b6ARvKcJkE25eNHatWACscMJTN_kCLSM6D+bfu_msA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <72839100-7fdf-693c-e9c2-348a5add8a56@redhat.com>
Date: Thu, 18 Jan 2018 18:48:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAPcyv4j9b6ARvKcJkE25eNHatWACscMJTN_kCLSM6D+bfu_msA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

>> I'd like to emphasize again, that I would prefer a virtio-pmem only
>> solution.
>>
>> There are architectures out there (e.g. s390x) that don't support
>> NVDIMMs - there is no HW interface to expose any such stuff.
>>
>> However, with virtio-pmem, we could make it work also on architectures
>> not having ACPI and friends.
>=20
> ACPI and virtio-only can share the same pmem driver. There are two
> parts to this, region discovery and setting up the pmem driver. For
> discovery you can either have an NFIT-bus defined range, or a new
> virtio-pmem-bus define it. As far as the pmem driver itself it's
> agnostic to how the range is discovered.
>=20

And in addition to discovery + setup, we need the flush via virtio.

> In other words, pmem consumes 'regions' from libnvdimm and the a bus
> provider like nfit, e820, or a new virtio-mechansim produce 'regions'.
>=20

That sounds good to me. I would like to see how the ACPI discovery
variant connects to a virtio ring.

The natural way for me would be:

A virtio-X device supplies a memory region ("discovery") and also the
interface for flushes for this device. So one virtio-X corresponds to
one pmem device. No ACPI to be involved (also not on architectures that
have ACPI)

--=20

Thanks,

David / dhildenb
