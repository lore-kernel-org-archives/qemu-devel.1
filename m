Received: from eggs.gnu.org ([2001:4830:134:3::10]:51357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eoVNQ-0004Gm-2H
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eoVNK-00071k-WA
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:28:08 -0500
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:33302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eoVNK-0006uO-QX
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:28:02 -0500
Received: from player774.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id A223D13D1C0
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 15:27:53 +0100 (CET)
References: <20180220132627.4163-1-hlandau@devever.net>
	<e13f6f08-c29a-2202-014c-1911181671e2@kaod.org>
	<20180220141954.GA5614@axminster>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <53c1e0f5-9652-e5da-57fb-0447b301d4f5@kaod.org>
Date: Wed, 21 Feb 2018 15:27:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180220141954.GA5614@axminster>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Fix ast2500 protection register emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hugo Landau <hlandau@devever.net>
Cc: qemu-devel@nongnu.org

On 02/20/2018 03:19 PM, Hugo Landau wrote:
>> I also gave it a test on an OpenBMC romulus image. Looks fine, but that's 
>> an old custom U-Boot. Which defconfig did you use for U-Boot HEAD ? 
> evb-ast2500_defconfig.

ok

> FYI, these changes are necessary, but not sufficient to get u-boot HEAD
> (or for that matter u-boot 2017.11, another version tested) running.
> 
> The other issues were
>   - the tests
>       while (!(readl(&regs->ecc_test_ctrl) & SDRAM_TEST_DONE));
>     and
>       while (!(readl(&info->regs->config) & SDRAM_CONF_CACHE_INIT_DONE));
>     which appear in various places in the u-boot source and which spin
>     forever. I made u-boot work by commenting these out in u-boot rather
>     than patching qemu, not familiar enough with qemu to implement this.

This patch :

  https://github.com/openbmc/qemu/commit/4fb98fffd3115d8d3d0a16a1033f5335b5c0fd9b

fakes some more SDMC registers to let the SDRAM initialization run. you
might want to take a look at it.

Thanks,

C.  

>   - the call to reset_assert in ast2500_sdrammc_probe seems to actually
>     reset the machine rather than just initialize SDRAM as it is
>     apparently supposed to, leading to an infinite cycle of resets.
>     Couldn't quite figure out how it was supposed to work, so I
>     commented this out, since obviously qemu doesn't actually have SDRAM
>     initialization requirements.
> 
> The above changes plus this patch allowed u-boot to get to the u-boot
> CLI. Haven't tried booting anything with it yet though.
> 
