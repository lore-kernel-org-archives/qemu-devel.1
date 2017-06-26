Received: from eggs.gnu.org ([2001:4830:134:3::10]:59265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYvq-0005Cf-MG
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYvm-00027r-OT
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:40:18 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPYvm-00027i-KF
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:40:14 -0400
Received: by mail-qk0-x241.google.com with SMTP id 16so1228385qkg.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 11:40:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170625192125.9992-1-laurent@vivier.eu>
	<20170625192125.9992-8-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8addee31-3a8b-d7fd-489e-b954577c8793@twiddle.net>
Date: Mon, 26 Jun 2017 11:40:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170625192125.9992-8-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/m68k: add fmovem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 06/25/2017 12:21 PM, Laurent Vivier wrote:
> +uint32_t HELPER(fmovem)(CPUM68KState *env, uint32_t addr, uint32_t ext)
> +{
> +    uintptr_t ra = GETPC();
> +    int mode = (ext >> 11) & 0x3;
> +    int is_load = ((ext & 0x2000) == 0);
> +    uint16_t mask;
> +    int incr, i;
> +
> +    if (m68k_feature(env, M68K_FEATURE_FPU)) {
> +        incr = 12;
> +    } else {
> +        incr = 8;
> +    }
> +
> +    if ((mode & 0x1) == 1) {
> +        /* Dynamic register list */
> +        int reg = extract32(ext, 4, 3);
> +        mask = env->dregs[reg] & 0x00FF;
> +    } else {
> +        /* Static register list */
> +        mask = ext & 0x00FF;
> +    }
> +
> +    if (!is_load && (mode & 2) == 0) {

There's too much decoding being done in the helper.

I think it would be better to split this into 6 helpers:

   fmovem{d,x}_st_predec
   fmovem{d,x}_st_postdec
   fmovem{d,x}_ld_postdec

It should be easy to share code for these via inline functions.

Pass in the mask as an argument.  This will either be a constant loaded via 
tcg_const_i32 or the zero-extended contents of the register.


r~
