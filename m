Received: from eggs.gnu.org ([2001:4830:134:3::10]:44600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eH57p-0005nE-RN
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eH57l-00033f-Vl
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:45:53 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:38998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eH57l-00031J-Ls
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:45:49 -0500
Received: from player778.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id B17918420A
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:45:38 +0100 (CET)
Date: Tue, 21 Nov 2017 10:45:23 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171121104523.1e7f8789@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <9da2b91f-215d-654f-a05b-76a0f898e6a7@redhat.com>
References: <20171120071423.11693-1-david@gibson.dropbear.id.au>
	<9da2b91f-215d-654f-a05b-76a0f898e6a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: Implement bug in
 spapr-vty device to be compatible with PowerVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, lvivier@redhat.com, paulus@samba.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 21 Nov 2017 08:27:51 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 20.11.2017 08:14, David Gibson wrote:
> > The spapr-vty device implements the PAPR defined virtual console,
> > which is also implemented by IBM's proprietary PowerVM hypervisor.
> > 
> > PowerVM's implementation has a bug where it inserts an extra \0 after
> > every \r going to the guest.  Because of that Linux's guest side
> > driver has a workaround which strips \0 characters that appear
> > immediately after a \r.  
> 
> Ouch.
> 
> I wonder whether it would make more sense to change the guest side
> driver to apply the workaround only if it's really running under
> PowerVM...? E.g. what if the PowerVM bug ever gets fixed one day?
> 

The bug has been around forever (already there in initial linux git
commit 1da177e4c3f4), so I'm not sure PowerVM will ever fix it. It
is legacy API now :) 

Also I'm not sure it is worth the pain to introduce extra complexity
in the existing linux driver... I guess we'd rather encourage people
to switch to virtio serial instead.

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

> > That means that when running under qemu, sending a binary stream from
> > host to guest via spapr-vty which happens to include a \r\0 sequence
> > will get corrupted by that workaround.
> > 
> > To deal with that, this patch duplicates PowerVM's bug, inserting an
> > extra \0 after each \r.  Ugly, but the best option available.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/char/spapr_vty.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> > index 0fa416ca6b..a95e5e91a7 100644
> > --- a/hw/char/spapr_vty.c
> > +++ b/hw/char/spapr_vty.c
> > @@ -58,6 +58,24 @@ static int vty_getchars(VIOsPAPRDevice *sdev, uint8_t *buf, int max)
> >  
> >      while ((n < max) && (dev->out != dev->in)) {
> >          buf[n++] = dev->buf[dev->out++ % VTERM_BUFSIZE];
> > +
> > +        /* PowerVM's vty implementation has a bug where it inserts a
> > +         * \0 after every \r going to the guest.  Existing guests have
> > +         * a workaround for this which removes every \0 immediately
> > +         * following a \r, so here we make ourselves bug-for-bug
> > +         * compatible, so that the guest won't drop a real \0-after-\r
> > +         * that happens to occur in a binary stream. */
> > +        if (buf[n-1] == '\r') {
> > +            if (n < max) {
> > +                buf[n++] = '\0';
> > +            } else {
> > +                /* No room for the extra \0, roll back and try again
> > +                 * next time */
> > +                dev->out--;
> > +                n--;
> > +                break;
> > +            }
> > +        }
> >      }
> >  
> >      qemu_chr_fe_accept_input(&dev->chardev);
> >   
> 
> Code looks fine to me, so:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
