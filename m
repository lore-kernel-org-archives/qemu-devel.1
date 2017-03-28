Received: from eggs.gnu.org ([2001:4830:134:3::10]:33399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tejaswinipoluri3@gmail.com>) id 1csjil-0004OT-TG
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tejaswinipoluri3@gmail.com>) id 1csjik-00069T-O0
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:31:07 -0400
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:37067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tejaswinipoluri3@gmail.com>)
	id 1csjik-00069G-I5
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:31:06 -0400
Received: by mail-it0-x234.google.com with SMTP id 190so7109135itm.0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 22:31:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170327111309.GB26900@stefanha-x1.localdomain>
References: <1490610662-5483-1-git-send-email-tejaswinipoluri3@gmail.com>
	<20170327111309.GB26900@stefanha-x1.localdomain>
From: Tejaswini Poluri <tejaswinipoluri3@gmail.com>
Date: Tue, 28 Mar 2017 11:01:05 +0530
Message-ID: <CAH=b03tqB4vy0fg3ikhf1iGpbQyLfDd28ymrO_Qo_QSysHOAKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [[RFC]PATCH:hw/sd:sd_init()] hw/sd : modified the
 sd_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Mar 27, 2017 at 4:43 PM, Stefan Hajnoczi <stefanha@redhat.com>
wrote:

> On Mon, Mar 27, 2017 at 04:01:02PM +0530, Tejaswini wrote:
> > From: Tejaswini Poluri <tejaswinipoluri3@gmail.com>
>
> Please shorten the subject line: "[PATCH] hw/sd: simplify sd_init()
> prototype"
>
> > @@ -573,16 +573,19 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
> >      qdev_prop_set_drive(dev, "drive", blk, &err);
> >      if (err) {
> >          error_report("sd_init failed: %s", error_get_pretty(err));
> > -        return NULL;
> > +        return -1;
> >      }
> >      qdev_prop_set_bit(dev, "spi", is_spi);
> >      object_property_set_bool(obj, true, "realized", &err);
> >      if (err) {
> >          error_report("sd_init failed: %s", error_get_pretty(err));
> > -        return NULL;
> > +        return -1;
> >      }
> > -
> > -    return SD_CARD(dev);
> > +    sd_state = SD_CARD(dev);
>
> The caller will not see the new value of sd_state.  In C arguments are
> passed by value.  That means they are local variables inside the
> function and do not affect the caller.
>
> The caller will call sd_init() along with passing SDState pointer as an
argument like below
if (sd_init(s->card, blk, false) < 0) .
And the sd_init() function is modified to
int sd_init(SDState *sd_state, BlockBackend *blk, bool is_spi)
so that the caller gets the new value of SDstate updated.
Looking forward for the comments of Paolo Bonzini to understand what more
needs to be done as part of the task.

I have CCed Paolo Bonzini, who posted this task.  Maybe he can explain
> what he meant by "Include SDState by value instead of allocating it in
> sd_init (hw/sd/)".
>
> > +    if (!sd_state) {
> > +             return -1;
> > +     }
>
> QEMU use 4 space indentation.  Please do not use tabs.
>



-- 
Regards,
Tejaswini
