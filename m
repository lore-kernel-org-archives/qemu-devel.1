Received: from eggs.gnu.org ([2001:4830:134:3::10]:57081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTt4L-0000WM-Kd
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTt4H-00034P-Lc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:35:45 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTt4F-00033P-Ec
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:35:39 -0500
Received: by mail-oi1-x244.google.com with SMTP id w13so11844627oiw.9
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 10:35:39 -0800 (PST)
References: <20181203160840.15115-1-richard.henderson@linaro.org>
	<20181203160840.15115-6-richard.henderson@linaro.org>
	<58a36fe9-8a56-d949-a942-a5ca3cc243f5@gmx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad5bd9c1-72fd-496c-0cb8-4c94cd27e919@linaro.org>
Date: Mon, 3 Dec 2018 12:35:35 -0600
MIME-Version: 1.0
In-Reply-To: <58a36fe9-8a56-d949-a942-a5ca3cc243f5@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 5/5] tcg/i386: Add
 setup_guest_base_seg for FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

On 12/3/18 11:01 AM, Kamil Rytarowski wrote:
> On 03.12.2018 17:08, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  tcg/i386/tcg-target.inc.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
>> index b8d2dd5ba3..3a39b51685 100644
>> --- a/tcg/i386/tcg-target.inc.c
>> +++ b/tcg/i386/tcg-target.inc.c
>> @@ -1873,6 +1873,15 @@ static inline int setup_guest_base_seg(void)
>>      }
>>      return 0;
>>  }
>> +# elif defined (__FreeBSD__) || defined (__FreeBSD_kernel__)
>> +#  include <machine/sysarch.h>
>> +static inline int setup_guest_base_seg(void)
>> +{
>> +    if (sysarch(AMD64_SET_GSBASE, &guest_base) == 0) {
>> +        return P_GS;
>> +    }
>> +    return 0;
>> +}
>>  # else
>>  static inline int setup_guest_base_seg(void)
>>  {
>>
> 
> There is also X86_SET_GSBASE in <include/sysarch.h> in NetBSD. Do we
> need to set it for this OS too?

You will want to do so, yes.  In the meantime NetBSD should not break; it is
only an optimization.


r~
