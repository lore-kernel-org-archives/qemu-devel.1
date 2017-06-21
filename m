Received: from eggs.gnu.org ([2001:4830:134:3::10]:42171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNilD-0001qz-Vl
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNilA-0005Ju-HC
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:45:44 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dNilA-0005JJ-6E
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:45:40 -0400
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-4-laurent@vivier.eu>
	<b05fb631-4ccb-39fa-adc3-6949a514b9d2@amsat.org>
	<f43b2f92-a76e-945f-9334-2cd9cb71ec95@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b4efd52d-ecc4-6321-45fa-e9477589ecd4@vivier.eu>
Date: Wed, 21 Jun 2017 18:45:09 +0200
MIME-Version: 1.0
In-Reply-To: <f43b2f92-a76e-945f-9334-2cd9cb71ec95@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 3/6] target-m68k: use floatx80 internally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>

Le 21/06/2017 à 18:37, Richard Henderson a écrit :
> On 06/21/2017 09:18 AM, Philippe Mathieu-Daudé wrote:
>>> +typedef CPU_LDoubleU FPReg;
>>
>> What an awful name... Anyway checking on "qemu/bswap.h" it seems there
>> is some endianess issue with it if your host is little-endian.
> 
> There is no endian-ness issue because we do not attempt to read that
> structure from memory as a whole.  Instead, Laurent uses two big-endian
> loads (with appropriate address arithmetic) and stores the result into
> this host structure in host-endian order.  Further, the host routines
> use the structure members by name and do not assume any particular
> relationship between them.
> 
>> Do you have a way to run Berkeley TestFloat?
> 
> As noted in Laurent's cover message, floatx80 isn't quite right -- that
> is the x86 data type, and the proper m68k data type is slightly different.
> 
> I would expect the results from using floatx80 to be Just Good Enough to
> produce a working m68k user-land.  It will produce correct results for
> normal numbers in arithmetic such as 1.0 + 10.0.  But I would expect
> many of the edge conditions that TestFloat would attempt (especially
> de-normals and un-normals) would fail.
> 

Thank you Richard.

Yes, with floatx80, we can run m68k user-land. I'm going to post the
missing instructions.

I've also ported TestFloat and SoftFloat to m68k to check the result,
it's not perfect but in a good shape.

https://github.com/vivier/m68k-testfloat
https://github.com/vivier/m68k-softfloat

I can compare result from my reference hardware (a real Quadra 800) and
qemu-m68k chroot.

But I plan to replace the floatx80 by a floatx96 in a near future...

Thanks,
Laurent
