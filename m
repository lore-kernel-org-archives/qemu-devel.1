Received: from eggs.gnu.org ([2001:4830:134:3::10]:52376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f83V0-0003MQ-Iv
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f83Uw-0003Xv-Jm
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:44:46 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:47298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f83Uw-0003Wz-5M
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:44:42 -0400
References: <20180413140334.26622-1-alex.bennee@linaro.org>
	<20180413140334.26622-3-alex.bennee@linaro.org>
	<3a3a9132-8f03-c476-bd0d-b6c91a9cc3a4@mail.uni-paderborn.de>
	<CAFEAcA9FWu7VU1-RtXA4h-LQOXVoDfOG9P8aTs02B-NF9N93qg@mail.gmail.com>
	<0703fdde-da82-d85f-3d68-e45e0839a9dc@mail.uni-paderborn.de>
	<CAFEAcA-ZzUVK_WWd6nA35YbHQHCCJHo93H7eomeq=2F9m59pnA@mail.gmail.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <4f3cf29d-bd9d-569f-445f-67821dcc50a6@mail.uni-paderborn.de>
Date: Mon, 16 Apr 2018 14:44:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ZzUVK_WWd6nA35YbHQHCCJHo93H7eomeq=2F9m59pnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] fpu/softfloat: raise float_invalid
 for NaN/Inf in round_to_int_and_pack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 04/13/2018 05:29 PM, Peter Maydell wrote:
> On 13 April 2018 at 16:24, Bastian Koppelmann
> <kbastian@mail.uni-paderborn.de> wrote:
>> However, my risu-like tests found another flag raising problem with
>> float32_div. I'll investigate it on Monday.

I found the problem. With float32_div(a, b), if a is inf and b is not inf we
just returned a without raising any flag. In div_floats() after the refactor we
don't have this case.

In my testcase I divided -inf by 0 so the div_floats() function ran into
div_by_zero and wrongly raised the corresponding flag.

Cheers,
Bastian
