Received: from eggs.gnu.org ([2001:4830:134:3::10]:59945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekYom-0005KS-JB
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 12:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekYoi-0001BJ-Ns
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 12:20:04 -0500
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:41978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekYoi-0001A8-Hh
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 12:20:00 -0500
Received: by mail-pf0-x233.google.com with SMTP id 68so2503829pfj.8
	for <qemu-devel@nongnu.org>; Sat, 10 Feb 2018 09:20:00 -0800 (PST)
References: <1954640316.20171226142913@mobile-stream.com>
	<751c9675-7e93-a907-4b9e-998c50155e84@msgid.tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <29427bc8-d37d-a20c-e0ed-aaebffd1c265@linaro.org>
Date: Sat, 10 Feb 2018 09:19:55 -0800
MIME-Version: 1.0
In-Reply-To: <751c9675-7e93-a907-4b9e-998c50155e84@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] fix evsrwu and others for powerpcspe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, info@mobile-stream.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 02/09/2018 11:25 PM, Michael Tokarev wrote:
> 26.12.2017 14:29, info@mobile-stream.com wrote:
>> GEN_SPEOP_ARITH2 declares non-local temporaries then calls gen_op_evsrwu/evsrws/evslw which generates branch insn.
> 
> I'm Cc'ing qemu-devel@ for review, since I don't know much about how ppc works.
> 
> Thanks,
> 
> /mjt
> 
>> --- target/ppc/translate/spe-impl.inc.c.orig
>> +++ target/ppc/translate/spe-impl.inc.c
>> @@ -158,8 +158,8 @@
>>          gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
>>          return;                                                               \
>>      }                                                                         \
>> -    t0 = tcg_temp_new_i32();                                                  \
>> -    t1 = tcg_temp_new_i32();                                                  \
>> +    t0 = tcg_temp_local_new_i32();                                                  \
>> +    t1 = tcg_temp_local_new_i32();                                                  \

While that's one possible solution, it would be better to rewrite the helpers
not to use branches.  E.g.

    tcg_gen_andi_i32(t0, arg2, 0x1f);
    tcg_gen_andi_i32(t1, arg2, 0x20);
    tcg_gen_shr_i32(ret, arg1, t0);
    tcg_gen_movi_i32(t0, 0);
    tcg_gen_movcond_i32(TCG_COND_NE, ret, t1, t0, t0, ret);


r~
