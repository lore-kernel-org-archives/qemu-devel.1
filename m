Received: from eggs.gnu.org ([2001:4830:134:3::10]:35103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duy3C-0003xt-AA
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duy38-0006ns-8Z
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:45:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duy38-0006ma-23
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:45:38 -0400
Date: Thu, 21 Sep 2017 11:45:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170921114533.2d089e36.cohuck@redhat.com>
In-Reply-To: <2bb5705f-eba3-2630-2e57-99242b9abd2a@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-3-pasic@linux.vnet.ibm.com>
	<2bb5705f-eba3-2630-2e57-99242b9abd2a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] s390x/css: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 21 Sep 2017 11:33:03 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 05/09/2017 13:16, Halil Pasic wrote:
> > Replace direct access which implicitly assumes no IDA
> > or MIDA with the new ccw data stream interface which should
> > cope with these transparently in the future.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > ---
> >   hw/s390x/css.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index 87d913f81c..c1bc9944e6 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -890,6 +890,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
> >       }
> > 
> >       /* Look at the command. */
> > +    ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
> >       switch (ccw.cmd_code) {
> >       case CCW_CMD_NOOP:
> >           /* Nothing to do. */
> > @@ -903,7 +904,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
> >               }
> >           }
> >           len = MIN(ccw.count, sizeof(sch->sense_data));
> > -        cpu_physical_memory_write(ccw.cda, sch->sense_data, len);
> > +        ccw_dstream_write_buf(&sch->cds, sch->sense_data, len);  
> 
> Don't you need to check the return value ?
> 
> >           sch->curr_status.scsw.count = ccw.count - len;
> >           memset(sch->sense_data, 0, sizeof(sch->sense_data));
> >           ret = 0;
> > @@ -930,7 +931,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
> >           } else {
> >               sense_id.reserved = 0;
> >           }
> > -        cpu_physical_memory_write(ccw.cda, &sense_id, len);
> > +        ccw_dstream_write_buf(&sch->cds, &sense_id, len);  
> 
> here too ?
> 
> >           sch->curr_status.scsw.count = ccw.count - len;
> >           ret = 0;
> >           break;
> >   
> 
> 

I think Halil wanted to introduce error checking in a patch on top, to
keep changes minimal for now (at least one of the patch submissions
said so).

It isn't worse than before, so putting it into a separate patch is fine
by me.
