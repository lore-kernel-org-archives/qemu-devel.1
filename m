Received: from eggs.gnu.org ([2001:4830:134:3::10]:33934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIzDD-00045g-J5
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIzDC-00056r-Tk
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:23:35 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIzDC-00056Z-OI
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:23:34 -0400
Received: by mail-oi0-x243.google.com with SMTP id k5-v6so1275542oiw.0
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:23:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2c55370d-fa43-12a1-5baf-ec7cf824c0dc@amsat.org>
References: <1526493784-25328-1-git-send-email-eric.auger@redhat.com>
	<1526493784-25328-3-git-send-email-eric.auger@redhat.com>
	<2c55370d-fa43-12a1-5baf-ec7cf824c0dc@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 May 2018 16:23:13 +0000
Message-ID: <CAFEAcA-GxScM9StKESYAqJ2sbiSH+hWjJXvF7COjJPojs5J5QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] hw/arm/smmu-common: Fix
 coverity issue in get_block_pte_address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Auger <eric.auger@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 16 May 2018 at 16:16, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Hi Eric,
>
> On 05/16/2018 03:03 PM, Eric Auger wrote:
>> Coverity points out that this can overflow if n > 31,
>> because it's only doing 32-bit arithmetic. Let's use 1ULL instead
>> of 1. Also the formulae used to compute n can be replaced by
>> the level_shift() macro.
>
> This level_shift() replacement doesn't seems that obvious to me, can you
> split it in another patch?
>
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmu-common.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 01c7be8..3c5f724 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -83,9 +83,9 @@ static inline hwaddr get_table_pte_address(uint64_t pt=
e, int granule_sz)
>>  static inline hwaddr get_block_pte_address(uint64_t pte, int level,
>>                                             int granule_sz, uint64_t *bs=
z)
>>  {
>> -    int n =3D (granule_sz - 3) * (4 - level) + 3;
>> +    int n =3D level_shift(level, granule_sz);
>
> Shouldn't this be level_shift(level + 1, granule_sz)?

No. The two expressions are equivalent, they're
just arranged differently:

   level_shift(lvl, gsz)
      =3D=3D gsz + (3 - lvl) * (gsz - 3)
      =3D=3D gsz + (4 - lvl) * (gsz - 3) - (gsz - 3)
      =3D=3D gsz - gsz + (4 - lvl) * (gsz - 3) + 3
      =3D=3D (gsz - 3) * (4 - lvl) + 3

thanks
-- PMM
