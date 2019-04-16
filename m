Received: from eggs.gnu.org ([209.51.188.92]:42856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGSJN-0004kF-QJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGSJK-0005jS-OQ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:56:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hGSJH-0005UB-HY
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:55:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so2868618wmi.0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:55:36 -0700 (PDT)
References: <20190416083150.19649-1-richard.henderson@linaro.org>
	<20190416083150.19649-3-richard.henderson@linaro.org>
	<6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <df82da11-f32e-f07c-15fe-0fb9b5f3540a@redhat.com>
Date: Tue, 16 Apr 2019 19:55:29 +0200
MIME-Version: 1.0
In-Reply-To: <6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] tcg: Restart after TB code generation
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 4/16/19 7:47 PM, Eric Blake wrote:
> On 4/16/19 3:31 AM, Richard Henderson wrote:
>> If a TB generates too much code, try again with fewer insns.
>>
>> Fixes: https://bugs.launchpad.net/bugs/1824853
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  accel/tcg/translate-all.c | 39 +++++++++++++++++++++++++++++++++------
>>  tcg/tcg.c                 |  4 ++++
>>  2 files changed, 37 insertions(+), 6 deletions(-)
>>
> 
>> +             * Try again with half as many insns as we attempted this time.
>> +             * If a single insn overflows, there's a bug somewhere...
>> +             */
>> +            max_insns = tb->icount;
>> +qemu_log("TB overflow: pc=%lx insns=%d\n", (unsigned long)pc, max_insns);
> 
> Leftover debugging? Or should it be kept but properly indented?

Oops. I'd rather keep it between #ifdef CONFIG_DEBUG_TCG/#endif.
