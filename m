Received: from eggs.gnu.org ([2001:4830:134:3::10]:36577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cYsUz-0004WW-LD
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cYsUv-0008HW-AM
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:50:48 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:33047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cYsUv-0008HS-62
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:50:45 -0500
Received: by mail-ua0-f177.google.com with SMTP id i68so292756013uad.0
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 02:50:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201102013.GC3232@redhat.com>
References: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
	<20170201102013.GC3232@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 1 Feb 2017 11:50:43 +0100
Message-ID: <CABdb735fGM9r4tirfOTyK1Jv8oC868nW5rCsNk_X5acoiav1iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

On Wed, Feb 1, 2017 at 11:20 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Feb 01, 2017 at 11:06:46AM +0100, Ladi Prosek wrote:
>> Analogous to guest-file-read and guest-file-write, this commit adds
>> support for issuing IOCTLs to files in the guest. With the goal of
>> abstracting away the differences between Posix ioctl() and Win32
>> DeviceIoControl() to provide one unified API, the schema distinguishes
>> between input and output buffer sizes (as required by Win32) and
>> allows the caller to supply either a 'buffer', pointer to which will
>> be passed to the Posix ioctl(), or an integer argument, passed to
>> ioctl() directly.
>
> What is the intended usage scenario for this ?

My specific case is extracting a piece of data from Windows guests.
Guest driver exposes a file object with a well-known IOCTL code to
return a data structure from the kernel.

> The size of arguments that need to be provided to ioctl()s vary on
> the architecture of the guest kernel that's running, which cannot be
> assumed to be the same as the architecture of the QEMU binary. ie
> you can be running i686 kernel in an x86_64 QEMU.  So it feels like
> it is going to be hard for applications to reliably use this feature
> unless they have more information about the guest OS, that is not
> currently provided by QEMU guest agent. So it feels like this design
> is not likely to be satisfactory to me.

I can turn this around and say that guest-file-read and
guest-file-write shouldn't exist because applications can't reliably
know what the format of files on the guest is.

This is just a transport, it doesn't need to understand the data it's
transporting. Yes, I get it that ioctl tends to be associated with
system-y things with tighter ties to the OS, bitness, endianness and
so on. But, it doesn't have to be. In my case I chose ioctl as opposed
to regular file I/O because what I'm reading is not a stream in
nature, it's a fixed size data structure.

Thanks!
Ladi

> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
