Received: from eggs.gnu.org ([2001:4830:134:3::10]:49235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFfqq-0002ZT-Rz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFfqq-0000hY-5Q
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:02:16 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFfqp-0000hU-VD
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:02:16 -0400
Received: by mail-wm0-x22e.google.com with SMTP id e127so97525875wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 05:02:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170525200537.GA12666@pacoca>
References: <mailman.73115.1495441935.22737.qemu-devel@nongnu.org>
	<BBC4E515-FE7D-4600-A5CA-BBCE26059415@gmail.com>
	<87efvghzb9.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170524023303.GA12163@pacoca> <20170525200537.GA12666@pacoca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 13:01:54 +0100
Message-ID: <CAFEAcA8wCfDuSbs-+o-D8Sogrfda_U6kSCH0x5SrAGfAiknYyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH risu] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: G 3 <programmingkidx@gmail.com>, Sandipan Das <sandipandas1990@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, aNikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 25 May 2017 at 21:05,  <joserz@linux.vnet.ibm.com> wrote:
> What do you think about sharing the same ppc64.risu file to ppc
> and ppc64/ppc64le. Then, instead of:
>
> <NAME> PPC64LE 01111...
>
> we'd have:
>
> <NAME> PPC 01111...
>
> So, specific instructions would be:
>
> <NAME> PPC64LE 01111...
> <NAME> PPC64 01111...
> <NAME> PPC32 01111...
>
> It will allow users to select the arch by using patterns like: ./risugen
> --pattern "PPC64*", or --pattern "PPC32*".

I think we should aim to share the files, but that we should
have a better mechanism than just a convention on the pattern
name (which is easy to make mistakes with and also makes it
harder to use the --pattern argument for the purpose it was
intended for, since you have to combine your desired pattern
with the pattern to select the right bit of the instruction set).
This isn't limited to PPC either -- for ARM we'd like to be
able to mark instructions as ARMv7/ARMv8/present in some
optional instruction set extension, etc.

We could perhaps do that with an optional field in the
lines in the risu file to mark what part of the instruction
set they're in, and a command line argument to select the
instruction set variant(s) desired.

Another possible approach would be to have the PPC32 insns
in their own file, and some sort of #include directive to
pull them into the PPC64 file.

This is all "adding extra features to risu", though, so I
don't insist it be done.

thanks
-- PMM
