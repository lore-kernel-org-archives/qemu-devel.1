Received: from eggs.gnu.org ([2001:4830:134:3::10]:56109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTlnb-0001Hg-99
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTlna-0007xi-HX
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:17:43 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTlna-0007xG-Cg
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:17:42 -0400
Received: by mail-ot0-x242.google.com with SMTP id d19-v6so10414663oti.8
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 03:17:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611171007.4165-1-peter.maydell@linaro.org>
References: <20180611171007.4165-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 11:17:21 +0100
Message-ID: <CAFEAcA_gc_5WZZbRrYCt7xUo1C-TKbyoWzhWX0Rwd1f=wtc85g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] Add ldn_*_p() and stn_*_p() and use
 them in exec.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 11 June 2018 at 18:10, Peter Maydell <peter.maydell@linaro.org> wrote:
> There's a common pattern in QEMU where a function needs to perform
> a data load or store of an N byte integer in a particular endianness.
> At the moment this is handled by doing a switch() on the size and
> calling the appropriate ld*_p or st*_p function for each size.
>
> This patchset provides a new family of functions ldn_*_p() and stn_*_p()
> which take the size as an argument and do the switch() themselves,
> and uses them in 5 callsites in exec.c.
>
> If people like the idea, naming convention, etc, we can look for
> and convert other callsites, extend this to eg an address_space_ldn()
> and address_space_stn() (sample use cases in watch_mem_read(),
> watch_mem_write(), dino_chip_write_with_attrs(), tx_ppc_read(),
> tx_ppc_write()...)
>
> Patch 2 here fixes an apparently unintentional sign-extension in
> subpage_read(), so that patch 3 is a no-behaviour-change patch.
>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   bswap: Add new stn_*_p() and ldn_*_p() memory access functions
>   exec.c: Don't accidentally sign-extend 4-byte loads in subpage_read()
>   exec.c: Use stn_p() and ldn_p() instead of explicit switches

Thanks for the review; I plan to put these into target-arm.next
(with the silly typo fixed). I have another series brewing which
depends on this one, so having them in-tree will reduce the
dependencies there.

thanks
-- PMM
