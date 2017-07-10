Received: from eggs.gnu.org ([2001:4830:134:3::10]:40624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dUTS1-0005Id-Q5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dUTRx-0004jK-Ns
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:49:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dUTRx-0004in-Ev
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:49:45 -0400
Date: Mon, 10 Jul 2017 09:49:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170710094938.5d525300@nial.brq.redhat.com>
In-Reply-To: <20170707150707.GJ10776@localhost.localdomain>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
	<20170707164453.4ba325fd@nial.brq.redhat.com>
	<20170707150707.GJ10776@localhost.localdomain>
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

On Fri, 7 Jul 2017 12:07:07 -0300
"Eduardo Habkost" <ehabkost@redhat.com> wrote:

> On Fri, Jul 07, 2017 at 04:44:53PM +0200, Igor Mammedov wrote:
> [...]
> > > > taking in account that fwcfg in not user creatable device how about:
> > > > 
> > > > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > > > index 316fca9..8f6eef8 100644
> > > > --- a/hw/nvram/fw_cfg.c
> > > > +++ b/hw/nvram/fw_cfg.c
> > > > @@ -1014,7 +1014,10 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
> > > >  
> > > >  FWCfgState *fw_cfg_find(void)
> > > >  {
> > > > -    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
> > > > +    bool ambig = false;
> > > > +    FWCfgState *f = FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, &ambig));
> > > > +    assert(!ambig);
> > > > +    return f;
> > > >  }
> > > > 
> > > > or if we must to print user friendly error and fail realize gracefully
> > > > (not sure why) just add errp argument to function so it could report
> > > > error back to caller, then places that do not care much about graceful
> > > > exit would use error_abort as argument and realize would use
> > > > its local_error/errp argument.    
> > > 
> > > My understanding from the thread was that we should only use assert()s
> > > where there is no other choice so that any failures can be handled in a
> > > more friendly manner.  
> > the rule I use to decide assert vs nice error handling:
> > 1: try to avoid crash on hotplug path
> > 2: if error could be induced by end user on startup, try to print nice error
> >    before dying
> > 3: when error should not happen just assert or use error_abort
> >    which would print nice error message before dying.  
> 
> I would add this to the list:
> 
> If returning error instead of aborting is easy, return an error
> and let the caller decide if it should use &error_abort or not.
agreed, there aren't that many callers of fw_cfg_find()
so I'd just add error argument to it and handle error at call sites.
