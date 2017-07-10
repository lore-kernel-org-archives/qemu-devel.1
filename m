Received: from eggs.gnu.org ([2001:4830:134:3::10]:51789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dUaXQ-0000sr-1q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dUaXL-0003g0-2u
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:23:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dUaXK-0003dU-P4
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:23:46 -0400
Date: Mon, 10 Jul 2017 17:23:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170710172336.33c64f86@nial.brq.redhat.com>
In-Reply-To: <20170710145331.GJ12152@localhost.localdomain>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
	<20170707164453.4ba325fd@nial.brq.redhat.com>
	<20170707150707.GJ10776@localhost.localdomain>
	<58f2d98e-ae7e-e2e7-e7f3-68e937b0b79f@ilande.co.uk>
	<20170710100147.0a7339e4@nial.brq.redhat.com>
	<20170710145331.GJ12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On Mon, 10 Jul 2017 11:53:31 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Jul 10, 2017 at 10:01:47AM +0200, Igor Mammedov wrote:
> > On Fri, 7 Jul 2017 17:20:25 +0100
> > Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> >   
> > > On 07/07/17 16:07, Eduardo Habkost wrote:
> > >   
> > > >> looks fine,
> > > >>
> > > >> so what I'd do is:
> > > >>  * drop 4/6    
> > > 
> > > Yes.
> > >   
> > > > Agreed on this point.  But:
> > > >     
> > > >>  * make fw_cfg_find() use ambiguous argument and error_abort if ambiguous == true    
> > > 
> > > During my latest tests I've found that everything works fine without the
> > > ambiguous argument.
> > > 
> > > Do we still want to keep it? And I don't think error_abort() is the
> > > right thing to do here, I'd much rather return NULL and add a suitable
> > > comment.  
> > I'd still use ambiguous argument and since you prefer not to assert
> > I'd add errp argument to fw_cfg_find() and handle error at callsites.
> > 
> > Just returning NULL isn't sufficient if you need to distinguish
> > 'not found' vs 'duplicate' usecases, additionally  'not found'
> > in most cases isn't even error but 'duplicate' definitely is.
> > 
> > Aborting on diplicate in fw_cfg_find() is fine and would
> > help to avoid touching current callers if you wish to limit
> > patches scope, but you can go with proper error propagating
> > route if you wish.  
> 
> Just making realize refuse to create two devices sounds much
> simpler to me.  No need to make fw_cfg_find() more complex (if we
> add errp argument to it) or less useful (if we add
> assert(!ambiguous) to it).
the problem here was a error message to print if fw_cfg_find()
returns NULL for missing or duplicate, if we need to print
precise error we would need proper error handling.

Considering to fw_cfg is builtin device I'd prefer just
assert in fw_cfg_find() on duplicate (all the callers consider it as error)
and let developer to deal with assert if it is triggered.
