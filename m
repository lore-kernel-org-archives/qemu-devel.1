Received: from eggs.gnu.org ([2001:4830:134:3::10]:37744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtLw-0004uJ-LH
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtLv-0005me-LT
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:19:16 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:35965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHtLv-0005m7-Gn
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:19:15 -0500
Received: by mail-ua0-x233.google.com with SMTP id 3so23844870uaz.3
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:19:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481894559-13974-2-git-send-email-marcin.krzeminski@nokia.com>
References: <1481894559-13974-1-git-send-email-marcin.krzeminski@nokia.com>
	<1481894559-13974-2-git-send-email-marcin.krzeminski@nokia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 14:18:54 +0000
Message-ID: <CAFEAcA-ODRCg1t=6iFBE5oue8X5GSHDXYWV2uy6sFttE8_tG6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 1/3] nvic: Add CPU numebr property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Krzeminski, Marcin (Nokia - PL/Wroclaw)" <marcin.krzeminski@nokia.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, rfsw-patches@mlist.nokia.com

On 16 December 2016 at 13:22,  <marcin.krzeminski@nokia.com> wrote:
> From: Marcin Krzeminski <marcin.krzeminski@nokia.com>
>
> In case of MultiCPU SoC M3 is not always CPU0.
> This commit add cpu_id property to allow set CPU
> number for NVIC model. Also address space that this used
> by NVIC is updated to mach CPU's one.
>
> Signed-off-by: Marcin Krzeminski <marcin.krzeminski@nokia.com>

The right fix for this I think is probably for the NVIC to
have an actual pointer to its CPU object, which the armv7m_init
code sets up (perhaps with QOM links?) when it creates the CPU
and the NVIC. The two really do need to be closely coupled,
and the CPU already has a pointer to its NVIC. There's
no need for the NVIC to get the CPU pointer by looking it up
by CPU ID.

Once I've got the GICv3 virtualization out of the way, the
next thing on my todo list is to pick up the NVIC refactoring
that Michael Davidsaver posted last year:
 https://lists.nongnu.org/archive/html/qemu-devel/2015-12/msg00504.html
which makes some moves in that direction (though it doesn't
init the NVIC's CPU pointer with a link, it just assumes
first_cpu).

thanks
-- PMM
