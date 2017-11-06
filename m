Received: from eggs.gnu.org ([2001:4830:134:3::10]:47825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBlOy-00046G-LN
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBlOu-0000Ea-EK
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:41:36 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:53613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBlOu-0000E8-84
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:41:32 -0500
Received: by mail-wr0-f196.google.com with SMTP id u40so9366306wrf.10
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 09:41:31 -0800 (PST)
References: <20171106005656.GC84093@humpty.home.comstyle.com>
	<CAFEAcA_2i0p9C3amtoB0o9Y4K83aCP7Gkw1cDqmLjrkLwJTZxg@mail.gmail.com>
	<20171106112638.GF23361@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7733d617-0e56-acdc-ad6d-aafce0c7160d@redhat.com>
Date: Mon, 6 Nov 2017 18:41:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171106112638.GF23361@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] osdep: Deal with TIME_MAX and OpenBSD
 64-bit time_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>

On 06/11/2017 12:26, Daniel P. Berrange wrote:
> On Mon, Nov 06, 2017 at 10:51:16AM +0000, Peter Maydell wrote:
>> On 6 November 2017 at 00:56, Brad Smith <brad@comstyle.com> wrote:
>>> Define TIME_MAX to LLONG_MAX for OpenBSD since OpenBSD uses 64-bit time_t.
>>>
>>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>>
>>>
>>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>>> index 6855b94bbf..824714049b 100644
>>> --- a/include/qemu/osdep.h
>>> +++ b/include/qemu/osdep.h
>>> @@ -132,8 +132,12 @@ extern int daemon(int, int);
>>>  #define ESHUTDOWN 4099
>>>  #endif
>>>  #ifndef TIME_MAX
>>> +#ifdef __OpenBSD__
>>> +#define TIME_MAX LLONG_MAX
>>> +#else
>>>  #define TIME_MAX LONG_MAX
>>>  #endif
>>> +#endif
>>
>> I'm not really a fan of adding new OS-specific #ifdefs --
>> what if one of the other BSDs uses or switches to 64-bit
>> time_t for 32-bit platforms? Is there some way we can detect
>> this generically at compile time (possibly in configure) ?
> 
> You could use a pair of compile time asserts to figure it out.
> 
> Would need one compile test to check 32 vs 64 bit:
> 
>   #include <time.h>
>   char time_t_64bit[sizeof(time_t) == 8 ? 1 : -1];
> 
> and a second to check signed vs unsigned:
> 
>   #include <time.h>
>   char time_t_signed[(time_t) -1 < 0 ? 1 : -1];
> 
> 
> Save each of these programs to the file $TMPC, and then run 'compile_object'
> from configure. You then have a decision matrix for 4 different TIME_MAX
> values to write into config-host.h.

What about

#define type_max(t)                   \
    ((t) -1 > 0                       \
     ? (t)~0                          \
     : (((t)1) <<                     \
         (sizeof(t) * 8 - 1)) - 1)    \

#define TIME_MAX type_max(time_t)

?  We don't need it to be a cpp constant, do we?  Or if we did, we could
assume it to be signed, it's enough for the three users.

Thanks,

Paolo
