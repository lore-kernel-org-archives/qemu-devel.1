Received: from eggs.gnu.org ([2001:4830:134:3::10]:51590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8zi-0003lf-LR
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8zh-0007s1-Hm
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:50:34 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8zh-0007rl-C4
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:50:33 -0500
Received: by mail-pf0-x242.google.com with SMTP id f144so12649496pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:50:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <148294246378.10801.8881527920302104439.stgit@fimbulvetr.bsc.es>
	<148294248013.10801.9410215722238543688.stgit@fimbulvetr.bsc.es>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5036a178-60eb-814a-5873-f82ed3453a82@twiddle.net>
Date: Tue, 10 Jan 2017 18:50:30 -0800
MIME-Version: 1.0
In-Reply-To: <148294248013.10801.9410215722238543688.stgit@fimbulvetr.bsc.es>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 3/6] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 12/28/2016 08:28 AM, Lluís Vilanova wrote:
> +typedef enum DisasJumpType {
> +    DJ_NEXT,
> +    DJ_TOO_MANY,
> +    DJ_TARGET,
> +} DisasJumpType;

I wonder if enums like DJ_TARGET_{0..N} wouldn't be better, rather than doing 
addition in the target-specific names.

> +typedef struct DisasContextBase {
> +    TranslationBlock *tb;
> +    bool singlestep_enabled;
> +    target_ulong pc_first;
> +    target_ulong pc_next;
> +    DisasJumpType jmp_type;
> +    unsigned int num_insns;
> +} DisasContextBase;

Sort the bool to the end to minimize padding.

> +/* Get first breakpoint matching a PC */
> +static inline CPUBreakpoint *cpu_breakpoint_get(CPUState *cpu, vaddr pc,
> +                                                CPUBreakpoint *bp)
> +{
> +    if (likely(bp == NULL)) {
> +        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
> +            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
> +                if (bp->pc == pc) {
> +                    return bp;
> +                }
> +            }
> +        }
> +    } else {
> +        QTAILQ_FOREACH_CONTINUE(bp, entry) {
> +            if (bp->pc == pc) {
> +                return bp;
> +            }
> +        }
> +    }
> +    return NULL;
> +}

Any reason not to put the QTAILQ_FOREACH directly into gen_intermediate_code, 
rather than indirect it like this?  I don't see this abstraction as an improvement.


r~
