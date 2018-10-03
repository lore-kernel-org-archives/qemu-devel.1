Received: from eggs.gnu.org ([2001:4830:134:3::10]:54945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g7bM4-0003pa-2A
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 03:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g7bLz-0007vy-UR
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 03:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1g7bLz-0007vf-IB
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 03:13:51 -0400
References: <20180928003058.12786-1-philmd@redhat.com>
	<61123eb6-4263-4847-cb43-8160c99adb45@redhat.com>
	<3a670f0b-069e-5713-da7a-dea46959ff8d@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a259468f-d11c-ea18-1708-a349b6014e71@redhat.com>
Date: Wed, 3 Oct 2018 09:13:36 +0200
MIME-Version: 1.0
In-Reply-To: <3a670f0b-069e-5713-da7a-dea46959ff8d@redhat.com>
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

On 10/03/18 02:23, Cleber Rosa wrote:
> On 9/28/18 6:51 AM, Laszlo Ersek wrote:

>>   I'm not sure if Avocado provides disk image preparation utilities, but
>>   perhaps (a) we could use the vvfat driver (*shudder*) or (b) we could
>>   preformat a small image, and track it as a binary file in git.
>>
> 
> So far we've added support for generating ISO images (with pure Python).
> I'm not sure if that's useful here.  We can think about trying to add
> the same thing for vvfat.

The ability to generate ISO images (natively at that!) seems useful.
UEFI-readable ISO images need an extension on top: the ISO9660
filesystem has to get the ElTorito extension, and the ElTorito boot
image should be a FAT filesystem. Under UEFI, what's visible isn't the
ISO9660 filesystem itself, but the contents of the embedded ElTorito
boot image.

In terms of shell utilities, this usually involves:

- creating and populating the FAT filesystem image (with guestfish, or
  with mkdosfs+mtools),

- invoking genisoimage with "-efi-boot fat.img -no-emul-boot -- fat.img"
  (basically, place the FAT image into the ISO9660 filesystem like any
  other file, but pass additional options so that genisoimage know it's
  meant as the ElTorito boot image for UEFI).

If you can add this feature generically, such as:
- input: a hierarchy of files,
- output: a temporary ISO image file,

then IMO it would help with UEFI testing. Any given test case could then
generate a "startup.nsh" UEFI shell script, invoking UEFI shell
builtins, and possibly custom UEFI applications (also to be placed in
the ISO image). This could cover a good amount of batch scenarios (where
no interaction is needed).

Regarding interaction with the UEFI shell over serial, the
<https://github.com/puiterwijk/qemu-ovmf-secureboot> project for example
has successfully used "subprocess.Popen()". But, I guess I only want to
highlight the idea here ("talk to the UEFI shell via serial"), not the
exact implementation. I assume Avocado already has polished,
"expect"-like tools, for talking to the guest over the serial port.

Thanks!
Laszlo
