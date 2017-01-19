Received: from eggs.gnu.org ([2001:4830:134:3::10]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cUFyx-0008Vy-P0
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cUFyt-0001Lm-QY
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:54:39 -0500
Received: from mail.ispras.ru ([83.149.199.45]:58452)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cUFyt-0001L9-IB
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:54:35 -0500
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-2-git-send-email-batuzovk@ispras.ru>
	<4d351b53-8724-b245-0077-942de1bebd66@twiddle.net>
	<alpine.DEB.2.11.1701191515580.1724@bulbul.intra.ispras.ru>
	<7178d6dd-4252-ad60-e1f0-51acffcd393c@twiddle.net>
From: Kirill Batuzov <batuzovk@ispras.ru>
Message-ID: <d3ca01a3-b8ed-93fd-235a-bd9b3adad838@ispras.ru>
Date: Thu, 19 Jan 2017 19:54:24 +0300
MIME-Version: 1.0
In-Reply-To: <7178d6dd-4252-ad60-e1f0-51acffcd393c@twiddle.net>
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
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 19.01.2017 18:09, Richard Henderson wrote:
> On 01/19/2017 05:04 AM, Kirill Batuzov wrote:
>> On Wed, 18 Jan 2017, Richard Henderson wrote:
>>
>>> On 01/17/2017 01:07 AM, Kirill Batuzov wrote:
>>>> +static inline TCGv_v128 tcg_global_mem_new_v128(TCGv_ptr reg, intptr_t
>>>> offset,
>>>> +                                                const char *name)
>>>> +{
>>>> +    int idx = tcg_global_mem_new_internal(TCG_TYPE_V128, reg, offset,
>>>> name);
>>>> +    return MAKE_TCGV_V128(idx);
>>>> +}
>>>
>>> You shouldn't allow a v128 type to be created if the host doesn't
>>> support it.
>>
>> The idea here was to create it either way, but make sure no operation
>> will ever be issued if host does not support it (tcg_gen_* wrappers take
>> care of this).
>
> Huh?  If you issue *no* operation, then how is the operation being
> emulated?

Wrappers issue emulation code instead of operation if it is not 
supported by host.

tcg_gen_add_i32x4 looks like this:

if (TCG_TARGET_HAS_add_i32x4) {
     tcg_gen_op3_v128(INDEX_op_add_i32x4, args[0], args[1], args[2]);
} else {
     for (i = 0; i < 4; i++) {
         tcg_gen_ld_i32(...);
         tcg_gen_ld_i32(...);
         tcg_gen_add_i32(...);
         tcg_gen_st_i32(...);
     }
}

So no operation working directly with TCGV_v128 temp should appear 
anywhere in the intermediate representation unless host claims it 
supports it (in which case it must support 128-bit type as well).

>
>> I'm not sure about this last part. The host may not have i64, so there
>> should be another case - 4 x i32. So we'll get 4 cases for v128:
>
> Recursively you'd get 4 x i32, but at least they'll be tagged
> TCG_TYPE_I64, and be handled by the rest of the tcg code generator like
> it should be.
>
>>
>> v128
>> 2 x v64
>> 2 x i64
>> 4 x i32
>>
>> 3 cases will need to be added to tcg_temp_new_internal and
>> tcg_global_new_mem_internal, two of which are rather useless (2 x i64,
>> 4 x i32).
>> Introduction of v256 will add 4 more cases two of which will be useless
>> again. This sounds like too much code that serves no purpose to me.
>
> Useless?  Surely you mean "used by hosts that don't implement v128".

I meant that host that doesn't support v128 type will not use this 
variables. It'll use their memory locations instead, so it does not 
matter how we represent them. The only TCG code that'll see them is 
tcg_gen_<vector_op> wrappers which know how to deal with them.

2 x v64 is a different story. We can make a much better emulation code 
if we represent a v128 variable as a pair of v64 variables and work with 
them as variables.

>
> I think one of us is very confused about how you intend to generate
> fallback code.  Perhaps any future patchset revision should update
> tcg/README first.
>

Sure, I'll do it in v2.

-- 
Kirill
