Received: from eggs.gnu.org ([2001:4830:134:3::10]:35266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9FsH-0007I9-G9
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9FsG-0005DI-MC
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:05:13 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-3-f4bug@amsat.org>
	<f447c23f-f63c-f3bb-a1b9-f63e5aff4063@twiddle.net>
	<20170512182132.jdw4g2pd5gvf2dti@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <aaa04be5-78d6-311b-609b-d02f18e9ef96@twiddle.net>
Date: Fri, 12 May 2017 12:05:00 -0700
MIME-Version: 1.0
In-Reply-To: <20170512182132.jdw4g2pd5gvf2dti@aurel32.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: optimize rev16() using
 extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On 05/12/2017 11:21 AM, Aurelien Jarno wrote:
> +    uint64_t mask1 = sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff;
> +    uint64_t mask2 = sf ? 0xff00ff00ff00ff00ull : 0xff00ff00;
> +
> +    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
> +    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, mask1);
> +    tcg_gen_shli_i64(tcg_rd, tcg_rn, 8);
> +    tcg_gen_andi_i64(tcg_rd, tcg_rd, mask2);

It would probably be better to use a single mask, since they're not free to 
instantiate in a register.  So e.g.

   TCGv mask = tcg_const_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
   tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
   tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
   tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
   tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);


r~
