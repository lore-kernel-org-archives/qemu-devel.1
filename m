Received: from eggs.gnu.org ([2001:4830:134:3::10]:52027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYxFN-0001gi-GH
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYxFK-0004UT-8T
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:04:05 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYxFJ-0004Ta-PK
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:04:02 -0500
Received: by mail-pl1-x642.google.com with SMTP id 101so6497236pld.6
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 10:04:01 -0800 (PST)
References: <20181214201855.14476-1-richard.henderson@linaro.org>
	<87k1k8gic7.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <32f6ded3-4dc8-7d3f-b68b-741528433380@linaro.org>
Date: Mon, 17 Dec 2018 10:03:56 -0800
MIME-Version: 1.0
In-Reply-To: <87k1k8gic7.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Convert ARM_TBFLAG_* to FIELDs
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

On 12/17/18 9:43 AM, Alex Bennée wrote:
>> Use "register" TBFLAG_ANY to indicate shared state between
>> A32 and A64, and "registers" TBFLAG_A32 & TBFLAG_A64 for
>> fields that are specific to the given cpu state.
>>
>> Move ARM_TBFLAG_BE to shared state, instead of its current
>> placement within "Bit usage when in AArch32 state".
> 
> This looks like a worthwhile clean-up but really we need to defer this
> calculation. It's in the top 2 hot functions on my build load stressor:
> 
>    5.74%  qemu-system-aarch64      [.] helper_lookup_tb_ptr
>    5.05%  qemu-system-aarch64      [.] get_phys_addr_lpae
>    4.39%  qemu-system-aarch64      [.] cpu_get_tb_cpu_state
>    3.73%  qemu-system-aarch64      [.] tcg_gen_code
>    3.65%  qemu-system-aarch64      [.] qht_lookup_custom

Yes, I know.  We need to put on our thinking caps and come up with a scheme
that minimizes the chances of missing an update to any (partially) pre-computed
value.

That has been Peter's (legitimate) resistance to such a scheme so far.  There
are a *lot* of variables that go into computing tb->flags.

In the meantime this patch just makes the task of adding bits less ugly.


r~
