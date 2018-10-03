Received: from eggs.gnu.org ([2001:4830:134:3::10]:33485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g7jZu-0003FN-9M
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 12:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g7jZq-0002ct-VK
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 12:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1g7jZq-0002cK-LZ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 12:00:42 -0400
References: <20180928003058.12786-1-philmd@redhat.com>
	<61123eb6-4263-4847-cb43-8160c99adb45@redhat.com>
	<3a670f0b-069e-5713-da7a-dea46959ff8d@redhat.com>
	<a259468f-d11c-ea18-1708-a349b6014e71@redhat.com>
	<7ee997c5-e200-6238-b1d9-b4930c153592@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9225135b-b5da-7e55-fd1f-7afbed166f56@redhat.com>
Date: Wed, 3 Oct 2018 17:59:59 +0200
MIME-Version: 1.0
In-Reply-To: <7ee997c5-e200-6238-b1d9-b4930c153592@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] acceptance tests: Test firmware
 checking debug console output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kashyap Chamarthy <kchamart@redhat.com>

On 10/03/18 17:20, Cleber Rosa wrote:
> On 10/3/18 3:13 AM, Laszlo Ersek wrote:
>> On 10/03/18 02:23, Cleber Rosa wrote:
>>> On 9/28/18 6:51 AM, Laszlo Ersek wrote:
>>
>>>>   I'm not sure if Avocado provides disk image preparation utilities, but
>>>>   perhaps (a) we could use the vvfat driver (*shudder*) or (b) we could
>>>>   preformat a small image, and track it as a binary file in git.
>>>>
>>>
>>> So far we've added support for generating ISO images (with pure Python).
>>> I'm not sure if that's useful here.  We can think about trying to add
>>> the same thing for vvfat.
>>
>> The ability to generate ISO images (natively at that!) seems useful.
>> UEFI-readable ISO images need an extension on top: the ISO9660
>> filesystem has to get the ElTorito extension, and the ElTorito boot
>> image should be a FAT filesystem. Under UEFI, what's visible isn't the
>> ISO9660 filesystem itself, but the contents of the embedded ElTorito
>> boot image.
>>
>> In terms of shell utilities, this usually involves:
>>
>> - creating and populating the FAT filesystem image (with guestfish, or
>>   with mkdosfs+mtools),
>>
> 
> Is FAT12 an option here?  The reason I ask is that there may be code
> FAT12 capable code ready to be incorporated:
> 
> https://github.com/clalancette/pyfat

Theoretically, I should answer "yes". For two reasons:

(1) In "13.3 File System Format", the UEFI-2.7 spec writes,

"[...] EFI encompasses the use of FAT32 for a system partition, and
FAT12 or FAT16 for removable media. [...]"

(2) When invoking mkdosfs without the "-F" option, mkdosfs chooses the
smallest FAT filesystem variant that can accommodate the requested size.
We successfully format UEFI-readable ISO images that don't exceed e.g.
3MB in final size. This implies (and I have now actually checked, with
"dosfsck -v") that their embedded ElTorito image is FAT12. edk2 has no
trouble reading that.


However... the maximum volume size for FAT12 appears to be 32 MB,
according to wikipedia:

  https://en.wikipedia.org/wiki/File_Allocation_Table#FAT12

It doesn't look good for the long term. For example, I can imagine a
test case where you place a kernel executable (containing a UEFI stub)
and an initial ramdisk on the UEFI-readable ISO. Using the RHEL-7.5
kernel and the matching initrd from my laptop as an example: that's
already 6.2MB + 25MB.

So, technically, FAT12 should be fine; in practice, it could prove limiting.

[...]

Thanks!
Laszlo
