Received: from eggs.gnu.org ([2001:4830:134:3::10]:54162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTldO-0006Lb-4s
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTldN-0001Gd-2X
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:07:10 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTldM-0001Ft-KK
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:07:08 -0400
Received: by mail-oi0-x241.google.com with SMTP id t22-v6so8330678oih.6
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 03:07:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605165507.GB2165@perard.uk.xensource.com>
References: <20180601175910.28146-1-peter.maydell@linaro.org>
	<20180605165507.GB2165@perard.uk.xensource.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 11:06:47 +0100
Message-ID: <CAFEAcA_X2V-YkM1ZeCHMPW3cQBk2=ZQ4BAgtcg67Eb+OuADbgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] xen: Don't use
 memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On 5 June 2018 at 17:55, Anthony PERARD <anthony.perard@citrix.com> wrote:
> On Fri, Jun 01, 2018 at 06:59:10PM +0100, Peter Maydell wrote:
>> The xen pci_assign_dev_load_option_rom() currently creates a RAM
>> memory region with memory_region_init_ram_nomigrate(), and then
>> manually registers it with vmstate_register_ram(). In fact for
>> its only callsite, the 'owner' pointer we use for the init call
>> and the '&dev->qdev' pointer we use for the vmstate_register_ram()
>> call refer to the same object. Simplify the function to only
>> take a pointer to the device once instead of twice, and use
>> memory_region_init_ram() which automatically does the vmstate
>> register for us.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This is a fairly trivial no-behaviour-change code cleanup, but
>> I've marked it as RFC because I don't have a setup for doing
>> more than just compile-testing Xen related patches.
>> This was found as part of a sweep through for code using
>> the _nomigrate versions of functions.
>
> That patch looks fine, and seams fine after hacking my way into testing
> the change.
>
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks for the review. Stefano, do you want to take it via the
xen subtree?

thanks
-- PMM
