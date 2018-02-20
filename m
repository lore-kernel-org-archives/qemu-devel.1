Received: from eggs.gnu.org ([2001:4830:134:3::10]:54772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hlandau@devever.net>) id 1eo8m2-0003FG-Cm
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hlandau@devever.net>) id 1eo8lx-00087L-FT
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:20:02 -0500
Received: from umbriel.devever.net ([149.202.51.241]:34742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hlandau@devever.net>) id 1eo8lx-00086X-63
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:19:57 -0500
Date: Tue, 20 Feb 2018 14:19:54 +0000
From: Hugo Landau <hlandau@devever.net>
Message-ID: <20180220141954.GA5614@axminster>
References: <20180220132627.4163-1-hlandau@devever.net>
	<e13f6f08-c29a-2202-014c-1911181671e2@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13f6f08-c29a-2202-014c-1911181671e2@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] Fix ast2500 protection register emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org

> I also gave it a test on an OpenBMC romulus image. Looks fine, but that's 
> an old custom U-Boot. Which defconfig did you use for U-Boot HEAD ? 
evb-ast2500_defconfig.

FYI, these changes are necessary, but not sufficient to get u-boot HEAD
(or for that matter u-boot 2017.11, another version tested) running.

The other issues were
  - the tests
      while (!(readl(&regs->ecc_test_ctrl) & SDRAM_TEST_DONE));
    and
      while (!(readl(&info->regs->config) & SDRAM_CONF_CACHE_INIT_DONE));
    which appear in various places in the u-boot source and which spin
    forever. I made u-boot work by commenting these out in u-boot rather
    than patching qemu, not familiar enough with qemu to implement this.

  - the call to reset_assert in ast2500_sdrammc_probe seems to actually
    reset the machine rather than just initialize SDRAM as it is
    apparently supposed to, leading to an infinite cycle of resets.
    Couldn't quite figure out how it was supposed to work, so I
    commented this out, since obviously qemu doesn't actually have SDRAM
    initialization requirements.

The above changes plus this patch allowed u-boot to get to the u-boot
CLI. Haven't tried booting anything with it yet though.
