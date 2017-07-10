Received: from eggs.gnu.org ([2001:4830:134:3::10]:52279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUVM0-00027x-S6
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUVLw-0000ko-V2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:51:44 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUVLw-0000kD-N9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:51:40 -0400
Received: by mail-wr0-f181.google.com with SMTP id 77so131036590wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 02:51:40 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-1-git-send-email-cota@braap.org>
Date: Mon, 10 Jul 2017 10:50:37 +0100
Message-ID: <87wp7gaadu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/22] tcg: per-thread TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Original RFC here:
>   https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg06874.html
>
> I included Richard's feedback (Thanks!) from the original RFC, and
> added quite a few things. This is now a proper PATCHset since it is
> a lot more mature.
>
> Highlights:
> - It works! I tested single/multi-threaded arm, aarch64 and alpha softmmu
>   with various -smp's (up to 120 on aarch64) and -tb-size's.
>   Also tested x86_64-linux-user with multi-threaded code. valgrind's
>   drd shows no obvious issues (it doesn't swallow C11 atomics, so it
>   spits out a lot of false positives though). Have not tested on a
>   non-x86 host, but given the audit I did of global non-const variables
>   (see commit message in patch 21), it should be OK.

It would be really nice if we could get ThreadSanitizer to support our
setcontext() co-routines. It was very useful during the original MTTCG
work and is a lot faster than Valgrind. There was some discussion on the
sanitizer lists and a basic plan of what is needed is known but its
unlikely to get done by the project itself.

>
> - Region-based allocation to maximize code_gen_buffer utilization.
>   See patch 20.
>
> - Patches 1-8 are unrelated fixes, but I'm keeping them as part of this
>   series to avoid merge headaches later on.
>
> - Performance-wise we get a 20% improvement when booting+shutting down
>   debian-arm with MTTCG and -smp 8 (see patch 22). Not bad! This is due
>   to not holding tb_lock during code translation, although the fact that
>   we still have to take it after every translation remains a scalability
>   issue. But before focusing on that, I'd like to get this reviewed.

Side issue. Have we considered the impact on codegen buffer utilisation
by doing an "off-code_gen_buffer" no cache translation the first time we
ever see a TB?

>
> I broke down features as much as possible, so that we do not end up
> with a "per-thread TCG" megapatch.
>
> The series applies on top of the current master (b11365867568).
>
> Thanks,
>
> 		Emilio


--
Alex Bennée
