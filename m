Received: from eggs.gnu.org ([2001:4830:134:3::10]:43916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFdUV-0002lw-Ic
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFdUU-0007Kk-4h
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:31:03 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFdUT-0007KG-TJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:31:02 -0400
Received: by mail-wm0-x22b.google.com with SMTP id b84so84284752wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:31:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170507002325.cg3rud5u5k5zqlsi@tha-monstah.mydomain>
References: <20170507002325.cg3rud5u5k5zqlsi@tha-monstah.mydomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 10:30:40 +0100
Message-ID: <CAFEAcA9tL_qru6CVLEsjdNSeNhs2_xZfdeydO5ePM_BEDarB7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] 'blank' address space for unknown arm peripherals?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marty Plummer <netz.kernel@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 May 2017 at 01:23, Marty Plummer <netz.kernel@gmail.com> wrote:
> Its my understanding that for creating machine definitions for qemu one
> uses what amount to 'drivers' or 'hardware simulations'. I was wondering
> if there was what amounted to a blank or raw memory area one could use
> as a placeholder for a peripheral which is currently undocumented and
> lacking source code for the linux kernel drivers the vendor ships.

We added the 'unimplemented-device' recently for this purpose:
code in hw/misc/unimp.c, example of use in hw/arm/stellaris.c
(calls to create_unimplemented_device()). NB that since by default
accesses to bits of the address space which don't have a device
will read-as-zero/writes-ignored, using this won't change the
behaviour at all, but unimplemented-device has tracing so that
if you use '-d unimp' on the QEMU command line it will print out
all the accesses the guest makes to these areas.

thanks
-- PMM
