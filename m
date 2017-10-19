Received: from eggs.gnu.org ([2001:4830:134:3::10]:41966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e5FRl-0005dV-Cd
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e5FRk-0003rV-Ey
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:21:33 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:54945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1e5FRk-0003oo-9T
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:21:32 -0400
Received: by mail-oi0-x243.google.com with SMTP id a132so16360661oih.11
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 11:21:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019080149.GB10089@infradead.org>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171017071633.GA9207@infradead.org>
	<1441791227.21027037.1508226056893.JavaMail.zimbra@redhat.com>
	<20171017080236.GA27649@infradead.org>
	<670833322.21037148.1508229041158.JavaMail.zimbra@redhat.com>
	<20171018130339.GB29767@stefanha-x1.localdomain>
	<CAPcyv4h6aFkyHhh4R4DTznbSCLf9CuBoszk0Q1gB5EKNcp_SeQ@mail.gmail.com>
	<20171019080149.GB10089@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 19 Oct 2017 11:21:26 -0700
Message-ID: <CAPcyv4j=Cdp68C15HddKaErpve2UGRfSTiL6bHiS=3gQybz9pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 2/2] KVM: add virtio-pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@infradead.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Kevin Wolf <kwolf@redhat.com>, haozhong zhang <haozhong.zhang@intel.com>, Jan Kara <jack@suse.cz>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, Linux MM <linux-mm@kvack.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>

On Thu, Oct 19, 2017 at 1:01 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Oct 18, 2017 at 08:51:37AM -0700, Dan Williams wrote:
>> This use case is not "Persistent Memory". Persistent Memory is
>> something you can map and make persistent with CPU instructions.
>> Anything that requires a driver call is device driver managed "Shared
>> Memory".
>
> How is this any different than the existing nvdimm_flush()? If you
> really care about the not driver thing it could easily be a write
> to a doorbell page or a hypercall, but in the end that's just semantics.

The difference is that nvdimm_flush() is not mandatory, and that the
platform will automatically perform the same flush at power-fail.
Applications should be able to assume that if they are using MAP_SYNC
that no other coordination with the kernel or the hypervisor is
necessary.

Advertising this as a generic Persistent Memory range to the guest
means that the guest could theoretically use it with device-dax where
there is no driver or filesystem sync interface. The hypervisor will
be waiting for flush notifications and the guest will just issue cache
flushes and sfence instructions. So, as far as I can see we need to
differentiate this virtio-model from standard "Persistent Memory" to
the guest and remove the possibility of guests/applications making the
wrong assumption.

Non-ODP RDMA in a guest comes to mind...
