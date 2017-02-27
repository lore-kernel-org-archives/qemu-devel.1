Received: from eggs.gnu.org ([2001:4830:134:3::10]:39069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciQhF-0006o9-Q0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciQhC-0007av-I9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:10:57 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ciQhC-0007XL-9r
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:10:54 -0500
Received: by mail-qk0-x242.google.com with SMTP id n186so5671005qkb.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:10:52 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170227112219.29313-1-ebischoff@suse.com>
	<20170227112219.29313-2-ebischoff@suse.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <10570286-fa33-485a-0773-94ed493d4ef0@twiddle.net>
Date: Tue, 28 Feb 2017 06:10:45 +1100
MIME-Version: 1.0
In-Reply-To: <20170227112219.29313-2-ebischoff@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Adding support for LPD and LPDG
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Bischoff <ebischoff@suse.com>, Alexander Graf <agraf@suse.de>
Cc: Michal Marek <mmarek@suse.cz>, QEmu developers <qemu-devel@nongnu.org>, Miroslav Benes <mbenes@suse.cz>, Eric Bischoff <ebischoff@nerim.net>

On 02/27/2017 10:22 PM, Eric Bischoff wrote:
> From: Eric Bischoff <ebischoff@nerim.net>
>
> LPD = LOAD PAIR DISJOINT
> ---
>  target/s390x/insn-data.def |  4 +++-
>  target/s390x/translate.c   | 21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 075ff59..e427988 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -504,7 +504,9 @@
>      C(0xb9e2, LOCGR,   RRF_c, LOC, r1, r2, r1, 0, loc, 0)
>      C(0xebf2, LOC,     RSY_b, LOC, r1, m2_32u, new, r1_32, loc, 0)
>      C(0xebe2, LOCG,    RSY_b, LOC, r1, m2_64, r1, 0, loc, 0)
> -/* LOAD PAIR DISJOINT TODO */
> +/* LOAD PAIR DISJOINT */
> +    C(0xc804, LPD,     SSF,   ILA, m1_32s, m2_32s, 0, r3_P32, movx, zero)
> +    C(0xc805, LPDG,    SSF,   ILA, m1_64, m2_64, 0, r3_P64, movx, zero)

The think is, in order to be able to say that the two loads were interlocked, 
which is what you're doing with CC=0, we need to provide some atomicity.

In general, this is going to require that you check parallel_cpus, and if true, 
signal cpu_loop_exit_atomic.

As a special case, it would be possible to check for two loads that happen to 
be sequential and perform them as an atomic read.  Whether that happens often 
enough to be worthwhile I don't know.


r~
