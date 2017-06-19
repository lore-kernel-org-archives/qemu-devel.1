Received: from eggs.gnu.org ([2001:4830:134:3::10]:33535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dN4Rs-00062h-Us
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dN4Rn-0006aR-UY
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:43:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dN4Rn-0006Yj-K0
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:42:59 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20170611231633.32582-1-laurent@vivier.eu>
	<20170611231633.32582-6-laurent@vivier.eu>
	<a229ea36-7ae8-daee-f446-8670fc3f6e53@twiddle.net>
	<47a2835f-5480-4d85-d55a-36e55a2b4f47@vivier.eu>
Message-ID: <f7e5acc9-a23d-fbd1-c2e5-3c2235f40c19@vivier.eu>
Date: Mon, 19 Jun 2017 23:42:07 +0200
MIME-Version: 1.0
In-Reply-To: <47a2835f-5480-4d85-d55a-36e55a2b4f47@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 5/7] target-m68k: use floatx80 internally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

Le 19/06/2017 à 23:03, Laurent Vivier a écrit :
> Le 19/06/2017 à 22:53, Richard Henderson a écrit :
>>
>> It would also make me happier if we were to adjust the definition of
>> fl0atx80 to more closely match m68k and those missing zeros.  Shouldn't
>> real hardware move instructions propagate those middle 2 bytes
>> regardless of contents?
>>
>> Perhaps something like
>>
>> #ifdef TARGET_M68K
>>   typedef struct {
>>     uint64_t low;
>>     union {
>>       uin32_t high32;
>>       struct {
>> #ifdef HOST_WORDS_BIGENDIAN
>>         uint16_t high, zero;
>> #else
>>         uint16_t zero, high;
>> #endif
>>       };
>>     };
>>   } floatx80;
>> #else
>>   ...
>> #endif
>>
>> (with a minor fix to make_floatx80 to use named initializers).
>>
>> Then you can use full 32-bit store insns when copying data here.  Which
>> also allows you to drop some of the shifts you're needing to add.
> 
> OK, I will.

The softfloat is in the target independent code, so we can't adjust the
size of floatx80 by target, TARGET_XXXX are poisoned when used in
softfloat.h.

Laurent
