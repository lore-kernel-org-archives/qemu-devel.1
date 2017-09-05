Received: from eggs.gnu.org ([2001:4830:134:3::10]:41649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpHMC-0002YH-R8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpHM8-00014O-6c
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:09:48 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpHM7-00013N-Vn
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:09:44 -0400
Received: by mail-wm0-x232.google.com with SMTP id i145so21832120wmf.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:09:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d80ba882-c00a-f10b-b8bc-8f6383e8cb74@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-11-git-send-email-peter.maydell@linaro.org>
	<b59d3474-15e4-7f01-d4d7-8ca0fcfef6b5@linaro.org>
	<CAFEAcA_F-oRO0vT4d62G1vat9o0o9exPKfEXw_BykXnXZJEYgQ@mail.gmail.com>
	<d80ba882-c00a-f10b-b8bc-8f6383e8cb74@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 18:09:22 +0100
Message-ID: <CAFEAcA-dc7fmyTqsSswOgDj0kQ6BT5FLb4nz10MDibP6KYJAqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/20] nvic: Add NS alias SCS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 September 2017 at 17:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 09/05/2017 09:26 AM, Peter Maydell wrote:
>> We don't map the hole. The container is 0x21000 in size, the normal
>> nvic_sysregs region is 0x1000 at offset 0x0 (which will be 0xe000e000
>> in the system address space), and the NS alias region
>> is 0x1000 at offset 0x20000 (0xe002e000 in the system address space).
>> There's nothing mapped in the hole in the container, so accesses
>> there will busfault, as they will for other PPB accesses before or
>> after the SCSes.
>
> Ok, it's not wrong, but I still don't understand the need for the container.

It lets us assemble all the parts of this bit of the address space --
SCS, systick (which sits on top of some of the SCS), NS SCS --
in the right place, rather than requiring any caller that wants
to instantiate an NVIC to do it (and to check whether the cpu
has the security extension to figure out whether the NS alias
exists, and so on).

Now that we've QOMified hw/arm/armv7m.c it's less important that
the NVIC in particular does that, and it's partly historical legacy
that most of this is done in the NVIC realize function rather than
in armv7m_instance_init() (we used to implement systick directly
in the NVIC source file rather than as its own device). It doesn't
seem worth shuffling the code around now, though (the container
already existed prior to this patch, we're just making it a bit
bigger and adding another thing to it.)

thanks
-- PMM
