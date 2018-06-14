Received: from eggs.gnu.org ([2001:4830:134:3::10]:45859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTZO7-0004a9-Ii
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTZO4-0001VN-H5
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:02:35 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:47025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTZO4-0001UD-3E
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:02:32 -0400
Received: by mail-pl0-x241.google.com with SMTP id 30-v6so4175561pld.13
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 14:02:31 -0700 (PDT)
References: <20180614105323.22524-1-mark.cave-ayland@ilande.co.uk>
	<20180614105323.22524-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc94cc82-5894-5c3b-2f86-b84d6920fb1a@linaro.org>
Date: Thu, 14 Jun 2018 11:02:26 -1000
MIME-Version: 1.0
In-Reply-To: <20180614105323.22524-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFCv2 PATCH 1/1] SPARC64: add icount support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com, cota@braap.org

On 06/14/2018 12:53 AM, Mark Cave-Ayland wrote:
> +                        if (dc->base.tb->cflags & CF_USE_ICOUNT) {
> +                            gen_io_start();
> +                        }

Need to use tb_cflags(dc->base.tb) for the atomic_read therein.


> +                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
> +                                        gen_io_end();
> +                                        /* End TB to handle timer interrupt */
> +                                        save_state(dc);
> +                                        gen_op_next_insn();
> +                                        tcg_gen_exit_tb(NULL, 0);
> +                                        dc->base.is_jmp = DISAS_NORETURN;
> +                                    }

Exiting the TB should not be dependent on icount.

I would encourage you to introduce e.g. DISAS_EXIT, and code to handle that in
sparc_tr_tb_stop, to avoid replicating this pattern so many times.


r~
