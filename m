Received: from eggs.gnu.org ([2001:4830:134:3::10]:40534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUK5j-0008AD-6F
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUK5e-00012w-As
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:50:11 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUK5e-00012P-4H
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:50:06 -0400
Received: by mail-pg0-f46.google.com with SMTP id t186so39838329pgb.1
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 14:50:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-22-git-send-email-cota@braap.org>
	<3fabc9d4-86b5-9d01-9499-3468bd2f2e5e@twiddle.net>
	<20170709212910.GA3027@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <15f9af98-4c04-7bdb-2502-a2e7a37eda8c@twiddle.net>
Date: Sun, 9 Jul 2017 11:48:53 -1000
MIME-Version: 1.0
In-Reply-To: <20170709212910.GA3027@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/22] tcg: enable per-thread TCG for
 softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/09/2017 11:29 AM, Emilio G. Cota wrote:
> On Sun, Jul 09, 2017 at 11:19:37 -1000, Richard Henderson wrote:
>> On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
>>> This allows us to generate TCG code in parallel. MTTCG already uses
>>> it, although the next commit pushes down a lock to actually
>>> perform parallel generation.
>>>
>>> User-mode is kept out of this: contention due to concurrent translation
>>> is more commonly found in full-system mode.
>>
>> Um, why do you believe that?  Are you suggesting that a multi-threaded
>> user-only guest is much more likely to share TBs and do much less code
>> generation total?
> 
> Exactly. Also, in user-mode "vCPU threads" (i.e. host threads) come and
> go all the time, so this doesn't work well with having a single
> code_gen_buffer, which I assumed was non-negotiable.

Ah, yes.  For any subdivision N of code_gen_buffer that we choose, at some 
point we may have N+1 threads and need to do Something Else.

That's probably something worth commenting somewhere with the "first" #ifndef 
CONFIG_USER_ONLY.


r~
