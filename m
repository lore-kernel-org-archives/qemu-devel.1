Received: from eggs.gnu.org ([2001:4830:134:3::10]:57896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptesarik@suse.com>) id 1fH2dB-0003Rk-I8
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptesarik@suse.com>) id 1fH2d6-00012R-IO
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:38:21 -0400
Date: Fri, 11 May 2018 09:38:03 +0200
From: Petr Tesarik <ptesarik@suse.com>
Message-ID: <20180511093803.7e4f4e85@ezekiel.suse.cz>
In-Reply-To: <20180511071052.1443-1-ptesarik@suse.com>
References: <20180511071052.1443-1-ptesarik@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] Fix conversion from uint64 to float128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

On Fri, 11 May 2018 09:10:52 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> The significand is passed to normalizeRoundAndPackFloat128() as high
> first, low second. The current code passes the integer first, so the
> result is incorrectly shifted left by 64 bits.
> 
> This bug affects the emulation of s390x instruction CXLGBR (convert
> from logical 64-bit binary-integer operand to extended BFP result).

I forgot to add a simple reproducer:

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
        unsigned long long x = atoll(argv[1]);
        long double d = x;

        printf("%llu -> %Lf\n", x, d);

        return 0;
}

On a real s390x, I get this:
linux-nig1:~ # ./cast 1
1 -> 1.000000

An s390x emulated with (unpatched) qemu-system-s390x gives:
linux-2s2c:~ # ./cast 1
1 -> 18446744073709551616.000000

That is 2^64.

Petr T
