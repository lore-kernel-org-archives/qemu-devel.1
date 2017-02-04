Received: from eggs.gnu.org ([2001:4830:134:3::10]:57667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZzpA-0002ET-LE
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZzp7-0007Co-JR
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:52:16 -0500
Received: from greensocs.com ([193.104.36.180]:58493)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZzp7-0007Cf-63
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:52:13 -0500
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
	<CAFEAcA9J-F4bVONk_Yhafx3T6R2POW9=pAbLdY+5iW_R_fmBCw@mail.gmail.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <b9eaacfd-74ab-68ef-dc46-488ef8427aa9@greensocs.com>
Date: Sat, 4 Feb 2017 13:52:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9J-F4bVONk_Yhafx3T6R2POW9=pAbLdY+5iW_R_fmBCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/5] execute code from mmio area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Mark Burton <mark.burton@greensocs.com>

On 02/04/2017 01:33 PM, Peter Maydell wrote:
> On 3 February 2017 at 17:06,  <fred.konrad@greensocs.com> wrote:
>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> This patch-set allows to execute code from mmio areas.
>> The main goal of this is to be able to run code for example from an SPI device.
>>
>> The three first patch fixes the way get_page_addr_code fills the TLB.
>>
>> The fourth patch implements the mmio execution helpers: the device must
>> implement the request_ptr callback of the MemoryRegion and will be notified when
>> the guest wants to execute code from it.
>>
>> The fifth patch implements the execution from the SPI memories in the
>> xilinx_spips model.
> 
> I like the general idea, but there's an awkward issue:
> at the moment our translation system assumes that when we're
> translating code then if the first instruction in the TB
> can be read OK then we won't ever get a fault trying to
> read subsequent bytes up to the end of the page. If we
> move from "we only translate code out of whole pages of
> RAM" to "we might translate code out of devices that
> are in subpages" then this assumption gets broken.
> (The symptom would be that we would report the fault
> in the wrong place, for the PC at the start of the TB.)
> 
> thanks
> -- PMM
> 

Hi Peter,

I think I see your point.
Is that the case that we might get a Bad RAM address error or some such
if we are not on a page boundary (or too small as you say)?
I guess this is a limitation. Mapping on a page boundary shouldn't be
too much restrictive.

Thanks,
Fred
