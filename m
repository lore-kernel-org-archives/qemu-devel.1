Received: from eggs.gnu.org ([209.51.188.92]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gtpaR-0000ir-4I
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gtpaQ-0006em-9n
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:08:07 -0500
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:50666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gtpaQ-0006cb-2e
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:08:06 -0500
Received: from player730.ha.ovh.net (unknown [10.109.146.132])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 656BD51CA3
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 09:08:04 +0100 (CET)
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-8-clg@kaod.org>
	<20190212055900.GN1884@umbus.fritz.box>
	<56a5772ae88c5b5f65c969e2191a02d62cca5055.camel@kernel.crashing.org>
	<20190213045427.GK1884@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e830f4c8-57f4-a912-4d1a-700255f72a15@kaod.org>
Date: Wed, 13 Feb 2019 09:07:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190213045427.GK1884@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/19] target/ppc: Make special ORs match
 x86 pause and don't generate on mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/13/19 5:54 AM, David Gibson wrote:
> On Wed, Feb 13, 2019 at 11:03:12AM +1100, Benjamin Herrenschmidt wrote:
>> On Tue, 2019-02-12 at 16:59 +1100, David Gibson wrote:
>>> On Mon, Jan 28, 2019 at 10:46:13AM +0100, C=E9dric Le Goater wrote:
>>>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>
>>>> There's no point in going out of translation on an SMT OR with
>>>> mttcg since the backend won't do anything useful such as pausing,
>>>> it's only useful on traditional TCG to give time to other
>>>> processors.
>>>
>>> Is it actively harmful in the MTTCG case, or just pointless?
>>
>> I think it can hurt performance, I don't remember for sure :)
>>
>>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  target/ppc/translate.c | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>>> index e169c43643a1..7d40a1fbe6bd 100644
>>>> --- a/target/ppc/translate.c
>>>> +++ b/target/ppc/translate.c
>>>> @@ -1580,7 +1580,7 @@ static void gen_pause(DisasContext *ctx)
>>>>      tcg_temp_free_i32(t0);
>>>> =20
>>>>      /* Stop translation, this gives other CPUs a chance to run */
>>>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>>> +    gen_exception_nip(ctx, EXCP_INTERRUPT, ctx->base.pc_next);
>>>
>>> I don't see how this change relates to the rest.
>>
>> Yeah not sure anymore :-)
>=20
> Oh.  That certainly doesn't make this easier to review.
>=20
> So, all these target/ppc patches are only indirectly related to XIVE
> pnv support.  C=E9dric, can you split them out into their own series on
> the next spin.

Sure. I will address your comments and resend them first.
=20
Thanks,

C.

>=20
>>
>>>>  }
>>>>  #endif /* defined(TARGET_PPC64) */
>>>> =20
>>>> @@ -1662,7 +1662,9 @@ static void gen_or(DisasContext *ctx)
>>>>           * than no-op, e.g., miso(rs=3D26), yield(27), mdoio(29), m=
doom(30),
>>>>           * and all currently undefined.
>>>>           */
>>>> -        gen_pause(ctx);
>>>> +        if (!mttcg_enabled) {
>>>> +            gen_pause(ctx);
>>>> +        }
>>>>  #endif
>>>>  #endif
>>>>      }
>>
>=20
