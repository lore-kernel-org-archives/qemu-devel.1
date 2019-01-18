Received: from eggs.gnu.org ([209.51.188.92]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkVhb-00085U-4g
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkVha-0005tg-92
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:04:59 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gkVhW-0005TR-M9
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:04:56 -0500
Received: by mail-wm1-x341.google.com with SMTP id p6so4797537wmc.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 07:04:41 -0800 (PST)
References: <20190116170114.26802-1-cota@braap.org>
	<20190116170114.26802-4-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190116170114.26802-4-cota@braap.org>
Date: Fri, 18 Jan 2019 15:04:38 +0000
Message-ID: <87y37ixb09.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 3/3] tcg/i386: enable dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> As the following experiments show, this series is a net perf gain,
> particularly for memory-heavy workloads. Experiments are run on an
> Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.
>
> 1. System boot + shudown, debian aarch64:
>
> - Before (v3.1.0):
>  Performance counter stats for './die.sh v3.1.0' (10 runs):
>
>        9019.797015      task-clock (msec)         #    0.993 CPUs utilize=
d            ( +-  0.23% )
>     29,910,312,379      cycles                    #    3.316 GHz         =
             ( +-  0.14% )
>     54,699,252,014      instructions              #    1.83  insn per cyc=
le           ( +-  0.08% )
>     10,061,951,686      branches                  # 1115.541 M/sec       =
             ( +-  0.08% )
>        172,966,530      branch-misses             #    1.72% of all branc=
hes          ( +-  0.07% )
>
>        9.084039051 seconds time elapsed                                  =
        ( +-  0.23% )
>
> - After:
>  Performance counter stats for './die.sh tlb-dyn-v5' (10 runs):
>
>        8624.084842      task-clock (msec)         #    0.993 CPUs utilize=
d            ( +-  0.23% )
>     28,556,123,404      cycles                    #    3.311 GHz         =
             ( +-  0.13% )
>     51,755,089,512      instructions              #    1.81  insn per cyc=
le           ( +-  0.05% )
>      9,526,513,946      branches                  # 1104.641 M/sec       =
             ( +-  0.05% )
>        166,578,509      branch-misses             #    1.75% of all branc=
hes          ( +-  0.19% )
>
>        8.680540350 seconds time elapsed                                  =
        ( +-  0.24% )
>
> That is, a 4.4% perf increase.
>
> 2. System boot + shutdown, ubuntu 18.04 x86_64:
>
> - Before (v3.1.0):
>       56100.574751      task-clock (msec)         #    1.016 CPUs utilize=
d            ( +-  4.81% )
>    200,745,466,128      cycles                    #    3.578 GHz         =
             ( +-  5.24% )
>    431,949,100,608      instructions              #    2.15  insn per cyc=
le           ( +-  5.65% )
>     77,502,383,330      branches                  # 1381.490 M/sec       =
             ( +-  6.18% )
>        844,681,191      branch-misses             #    1.09% of all branc=
hes          ( +-  3.82% )
>
>       55.221556378 seconds time elapsed                                  =
        ( +-  5.01% )
>
> - After:
>       56603.419540      task-clock (msec)         #    1.019 CPUs utilize=
d            ( +- 10.19% )
>    202,217,930,479      cycles                    #    3.573 GHz         =
             ( +- 10.69% )
>    439,336,291,626      instructions              #    2.17  insn per cyc=
le           ( +- 14.14% )
>     80,538,357,447      branches                  # 1422.853 M/sec       =
             ( +- 16.09% )
>        776,321,622      branch-misses             #    0.96% of all branc=
hes          ( +-  3.77% )
>
>       55.549661409 seconds time elapsed                                  =
        ( +- 10.44% )
>
> No improvement (within noise range). Note that for this workload,
> increasing the time window too much can lead to perf degradation,
> since it flushes the TLB *very* frequently.

I would expect this to be fairly minimal in the amount of memory that is
retouched. We spend a bunch of time paging things in just to drop
everything and die. However heavy memory operations like my build stress
test do see a performance boost.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Do you have access to any aarch64 hardware? It would be nice to see if
we could support it there as well.

--
Alex Benn=C3=A9e
