Received: from eggs.gnu.org ([2001:4830:134:3::10]:38446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1gM5Ia-0006Fs-GW
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1gM5IX-0005GP-5d
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:02:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50913 helo=mail.zytor.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpa@zytor.com>) id 1gM5IW-00052J-S5
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:02:09 -0500
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
	<c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
	<20181109072015.GA86700@gmail.com>
	<38905d35-29af-b522-1629-b13e98a47a42@intel.com>
	<d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
	<b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
	<d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
	<20181112045624.GA28219@gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <fcf1d6b5-e64f-3aea-f794-99237e1988cf@zytor.com>
Date: Sun, 11 Nov 2018 22:00:42 -0800
MIME-Version: 1.0
In-Reply-To: <20181112045624.GA28219@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Ingo Molnar <mingo@kernel.org>
Cc: Li Zhijian <zhijianx.li@intel.com>, Juergen Gross <jgross@suse.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kees Cook <keescook@chromium.org>

On 11/11/18 8:56 PM, Ingo Molnar wrote:
> 
>> Also note that the ext_ramdisk_image and ext_ramdisk_size are part of
>> struct boot_params as opposed to struct setup_header, which means that
>> they are not supported when entering via the 16-bit BIOS entry point,
>> and I am willing to bet that there will be, ahem, "strangeness" if
>> entered via the 32-bit entry point if at least the command line is
>> loaded above the 4 GB mark; the initrd should be fine, though.
>>
>> This is obviosly not an issue in EFI environments, where we enter
>> through the EFI handover entry point.
>>
>> The main reason these were not added to struct setup_header is that
>> there are only 24 bytes left in that header and so space is highly
>> precious. One way to deal with that if we really, really need to would
>> be to add an initrd/initramfs type of setup_data.
> 
> Is there no way to extend that header by making an extended header part 
> of the payload?
> 
> IIRC that header is small and fixed size to be part of a single sector at 
> the very beginning of boot images, but accessing any extended header bits 
> from the payload section shouldn't really be an issue for a modern 
> bootloader to handle, right?
> 
> Such an extended header could use a more modern (self-extending) ABI as 
> well.
> 

Yes, although I don't really think it is as much of an issue as it seems at
this point.

The limit comes from having used a one-byte jump instruction at the beginning;
however, these days that limit is functionally walled.

It is of course possible to address this if it should become necessary,
however, the current protocol has lasted for 23 years so far and we haven't
run out yet, even with occasional missteps. As such, I don't think we are in a
huge hurry to address this particular aspect.

In part as a result of this exchange I have spent some time thinking about the
boot protocol and its dependencies, and there is, in fact, a much more serious
problem that needs to be addressed: it is not currently possible in a
forward-compatible way to map all data areas that may be occupied by
bootloader-provided data. The kernel proper has an advantage here, in that the
kernel will by definition always be the "owner of the protocol" (anything the
kernel doesn't know how to map won't be used by the kernel anyway), but it
really isn't a good situation. So I'm currently trying to think up a way to
make that possible.

	-hpa
