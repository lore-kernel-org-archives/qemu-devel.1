Received: from eggs.gnu.org ([2001:4830:134:3::10]:57341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dW3lF-0007Zv-BR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dW3lC-0000UT-AM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:48:13 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:33296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dW3lC-0000UI-5G
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:48:10 -0400
Received: by mail-qk0-x231.google.com with SMTP id a66so66075499qkb.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:48:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
	<150002073981.22386.9870422422367410100.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <01ac89ab-c7b0-3ada-b8bf-9f033cf90f15@twiddle.net>
Date: Fri, 14 Jul 2017 06:48:02 -1000
MIME-Version: 1.0
In-Reply-To: <150002073981.22386.9870422422367410100.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 03/26] target: [tcg] Add generic
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
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 07/13/2017 10:25 PM, Lluís Vilanova wrote:
> +        /* Pass breakpoint hits to target for further processing */
> +        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
> +            CPUBreakpoint *bp;
> +            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
> +                if (bp->pc == db->pc_next) {
> +                    if (ops->breakpoint_check(db, cpu, bp)) {
> +                        break;
> +                    }
> +                }
> +            }
> +
> +            if (db->is_jmp == DISAS_NORETURN) {
> +                break;
> +            }
> +        }

You should accept any != DISAS_NEXT value here.
(1) Because DISAS_NEXT == 0 and it's the quickest test, and
(2) If you *require* NORETURN here, then you've also got to
convert some of the backends to not use DISAS_TARGET_N, which
as of [07/26] target/i386: [tcg] Port to breakpoint_check, I
haven't seen happen.


r~
