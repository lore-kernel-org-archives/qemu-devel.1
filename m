Received: from eggs.gnu.org ([2001:4830:134:3::10]:51359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flH5s-0003bF-G0
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flH5r-0007TK-Ep
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:08:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180802144430.13870-1-peter.maydell@linaro.org>
	<20180802144430.13870-3-peter.maydell@linaro.org>
	<509a2c72-2e88-6961-6029-f373c78fe9b8@amsat.org>
	<CAFEAcA-qPHvx9PnZwYdpLDi4wBPL8MZywg3E0+pUU1PVdkTQ_w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <36265605-cea1-e1cb-ab1c-3aea4b2973e6@amsat.org>
Date: Thu, 2 Aug 2018 14:08:28 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qPHvx9PnZwYdpLDi4wBPL8MZywg3E0+pUU1PVdkTQ_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/ppc/ppc_boards: Don't use old_mmio
 for ref405ep_fpga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, "patches@linaro.org" <patches@linaro.org>

On 08/02/2018 01:40 PM, Peter Maydell wrote:
> On 2 August 2018 at 16:58, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hopefully this is a good case to show the bug I'm having with
>> access_with_adjusted_size().
>>
>> I agree with your change, so:
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> However IMO little endian guest access is likely to fail.
>>
>> The bug I'm having looks like, we have BE data is 'aabbccdd', I expect
>> 16-bit access @2 return 'ccdd' but returns 'bbaa' (IIRC).
> 
> Behaviour here is going to depend on (a) what the TARGET_ENDIANNESS
> setting is for the system (b) whether the device is DEVICE_NATIVE_ENDIAN,
> DEVICE_BIG_ENDIAN or DEVICE_LITTLE_ENDIAN (c) whether the guest
> CPU is in "little endian" or "big endian" mode (if the guest CPU
> architecture is bi-endian). I would not be surprised if device
> models which were only ever expected to work with (say) big endian
> MIPS didn't behave correctly when run with a little endian
> MIPS OS, but that's usually an error in the device model and/or
> its choice of .endianness in the memory region ops struct.
> 
> If there's something wrong with access_with_adjusted_size(),
> I would suggest starting a different thread for that. I don't
> think these changes should alter the behaviour of this device.

Sure, I'll do when I continue to work on this.

I started my mail with "Hi Peter" but the access_with_adjusted_size()
comments were directed to the PPC reviewers, I'll reword to be more
explicit.

PPC reviewers: watch out I'm hitting an issue on MIPS boards when using
bi-endian cpu in little-endian configuration, and accessing big-endian
ordered devices (usually when .valid access size is bigger than device
.impl). I don't know how to test this with PPC images.
This patch as it looks correct to me, but since now
access_with_adjusted_size() is involved, it might trigger the previous
described issue.

Regards,

Phil.
