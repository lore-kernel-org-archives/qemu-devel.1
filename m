Received: from eggs.gnu.org ([209.51.188.92]:36569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyhjy-0002zZ-DR
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyhjx-0002py-Io
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:46:06 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-4-david@redhat.com>
	<59942bd6-49ca-504f-0d2a-910939eea09d@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a631ec6e-6d65-a265-88c8-2e75930e6a6a@redhat.com>
Date: Tue, 26 Feb 2019 19:45:54 +0100
MIME-Version: 1.0
In-Reply-To: <59942bd6-49ca-504f-0d2a-910939eea09d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/33] s390x: Add one temporary vector
 register in CPU state for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 26.02.19 19:36, Richard Henderson wrote:
> On 2/26/19 3:38 AM, David Hildenbrand wrote:
>> We sometimes want to work on a temporary vector register instead of the
>> actual destination, because source and destination might overlap. An
>> alternative would be loading the vector into two i64 variables, but than
>> separate handling for accessing the vector elements would be needed.
>> This is easier. Add one for now as that seems to be enough.
> 
> Hmm, I'll reserve judgment until I see how this is used.
> 
> For ARM SVE, I would allocate this temporary on the stack within the helper,
> and move one of the operands out of the way.  E.g.

Yes, I do the same for helpers. This, however is for TCG translated code :)

E.g. see

[PATCH v1 08/33] s390x/tcg: Implement VECTOR LOAD
[PATCH v1 19/33] s390x/tcg: Implement VECTOR MERGE (HIGH|LOW)
[PATCH v1 33/33] s390x/tcg: Implement VECTOR UNPACK *


> 
> void helper(foo)(void *vd, void *vx, *void *vy
> {
>     VectorReg tmp;
>     TYPE *d = vd, *x = vx, *y = vy;
> 
>     if (vx == vd || vy == vd) {
>         tmp = *(VectorReg *)vd;
>         if (vx == vd) {
>             vx = &tmp;
>         }
>         if (vy == vd) {
>             vy = &tmp;
>         }
>     }
> 
>     process d, x, y as normal.
> }
> 
> This minimized the amount of code inline.  However, SVE vectors are quite a bit
> larger, at 256 bytes, so the copy itself was out of line most of the time anyway.
> 
> Provisionally,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
