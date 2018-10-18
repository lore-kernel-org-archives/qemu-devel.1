Received: from eggs.gnu.org ([2001:4830:134:3::10]:50416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDCLk-0007vn-1E
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDCLj-0001k4-0R
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:44:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDCLi-0001il-No
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:44:42 -0400
Received: by mail-ot1-x343.google.com with SMTP id l58so30620490otd.6
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 10:44:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <528ec11f-c043-9e97-3de9-73d8f7f16bdf@redhat.com>
References: <1539845066-31635-1-git-send-email-dayeol@berkeley.edu>
	<528ec11f-c043-9e97-3de9-73d8f7f16bdf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 18:44:21 +0100
Message-ID: <CAFEAcA_A7cY3WgJpTPZjh4pwMSbcsFV=x061_f4a5FRJ6n4wCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] [PATCH] target/riscv/pmp.c:
 pmpcfg_csr_read return type demotion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Dayeol Lee <dayeol@berkeley.edu>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 18 October 2018 at 18:37, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Hi Lee,
>
> On 18/10/2018 08:44, Dayeol Lee wrote:
>> There is a data type demotion bug in target/riscv/pmp.c
>> When the target_ulong is 8 bytes, pmpcfg_csr_read returns only lower 4
>> bytes.
>> ---
>>  target/riscv/pmp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
>> index c828950..4b6c20e 100644
>> --- a/target/riscv/pmp.c
>> +++ b/target/riscv/pmp.c
>> @@ -337,7 +337,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uin=
t32_t reg_index)
>>
>>      for (i =3D 0; i < sizeof(target_ulong); i++) {
>>          val =3D pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + =
i);
>> -        cfg_val |=3D (val << (i * 8));
>> +        cfg_val |=3D ((target_ulong)val << ((target_ulong)i * 8));
>
> Casting 'val' seems correct, however you don't need to cast the 'i'.

You could just declare 'val' as a target_ulong to start with,
and avoid the need for a cast at all, I think ?

thanks
-- PMM
