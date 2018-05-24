Received: from eggs.gnu.org ([2001:4830:134:3::10]:42981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLrr4-0005Zd-99
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLrr0-0003fP-CU
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:08:38 -0400
Date: Thu, 24 May 2018 17:08:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180524150817.GF4008@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<20180524174603-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524174603-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, ehabkost@redhat.com, stefanha@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 24.05.2018 um 16:56 hat Michael S. Tsirkin geschrieben:
> On Thu, May 24, 2018 at 12:32:51PM +0100, Richard W.M. Jones wrote:
> > There is however a seed of a good idea in the thread:
> > 
> > > I don't think QEMU needs to use this information automatically,
> > > necessarily.  I think the first step is to simply make QEMU save
> > > this information in the disk image, and making qemu-img able to
> > > read and write this information.
> > 
> > It would be nice if qcow2 added arbitrary data sections (which would
> > always be ignored by qemu) for storing additional data.  This could be
> > used to create a compact qcow2 + metadata format to rival OVA for
> > management layers to use, and there are various other uses too.
> > 
> > Rich.
> 
> I think this part is pretty uncontroversial.
> 
> But can we add data without changing the verion?

Yes. Don't worry about where to store it, we'll solve this. Do worry
about what to store.

> typedef struct QCowHeader {
>     uint32_t magic;
>     uint32_t version;
>     uint64_t backing_file_offset;
>     uint32_t backing_file_size;
>     uint32_t mtime;
>     uint64_t size; /* in bytes */
>     uint8_t cluster_bits;
>     uint8_t l2_bits;
>     uint16_t padding;
>     uint32_t crypt_method;
>     uint64_t l1_table_offset;
> } QEMU_PACKED QCowHeader;
> 
> How about changing mtime to a flags bitmap?
> E.g. 0x1 would mean there's an extended header.

You're looking at the qcow1 header. qcow2 has mechanisms to extend the
metadata, including compatible and incompatible feature flags and a
header_length field.

Kevin
