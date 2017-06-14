Received: from eggs.gnu.org ([2001:4830:134:3::10]:47191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLATb-0004wF-Az
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLATX-00046U-B0
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:44:59 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:34944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLATX-00046O-6T
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:44:55 -0400
Received: by mail-qt0-x230.google.com with SMTP id w1so4240783qtg.2
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:44:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-3-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9db5e18a-8d0c-4083-ecab-e8a5fa2da67a@twiddle.net>
Date: Wed, 14 Jun 2017 08:44:50 -0700
MIME-Version: 1.0
In-Reply-To: <20170614140209.29847-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] tcg-runtime: light re-factor of
 lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com, cota@braap.org
Cc: qemu-devel@nongnu.org

On 06/14/2017 07:02 AM, Alex Bennée wrote:
> Just a little precursor re-factoring before I was going to add a trace
> point:
> 
>    - single return point, defaulting to tcg_ctx.code_gen_epilogue

Why?  Any if you're going to do that, why not init ret = epilogue and avoid the 
null test at the end?

>    - move cs_base, pc and flags inside the jump cache hit scope

Funny story.  While looking at this again, I notice that there's no reason to 
avoid, and every reason not to avoid, calling tb_htable_lookup when 
tb_jmp_cache is empty.  So I'm now doing

     tb = atomic_rcu_read(...);
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);

     if (!(tb && tb->pc == addr && ...)) {
         tb = tb_htable_lookup(...);
         ...

>    - calculate the tb_jmp_cache hash once

I did look once and the compiler is doing the CSE.  But it does look cleaner.


r~
