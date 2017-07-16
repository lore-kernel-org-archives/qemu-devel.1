Received: from eggs.gnu.org ([2001:4830:134:3::10]:53851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWdtM-0004CR-IV
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 03:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWdtJ-0005ja-9p
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 03:23:00 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:36637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWdtJ-0005hl-3g
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 03:22:57 -0400
Received: by mail-pf0-x230.google.com with SMTP id q86so63070229pfl.3
	for <qemu-devel@nongnu.org>; Sun, 16 Jul 2017 00:22:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-10-git-send-email-cota@braap.org>
	<cb152594-248b-85fb-180a-fb83eecf4998@twiddle.net>
	<20170710235751.GA16131@flamenco>
	<57e5db60-7008-7c60-7139-7eb426078c0d@twiddle.net>
	<20170712204804.GA25618@flamenco>
	<f7b8057b-a52a-788e-cddb-0b4ecf761fbd@twiddle.net>
	<20170716014359.GA1628@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9b761ca3-c78b-aaad-0a89-71423451e6b1@twiddle.net>
Date: Sat, 15 Jul 2017 21:22:42 -1000
MIME-Version: 1.0
In-Reply-To: <20170716014359.GA1628@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/22] exec-all: shrink tb->invalid to
 uint8_t
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

On 07/15/2017 03:43 PM, Emilio G. Cota wrote:
> On Wed, Jul 12, 2017 at 13:06:23 -1000, Richard Henderson wrote:
>> You've got a problem here in that you're not including CF_COUNT_MASK in the
>> hash and you dropped the flush when changing to parallel_cpus = true.  That
>> means you could find an old TB with CF_COUNT > 1.
>>
>> Not required for this patch set, but what I'd like to see eventually is
>>
>>    (1) cpu_exec_step merged into cpu_exec_step_atomic for clarity.
>>    (2) callers of tb_gen_code add in CF_PARALLEL as needed; do not
>>        pick it up from parallel_cpus within tb_gen_code.
>>    (3) target/*/translate.c uses CF_PARALLEL instead of parallel_cpus.
>>    (4) cpu_exec_step_atomic does the tb lookup and code gen outside
>>        of the start_exclusive/end_exclusive lock.
> 
> I have implemented these for v2, which is almost ready to go. However,
> just noticed that tcg-op.c also checks parallel_cpus to decide whether
> to emit a real atomic or a non-atomic op. Should we export the two
> flavours of these ops to targets, since targets are the ones that can
> check CF_PARALLEL? Or perhaps set a bit in the now-per-thread *tcg_ctx?

Jeez.  I forgot about that one.  A bit in tcg_ctx seems the best.


r~
