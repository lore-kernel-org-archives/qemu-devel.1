Received: from eggs.gnu.org ([2001:4830:134:3::10]:45101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1UML-0007MS-JF
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1UMI-0000s1-HJ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:00:41 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:40720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1UMI-0000rX-Ab
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:00:38 -0400
Received: by mail-wm0-x232.google.com with SMTP id x4so10403951wmh.5
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:00:38 -0700 (PDT)
References: <1522128840-498-1-git-send-email-cota@braap.org>
	<1522128840-498-10-git-send-email-cota@braap.org>
	<87in9g8h6h.fsf@linaro.org> <20180328222517.GA31554@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180328222517.GA31554@flamenco>
Date: Thu, 29 Mar 2018 11:00:31 +0100
Message-ID: <87370j8am8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/14] hardfloat: support float32/64
 multiplication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Emilio G. Cota <cota@braap.org> writes:

> On Wed, Mar 28, 2018 at 14:26:30 +0100, Alex Benn=C3=A9e wrote:
>> Emilio G. Cota <cota@braap.org> writes:
>> OK I've had a bit more of a play and I think we can drop the macro abuse
>> and have common wrappers for the host_fpu. We don't want to intermingle
>> with the soft float slow path to stop the compiler adding overhead. We
>> also need a wrapper for each float size and op count due to differences
>> in the classify functions. However the boiler plate is pretty common and
>> where there are differences the compiler is smart enough to fix it.
>>
>> See branch:
>> https://github.com/stsquad/qemu/tree/hostfloat/common-fpu-wrapper
>>
>> I keep the numbers for add/sub and doubled the speed of float32_mul on
>> my box, without any macros ;-)
>
> I really like the idea of letting the compiler unfold everything.
> In fact I just did that to re-implement fp-bench (now with support
> for -t host/soft, yay).

It's a poor mans templates but it certainly makes reading and debugging
the code a lot easier. Of course sometimes it does feel like you are
doing more work to guide the compiler to the right answer....

>
>> Full patch inline:
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index d0f1f65c12..89217b5e67 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -879,56 +879,72 @@ soft_float64_sub(float64 a, float64 b, float_statu=
s *status)
>>      return float64_round_pack_canonical(pr, status);
>>  }
> (snip)
>> +static float fpu_mul32(float a, float b, bool *nocheck) {
>> +
>> +    if (float32_is_zero(a) || float32_is_zero(b)) {
>> +        bool signbit =3D float32_is_neg(a) ^ float32_is_neg(b);
>> +        *nocheck =3D true;
>> +        return float32_set_sign((0), signbit);
>> +    } else {
>> +        float ha =3D float32_to_float(a);
>> +        float hb =3D float32_to_float(b);
>> +        float hr =3D ha * hb;
>> +        return hr;
>>      }
>> +}
>
> This function is wrong :-(
>
> Note that a and b are floats, not float32's. So if any of
> them is 0.X then they get silently converted to 0, which goes via the
> fast(er) path above. This explains the speedup.

So we need to push the casting into the helpers. Well at least it didn't
get any slower once fixed ;-)

>
> Note that you could have caught this with:
>
>   $ ./fp-test -t soft ibm/* -w whitelist.txt -e x
>
> Compiling with -Wconversion would also point these out, but the output
> is way too noisy to be useful.
>
>
> That said, I'll take inspiration from your approach for v3--hopefully
> without (many) macros this time round.
>
> Thanks!
>
> 		Emilio


--
Alex Benn=C3=A9e
