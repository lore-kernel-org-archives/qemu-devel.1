Received: from eggs.gnu.org ([2001:4830:134:3::10]:43479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYfcw-0000eo-QM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYfct-0002lP-Lo
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:38:26 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dYfct-0002kG-Cz
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:38:23 -0400
Received: by mail-pf0-x241.google.com with SMTP id q85so5613886pfq.2
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:38:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-5-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <611ac916-1695-2f82-3874-c07330f09c8c@twiddle.net>
Date: Fri, 21 Jul 2017 11:38:14 -1000
MIME-Version: 1.0
In-Reply-To: <1500616763-26560-5-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 42/43] tcg: introduce regions to split
 code_gen_buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/20/2017 07:59 PM, Emilio G. Cota wrote:
> This is groundwork for supporting multiple TCG contexts.
> 
> The naive solution here is to split code_gen_buffer statically
> among the TCG threads; this however results in poor utilization
> if translation needs are different across TCG threads.
> 
> What we do here is to add an extra layer of indirection, assigning
> regions that act just like pages do in virtual memory allocation.
> (BTW if you are wondering about the chosen naming, I did not want
> to use blocks or pages because those are already heavily used in QEMU).
> 
> We use a global lock to serialize allocations as well as statistics
> reporting (we now export the size of the used code_gen_buffer with
> tcg_code_size()). Note that for the allocator we could just use
> a counter and atomic_inc; however, that would complicate the gathering
> of tcg_code_size()-like stats. So given that the region operations are
> not a fast path, a lock seems the most reasonable choice.
> 
> The effectiveness of this approach is clear after seeing some numbers.
> I used the bootup+shutdown of debian-arm with '-tb-size 80' as a benchmark.
> Note that I'm evaluating this after enabling per-thread TCG (which
> is done by a subsequent commit).
> 
> * -smp 1, 1 region (entire buffer):
>      qemu: flush code_size=83885014 nb_tbs=154739 avg_tb_size=357
>      qemu: flush code_size=83884902 nb_tbs=153136 avg_tb_size=363
>      qemu: flush code_size=83885014 nb_tbs=152777 avg_tb_size=364
>      qemu: flush code_size=83884950 nb_tbs=150057 avg_tb_size=373
>      qemu: flush code_size=83884998 nb_tbs=150234 avg_tb_size=373
>      qemu: flush code_size=83885014 nb_tbs=154009 avg_tb_size=360
>      qemu: flush code_size=83885014 nb_tbs=151007 avg_tb_size=370
>      qemu: flush code_size=83885014 nb_tbs=151816 avg_tb_size=367
> 
> That is, 8 flushes.
> 
> * -smp 8, 32 regions (80/32 MB per region) [i.e. this patch]:
> 
>      qemu: flush code_size=76328008 nb_tbs=141040 avg_tb_size=356
>      qemu: flush code_size=75366534 nb_tbs=138000 avg_tb_size=361
>      qemu: flush code_size=76864546 nb_tbs=140653 avg_tb_size=361
>      qemu: flush code_size=76309084 nb_tbs=135945 avg_tb_size=375
>      qemu: flush code_size=74581856 nb_tbs=132909 avg_tb_size=375
>      qemu: flush code_size=73927256 nb_tbs=135616 avg_tb_size=360
>      qemu: flush code_size=78629426 nb_tbs=142896 avg_tb_size=365
>      qemu: flush code_size=76667052 nb_tbs=138508 avg_tb_size=368
> 
> Again, 8 flushes. Note how buffer utilization is not 100%, but it
> is close. Smaller region sizes would yield higher utilization,
> but we want region allocation to be rare (it acquires a lock), so
> we do not want to go too small.
> 
> * -smp 8, static partitioning of 8 regions (10 MB per region):
>      qemu: flush code_size=21936504 nb_tbs=40570 avg_tb_size=354
>      qemu: flush code_size=11472174 nb_tbs=20633 avg_tb_size=370
>      qemu: flush code_size=11603976 nb_tbs=21059 avg_tb_size=365
>      qemu: flush code_size=23254872 nb_tbs=41243 avg_tb_size=377
>      qemu: flush code_size=28289496 nb_tbs=52057 avg_tb_size=358
>      qemu: flush code_size=43605160 nb_tbs=78896 avg_tb_size=367
>      qemu: flush code_size=45166552 nb_tbs=82158 avg_tb_size=364
>      qemu: flush code_size=63289640 nb_tbs=116494 avg_tb_size=358
>      qemu: flush code_size=51389960 nb_tbs=93937 avg_tb_size=362
>      qemu: flush code_size=59665928 nb_tbs=107063 avg_tb_size=372
>      qemu: flush code_size=38380824 nb_tbs=68597 avg_tb_size=374
>      qemu: flush code_size=44884568 nb_tbs=79901 avg_tb_size=376
>      qemu: flush code_size=50782632 nb_tbs=90681 avg_tb_size=374
>      qemu: flush code_size=39848888 nb_tbs=71433 avg_tb_size=372
>      qemu: flush code_size=64708840 nb_tbs=119052 avg_tb_size=359
>      qemu: flush code_size=49830008 nb_tbs=90992 avg_tb_size=362
>      qemu: flush code_size=68372408 nb_tbs=123442 avg_tb_size=368
>      qemu: flush code_size=33555560 nb_tbs=59514 avg_tb_size=378
>      qemu: flush code_size=44748344 nb_tbs=80974 avg_tb_size=367
>      qemu: flush code_size=37104248 nb_tbs=67609 avg_tb_size=364
> 
> That is, 20 flushes. Note how a static partitioning approach uses
> the code buffer poorly, leading to many unnecessary flushes.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   tcg/tcg.h                 |   6 ++
>   accel/tcg/translate-all.c |  63 +++++--------
>   bsd-user/main.c           |   1 +
>   cpus.c                    |  12 +++
>   linux-user/main.c         |   1 +
>   tcg/tcg.c                 | 222 +++++++++++++++++++++++++++++++++++++++++++++-
>   6 files changed, 260 insertions(+), 45 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>

r~
