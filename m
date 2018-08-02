Received: from eggs.gnu.org ([2001:4830:134:3::10]:44222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flGem-0005CU-KA
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flGel-000088-PO
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:40:56 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1flGel-00007z-Ix
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:40:55 -0400
Received: by mail-oi0-x242.google.com with SMTP id n21-v6so4860865oig.3
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 09:40:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <509a2c72-2e88-6961-6029-f373c78fe9b8@amsat.org>
References: <20180802144430.13870-1-peter.maydell@linaro.org>
	<20180802144430.13870-3-peter.maydell@linaro.org>
	<509a2c72-2e88-6961-6029-f373c78fe9b8@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Aug 2018 17:40:34 +0100
Message-ID: <CAFEAcA-qPHvx9PnZwYdpLDi4wBPL8MZywg3E0+pUU1PVdkTQ_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, "patches@linaro.org" <patches@linaro.org>

On 2 August 2018 at 16:58, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> Hopefully this is a good case to show the bug I'm having with
> access_with_adjusted_size().
>
> I agree with your change, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> However IMO little endian guest access is likely to fail.
>
> The bug I'm having looks like, we have BE data is 'aabbccdd', I expect
> 16-bit access @2 return 'ccdd' but returns 'bbaa' (IIRC).

Behaviour here is going to depend on (a) what the TARGET_ENDIANNESS
setting is for the system (b) whether the device is DEVICE_NATIVE_ENDIAN,
DEVICE_BIG_ENDIAN or DEVICE_LITTLE_ENDIAN (c) whether the guest
CPU is in "little endian" or "big endian" mode (if the guest CPU
architecture is bi-endian). I would not be surprised if device
models which were only ever expected to work with (say) big endian
MIPS didn't behave correctly when run with a little endian
MIPS OS, but that's usually an error in the device model and/or
its choice of .endianness in the memory region ops struct.

If there's something wrong with access_with_adjusted_size(),
I would suggest starting a different thread for that. I don't
think these changes should alter the behaviour of this device.

thanks
-- PMM
