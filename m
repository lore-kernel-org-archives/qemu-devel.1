Received: from eggs.gnu.org ([2001:4830:134:3::10]:46365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXp7r-0002vA-M2
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXp7m-0007ne-Qq
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:39:23 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXp7m-0007mw-KA
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:39:18 -0400
Received: by mail-pg0-x244.google.com with SMTP id n2-v6so4291716pgq.6
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:39:18 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-14-richard.henderson@linaro.org>
	<CAFEAcA9xxh6tkpoLAoKaZ95SOtVi6Oqz+K2dMiEg2RnS-8dUHQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a3b4a33a-296f-cfa4-1dc5-7a67d64fb111@linaro.org>
Date: Tue, 26 Jun 2018 07:39:14 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xxh6tkpoLAoKaZ95SOtVi6Oqz+K2dMiEg2RnS-8dUHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 13/35] target/arm: Implement SVE gather
 loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/25/2018 09:55 AM, Peter Maydell wrote:
>> +static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
>> +{
>> +    gen_helper_gvec_mem_scatter *fn = NULL;
>> +
>> +    if (a->esz < a->msz
>> +        || (a->msz == 0 && a->scale)
> Doesn't this check duplicate work you're already doing in the decode
> entries in the .decode file? If we're going to throw out msz==0 scale==1
> here we don't need to go to the effort to split this into 4 patterns
> so we can force the scale bit to 0 in the msz=00 line:
> 
>> +LD1_zprz        1100010 00 .0 ..... 0.. ... ..... ..... \
>> +                @rprr_g_load_xs_u esz=3 msz=0 scale=0
>> +LD1_zprz        1100010 01 .. ..... 0.. ... ..... ..... \
>> +                @rprr_g_load_xs_u_sc esz=3 msz=1
>> +LD1_zprz        1100010 10 .. ..... 0.. ... ..... ..... \
>> +                @rprr_g_load_xs_u_sc esz=3 msz=2
>> +LD1_zprz        1100010 11 .. ..... 0.. ... ..... ..... \
>> +                @rprr_g_load_xs_u_sc esz=3 msz=3
> and could just have
> LD1_zprz     1100010 msz:2 .. ..... 0.. ... ..... ..... \
>                 @rprr_g_load_xs_u_sc esz=3 scale=0
> 
> couldn't we?
> 
> (I don't really care which way round we do it.)
> 

I believe that I originally had the combined form, but it conflicts with some
other pattern (looking through the patterns, perhaps PRF?).  I must have
squashed the patch to split the pattern without removing the check in the helper.

> Is LDFF1 support going to appear later in this patchset?
> 
> For the moment should we UNDEF it?

Next patch, as you found.  Maybe I'll just drop the comment from this patch.  I
may also re-format the tables here, so they don't require so much re-formatting
in the next patch.


r~
