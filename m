Received: from eggs.gnu.org ([2001:4830:134:3::10]:33155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mol@pengutronix.de>) id 1duYLl-0002UX-KU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mol@pengutronix.de>) id 1duYLk-0006rZ-C4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:19:09 -0400
Received: from metis.ext.pengutronix.de
	([2001:67c:670:201:290:27ff:fe1d:cc33]:39257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mol@pengutronix.de>) id 1duYLk-0006d4-5N
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:19:08 -0400
Date: Wed, 20 Sep 2017 08:19:05 +0200
From: Michael Olbrich <m.olbrich@pengutronix.de>
Message-ID: <20170920061905.rbv3g2ubd4c5zvn4@pengutronix.de>
References: <150555367996.36.15771330325496067998@69b6ddf88678>
	<20170916103523.1482-1-m.olbrich@pengutronix.de>
	<CAKmqyKP_5dC1td8DMCEM_4v74XBZy5-rWH2z4XA8VCw4165SAg@mail.gmail.com>
	<20170919082358.43upqf3lawg2aqtg@pengutronix.de>
	<CAKmqyKOeYQHRytnhzmC0Tr3rp4KU8NomgnFhhcrKE5KP75WMow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKOeYQHRytnhzmC0Tr3rp4KU8NomgnFhhcrKE5KP75WMow@mail.gmail.com>
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
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Sep 19, 2017 at 05:09:51PM -0700, Alistair Francis wrote:
> On Tue, Sep 19, 2017 at 1:23 AM, Michael Olbrich
> <m.olbrich@pengutronix.de> wrote:
> > On Mon, Sep 18, 2017 at 02:28:26PM -0700, Alistair Francis wrote:
> >> On Sat, Sep 16, 2017 at 3:35 AM, Michael Olbrich
> >> <m.olbrich@pengutronix.de> wrote:
> >> >  hw/sd/sd.c | 12 ++++++------
> >> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> >> > index ba47bff4db80..35347a5bbcde 100644
> >> > --- a/hw/sd/sd.c
> >> > +++ b/hw/sd/sd.c
> >> > @@ -1797,8 +1797,13 @@ uint8_t sd_read_data(SDState *sd)
> >> >          break;
> >> >
> >> >      case 18:   /* CMD18:  READ_MULTIPLE_BLOCK */
> >> > -        if (sd->data_offset == 0)
> >> > +        if (sd->data_offset == 0) {
> >> > +            if (sd->data_start + io_len > sd->size) {
> >> > +                sd->card_status |= ADDRESS_ERROR;
> >> > +                return 0x00;
> >> > +            }
> >>
> >> Why move it inside the if (sd->data_offset == 0) and not just below
> >> the ret = sd->data[sd->data_offset ++] ?
> >>
> >> >              BLK_READ_BLOCK(sd->data_start, io_len);
> >
> > Mostly because of the line above. This copies the full block from the
> > backend storage to sd->data, so we need to make sure that the data is
> > actually available to fill sd->data, not if it's ok to access a certain
> > byte within sd->data.
> 
> Doesn't this mean that the check is only done for the first block
> then? When data_offset is 0.

No, data_offset is reset at the end of the block. That's not visible in the
patch. Here ist the relevant hunks with a bit more context:

     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
-        if (sd->data_offset == 0)
+        if (sd->data_offset == 0) {
+            if (sd->data_start + io_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return 0x00;
+            }
             BLK_READ_BLOCK(sd->data_start, io_len);
+        }
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= io_len) {
             sd->data_start += io_len;
             sd->data_offset = 0;
[...]
-
-            if (sd->data_start + io_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-                break;
-            }
         }
         break;

As you can see, the old check was inside the block that resets data_offset
to zero. This patch just delays exactly that check to the beginning of the
next access.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
