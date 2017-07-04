Received: from eggs.gnu.org ([2001:4830:134:3::10]:53127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dSBNh-0006BX-7v
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 20:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dSBNd-00089t-SD
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 20:07:53 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dSBNd-000881-HY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 20:07:49 -0400
References: <20170703162328.24474-1-laurent@vivier.eu>
	<20170703162328.24474-5-laurent@vivier.eu>
	<39af8700-3e03-828d-144a-5e86703e90cd@twiddle.net>
	<b5158122-61cb-0950-956c-79a9556bdabc@vivier.eu>
	<fd4d0cfa-b746-7ea8-f1a0-2409b519f5bf@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6b52c76c-a5a6-0f35-3a1d-d5038ef42356@vivier.eu>
Date: Tue, 4 Jul 2017 02:07:26 +0200
MIME-Version: 1.0
In-Reply-To: <fd4d0cfa-b746-7ea8-f1a0-2409b519f5bf@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] target-m68k: add fscale,
 fgetman and fgetexp
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

Le 03/07/2017 à 22:31, Richard Henderson a écrit :
> On 07/03/2017 12:50 PM, Laurent Vivier wrote:
>>         fmove.x #0x000000000ABCDEF12345,%fp0
>>         fgetman.x %fp0,%fp6
>> fp0            2.1518178707571747286191852003521627e-4938    (raw
>> 0x0000000000000abcdef12345)
>> fp6            1.342222103012886691431049257516861    (raw
>> 0x3fff0000abcdef1234500000)
> 
> This one shows exactly what I was thinking about.
> 
>> So I guess the mantissa must be shifted to left until we have a 1 in the
>> explicit integer part bit?
> 
> Yes.
> 
> Please try fgetexp on this same input.

	        fmove.x #0x000000000ABCDEF12345,%fp0
	        fgetexp.x %fp0,%fp6
fp0            (raw 0x0000000000000abcdef12345)
fp6            -16403

> I suspect the answer is -16384 - clz64(val->l.lower).

It looks like -16383 - clz64(val->l.lower)

	        fmove.x #0x000056789ABCDEF12345,%fp0
	        fgetexp.x %fp0,%fp6
fp0            (raw 0x0000000056789abcdef12345)
fp6            -16384

	        fmove.x #0x000086789ABCDEF12345,%fp0
	        fgetexp.x %fp0,%fp6
fp0            (raw 0x0000000086789abcdef12345)
fp6            -16383

Thanks,
Laurent
