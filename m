Received: from eggs.gnu.org ([2001:4830:134:3::10]:58468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etDBm-0001W5-4b
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etDBi-0004Vl-4V
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:03:34 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1etDBh-0004VJ-Tu
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:03:30 -0500
Received: by mail-wm0-x241.google.com with SMTP id i3so22359225wmi.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 06:03:29 -0800 (PST)
References: <20180303143823.27055-1-richard.henderson@linaro.org>
	<20180303143823.27055-2-richard.henderson@linaro.org>
	<87a7vltmka.fsf@linaro.org>
	<CAFEAcA8hNzeCSe2DNwUfzeKOSonHY5uoc31m68F2YQsvcyjJLQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8hNzeCSe2DNwUfzeKOSonHY5uoc31m68F2YQsvcyjJLQ@mail.gmail.com>
Date: Tue, 06 Mar 2018 14:03:27 +0000
Message-ID: <877eqpti6o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 1/5] linux-user: Implement
 aarch64 PR_SVE_SET/GET_VL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 6 March 2018 at 12:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> As an implementation choice, widening VL has zeroed the
>>> previously inaccessible portion of the sve registers.
>>>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
>>> +                int old_vq =3D (env->vfp.zcr_el[1] & 0xf) + 1;
>>> +                int vq =3D MAX(arg2 / 16, 1);
>>> +
>>> +                if (vq < old_vq) {
>>> +                    aarch64_sve_narrow_vq(env, vq);
>>> +                }
>>> +                env->vfp.zcr_el[1] =3D vq - 1;
>>
>> It seems odd not to have setting this inside cpu64.c. Won't a similar
>> manipulation need to be made for system mode? I'd keep all the logic
>> together in aarch64_sve_narrow_vq (or maybe call it aarch64_sve_set_vq
>> and pass it the current exception level).
>
> I think I asked Richard to put it into linux-user because it was
> in target/arm in an earlier version of this series. The manipulation
> that's happening here is kind of linux-specific (if it were for
> system mode we'd need to think about ZCR_EL2 and ZCR_EL3 as well),
> and the analogy is with cpu_set_tls/cpu_get_tls which are in
> linux-user/arm/target_cpu.h.

Fair enough.

>
> NB: I've already put this series in target-arm.next -- do you want
> me to drop them ? (That would mean they won't go in 2.12, given
> RTH is away.)

No it's fine. We can always fix up minor nits later when system mode is
done.

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
