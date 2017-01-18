Received: from eggs.gnu.org ([2001:4830:134:3::10]:36844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTxzj-0005su-O5
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTxze-00051X-O3
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:42:15 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTxze-000501-I2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:42:10 -0500
Received: by mail-pg0-x242.google.com with SMTP id 75so2280157pgf.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 13:42:08 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484773521-16530-1-git-send-email-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <510d4403-7ca4-4536-8896-44835f253dc4@twiddle.net>
Date: Wed, 18 Jan 2017 13:42:05 -0800
MIME-Version: 1.0
In-Reply-To: <1484773521-16530-1-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] target-m68k: implement 680x0 FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 01/18/2017 01:05 PM, Laurent Vivier wrote:
> This series modifies the original ColdFire FPU implementation
> to use floatx80 instead of float64 internally as this
> is the native datatype for 680x0. I didn't keep the float64
> type for ColdFire, but if someone thinks it's required I
> can update this series in this way.

I think at minimum you'll need to round to float64.  But this control is also 
needed for 68040 FPU, so probably you can use the same helpers.

I'm thinking something like

void helper_foo_d(args);
{
   ...
   r80 = floatx80_foo(args);
   r64 = floatx80_to_float64(r80, &env->fp_status);
   r80 = float64_to_floatx80(r64, &env->fp_status);
   [store r80]
   ...
}

since iirc 68040 has fadd.d, fadd.s to go with fadd.


r~
