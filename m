Received: from eggs.gnu.org ([2001:4830:134:3::10]:46917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNgFI-0003uv-P4
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNgFH-00021D-PI
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:09:08 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNgFH-00020e-Im
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:09:07 -0400
Received: by mail-oi0-x243.google.com with SMTP id 11-v6so13344341ois.8
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 08:09:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180528061154.25367-1-f4bug@amsat.org>
References: <20180528061154.25367-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 16:08:46 +0100
Message-ID: <CAFEAcA_ob6mHqfAAM9iAMae5vfxaYhmcqkk-gJH+s1mHuvFp8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/misc/unimp: Add
 create_unimplemented_subregion_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alexey Korolev <akorolex@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 28 May 2018 at 07:11, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> The create_unimplemented_device() function is very useful to
> register unimplemented devices to the SysBus 'absolute' address.
>
> Some devices are modelled as container of memory subregions,
> the subregions being mmio-mapped relatively to the container
> base address.
>
> With these container devices, the current create_unimplemented_device()
> does not work.
> Add a function to remove the current limitation, and allow
> containerized devices to use the helpful UnimplementedDevice.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> I don't like the function name much, I first tried with
> create_unimplemented_device_mr() :( Would it be cleaner renaming current
> create_unimplemented_device() -> create_unimplemented_sysbus_device()?
>
> Also, is this useful to have this code inlined?

My experience has been that devices that want to map the
unimplemented device into some other container probably
also want to do in-place initialization rather than using
qdev_create() -- eg hw/arm/iotkit.c which directly creates
TYPE_UNIMPLEMENTED_DEVICEs which are embedded in its state
struct.

It was always the intention that you can create a
TYPE_UNIMPLEMENTED_DEVICE directly; create_unimplemented_device()
is just a convenience wrapper.

I'm not opposed to having another convenience wrapper here;
but I'm not sure this is the right API for one (ie if it
would be used in very many places).

thanks
-- PMM
