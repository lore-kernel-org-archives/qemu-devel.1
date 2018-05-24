Received: from eggs.gnu.org ([2001:4830:134:3::10]:39227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLrg7-0005iv-OI
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLrg0-00039M-3B
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:57:19 -0400
Date: Thu, 24 May 2018 17:56:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524174603-mutt-send-email-mst@kernel.org>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524113251.GB4660@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: ehabkost@redhat.com, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, May 24, 2018 at 12:32:51PM +0100, Richard W.M. Jones wrote:
> There is however a seed of a good idea in the thread:
> 
> > I don't think QEMU needs to use this information automatically,
> > necessarily.  I think the first step is to simply make QEMU save
> > this information in the disk image, and making qemu-img able to
> > read and write this information.
> 
> It would be nice if qcow2 added arbitrary data sections (which would
> always be ignored by qemu) for storing additional data.  This could be
> used to create a compact qcow2 + metadata format to rival OVA for
> management layers to use, and there are various other uses too.
> 
> Rich.

I think this part is pretty uncontroversial.

But can we add data without changing the verion?

typedef struct QCowHeader {
    uint32_t magic;
    uint32_t version;
    uint64_t backing_file_offset;
    uint32_t backing_file_size;
    uint32_t mtime;
    uint64_t size; /* in bytes */
    uint8_t cluster_bits;
    uint8_t l2_bits;
    uint16_t padding;
    uint32_t crypt_method;
    uint64_t l1_table_offset;
} QEMU_PACKED QCowHeader;


How about changing mtime to a flags bitmap?
E.g. 0x1 would mean there's an extended header.

And then:

struct QCowExtHeader {
    uint64_t meta_data_offset;
    uint32_t meta_data_size;
    uint32_t meta_data_format; /* 0x0 - UTF-8 NULL-terminated string */
};


Thanks!

-- 
MST
