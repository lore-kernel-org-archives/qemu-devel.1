Received: from eggs.gnu.org ([2001:4830:134:3::10]:39782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d46cs-00042B-V6
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d46co-0008NA-B7
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:12:02 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1d46co-0008Mf-5s
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:11:58 -0400
Received: by mail-vk0-f53.google.com with SMTP id o76so8771471vkc.2
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 07:11:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424130355.31324-1-marcandre.lureau@redhat.com>
References: <20170424130355.31324-1-marcandre.lureau@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 28 Apr 2017 16:11:53 +0200
Message-ID: <CABdb736pFG7yK+C_J-WWRbX+e-bk62TejQ_GtObxyFmV5t350w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RFC: vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, anderson@redhat.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Apr 24, 2017 at 3:03 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The VM coreinfo (vmcoreinfo) device is an emulated device which
> exposes a 4k memory range to the guest to store various informations
> useful to debug the guest OS. (it is greatly inspired by the VMGENID
> device implementation)
>
> This is an early-boot alternative to the qemu-ga VMDUMP_INFO event
> proposed in "[PATCH 00/21] WIP: dump: add kaslr support".
>
> If deemed more appropriate, we can consider writing to fw_cfg directly
> instead of guest memory, now that qemu 2.9 supports it again.
>
> The proof-of-concept kernel module:
> https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c

Here's a proof-of-concept Windows driver:
https://github.com/ladipro/kvm-guest-drivers-windows/tree/vmcoreinfo/vmcore=
info

I just wanted to be sure that it's possible to evaluate the ADDR
method in Windows.

>From a practical point of view it is unfortunate that this would be a
completely new device. For Windows guests it means another driver
binary and all the overhead associated with deploying it on VMs. Would
it be too crazy to add this functionality to the pvpanic device? The
mechanics could stay the same but it would be done under the existing
ACPI\QEMU0001 device.

> +Storage Format:
> +---------------
> +
> +The content is expected to use little-endian format.
> +
> +In order to implement an OVMF "SDT Header Probe Suppressor", the content=
s of
> +the vmcoreinfo blob has 40 bytes of padding:
> +
> ++-----------------------------------+
> +| SSDT with OEM Table ID =3D VMCOREIN |
> ++-----------------------------------+
> +| ...                               |       TOP OF PAGE
> +| VCIA dword object ----------------|-----> +---------------------------=
+
> +| ...                               |       | fw-allocated array for    =
|
> +| _STA method referring to VCIA     |       | "etc/vmcoreinfo"          =
|
> +| ...                               |       +---------------------------=
+
> +| ADDR method referring to VCIA     |       |  0: OVMF SDT Header probe =
|
> +| ...                               |       |     suppressor            =
|
> ++-----------------------------------+       | 40: uint32 version field  =
|
> +                                            | 44: info contents         =
|
> +                                            |     ....                  =
|
> +                                            +---------------------------=
+
> +                                            END OF PAGE
> +
> +Version 0 content:
> +
> + uint64 paddr:
> +  Physical address of the Linux vmcoreinfo ELF note.

Or physical address of the Windows crash dump header :p
Do we want to have an additional discriminator field to tell what kind
of information was written by the guest or would Windows use a
different version?

Thanks!
Ladi
