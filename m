Received: from eggs.gnu.org ([2001:4830:134:3::10]:51807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e2C3E-0004tl-EE
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e2C38-0001Ln-Ia
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:07:36 -0400
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:58051)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1e2C38-0001Ks-BB
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:07:30 -0400
References: <20171007155522.25436-1-sw@weilnetz.de>
	<bfac5ec4-885e-7531-2d00-ce48bf518a6d@linaro.org>
	<c01459d1-81f4-8af3-4e52-f7703ff389ea@weilnetz.de>
	<d2025f3e-d54d-e5d0-d834-6e088a6f09ec@linaro.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <d72c1f3d-9f4f-ff08-4a27-e3b330333c6c@weilnetz.de>
Date: Tue, 10 Oct 2017 18:48:32 +0200
MIME-Version: 1.0
In-Reply-To: <d2025f3e-d54d-e5d0-d834-6e088a6f09ec@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Fix compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 10.10.2017 um 16:43 schrieb Richard Henderson:
> On 10/09/2017 10:39 PM, Stefan Weil wrote:
>> Am 09.10.2017 um 23:58 schrieb Richard Henderson:
>>> On 10/07/2017 08:55 AM, Stefan Weil wrote:
>>>> +        char *addr = memset_args->addr;
>>>> +        uint64_t numpages = memset_args->numpages;
>>>> +        uint64_t hpagesize = memset_args->hpagesize;
>>>> +        unsigned i;
>>> Match numpages properly while you're at it?
>>>
>>>
>>> r~
>> Do you mean using uint64_t for the loop variable i?
> Yes.
>
>> Sure. I only hesitated to do that because it is so huge.
>> A 64 bit loop variable looks strange, and the loop would
>> take some time if it really uses that range. :-)
> Why would we use a 64-bit variable for numpages if we don't expect such a
> value?  What I see, from spot review only, is an apparent bug -- the iterator
> type does not match the bound type.

If we really expect more than 2^32 pages, touching all those pages
will need a significant time even on fast machines.

It looks like that function is called in its own thread.
Can we be sure that there is no more than one thread of that kind,
or do we need more code to disallow a 2nd thread?
I don't think that touching the pages twice at the
same time makes sense.

What about using size_t instead of uint64_t? Parts of the code already
use size_t, and it makes a difference for QEMU running on 32 bit hosts.

Stefan
