Received: from eggs.gnu.org ([2001:4830:134:3::10]:60285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePXq5-0001nT-3O
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePXq4-0007Ld-51
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:02:33 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:44195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePXq3-0007LA-Uq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:02:32 -0500
Received: by mail-it0-x244.google.com with SMTP id b5so13423522itc.3
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 10:02:31 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKNPY47rHEzOU0HScfN60UixdRtwYk_UGTbsdmbO3PCS8Q@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-14-f4bug@amsat.org>
	<CAKmqyKNPY47rHEzOU0HScfN60UixdRtwYk_UGTbsdmbO3PCS8Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 15:02:30 -0300
Message-ID: <CAAdtpL4FFHWcGujsW236qkkGvvEzBLzj94+wEsUMKt8XJiEU+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/14] sdhci: add sdhci_init_capareg() to
 initialize the CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Dec 14, 2017 at 2:51 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
> <f4bug@amsat.org> wrote:
>> following patches modifying CAPAB will be easier to review.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  hw/sd/sdhci.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index dadc4787b2..78bb8e8e89 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -100,6 +100,13 @@
>>
>>  #define MASKED_WRITE(reg, mask, val)  (reg =3D (reg & (mask)) | (val))
>>
>> +static void sdhci_init_capareg(SDHCIState *s, Error **errp)
>> +{
>> +    if (s->capareg =3D=3D UINT32_MAX) {
>> +        s->capareg =3D SDHC_CAPAB_REG_DEFAULT;
>> +    }
>> +}
>> +
>>  static uint8_t sdhci_slotint(SDHCIState *s)
>>  {
>>      return (s->norintsts & s->norintsigen) || (s->errintsts & s->errint=
sigen) ||
>> @@ -1158,6 +1165,8 @@ static void sdhci_initfn(SDHCIState *s)
>>
>>  static void sdhci_realizefn(SDHCIState *s, Error **errp)
>>  {
>> +    sdhci_init_capareg(s, errp);
>> +
>>      s->buf_maxsz =3D sdhci_get_fifolen(s);
>>      s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
>>
>> @@ -1244,8 +1253,7 @@ const VMStateDescription sdhci_vmstate =3D {
>>  /* Capabilities registers provide information on supported features of =
this
>>   * specific host controller implementation */
>>  static Property sdhci_properties[] =3D {
>> -    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
>> -            SDHC_CAPAB_REG_DEFAULT),
>> +    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg, UINT32_MAX),
>
> This looks like a step in the wrong direction.
>
> If this is required to do something smarter latter it should probably
> be in that series.

You are right, I might have add this patch in the incorrect series.
I'll move it to the one where the CAPAB register is correctly set
regarding the SDHCI supports the v2 or v3 spec.
