Received: from eggs.gnu.org ([2001:4830:134:3::10]:59961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ejavZ-0007H1-Ru
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ejavV-0003uL-SB
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:23:05 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:39590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ejavV-0003uB-KH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:23:01 -0500
Received: by mail-pg0-x243.google.com with SMTP id w17so1036639pgv.6
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 17:23:01 -0800 (PST)
References: <20180207000731.32764.95992.stgit@gimli.home>
	<cfe31ae1-2557-d15a-45a2-0ba03d8d71fa@ozlabs.ru>
	<20180206212538.50ef0e13@w520.home>
	<6014d60c-9bdb-4dc0-7cd7-9299005d9c5a@ozlabs.ru>
	<20180207071253.7c606594@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <86c09adf-c4ab-5eca-629a-4d6c6a5692be@ozlabs.ru>
Date: Thu, 8 Feb 2018 12:22:53 +1100
MIME-Version: 1.0
In-Reply-To: <20180207071253.7c606594@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org

On 08/02/18 01:12, Alex Williamson wrote:
> On Wed, 7 Feb 2018 15:48:26 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 07/02/18 15:25, Alex Williamson wrote:
>>> On Wed, 7 Feb 2018 15:09:22 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:  
>>>> On 07/02/18 11:08, Alex Williamson wrote:  
>>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>>> index e3301dbd27d4..07966a5f0832 100644
>>>>> --- a/include/uapi/linux/vfio.h
>>>>> +++ b/include/uapi/linux/vfio.h
>>>>> @@ -503,6 +503,30 @@ struct vfio_pci_hot_reset {
>>>>>  
>>>>>  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
>>>>>  
>>>>> +/**
>>>>> + * VFIO_DEVICE_IOEVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 14,
>>>>> + *                              struct vfio_device_ioeventfd)
>>>>> + *
>>>>> + * Perform a write to the device at the specified device fd offset, with
>>>>> + * the specified data and width when the provided eventfd is triggered.
>>>>> + *
>>>>> + * Return: 0 on success, -errno on failure.
>>>>> + */
>>>>> +struct vfio_device_ioeventfd {
>>>>> +	__u32	argsz;
>>>>> +	__u32	flags;
>>>>> +#define VFIO_DEVICE_IOEVENTFD_8		(1 << 0) /* 1-byte write */
>>>>> +#define VFIO_DEVICE_IOEVENTFD_16	(1 << 1) /* 2-byte write */
>>>>> +#define VFIO_DEVICE_IOEVENTFD_32	(1 << 2) /* 4-byte write */
>>>>> +#define VFIO_DEVICE_IOEVENTFD_64	(1 << 3) /* 8-byte write */
>>>>> +#define VFIO_DEVICE_IOEVENTFD_SIZE_MASK	(0xf)
>>>>> +	__u64	offset;			/* device fd offset of write */
>>>>> +	__u64	data;			/* data to be written */
>>>>> +	__s32	fd;			/* -1 for de-assignment */
>>>>> +};
>>>>> +
>>>>> +#define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 14)    
>>>>
>>>>
>>>> Is this a first ioctl with endianness fixed to little-endian? I'd suggest
>>>> to comment on that as things like vfio_info_cap_header do use the host
>>>> endianness.  
>>>
>>> Look at our current read and write interface, we call leXX_to_cpu
>>> before calling iowriteXX there and I think a user would logically
>>> expect to use the same data format here as they would there.  
>>
>> If the data is "char data[8]" (i.e. bytestream), then it can be expected to
>> be device/bus endian (i.e. PCI == little endian), but if it is u64 - then I
>> am not so sure really, and this made me look around. It could be "__le64
>> data" too.
>>
>>> Also note
>>> that iowriteXX does a cpu_to_leXX, so are we really defining the
>>> interface as little-endian or are we just trying to make ourselves
>>> endian neutral and counter that implicit conversion?  Thanks,  
>>
>> Defining it LE is fine, I just find it a bit confusing when
>> vfio_info_cap_header is host endian but vfio_device_ioeventfd is not.
> 
> But I don't think we are defining the interface as little-endian.
> iowriteXX does a cpu_to_leXX byteswap.  Therefore in order to maintain
> endian neutrality, if the data does a cpu->le swap on the way out, I
> need to do a le->cpu swap on the way in, right?  Please defend the
> assertion that we're creating a little-endian interface.  Thanks,


vfio_pci_ioctl() passes "endian-neutral" ioeventfd.data to
vfio_pci_ioeventfd() which immediately does the leXX_to_cpu() conversion
(and uses the result later on in iowriteXX(), which is not VFIO API) so I
read it as the ioctl really expects LE.

The QEMU part - vfio_nvidia_mirror_quirk MR - does not swap bytes but the
MR itself it declared DEVICE_LITTLE_ENDIAN which means
vfio_nvidia_quirk_mirror_write() receives byteswapped @data in the host
endian == bigendian on a big endian host. So the ioctl() handler will
receive a BE value, do byteswap #1 in leXX_to_cpu(), and then do byteswap
#2 in iowriteXX() so after all a BE will be written to a device. So I'd say
we rather do not need leXX_to_cpu() in vfio_pci_ioeventfd(). Correct me
where I am wrong. Thanks,



-- 
Alexey
