Received: from eggs.gnu.org ([2001:4830:134:3::10]:59781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTaQk-0005l6-Sm
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTaQh-0003Kw-Gu
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:09:22 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35527
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fTaQh-0003IT-91
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:09:19 -0400
References: <20180614105323.22524-1-mark.cave-ayland@ilande.co.uk>
	<20180614105323.22524-2-mark.cave-ayland@ilande.co.uk>
	<bc94cc82-5894-5c3b-2f86-b84d6920fb1a@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3ab4d967-a930-4d61-1442-431114f9f1ea@ilande.co.uk>
Date: Thu, 14 Jun 2018 23:09:07 +0100
MIME-Version: 1.0
In-Reply-To: <bc94cc82-5894-5c3b-2f86-b84d6920fb1a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com, cota@braap.org

On 14/06/18 22:02, Richard Henderson wrote:

> On 06/14/2018 12:53 AM, Mark Cave-Ayland wrote:
>> +                        if (dc->base.tb->cflags & CF_USE_ICOUNT) {
>> +                            gen_io_start();
>> +                        }
> 
> Need to use tb_cflags(dc->base.tb) for the atomic_read therein.
> 
> 
>> +                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
>> +                                        gen_io_end();
>> +                                        /* End TB to handle timer interrupt */
>> +                                        save_state(dc);
>> +                                        gen_op_next_insn();
>> +                                        tcg_gen_exit_tb(NULL, 0);
>> +                                        dc->base.is_jmp = DISAS_NORETURN;
>> +                                    }
> 
> Exiting the TB should not be dependent on icount.
> 
> I would encourage you to introduce e.g. DISAS_EXIT, and code to handle that in
> sparc_tr_tb_stop, to avoid replicating this pattern so many times.

Okay thanks for the feedback. I've made the changes and will post a v3 
shortly.

I still see the "WARNING: Time of Day clock error" messages on the 
console when booting Milax with icount enabled, although I'm inclined to 
merge this if you're happy with the patch as it is a definite improvement.


ATB,

Mark.
