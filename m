Received: from eggs.gnu.org ([2001:4830:134:3::10]:34724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ehkhV-00089u-4g
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 18:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ehkhU-0007Jb-8b
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 18:24:57 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:40499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ehkhU-0007JI-0O
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 18:24:56 -0500
Received: by mail-lf0-x241.google.com with SMTP id h92so33799918lfi.7
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 15:24:55 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <a5b70a60-86a3-a757-ecfe-dde7d6456682@amsat.org>
References: <8be93dc009d8473294b1adc26657058b8e56a550.1517600250.git.alistair.francis@xilinx.com>
	<a5b70a60-86a3-a757-ecfe-dde7d6456682@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 2 Feb 2018 15:24:23 -0800
Message-ID: <CAKmqyKN5CxH_bZgfz1DxDiLgouvE5nxeMyszxoDAMd75iQAk8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw: register: Run post_write hook
 on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Feb 2, 2018 at 12:24 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Alistair,
>
> On 02/02/2018 04:38 PM, Alistair Francis wrote:
>> Ensure that the post write hook is called during reset. This allows us
>> to rely on the post write functions instead of having to call them from
>> the reset() function.
>
> This makes sens. Can you add a comment about this new behavior in
> include/hw/register.h?

Yep, fixed in V2 which I'll send out next week.

Alistair

>
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>
> with comment:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> ---
>>
>>  hw/core/register.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/core/register.c b/hw/core/register.c
>> index 900294b9c4..0741a1af32 100644
>> --- a/hw/core/register.c
>> +++ b/hw/core/register.c
>> @@ -159,13 +159,21 @@ uint64_t register_read(RegisterInfo *reg, uint64_t=
 re, const char* prefix,
>>
>>  void register_reset(RegisterInfo *reg)
>>  {
>> +    const RegisterAccessInfo *ac;
>> +
>>      g_assert(reg);
>>
>>      if (!reg->data || !reg->access) {
>>          return;
>>      }
>>
>> +    ac =3D reg->access;
>> +
>>      register_write_val(reg, reg->access->reset);
>> +
>> +    if (ac->post_write) {
>> +        ac->post_write(reg, reg->access->reset);
>> +    }
>>  }
>>
>>  void register_init(RegisterInfo *reg)
>>
