Received: from eggs.gnu.org ([2001:4830:134:3::10]:36911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0myk-0002Pw-0C
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0myf-0003El-HG
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:41:26 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:34663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f0myf-0003EO-9w
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:41:21 -0400
Received: by mail-wm0-x232.google.com with SMTP id a20so20926394wmd.1
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 04:41:21 -0700 (PDT)
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-9-git-send-email-cota@braap.org>
	<67b8c0f8-3fd9-ba7c-a666-d0715b5a3329@linaro.org>
	<20180322055710.GA22376@flamenco>
	<959d13eb-498e-0bd6-2553-1b621a87f1bd@linaro.org>
	<20180322195721.GA22594@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180322195721.GA22594@flamenco>
Date: Tue, 27 Mar 2018 12:41:18 +0100
Message-ID: <87r2o5925d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 08/14] hostfloat: support float32/64
 addition and subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Emilio G. Cota <cota@braap.org> writes:

> On Thu, Mar 22, 2018 at 14:41:05 +0800, Richard Henderson wrote:
> (snip)
>> Another thought re all of the soft_is_normal || soft_is_zero checks that=
 you're
>> performing.  I think it would be nice if we could work with
>> float*_unpack_canonical so that we don't have to duplicate work.  E.g.
>>
>> /* Return true for float_class_normal && float_class_zero.  */
>> static inline bool is_finite(FloatClass c) { return c <=3D float_class_z=
ero; }
>>
>> float32 float32_add(float32 a, float32 b, float_status *s)
>> {
>>   FloatClass a_cls =3D float32_classify(a);
>>   FloatClass b_cls =3D float32_classify(b);
>
> Just looked at this. It can be done, although it comes at the
> price of some performance for fp-bench -o add:
> 180 Mflops vs. 196 Mflops, i.e. a 8% slowdown. That is with
> adequate inlining etc., otherwise perf is worse.
>
> I'm not convinced that we can gain much in simplicity to
> justify the perf impact. Yes, we'd simplify canonicalize(),
> but we'd probably need a float_class_denormal[*], which
> would complicate everything else.
>
> I think it makes sense to keep some inlines that work on
> the float32/64's directly.
>
>>   if (is_finite(a_cls) && is_finite(b_cls) && ...) {
>>       /* do hardfp thing */
>>   }
>
> [*] Taking 0, denormals and normals would be OK from correctness,
> but we really don't want to compute ops with denormal inputs on
> the host; it is very likely that the output will also be denormal,
> and we'll end up deferring to soft-fp anyway to avoid
> computing whether the underflow exception has occurred,
> which is expensive.
>
>>   pa =3D float32_unpack(a, ca, s);
>>   pb =3D float32_unpack(b, cb, s);
>>   pr =3D addsub_floats(pa, pb, s, false);
>>   return float32_round_pack(pr, s);
>> }
>
> It pays off to have two separate functions (add & sub) for the
> slow path. With soft_f32_add/sub factored out:
>
> $ taskset -c 0 x86_64-linux-user/qemu-x86_64 tests/fp-bench -o add
> 197.53 MFlops
>
> With the above four lines (pa...return) as an else branch:
> 169.16 MFlops
>
> BTW flattening makes things worse (150.63 MFlops).

That's disappointing. Did you look at the generated code? Because the
way we are abusing __flatten__ to effectively make a compile time
template you would hope it could pull the relevant classify bits to
before the hard float branch and do the rest later if needed.

Everything was inline or in softfloat.c for this test right?

>
> Note that fp-bench only tests normal numbers. But I think it's fair
> to assume that this is the path we want to speed up.
>
> Thanks,
>
> 		E.


--
Alex Benn=C3=A9e
