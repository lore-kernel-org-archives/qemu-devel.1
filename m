Received: from eggs.gnu.org ([2001:4830:134:3::10]:47477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8MRW-0001qv-KE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8MLe-0008Iq-Ip
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:24:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8MLe-0008HE-D6
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:24:38 -0400
Date: Fri, 5 Oct 2018 11:24:35 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181005092435.4i2er4khtq3gwqtm@sirius.home.kraxel.org>
References: <20180927155538.699-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927155538.699-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] hw/display/qxl: Suppress clang-7 warning
 about misaligned atomic operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Thu, Sep 27, 2018 at 04:55:38PM +0100, Peter Maydell wrote:
> If QEMU is compiled with clang-7 it results in the warning:
> 
> hw/display/qxl.c:1884:19: error: misaligned or large atomic operation
> may incur significant performance penalty [-Werror,-Watomic-alignment]
>     old_pending = atomic_fetch_or(&d->ram->int_pending, le_events);
>                   ^
> 
> This is because the Spice headers forgot to define the QXLRam struct
> with the '__aligned__(4)' attribute.  clang 7 and newer will thus
> warn that the access here to int_pending might not be 4-aligned
> (because the QXLRam object d->ram points at might start at a
> misaligned address).  In fact we set up d->ram in init_qxl_ram() so
> it always starts at a 4K boundary, so we know the atomic access here
> is OK.
> 
> Newer Spice versions (with Spice commit
> beda5ec7a6848be20c0cac2a9a8ef2a41e8069c1) will fix the bug;
> for older Spice versions, work around it by telling the compiler
> explicitly that the alignment is OK using __builtin_assume_aligned().

Added to vga queue.

cheers,
  Gerd
