Received: from eggs.gnu.org ([2001:4830:134:3::10]:53271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e47mt-0003bq-9O
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e47ms-00078V-Cl
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:58:43 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:48199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1e47ms-00075c-4n
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:58:42 -0400
Received: by mail-oi0-x231.google.com with SMTP id m198so25859289oig.5
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 08:58:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171016144753.GB14135@stefanha-x1.localdomain>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171013094431.GA27308@stefanha-x1.localdomain>
	<24301306.20068579.1507891695416.JavaMail.zimbra@redhat.com>
	<20171016144753.GB14135@stefanha-x1.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Oct 2017 08:58:37 -0700
Message-ID: <CAPcyv4hffSdoONfFohKZzfB2gywGYG9MmDxC0H9+5R53w+ROVQ@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Rik van Riel <riel@redhat.com>, haozhong zhang <haozhong.zhang@intel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, ross zwisler <ross.zwisler@intel.com>, David Hildenbrand <david@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>

On Mon, Oct 16, 2017 at 7:47 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Oct 13, 2017 at 06:48:15AM -0400, Pankaj Gupta wrote:
>> > On Thu, Oct 12, 2017 at 09:20:26PM +0530, Pankaj Gupta wrote:
>> > > +static blk_qc_t virtio_pmem_make_request(struct request_queue *q,
>> > > +                 struct bio *bio)
>> > > +{
>> > > + blk_status_t rc = 0;
>> > > + struct bio_vec bvec;
>> > > + struct bvec_iter iter;
>> > > + struct virtio_pmem *pmem = q->queuedata;
>> > > +
>> > > + if (bio->bi_opf & REQ_FLUSH)
>> > > +         //todo host flush command
>> >
>> > This detail is critical to the device design.  What is the plan?
>>
>> yes, this is good point.
>>
>> was thinking of guest sending a flush command to Qemu which
>> will do a fsync on file fd.
>
> Previously there was discussion about fsyncing a specific file range
> instead of the whole file.  This could perform better in cases where
> only a subset of dirty pages need to be flushed.
>
> One possibility is to design the virtio interface to communicate ranges
> but the emulation code simply fsyncs the fd for the time being.  Later
> on, if the necessary kernel and userspace interfaces are added, we can
> make use of the interface.

Range based is not a natural storage cache management mechanism. All
that is it available typically is a full write-cache-flush mechanism
and upper layers would need to customized for range-based flushing.

>> If we do a async flush and move the task to wait queue till we receive
>> flush complete reply from host we can allow other tasks to execute
>> in current cpu.
>>
>> Any suggestions you have or anything I am not foreseeing here?
>
> My main thought about this patch series is whether pmem should be a
> virtio-blk feature bit instead of a whole new device.  There is quite a
> bit of overlap between the two.

I'd be open to that... there's already provisions in the pmem driver
for platforms where cpu caches are flushed on power-loss, a virtio
mode for this shared-memory case seems reasonable.
