Received: from eggs.gnu.org ([2001:4830:134:3::10]:40379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwakj-0004Pf-Gp
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwaki-0005G6-Fh
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:17:21 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwaki-0005FZ-8k
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:17:20 -0400
Received: by mail-wm0-x242.google.com with SMTP id i131so7959589wma.1
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 14:17:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89F3RVOyu3SPHxZiPB-ws2sQhL71e21fAGP-_TCgOC3w@mail.gmail.com>
References: <150555367996.36.15771330325496067998@69b6ddf88678>
	<20170916103523.1482-1-m.olbrich@pengutronix.de>
	<CAKmqyKP_5dC1td8DMCEM_4v74XBZy5-rWH2z4XA8VCw4165SAg@mail.gmail.com>
	<20170919082358.43upqf3lawg2aqtg@pengutronix.de>
	<CAKmqyKOeYQHRytnhzmC0Tr3rp4KU8NomgnFhhcrKE5KP75WMow@mail.gmail.com>
	<20170920061905.rbv3g2ubd4c5zvn4@pengutronix.de>
	<CAFEAcA89F3RVOyu3SPHxZiPB-ws2sQhL71e21fAGP-_TCgOC3w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 25 Sep 2017 14:16:47 -0700
Message-ID: <CAKmqyKO19A7ZKEKkLToW23jFZH1pdtv17Y4Hj==TE7ZGGFpW6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/sd: fix out-of-bounds check for
 multi block reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Olbrich <m.olbrich@pengutronix.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Sep 25, 2017 at 12:27 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 20 September 2017 at 07:19, Michael Olbrich <m.olbrich@pengutronix.de> wrote:
>> On Tue, Sep 19, 2017 at 05:09:51PM -0700, Alistair Francis wrote:
>>> On Tue, Sep 19, 2017 at 1:23 AM, Michael Olbrich
>>> <m.olbrich@pengutronix.de> wrote:
>>> > On Mon, Sep 18, 2017 at 02:28:26PM -0700, Alistair Francis wrote:
>>> >> On Sat, Sep 16, 2017 at 3:35 AM, Michael Olbrich
>>> >> <m.olbrich@pengutronix.de> wrote:
>>> >> >  hw/sd/sd.c | 12 ++++++------
>>> >> >  1 file changed, 6 insertions(+), 6 deletions(-)
>>> >> >
>>> >> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> >> > index ba47bff4db80..35347a5bbcde 100644
>>> >> > --- a/hw/sd/sd.c
>>> >> > +++ b/hw/sd/sd.c
>>> >> > @@ -1797,8 +1797,13 @@ uint8_t sd_read_data(SDState *sd)
>>> >> >          break;
>>> >> >
>>> >> >      case 18:   /* CMD18:  READ_MULTIPLE_BLOCK */
>>> >> > -        if (sd->data_offset == 0)
>>> >> > +        if (sd->data_offset == 0) {
>>> >> > +            if (sd->data_start + io_len > sd->size) {
>>> >> > +                sd->card_status |= ADDRESS_ERROR;
>>> >> > +                return 0x00;
>>> >> > +            }
>>> >>
>>> >> Why move it inside the if (sd->data_offset == 0) and not just below
>>> >> the ret = sd->data[sd->data_offset ++] ?
>>> >>
>>> >> >              BLK_READ_BLOCK(sd->data_start, io_len);
>>> >
>>> > Mostly because of the line above. This copies the full block from the
>>> > backend storage to sd->data, so we need to make sure that the data is
>>> > actually available to fill sd->data, not if it's ok to access a certain
>>> > byte within sd->data.
>>>
>>> Doesn't this mean that the check is only done for the first block
>>> then? When data_offset is 0.
>>
>> No, data_offset is reset at the end of the block.
>> [...]
>
> Alistair, were you planning to provide a reviewed-by: for this
> patch (or did you have more review comments on it)?

Ah woops, this slipped through. Looks fine to me then.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

>
> thanks
> -- PMM
