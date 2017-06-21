Received: from eggs.gnu.org ([2001:4830:134:3::10]:39442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNidE-0000uM-Vj
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNidA-0001bX-Te
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:37:29 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:32966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNidA-0001bK-Nn
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:37:24 -0400
Received: by mail-qk0-x235.google.com with SMTP id r62so87249461qkf.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:37:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-4-laurent@vivier.eu>
	<b05fb631-4ccb-39fa-adc3-6949a514b9d2@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f43b2f92-a76e-945f-9334-2cd9cb71ec95@twiddle.net>
Date: Wed, 21 Jun 2017 09:37:19 -0700
MIME-Version: 1.0
In-Reply-To: <b05fb631-4ccb-39fa-adc3-6949a514b9d2@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>

On 06/21/2017 09:18 AM, Philippe Mathieu-Daudé wrote:
>> +typedef CPU_LDoubleU FPReg;
> 
> What an awful name... Anyway checking on "qemu/bswap.h" it seems there is some 
> endianess issue with it if your host is little-endian.

There is no endian-ness issue because we do not attempt to read that structure 
from memory as a whole.  Instead, Laurent uses two big-endian loads (with 
appropriate address arithmetic) and stores the result into this host structure 
in host-endian order.  Further, the host routines use the structure members by 
name and do not assume any particular relationship between them.

> Do you have a way to run Berkeley TestFloat?

As noted in Laurent's cover message, floatx80 isn't quite right -- that is the 
x86 data type, and the proper m68k data type is slightly different.

I would expect the results from using floatx80 to be Just Good Enough to 
produce a working m68k user-land.  It will produce correct results for normal 
numbers in arithmetic such as 1.0 + 10.0.  But I would expect many of the edge 
conditions that TestFloat would attempt (especially de-normals and un-normals) 
would fail.


r~
