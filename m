Received: from eggs.gnu.org ([2001:4830:134:3::10]:35626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNgg-0002Ar-1b
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNga-0001NE-9x
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:28:58 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:44629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezNga-0001N3-3w
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:28:52 -0400
Received: by mail-oi0-x236.google.com with SMTP id j143-v6so1538453oih.11
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 07:28:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ebf41b29-24e1-2f51-e382-22b34260cb34@redhat.com>
References: <1521794165-31678-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-KEnE9NKGC-vTnMByFC_LDPt2Ae8G7GfOxakfgMGH90w@mail.gmail.com>
	<6750673e-ffc3-578e-e867-332ac0790935@redhat.com>
	<CAFEAcA_u3cKF1aSHbrjW0Hc403G5GkNNom_9mqkJfregfqMymw@mail.gmail.com>
	<173b1d18-720a-4f61-29cf-4f812b78cb2e@redhat.com>
	<CAFEAcA_HaC6yjX7wW0MscxfiEafFT2uhMiWeN644NTYADhdEnQ@mail.gmail.com>
	<ebf41b29-24e1-2f51-e382-22b34260cb34@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 14:28:31 +0000
Message-ID: <CAFEAcA8ga2WjKcj=3ercfgC+wATk_jc2tEpQ48-r-OhoMUpzPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/riscv: Fix crashes with
 "-nodefaults"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 23 March 2018 at 14:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 23/03/2018 15:04, Peter Maydell wrote:
>>> However, if the machine is emulating a real-world board with a fixed SoC
>>> and fixed hardware in the SoC, it makes more sense to create a null backend.
>>
>> That's a lot of duplicate code to say "oh, this is NULL, create the
>> null backend" in lots of different boards :-(
>
> Note it's a null "backend", not necessarily a null "character device".
> Your proposal, namely ensuring that be->chr == NULL is handled properly
> in qemu_chr_fe_init, would be just fine.

Hmm, the chardev layer code seems to have more ends than I expect.
The "frontend" is the UART model, right, and I thought the
"backend" was the TCP/UDP/serial port/stdio/etc end of things,
but those seem to be Chardevs? If those aren't the backend,
then what is?

What I'd like, anyway, is that every UART model can cope with being
setup with a NULL 'chardev' property, and ideally that that doesn't
require a lot of extra code per-UART, and doesn't require each UART
to create a TYPE_CHARDEV_NULL.

> The main point was that the choice of whether to create the device is up
> to the board, and there isn't a single answer valid for all boards.

I agree with that part, yes, assuming I have the terminology right now.

thanks
-- PMM
