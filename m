Received: from eggs.gnu.org ([2001:4830:134:3::10]:32967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cUEL6-0000o7-Ai
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cUEL3-0002yP-3Z
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:09:24 -0500
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:33828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cUEL2-0002y9-V5
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:09:21 -0500
Received: by mail-yb0-x241.google.com with SMTP id w194so2810799ybe.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 07:09:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-2-git-send-email-batuzovk@ispras.ru>
	<4d351b53-8724-b245-0077-942de1bebd66@twiddle.net>
	<alpine.DEB.2.11.1701191515580.1724@bulbul.intra.ispras.ru>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7178d6dd-4252-ad60-e1f0-51acffcd393c@twiddle.net>
Date: Thu, 19 Jan 2017 07:09:16 -0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1701191515580.1724@bulbul.intra.ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/18] tcg: add support for 128bit vector
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01/19/2017 05:04 AM, Kirill Batuzov wrote:
> On Wed, 18 Jan 2017, Richard Henderson wrote:
>
>> On 01/17/2017 01:07 AM, Kirill Batuzov wrote:
>>> +static inline TCGv_v128 tcg_global_mem_new_v128(TCGv_ptr reg, intptr_t
>>> offset,
>>> +                                                const char *name)
>>> +{
>>> +    int idx = tcg_global_mem_new_internal(TCG_TYPE_V128, reg, offset,
>>> name);
>>> +    return MAKE_TCGV_V128(idx);
>>> +}
>>
>> You shouldn't allow a v128 type to be created if the host doesn't support it.
>
> The idea here was to create it either way, but make sure no operation
> will ever be issued if host does not support it (tcg_gen_* wrappers take
> care of this).

Huh?  If you issue *no* operation, then how is the operation being emulated?

> I'm not sure about this last part. The host may not have i64, so there
> should be another case - 4 x i32. So we'll get 4 cases for v128:

Recursively you'd get 4 x i32, but at least they'll be tagged TCG_TYPE_I64, and 
be handled by the rest of the tcg code generator like it should be.

>
> v128
> 2 x v64
> 2 x i64
> 4 x i32
>
> 3 cases will need to be added to tcg_temp_new_internal and
> tcg_global_new_mem_internal, two of which are rather useless (2 x i64, 4 x i32).
> Introduction of v256 will add 4 more cases two of which will be useless
> again. This sounds like too much code that serves no purpose to me.

Useless?  Surely you mean "used by hosts that don't implement v128".

I think one of us is very confused about how you intend to generate fallback 
code.  Perhaps any future patchset revision should update tcg/README first.


r~
