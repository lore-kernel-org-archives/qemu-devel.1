Received: from eggs.gnu.org ([2001:4830:134:3::10]:35216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d93Fw-0005Ys-OX
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d93Ft-0004by-L8
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:36:48 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d93Ft-0004bp-Em
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:36:45 -0400
Received: by mail-qk0-x243.google.com with SMTP id u75so6534115qka.1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 22:36:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-2-f4bug@amsat.org>
	<alpine.DEB.2.20.1705121139030.2981@hadrien>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7d1b12cd-80dc-7fc8-935d-bec7fb08e256@amsat.org>
Date: Fri, 12 May 2017 02:36:39 -0300
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1705121139030.2981@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/5] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Lawall <julia.lawall@lip6.fr>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Elfring <elfring@users.sourceforge.net>

Hi Julia,

Sorry I planed to send you another mail but sent this mail to QEMU list 
first.

> I don't think I have seen earlier versions of this script.  Are you
> proposing it to be added to the kernel?  If so, it should be put in an
> appropriate subdirectory of Coccinelle.

This script is specific to QEMU codebase and wont benefit the Linux kernel.

> Overall, could you explain at a high level what it is intended to do?  It
> uses rather heavily regular expressions and python code, so I wonder if
> this is the best way to do it.

In this patch 
http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01466.html 
Aurelien does:

-    tcg_gen_shri_i32(cpu_sr_q, src, SR_Q);
-    tcg_gen_andi_i32(cpu_sr_q, cpu_sr_q, 1);
+    tcg_gen_extract_i32(cpu_sr_q, src, SR_Q, 1);

having:

#define SR_Q  8

I wanted to write a Coccinelle script to check for this pattern.
My first version was wrong, as Richard Henderson reminded me this 
pattern can be applied as long as the len argument (here "1") is a 
Mersenne prime (all least significant bits as "1").

The codebase also defines:

#if TARGET_LONG_BITS == 64
# define tcg_gen_andi_tl tcg_gen_andi_i64
# define tcg_gen_shri_tl tcg_gen_shri_i64
#else
# define tcg_gen_andi_tl tcg_gen_andi_i32
# define tcg_gen_shri_tl tcg_gen_shri_i32
#endif

The same pattern can be applied for i32/i64/tl uses.

>> The following thread was helpful while writing this script:
>>
>>     https://github.com/coccinelle/coccinelle/issues/86
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  scripts/coccinelle/tcg_gen_extract.cocci | 71 ++++++++++++++++++++++++++++++++
>>  1 file changed, 71 insertions(+)
>>  create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci
>>
>> diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccinelle/tcg_gen_extract.cocci
>> new file mode 100644
>> index 0000000000..4823073005
>> --- /dev/null
>> +++ b/scripts/coccinelle/tcg_gen_extract.cocci
>> @@ -0,0 +1,71 @@
>> +// optimize TCG using extract op
>> +//
>> +// Copyright: (C) 2017 Philippe Mathieu-Daudé. GPLv2+.
>> +// Confidence: High
>> +// Options: --macro-file scripts/cocci-macro-file.h
>> +//
>> +// Nikunj A Dadhania optimization:
>> +// http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05211.html
>> +// Aurelien Jarno optimization:
>> +// http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01466.html
>> +// Coccinelle helpful issue:
>> +// https://github.com/coccinelle/coccinelle/issues/86
>> +
>> +@match@ // match shri*+andi* pattern, calls script verify_len
>> +identifier ret, arg;
>> +constant ofs, len;
>> +identifier shr_fn =~ "^tcg_gen_shri_";
>> +identifier and_fn =~ "^tcg_gen_andi_";
>> +position shr_p;
>> +position and_p;
>> +@@
>> +(
>> +shr_fn@shr_p(ret, arg, ofs);
>> +and_fn@and_p(ret, ret, len);
>> +)

First I want to match any of:
- tcg_gen_andi_i32/tcg_gen_shri_i32
- tcg_gen_andi_i64/tcg_gen_shri_i64
- tcg_gen_andi_tl/tcg_gen_shri_tl

Now I want to verify "len" is Mersenne prime.

>> +@script:python verify_len@
>> +ret_s << match.ret;
>> +len_s << match.len;
>> +shr_s << match.shr_fn;
>> +and_s << match.and_fn;
>> +shr_p << match.shr_p;
>> +extract_fn;
>> +@@
>> +print "candidate at %s:%s" % (shr_p[0].file, shr_p[0].line)
>> +len_fn=len("tcg_gen_shri_")
>> +shr_sz=shr_s[len_fn:]
>> +and_sz=and_s[len_fn:]
>> +# TODO: op_size shr<and allowed?
>> +is_same_op_size = shr_sz == and_sz

shr_s/and_s are strings containing function name.
check we matched a combination i32/i32 or i64/i64 or tl/tl.

(I think having i32/i64 and i32/tl is also valid but expect Richard's 
confirmation, anyway I doubt those combinations are used).

>> +print "  op_size: %s/%s (%s)" % (shr_sz, and_sz, "same" if is_same_op_size else "DIFFERENT")
>> +is_optimizable = False
>> +if is_same_op_size:
>> +    try: # only eval integer, no #define like 'SR_M' (cpp did this, else some headers are missing).
>> +        len_v = long(len_s.strip("UL"), 0)

Here len_s is also a string.

Some "len" encountered:
[1, 0xffff, 0x1, 0x00FF00FF, 0x0000FFFF0000FFFFULL]

Now len_v is the value of len_s.

>> +        low_bits = 0
>> +        while (len_v & (1 << low_bits)):
>> +            low_bits += 1

Dumbly count least significant bits.

>> +        print "  low_bits:", low_bits, "(value: 0x%x)" % ((1 << low_bits) - 1)
>> +        print "  len: 0x%x" % len_v
>> +        is_optimizable = ((1 << low_bits) - 1) == len_v # check low_bits

Check if Mersenne prime of "low_bits" least significant bits is the same 
number than len_v, the function argument.

If Yes: len_v is a Mersenne prime and we can optimize.

>> +        print "  len_bits %s= low_bits" % ("=" if is_optimizable else "!")
>> +        print "  candidate", "IS" if is_optimizable else "is NOT", "optimizable"
>> +        coccinelle.extract_fn = "tcg_gen_extract_" + and_sz

Add the "tcg_gen_extract()" function name as identifier in coccinelle 
namespace, appending if we are handling i32, i64 or tl.

>> +    except:
>> +        print "  ERROR (check included headers?)"
>> +    cocci.include_match(is_optimizable)

If we can not optimize, then discard this environment.

>> +print
>> +
>> +@replacement depends on verify_len@
>> +identifier match.ret, match.arg;
>> +constant match.ofs, match.len;
>> +identifier match.shr_fn;
>> +identifier match.and_fn;
>> +position match.shr_p;
>> +position match.and_p;
>> +identifier verify_len.extract_fn;
>> +@@
>> +-shr_fn@shr_p(ret, arg, ofs);
>> +-and_fn@and_p(ret, ret, len);
>> ++extract_fn(ret, arg, ofs, len);

Emit patch with function name from verify_len rule, other from the match 
rule.

>> --
>> 2.11.0

Thank you for your interest and fast reply!

Phil.
