Received: from eggs.gnu.org ([2001:4830:134:3::10]:39561)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+c96c7f713f0eb2402da4+5171+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e5SF7-0007v3-Nd
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 04:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+c96c7f713f0eb2402da4+5171+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e5SF4-0002Nc-0d
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 04:01:21 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:55901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<BATV+c96c7f713f0eb2402da4+5171+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e5SF3-0002CD-RP
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 04:01:17 -0400
Date: Fri, 20 Oct 2017 01:00:49 -0700
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20171020080049.GA25471@infradead.org>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171017071633.GA9207@infradead.org>
	<1441791227.21027037.1508226056893.JavaMail.zimbra@redhat.com>
	<20171017080236.GA27649@infradead.org>
	<670833322.21037148.1508229041158.JavaMail.zimbra@redhat.com>
	<20171018130339.GB29767@stefanha-x1.localdomain>
	<CAPcyv4h6aFkyHhh4R4DTznbSCLf9CuBoszk0Q1gB5EKNcp_SeQ@mail.gmail.com>
	<20171019080149.GB10089@infradead.org>
	<CAPcyv4j=Cdp68C15HddKaErpve2UGRfSTiL6bHiS=3gQybz9pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j=Cdp68C15HddKaErpve2UGRfSTiL6bHiS=3gQybz9pg@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 2/2] KVM: add virtio-pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Stefan Hajnoczi <stefanha@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Kevin Wolf <kwolf@redhat.com>, haozhong zhang <haozhong.zhang@intel.com>, Jan Kara <jack@suse.cz>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, Linux MM <linux-mm@kvack.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>

On Thu, Oct 19, 2017 at 11:21:26AM -0700, Dan Williams wrote:
> The difference is that nvdimm_flush() is not mandatory, and that the
> platform will automatically perform the same flush at power-fail.
> Applications should be able to assume that if they are using MAP_SYNC
> that no other coordination with the kernel or the hypervisor is
> necessary.
> 
> Advertising this as a generic Persistent Memory range to the guest
> means that the guest could theoretically use it with device-dax where
> there is no driver or filesystem sync interface. The hypervisor will
> be waiting for flush notifications and the guest will just issue cache
> flushes and sfence instructions. So, as far as I can see we need to
> differentiate this virtio-model from standard "Persistent Memory" to
> the guest and remove the possibility of guests/applications making the
> wrong assumption.

So add a flag that it is not.  We already have the nd_volatile type,
that is special.  For now only in Linux, but I think adding this type
to the spec eventually would be very useful for efficiently exposing
directly mappable device to VM guests.
