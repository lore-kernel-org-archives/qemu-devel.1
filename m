Received: from eggs.gnu.org ([2001:4830:134:3::10]:33008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eK3Ba-0000Ys-Il
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eK3BW-00061p-Ij
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:18:02 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:62323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eK3BW-00060N-77
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:17:58 -0500
References: <20171123163538.31411-1-laurent@vivier.eu>
	<CAFEAcA9+f2cgUUS00DXzF9a96evPRnxY5MTUZpe+OA3Trv84WA@mail.gmail.com>
	<e6dc192f-6fcd-f25d-d1db-983280c915f4@vivier.eu>
	<CAFEAcA9uOJ5i-XbK5zbxgFBSvu=kQ6p99EA-CyhrSTKtx+CF9A@mail.gmail.com>
	<e90eaeb0-19d4-659c-9007-5b0e18d87d9a@tuxfamily.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <629dc696-a5e7-4b94-f964-0e9fdd7cf511@vivier.eu>
Date: Wed, 29 Nov 2017 15:17:31 +0100
MIME-Version: 1.0
In-Reply-To: <e90eaeb0-19d4-659c-9007-5b0e18d87d9a@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/m68k: implement 680x0 FPU
 (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andreas Grabher <andreas.grabher@cable.vol.at>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 29/11/2017 à 15:08, Thomas Huth a écrit :
> On 29.11.2017 14:59, Peter Maydell wrote:
>> On 29 November 2017 at 13:42, Laurent Vivier <laurent@vivier.eu> wrote:
>>> these functions come from:
>>>
>>> http://previous.alternative-system.com/
>>>
>>> http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat.c
>>>
>>> This is also a modified softfloat, release 2b
>>> which is BSD license if I'm correct.
>>
>> We can't use softfloat2b code (the part of the license that goes
>> "USE OF THIS SOFTWARE IS RESTRICTED TO PERSONS
>> AND ORGANIZATIONS [...] WHO FURTHERMORE EFFECTIVELY INDEMNIFY JOHN
>> HAUSER AND THE INTERNATIONAL COMPUTER SCIENCE INSTITUTE" isn't
>> GPL compatible).
>>
>> We can use softfloat2a code, which doesn't have that indemnity clause.
> 
> Sigh. That's why WinUAE and Hatari immediately switched back to
> softfloat2a (derived from QEMU) after we've identified the problem
> there. Looks like the Previous folks forgot to do that step, too :-(
> 
>>> This code has also been copied to WinUAE (GPL), where softfloat has been
>>> copied from QEMU:
>>> https://github.com/tonioni/WinUAE/blob/master/softfloat/softfloat.cpp
>>
>> Yes, lots of projects used the softfloat2b code without realising
>> it wasn't GPL compatible (including QEMU -- we had a painful job
>> to fix things up and convert to the 2a codebase a while back).
>>
>>> But I think the bad news comes later:
>>>
>>> all the other functions (sin, cos, tan, log, exp, ...) found in previous
>>> (softfloat_fpsp.c) are "derived" from NeXT library FPSP:
>>>
>>> http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/softfloat_fpsp.c
>>>
>>> /*============================================================================
>>>
>>>  This C source file is an extension to the SoftFloat IEC/IEEE Floating-point
>>>  Arithmetic Package, Release 2a.
>>>
>>>  Written by Andreas Grabher for Previous, NeXT Computer Emulator.
>>>
>>> =============================================================================*/
>>> ...
>>> /*----------------------------------------------------------------------------
>>> | Algorithms for transcendental functions supported by MC68881 and MC68882
>>> | mathematical coprocessors. The functions are derived from FPSP library.
>>> *----------------------------------------------------------------------------*/
>>>
>>> FPSP library can be found:
>>>
>>> https://ftp.nice.ch/pub/next/developer/hardware/m68k/
>>>
>>> And the assembly source code is not free at all:
>>>
>>> https://ftp.nice.ch/pub/next/developer/hardware/m68k/_libFPSP.1.p2.N.s/l_fpsp.h
>>>
>>>
>>> |               Copyright (C) Motorola, Inc. 1991
>>> |                       All Rights Reserved
>>> |
>>> |       THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
>>> |       The copyright notice above does not evidence any
>>> |       actual or intended publication of such source code.
>>>
>>>
>>> So I'm wondering what license apply to the C version found in "Previous".
>>
>> Good question. It's clearly not copied code (since the FPSP library is
>> all native m68k assembly), but presumably it's the same algorithms
>> transliterated into C...
> 
> There also seem to be other versions of that library available, e.g.:
> 
> https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/arch/m68k/fpsp/l_fpsp.h
> 
> Maybe Andreas (now on CC: ) could clarify which version he used / how
> the C sources were developed?

Thank you Thomas,

This seems to be the same code re-licensed to:

MOTOROLA MICROPROCESSOR & MEMORY TECHNOLOGY GROUP
M68000 Hi-Performance Microprocessor Division
M68040 Software Package

M68040 Software Package Copyright (c) 1993, 1994 Motorola Inc.
All rights reserved.

THE SOFTWARE is provided on an "AS IS" basis and without warranty.
To the maximum extent permitted by applicable law,
MOTOROLA DISCLAIMS ALL WARRANTIES WHETHER EXPRESS OR IMPLIED,
INCLUDING IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A
PARTICULAR PURPOSE and any warranty against infringement with
regard to the SOFTWARE (INCLUDING ANY MODIFIED VERSIONS THEREOF)
and any accompanying written materials.

To the maximum extent permitted by applicable law,
IN NO EVENT SHALL MOTOROLA BE LIABLE FOR ANY DAMAGES WHATSOEVER
(INCLUDING WITHOUT LIMITATION, DAMAGES FOR LOSS OF BUSINESS
PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR
OTHER PECUNIARY LOSS) ARISING OF THE USE OR INABILITY TO USE THE
SOFTWARE.  Motorola assumes no responsibility for the maintenance
and support of the SOFTWARE.

You are hereby granted a copyright license to use, modify, and
distribute the SOFTWARE so long as this entire notice is retained
without alteration in any modified and/or redistributed versions,
and that such modified versions are clearly identified as such.
No licenses are granted by implication, estoppel or otherwise
under any patents or trademarks of Motorola, Inc.

Laurent
