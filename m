Received: from eggs.gnu.org ([208.118.235.92]:58534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbk8Q-0000Pk-Ey
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 05:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbk8L-0006n3-HB
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 05:40:26 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbk8L-0006lx-BU
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 05:40:21 -0500
Received: by mail-wr1-x430.google.com with SMTP id r10so13398436wrs.10
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 02:40:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<11a6562f583531e5a5473716bea44ee3ae7be120.1545598229.git.DirtY.iCE.hu@gmail.com>
	<66e793ef-dd32-eb81-14f5-cf59ca8c73bb@amsat.org>
	<980b862a-9c2d-8ab7-2937-846524399148@gmail.com>
	<42f870e2-97bc-1028-3587-d9ae31537a13@amsat.org>
	<20a6e023-89be-f2e1-aa11-0686a1dfe021@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3ff67b65-935e-9149-05a7-543752723b06@amsat.org>
Date: Tue, 25 Dec 2018 11:40:16 +0100
MIME-Version: 1.0
In-Reply-To: <20a6e023-89be-f2e1-aa11-0686a1dfe021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 23/52] audio: remove audio_MIN, audio_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>

On 12/24/18 9:48 PM, Kővágó Zoltán wrote:
> On 2018-12-24 18:16, Philippe Mathieu-Daudé wrote:
>> On 12/24/18 3:16 AM, Zoltán Kővágó wrote:
>>> Hi Phil,
>>>
>>> On 2018-12-24 00:49, Philippe Mathieu-Daudé wrote:
>>>> Hi Zoltán,
>>>>
>>>> On 12/23/18 9:51 PM, Kővágó, Zoltán wrote:
>>>>> There's already a MIN and MAX macro in include/qemu/osdep.h, use them
>>>>> instead.
>>>>>
>>>>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>>>>>
>>>>> ---
>>>>>
>>>>> Changes from v1:
>>>>> * removed audio_MIN, audio_MAX macros
>>>>> ---
>>>> [...]>
>>>>> diff --git a/audio/audio.h b/audio/audio.h
>>>>> index ccfef9e10a..bcbe56d639 100644
>>>>> --- a/audio/audio.h
>>>>> +++ b/audio/audio.h
>>>>> @@ -148,23 +148,6 @@ static inline void *advance (void *p, int incr)
>>>>>      return (d + incr);
>>>>>  }
>>>>>  
>>>>> -#ifdef __GNUC__
>>>>> -#define audio_MIN(a, b) ( __extension__ ({      \
>>>>> -    __typeof (a) ta = a;                        \
>>>>> -    __typeof (b) tb = b;                        \
>>>>> -    ((ta)>(tb)?(tb):(ta));                      \
>>>>> -}))
>>>>> -
>>>>> -#define audio_MAX(a, b) ( __extension__ ({      \
>>>>> -    __typeof (a) ta = a;                        \
>>>>> -    __typeof (b) tb = b;                        \
>>>>> -    ((ta)<(tb)?(tb):(ta));                      \
>>>>> -}))
>>>>> -#else
>>>>> -#define audio_MIN(a, b) ((a)>(b)?(b):(a))
>>>>> -#define audio_MAX(a, b) ((a)<(b)?(b):(a))
>>>>> -#endif
>>>>> -
>>>>
>>>> Those MIN/MAX are smarter than the ones in "qemu/osdep.h", I'd keep them
>>>> moving them there.
>>>
>>> Yes, but only when using gcc (or clang when it emulates gcc).
>>> Unfortunately, they work differently when one of the expressions has
>>> side effects, which is a disaster waiting to happen (when some poor folk
>>> finally tries to compile it with a non-gcc compiler).
>>
>> We already use the typeof extension:
>>
>> $ git grep typeof|wc -l
>> 145
>>
>> For MIN/MAX I'd use rather use the __auto_type extension.
>>
>>> Or do we support any compilers beside gcc and clang? Because if not,
>>> sure, do it, just remove the #ifdef and keep only the gcc version.
>>
>> Yes, this is checked by the ./configure script:
>>
>> 1850 # Check whether the compiler matches our minimum requirements:
>> ...
>> 1859 #   error You need at least Clang v3.4 to compile QEMU
>> ...
>> 1864 #  error You need at least GCC v4.8 to compile QEMU
>> ...
>> 1867 # error You either need GCC or Clang to compiler QEMU
> 
> Fair enough. I've tried to check the documentation for supported
> compilers, but I haven't found any info. Well, I didn't look at the
> configure script, I admit that.

You haven't found any info because the minimum requirements are not well
documented on the wiki.

> 
> This is what I came up with:
> 
> #ifndef MIN
> #define MIN(a, b) ( __extension__ ({      \
>     __auto_type _a = (a);                 \
>     __auto_type _b = (b);                 \
>     _a > _b ? _b : _a;                    \
> }))
> #endif
> #ifndef MAX
> #define MAX(a, b) ( __extension__ ({      \
>     __auto_type _a = (a);                 \
>     __auto_type _b = (b);                 \
>     _a < _b ? _b : _a;                    \
> }))
> #endif
> 
> 
> I changed it a bit, since a and b are the macro parameters, so they are
> the variables that we should put into parentheses, and I renamed ta/tb
> to _a/_b, this way they're less likely to clobber some other variables.

Sounds good. Now the parentheses around a/b are not necessary.

I wonder however if it wouldn't be cleaner to previously add:

#ifdef MIN
# undef MIN
#endif

and for MAX, rather than only use these macros if undefs.

> To be honest, we could probably drop the __extension__ keyword too,
> we're not compiling with -pedantic. Other than audio_MIN and audio_MAX,
> it only appears in the DO_UPCAST macro.

Fine with me!

If you have this patch ready, you can send it alone out of this series,
no need to resend this whole series for this patch.

Thanks,

Phil.
