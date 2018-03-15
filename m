Received: from eggs.gnu.org ([2001:4830:134:3::10]:53381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewaLn-0004xU-6U
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewaLi-0006bv-SS
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:23:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ewaLi-0006bc-Ng
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:23:46 -0400
Date: Thu, 15 Mar 2018 15:23:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180315152334.29ee10b6@w520.home>
In-Reply-To: <777482c6-8180-df0f-0a0c-5d6e000553ba@redhat.com>
References: <20180207000731.32764.95992.stgit@gimli.home>
	<cfe31ae1-2557-d15a-45a2-0ba03d8d71fa@ozlabs.ru>
	<20180206212538.50ef0e13@w520.home>
	<6014d60c-9bdb-4dc0-7cd7-9299005d9c5a@ozlabs.ru>
	<20180207071253.7c606594@w520.home>
	<86c09adf-c4ab-5eca-629a-4d6c6a5692be@ozlabs.ru>
	<777482c6-8180-df0f-0a0c-5d6e000553ba@redhat.com>
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org

On Tue, 13 Mar 2018 13:38:00 +0100
Auger Eric <eric.auger@redhat.com> wrote:
> On 08/02/18 02:22, Alexey Kardashevskiy wrote:
> > On 08/02/18 01:12, Alex Williamson wrote:  
> >> On Wed, 7 Feb 2018 15:48:26 +1100
> >> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>> On 07/02/18 15:25, Alex Williamson wrote:  
> >>>> On Wed, 7 Feb 2018 15:09:22 +1100
> >>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:    
> >>>>> On 07/02/18 11:08, Alex Williamson wrote:    
> >>>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >>>>>> index e3301dbd27d4..07966a5f0832 100644
> >>>>>> --- a/include/uapi/linux/vfio.h
> >>>>>> +++ b/include/uapi/linux/vfio.h
> >>>>>> @@ -503,6 +503,30 @@ struct vfio_pci_hot_reset {
> >>>>>>  
> >>>>>>  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
> >>>>>>  
> >>>>>> +/**
> >>>>>> + * VFIO_DEVICE_IOEVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 14,
> >>>>>> + *                              struct vfio_device_ioeventfd)
> >>>>>> + *
> >>>>>> + * Perform a write to the device at the specified device fd offset, with
> >>>>>> + * the specified data and width when the provided eventfd is triggered.
> >>>>>> + *
> >>>>>> + * Return: 0 on success, -errno on failure.
> >>>>>> + */
> >>>>>> +struct vfio_device_ioeventfd {
> >>>>>> +	__u32	argsz;
> >>>>>> +	__u32	flags;
> >>>>>> +#define VFIO_DEVICE_IOEVENTFD_8		(1 << 0) /* 1-byte write */
> >>>>>> +#define VFIO_DEVICE_IOEVENTFD_16	(1 << 1) /* 2-byte write */
> >>>>>> +#define VFIO_DEVICE_IOEVENTFD_32	(1 << 2) /* 4-byte write */
> >>>>>> +#define VFIO_DEVICE_IOEVENTFD_64	(1 << 3) /* 8-byte write */
> >>>>>> +#define VFIO_DEVICE_IOEVENTFD_SIZE_MASK	(0xf)
> >>>>>> +	__u64	offset;			/* device fd offset of write */
> >>>>>> +	__u64	data;			/* data to be written */
> >>>>>> +	__s32	fd;			/* -1 for de-assignment */
> >>>>>> +};
> >>>>>> +
> >>>>>> +#define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 14)      
> >>>>>
> >>>>>
> >>>>> Is this a first ioctl with endianness fixed to little-endian? I'd suggest
> >>>>> to comment on that as things like vfio_info_cap_header do use the host
> >>>>> endianness.    
> >>>>
> >>>> Look at our current read and write interface, we call leXX_to_cpu
> >>>> before calling iowriteXX there and I think a user would logically
> >>>> expect to use the same data format here as they would there.    
> >>>
> >>> If the data is "char data[8]" (i.e. bytestream), then it can be expected to
> >>> be device/bus endian (i.e. PCI == little endian), but if it is u64 - then I
> >>> am not so sure really, and this made me look around. It could be "__le64
> >>> data" too.
> >>>  
> >>>> Also note
> >>>> that iowriteXX does a cpu_to_leXX, so are we really defining the
> >>>> interface as little-endian or are we just trying to make ourselves
> >>>> endian neutral and counter that implicit conversion?  Thanks,    
> >>>
> >>> Defining it LE is fine, I just find it a bit confusing when
> >>> vfio_info_cap_header is host endian but vfio_device_ioeventfd is not.  
> >>
> >> But I don't think we are defining the interface as little-endian.
> >> iowriteXX does a cpu_to_leXX byteswap.  Therefore in order to maintain
> >> endian neutrality, if the data does a cpu->le swap on the way out, I
> >> need to do a le->cpu swap on the way in, right?  Please defend the
> >> assertion that we're creating a little-endian interface.  Thanks,  
> > 
> > 
> > vfio_pci_ioctl() passes "endian-neutral" ioeventfd.data to
> > vfio_pci_ioeventfd() which immediately does the leXX_to_cpu() conversion
> > (and uses the result later on in iowriteXX(), which is not VFIO API) so I
> > read it as the ioctl really expects LE.
> > 
> > The QEMU part - vfio_nvidia_mirror_quirk MR - does not swap bytes but the
> > MR itself it declared DEVICE_LITTLE_ENDIAN which means
> > vfio_nvidia_quirk_mirror_write() receives byteswapped @data in the host
> > endian == bigendian on a big endian host. So the ioctl() handler will
> > receive a BE value, do byteswap #1 in leXX_to_cpu(), and then do byteswap
> > #2 in iowriteXX() so after all a BE will be written to a device. So I'd say
> > we rather do not need leXX_to_cpu() in vfio_pci_ioeventfd(). Correct me
> > where I am wrong. Thanks,  
> 
> It is not crystal clear to me what is the outcome of this discussion.
> Please can you clarify?
> 
> At the beginning I understood we had a chain of lexx_to_cpu and
> cpu_to_lexx (in iowritexx) so it was neutral. Now I am lost about what
> we want.

I've tried to address this with patch 2/3 in the newer series, adding
helpers such that the implicit endian-ness of the io{read,write}
functions is hidden and no extraneous swapping is done.  Therefore the
leXX_to_cpu() is gone, as Alexey wanted.  Unless there's a new
objection, this is what I intend to go with.  Thanks,

Alex
