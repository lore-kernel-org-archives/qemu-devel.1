Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mingo.kernel.org@gmail.com>) id 1gM4Si-00034v-Ek
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 00:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mingo.kernel.org@gmail.com>) id 1gM4H2-0001yC-BB
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 23:56:38 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mingo.kernel.org@gmail.com>)
	id 1gM4H0-0001x4-8s
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 23:56:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id z13-v6so7798587wrs.3
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 20:56:29 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 12 Nov 2018 05:56:24 +0100
From: Ingo Molnar <mingo@kernel.org>
Message-ID: <20181112045624.GA28219@gmail.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
	<c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
	<20181109072015.GA86700@gmail.com>
	<38905d35-29af-b522-1629-b13e98a47a42@intel.com>
	<d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
	<b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
	<d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Li Zhijian <zhijianx.li@intel.com>, Juergen Gross <jgross@suse.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kees Cook <keescook@chromium.org>


* H. Peter Anvin <hpa@zytor.com> wrote:

> On 11/9/18 5:40 AM, Li Zhijian wrote:
> > Just noticed that there is a field xloadflags at recent protocol
> >   60 Protocol 2.12:  (Kernel 3.8) Added the xloadflags field and
> > extension fields
> >   61                 to struct boot_params for loading bzImage and ramdisk
> >   62                 above 4G in 64bit.
> > [snip]
> >  617 Field name:     xloadflags
> >  618 Type:           read
> >  619 Offset/size:    0x236/2
> >  620 Protocol:       2.12+
> >  621
> >  622   This field is a bitmask.
> >  623
> >  624   Bit 0 (read): XLF_KERNEL_64
> >  625         - If 1, this kernel has the legacy 64-bit entry point at
> > 0x200.
> >  626
> >  627   Bit 1 (read): XLF_CAN_BE_LOADED_ABOVE_4G
> >  628         - If 1, kernel/boot_params/cmdline/ramdisk can be above 4G.
> >  629
> > 
> > maybe we can reuse this field and append a new Bit 5
> > XLF_INITRD_MAX_SIZE_4G and increase header version.
> > For the old protocol version 2.12+, if  XLF_CAN_BE_LOADED_ABOVE_4G is
> > set, we can also realize ~4GB initrd is allowed.
> > 
> > bootloader side:
> > if protocol >= 2.15
> >    if XLF_INITRD_LOAD_BELOW_4G
> >       support ~4G initrd
> >    fi
> > else if protocol >=2.12
> >    if XLF_CAN_BE_LOADED_ABOVE_4G
> >     support ~4G initrd
> >    fi
> > fi
> > 
> 
> The two are equivalent.  Obviously you have to load above 4 GB if you
> have more than 4 GB of initrd.  If XLF_CAN_BE_LOADED_ABOVE_4G is not
> set, then you most likely are on a 32-bit kernel and there are more
> fundamental limits (even if you were to load it above the 2 GB mark, you
> would be limited by the size of kernel memory.)
> 
> So, in case you are wondering: the bootloader that broke when setting
> the initrd_max field above 2 GB was, of course, Grub.
> 
> So just use XLF_CAN_BE_LOADED_ABOVE_4G. There is no need for a new flag
> or new field.

That's nice, and that's the best solution!

> Also note that the ext_ramdisk_image and ext_ramdisk_size are part of
> struct boot_params as opposed to struct setup_header, which means that
> they are not supported when entering via the 16-bit BIOS entry point,
> and I am willing to bet that there will be, ahem, "strangeness" if
> entered via the 32-bit entry point if at least the command line is
> loaded above the 4 GB mark; the initrd should be fine, though.
> 
> This is obviosly not an issue in EFI environments, where we enter
> through the EFI handover entry point.
> 
> The main reason these were not added to struct setup_header is that
> there are only 24 bytes left in that header and so space is highly
> precious. One way to deal with that if we really, really need to would
> be to add an initrd/initramfs type of setup_data.

Is there no way to extend that header by making an extended header part 
of the payload?

IIRC that header is small and fixed size to be part of a single sector at 
the very beginning of boot images, but accessing any extended header bits 
from the payload section shouldn't really be an issue for a modern 
bootloader to handle, right?

Such an extended header could use a more modern (self-extending) ABI as 
well.

Thanks,

	Ingo
