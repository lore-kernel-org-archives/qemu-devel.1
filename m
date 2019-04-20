Received: from eggs.gnu.org ([209.51.188.92]:43255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHeyE-0005WG-UR
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 21:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHeyD-0006Lo-H4
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 21:39:10 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHeyA-0006F0-Ta
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 21:39:07 -0400
Received: by mail-pl1-x642.google.com with SMTP id b3so3271069plr.7
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 18:39:05 -0700 (PDT)
References: <20190416083150.19649-1-richard.henderson@linaro.org>
	<87zholfvcb.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0d8bc0a-cd4a-ed3a-a1ce-aeb8d5ce5ec0@linaro.org>
Date: Fri, 19 Apr 2019 15:38:59 -1000
MIME-Version: 1.0
In-Reply-To: <87zholfvcb.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: Fix launchpad 1824853
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 4/19/19 1:07 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> This is a case where we generate more than 64k code for a mere 231
>> guest instructions.
> 
> I would like to know more! Are these unrolled vector ops or something else?

Yes.  E.g.

  ld4  { v0.16b - v3.16b }, [x0]

will generate 64 guest byte loads.  Given the size of the code
generated for each guest memory operation, we should probably
change this to use 64-bit loads and dole out the bytes manually.

Even for linux-user, with direct host memory ops this converts
to 1k code.

r~
