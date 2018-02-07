Received: from eggs.gnu.org ([2001:4830:134:3::10]:43938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejHIl-0000ok-W4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 23:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejHIi-0003bd-S6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 23:25:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ejHIi-0003bJ-LY
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 23:25:40 -0500
Date: Tue, 6 Feb 2018 21:25:38 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180206212538.50ef0e13@w520.home>
In-Reply-To: <cfe31ae1-2557-d15a-45a2-0ba03d8d71fa@ozlabs.ru>
References: <20180207000731.32764.95992.stgit@gimli.home>
	<cfe31ae1-2557-d15a-45a2-0ba03d8d71fa@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] vfio/pci: Add ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org

On Wed, 7 Feb 2018 15:09:22 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> On 07/02/18 11:08, Alex Williamson wrote:
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index e3301dbd27d4..07966a5f0832 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -503,6 +503,30 @@ struct vfio_pci_hot_reset {
> >  
> >  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
> >  
> > +/**
> > + * VFIO_DEVICE_IOEVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 14,
> > + *                              struct vfio_device_ioeventfd)
> > + *
> > + * Perform a write to the device at the specified device fd offset, with
> > + * the specified data and width when the provided eventfd is triggered.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +struct vfio_device_ioeventfd {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +#define VFIO_DEVICE_IOEVENTFD_8		(1 << 0) /* 1-byte write */
> > +#define VFIO_DEVICE_IOEVENTFD_16	(1 << 1) /* 2-byte write */
> > +#define VFIO_DEVICE_IOEVENTFD_32	(1 << 2) /* 4-byte write */
> > +#define VFIO_DEVICE_IOEVENTFD_64	(1 << 3) /* 8-byte write */
> > +#define VFIO_DEVICE_IOEVENTFD_SIZE_MASK	(0xf)
> > +	__u64	offset;			/* device fd offset of write */
> > +	__u64	data;			/* data to be written */
> > +	__s32	fd;			/* -1 for de-assignment */
> > +};
> > +
> > +#define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 14)  
> 
> 
> Is this a first ioctl with endianness fixed to little-endian? I'd suggest
> to comment on that as things like vfio_info_cap_header do use the host
> endianness.

Look at our current read and write interface, we call leXX_to_cpu
before calling iowriteXX there and I think a user would logically
expect to use the same data format here as they would there.  Also note
that iowriteXX does a cpu_to_leXX, so are we really defining the
interface as little-endian or are we just trying to make ourselves
endian neutral and counter that implicit conversion?  Thanks,

Alex
