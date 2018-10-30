Received: from eggs.gnu.org ([2001:4830:134:3::10]:44139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gHchF-0000aa-1G
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gHch9-00083r-J2
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:41:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:49998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gHch9-00080W-4F
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:41:07 -0400
Date: Tue, 30 Oct 2018 23:40:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20181030170353.7447-1-peter.maydell@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1810302325120.3213@zero.eik.bme.hu>
References: <20181030170353.7447-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/ppc/ppc440_uc: Remove dead code
 in sdram_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Tue, 30 Oct 2018, Peter Maydell wrote:
> Coverity points out in CID 1390588 that the test for sh == 0
> in sdram_size() can never fire, because we calculate sh with
>    sh = 1024 - ((bcr >> 6) & 0x3ff);
> which must result in a value between 1 and 1024 inclusive.
>
> Without the relevant manual for the SoC, we're not completely
> sure of the correct behaviour here, but we can remove the
> dead code without changing how QEMU currently behaves.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We had a discussion about this coverity error a while back:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg05187.html
> I'd just like to squash the Coverity warning, I think.

As I told back then, feel free to go ahead and avoid the warning if it's 
in your way.

As for the proper fix, I'm still not sure how it works on real SoC but the 
current formula is likely wrong and this U-Boot commit may provide some 
hints instead:

https://git.denx.de/?p=u-boot.git;a=commitdiff;h=8ac41e3e37c3080c6b1d9461d654161cfe2aa492

Here RAM sizes are encoded in some strange way and I think this function 
(and the ppc460ex_sdram_bank_sizes array in sam460ex.c) might need to be 
changed to work according to this but I don't get this enough to be able 
to write a patch that I'm confident won't break anything else. (Also this 
is the reason why RAM size is limited to 1GB on the sam460ex emulation 
currently so fixing this would also allow RAM up to 4 GB as on real 
hardware.)

If this makes more sense to someone or there's someone who knows how it 
works on the 460EX SoC, help is appreciated as I likely won't be able to 
spend enough time to try to understand and fix this based on just the 
U-Boot source without more proper docs anytime soon.

Regards,
BALATON Zoltan

> hw/ppc/ppc440_uc.c | 6 +-----
> 1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 09ccda548f3..9360f781cef 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -559,11 +559,7 @@ static target_ulong sdram_size(uint32_t bcr)
>     int sh;
>
>     sh = 1024 - ((bcr >> 6) & 0x3ff);
> -    if (sh == 0) {
> -        size = -1;
> -    } else {
> -        size = 8 * MiB * sh;
> -    }
> +    size = 8 * MiB * sh;
>
>     return size;
> }
>
