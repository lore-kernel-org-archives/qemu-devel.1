Received: from eggs.gnu.org ([209.51.188.92]:37775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1HYF-0006ez-23
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1HYE-0004Vs-C7
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:24:39 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1HYE-0004Mx-2T
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:24:38 -0500
Received: by mail-pf1-x442.google.com with SMTP id n125so6670337pfn.5
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 13:24:34 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-5-mark.cave-ayland@ilande.co.uk>
	<a6832b4d-f6ae-e783-f3df-68d702eb18ef@linaro.org>
	<df436d44-56a7-8796-36a0-266b0a8091a0@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <570140a6-20b2-d179-2234-9d947b0ebaea@linaro.org>
Date: Tue, 5 Mar 2019 13:24:29 -0800
MIME-Version: 1.0
In-Reply-To: <df436d44-56a7-8796-36a0-266b0a8091a0@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/8] target/ppc: introduce avrh_offset()
 and avrl_offset() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/5/19 9:38 AM, Mark Cave-Ayland wrote:
> It's really that this is a stepping stone to patch 7 where you end up with this:
> 
> static inline int vsrh_offset(int i)
> {
>     return offsetof(CPUPPCState, vsr[i].VsrD(0));
> }
> 
> static inline int vsrl_offset(int i)
> {
>     return offsetof(CPUPPCState, vsr[i].VsrD(1));
> }
> 
> ...
> 
> static inline int avrh_offset(int i)
> {
>     return vsrh_offset(i + 32);
> }
> 
> static inline int avrl_offset(int i)
> {
>     return vsrl_offset(i + 32);
> }

Yes, but the only users look like...

>     tcg_gen_ld_i64(dst, cpu_env, high ? avrh_offset(regno) : avrl_offset(regno));

... this.  And to me that suggests that one helper instead of two would be
better, so that you can write

  tcg_gen_ld_i64(dst, cpu_env, avr64_offset(regno, high));

and propagate the "high" into the VsrD argument.

> which looks a bit easier on the eye? I'm less keen on pushing the "high" bool all the
> way down into offset functions as I find the separate vsrh/vsrl functions much easier
> to read in the helpers than the get_avr64() version.

Ah.  Hmm.

Will we not in the end require a function A64's

  vec_reg_offset(regno, element, size)

I know DavidH did when writing the s390x vector support last week.  Perhaps
that's more palatable than avr64_offset that only supports 64-bit elements?


r~
