Received: from eggs.gnu.org ([2001:4830:134:3::10]:53050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejQT5-00025Z-Lm
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejQT1-0002uq-8P
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:12:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ejQT1-0002uY-0Y
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:12:55 -0500
Date: Wed, 7 Feb 2018 07:12:53 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180207071253.7c606594@w520.home>
In-Reply-To: <6014d60c-9bdb-4dc0-7cd7-9299005d9c5a@ozlabs.ru>
References: <20180207000731.32764.95992.stgit@gimli.home>
	<cfe31ae1-2557-d15a-45a2-0ba03d8d71fa@ozlabs.ru>
	<20180206212538.50ef0e13@w520.home>
	<6014d60c-9bdb-4dc0-7cd7-9299005d9c5a@ozlabs.ru>
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

On Wed, 7 Feb 2018 15:48:26 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 07/02/18 15:25, Alex Williamson wrote:
> > On Wed, 7 Feb 2018 15:09:22 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:  
> >> On 07/02/18 11:08, Alex Williamson wrote:  
> >>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >>> index e3301dbd27d4..07966a5f0832 100644
> >>> --- a/include/uapi/linux/vfio.h
> >>> +++ b/include/uapi/linux/vfio.h
> >>> @@ -503,6 +503,30 @@ struct vfio_pci_hot_reset {
> >>>  
> >>>  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
> >>>  
> >>> +/**
> >>> + * VFIO_DEVICE_IOEVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 14,
> >>> + *                              struct vfio_device_ioeventfd)
> >>> + *
> >>> + * Perform a write to the device at the specified device fd offset, with
> >>> + * the specified data and width when the provided eventfd is triggered.
> >>> + *
> >>> + * Return: 0 on success, -errno on failure.
> >>> + */
> >>> +struct vfio_device_ioeventfd {
> >>> +	__u32	argsz;
> >>> +	__u32	flags;
> >>> +#define VFIO_DEVICE_IOEVENTFD_8		(1 << 0) /* 1-byte write */
> >>> +#define VFIO_DEVICE_IOEVENTFD_16	(1 << 1) /* 2-byte write */
> >>> +#define VFIO_DEVICE_IOEVENTFD_32	(1 << 2) /* 4-byte write */
> >>> +#define VFIO_DEVICE_IOEVENTFD_64	(1 << 3) /* 8-byte write */
> >>> +#define VFIO_DEVICE_IOEVENTFD_SIZE_MASK	(0xf)
> >>> +	__u64	offset;			/* device fd offset of write */
> >>> +	__u64	data;			/* data to be written */
> >>> +	__s32	fd;			/* -1 for de-assignment */
> >>> +};
> >>> +
> >>> +#define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 14)    
> >>
> >>
> >> Is this a first ioctl with endianness fixed to little-endian? I'd suggest
> >> to comment on that as things like vfio_info_cap_header do use the host
> >> endianness.  
> > 
> > Look at our current read and write interface, we call leXX_to_cpu
> > before calling iowriteXX there and I think a user would logically
> > expect to use the same data format here as they would there.  
> 
> If the data is "char data[8]" (i.e. bytestream), then it can be expected to
> be device/bus endian (i.e. PCI == little endian), but if it is u64 - then I
> am not so sure really, and this made me look around. It could be "__le64
> data" too.
> 
> > Also note
> > that iowriteXX does a cpu_to_leXX, so are we really defining the
> > interface as little-endian or are we just trying to make ourselves
> > endian neutral and counter that implicit conversion?  Thanks,  
> 
> Defining it LE is fine, I just find it a bit confusing when
> vfio_info_cap_header is host endian but vfio_device_ioeventfd is not.

But I don't think we are defining the interface as little-endian.
iowriteXX does a cpu_to_leXX byteswap.  Therefore in order to maintain
endian neutrality, if the data does a cpu->le swap on the way out, I
need to do a le->cpu swap on the way in, right?  Please defend the
assertion that we're creating a little-endian interface.  Thanks,

Alex
