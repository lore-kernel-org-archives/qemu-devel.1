Received: from eggs.gnu.org ([2001:4830:134:3::10]:55253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cr6m9-0000lu-RU
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cr6m8-0004XX-Uw
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:43:53 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cr6m8-0004XN-RT
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:43:52 -0400
Received: by mail-yw0-x243.google.com with SMTP id h11so24380832ywa.2
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 10:43:52 -0700 (PDT)
MIME-Version: 1.0
Sender: bobby.prani@gmail.com
In-Reply-To: <575fee6e-489d-54a8-dfbc-1f42172d5713@redhat.com>
References: <CAG48ez1tcz7GGsc5+L3EF140NsW=UyNir=0UpuZZYrBn4ZxrSA@mail.gmail.com>
	<CAFEAcA8-GJxpmppZGF5ygSAL4Y81BdvYKqso-XhjR2pbjMLi+A@mail.gmail.com>
	<CAJhHMCA=rwLqLOPq3kMOz9SpV83yrzkK_K6RfPmuyXMU1pXT7g@mail.gmail.com>
	<CAFEAcA9ZtayLn-bOPL4=2=w0SS_H0-EYO0UpFzXJSvyueGOHMw@mail.gmail.com>
	<CAJhHMCAjG1kfG8-3E8CcWu4V2cWMsR0La6iZ3hq0rbM91+brsA@mail.gmail.com>
	<CAFEAcA-x8CbqVpnaszmdZzLZt6+urxSntdWxLHeFXAOy327OqA@mail.gmail.com>
	<CAJhHMCDfmT_zrnuEBcmoJ+CJV9j8CB79ybehWoMBeh3rd+hA3Q@mail.gmail.com>
	<9f45e912-5fc8-bb99-506e-221f2cb6ac7e@twiddle.net>
	<df57bde4-a33c-54b0-3f5a-3d0e28cdbca7@redhat.com>
	<CAJhHMCDke60mQgOza1xgTs9sSTcE0HESG7G=f3bQ5sP+0Baz0A@mail.gmail.com>
	<575fee6e-489d-54a8-dfbc-1f42172d5713@redhat.com>
From: Pranith Kumar <bobby.prani+qemu@gmail.com>
Date: Thu, 23 Mar 2017 13:43:21 -0400
Message-ID: <CAJhHMCAdxeQNJmkncB9+en1NSXgYUV8-wtsKEU1-FKo9TRUkdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [BUG] user-to-root privesc inside VM via bad
 translation caching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Qemu Developers <qemu-devel@nongnu.org>, Jann Horn <jannh@google.com>

On Thu, Mar 23, 2017 at 1:37 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 23/03/2017 17:50, Pranith Kumar wrote:
>> On Thu, Mar 23, 2017 at 6:27 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>>
>>> On 22/03/2017 21:01, Richard Henderson wrote:
>>>>>
>>>>> Ah, OK. Thanks for the explanation. May be we should check the size of
>>>>> the instruction while decoding the prefixes and error out once we
>>>>> exceed the limit. We would not generate any IR code.
>>>>
>>>> Yes.
>>>>
>>>> It would not enforce a true limit of 15 bytes, since you can't know that
>>>> until you've done the rest of the decode.  But you'd be able to say that
>>>> no more than 14 prefix + 1 opc + 6 modrm+sib+ofs + 4 immediate = 25
>>>> bytes is used.
>>>>
>>>> Which does fix the bug.
>>>
>>> Yeah, that would work for 2.9 if somebody wants to put together a patch.
>>>  Ensuring that all instruction fetching happens before translation side
>>> effects is a little harder, but perhaps it's also the opportunity to get
>>> rid of s->rip_offset which is a little ugly.
>>
>> How about the following?
>>
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index 72c1b03a2a..67c58b8900 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -4418,6 +4418,11 @@ static target_ulong disas_insn(CPUX86State
>> *env, DisasContext *s,
>>      s->vex_l = 0;
>>      s->vex_v = 0;
>>   next_byte:
>> +    /* The prefixes can atmost be 14 bytes since x86 has an upper
>> +       limit of 15 bytes for the instruction */
>> +    if (s->pc - pc_start > 14) {
>> +        goto illegal_op;
>> +    }
>>      b = cpu_ldub_code(env, s->pc);
>>      s->pc++;
>>      /* Collect prefixes.  */
>
> Please make the comment more verbose, based on Richard's remark.  We
> should apply it to 2.9.
>
> Also, QEMU usually formats comments with stars on every line.


OK. I'll send a proper patch with updated comment.

Thanks,
--
Pranith
