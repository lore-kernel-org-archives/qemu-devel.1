Received: from eggs.gnu.org ([2001:4830:134:3::10]:57456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX6Zf-0004hv-9w
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX6Ze-0006uW-4m
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:28:19 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:34890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX6Zd-0006u4-VI
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:28:18 -0500
Received: by mail-vk0-x231.google.com with SMTP id x75so175089530vke.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:28:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127103505.18606-17-alex.bennee@linaro.org>
References: <20170127103505.18606-1-alex.bennee@linaro.org>
	<20170127103505.18606-17-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 13:27:56 +0000
Message-ID: <CAFEAcA82McdB15znd7LK-OGkioHreht2Nk6h5t-As0JiYXHoRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 16/25] cputlb and arm/sparc targets:
 convert mmuidx flushes from varg to bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:Overall" <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 27 January 2017 at 10:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> While the vargs approach was flexible the original MTTCG ended up
> having munge the bits to a bitmap so the data could be used in
> deferred work helpers. Instead of hiding that in cputlb we push the
> change to the API to make it take a bitmap of MMU indexes instead.
>
> This change is fairly mechanical but as storing the actual index is
> useful for cases like the current running context. As a result the
> constants are renamed to ARMMMUBit_foo and a couple of helper
> functions added to convert between a single bit and a scalar index.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

So, as discussed on IRC, I don't think this is really the right
way to go. An MMU index is an index, ie it refers to a particular
TLB. Almost all the time you don't want to think of it as a bit
value. The only place that does care about that is places in
the TLB code which want to say "do some operation on multiple
TLBs at once", which is basically just the tlb_flush_by_mmuidx()
function. So that function should have an API that lets you
specify multiple TLBs (either the one it has now, or maybe one
where you pass it in a uint32_t with bits set).

That avoids either all or almost all of this churn.

> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1954,27 +1954,40 @@ static inline bool arm_excp_unmasked(CPUState *cs=
, unsigned int excp_idx,
>   * of the AT/ATS operations.
>   * The values used are carefully arranged to make mmu_idx =3D> EL lookup=
 easy.
>   */
> -typedef enum ARMMMUIdx {
> -    ARMMMUIdx_S12NSE0 =3D 0,
> -    ARMMMUIdx_S12NSE1 =3D 1,
> -    ARMMMUIdx_S1E2 =3D 2,
> -    ARMMMUIdx_S1E3 =3D 3,
> -    ARMMMUIdx_S1SE0 =3D 4,
> -    ARMMMUIdx_S1SE1 =3D 5,
> -    ARMMMUIdx_S2NS =3D 6,
> +typedef enum ARMMMUBitMap {
> +    ARMMMUBit_S12NSE0 =3D 1 << 0,
> +    ARMMMUBit_S12NSE1 =3D 1 << 1,
> +    ARMMMUBit_S1E2 =3D 1 << 2,
> +    ARMMMUBit_S1E3 =3D 1 << 3,
> +    ARMMMUBit_S1SE0 =3D 1 << 4,
> +    ARMMMUBit_S1SE1 =3D 1 << 5,
> +    ARMMMUBit_S2NS =3D 1 << 6,
>      /* Indexes below here don't have TLBs and are used only for AT syste=
m
>       * instructions or for the first stage of an S12 page table walk.
>       */
> -    ARMMMUIdx_S1NSE0 =3D 7,
> -    ARMMMUIdx_S1NSE1 =3D 8,
> -} ARMMMUIdx;
> +    ARMMMUBit_S1NSE0 =3D 1 << 7,
> +    ARMMMUBit_S1NSE1 =3D 1 << 8,
> +} ARMMMUBitMap;

In particular I'd be very wary of changing these values, because
as the comment says things are arranged carefully to make some
operations easy.

thanks
-- PMM
