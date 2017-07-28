Received: from eggs.gnu.org ([2001:4830:134:3::10]:53864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1db7XW-00046d-79
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1db7XT-00050k-09
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:50:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1db7XS-0004zj-QX
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:50:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6SFn2MF103515
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 11:50:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c01s2qs7n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 11:50:53 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 28 Jul 2017 11:50:53 -0400
Date: Fri, 28 Jul 2017 23:50:48 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727114603.77b801e2@gondolin>
	<20170728092108.GE15504@bjsdjshi@linux.vnet.ibm.com>
	<20170728135301.0b510793@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728135301.0b510793@gondolin>
Message-Id: <20170728155048.GB5874@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Channel Path realted CRW generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

* Cornelia Huck <cohuck@redhat.com> [2017-07-28 13:53:01 +0200]:

[...]

> > > > During an internal discussion, Halil and Pierre pointed out that for path
> > > > hotplug, generating a CRW seems logical, but how is it covered by the AR is not
> > > > clear - we have problem in understanding some grammar ambiguous paragraphs.
> > > > While certain parts of the AR is not available outside, but I'm still wondering
> > > > if the author ;) could give us some clue... BTW, we know that, in Linux kernel
> > > > we had code that handles un-solicited chp crw, so we tend to believe it's right
> > > > to generate channel path initialized CRW for path hotplug. It's just we can not
> > > > find the reason from the document.  
> > > 
> > > I always found path notifications to be a bit odd. They depend on
> > > various things:
> > > - whether you're running under LPAR or under z/VM
> > > - whether it's a hardware condition (path failure) or something
> > >   triggered by the admin (path vary on/off)
> > > - if it's admin triggered, where it was done (on the SE, by one of
> > >   several mechanisms in CP, via SCLP)  
> > These are clear.
> > 
> > During the internnal discussion, we wished to get the resources to test
> > all of these cases to verify. For the z/VM and SE stuff, it seems a bit
> > difficult. So we decided to go with a shortcut -- to ask you.
> 
> Unfortunately, my memory is not perfect
Still a very efficient shortcut for me. ;)

> - and I've seen changes in behaviour between different versions of the
> hardware etc. as well...
...

> 
> > 
> > > 
> > > You're bound to get different kinds of notifications: via a CRW with
> > > source channel path, via event information retrievable via CHSC
> > > (indicated by a CRW with source CSS),  
> > Ha, I was not awre of this one before!
> 
> That's the 'link incident' and 'resource accessibility' stuff.
My focus was trying to have the minimum stuff to make a Linux guest
working well -- basically, my working on prototype targeted to make the
output lschp and lscss corect and uptodate. I

I will dig this and see if I need to do more stuff.

> 
> > 
> > > via a PNO indication, or nothing at all.
> > > 
> > > [Reminds me of a case where we got path gone CRWs under LPAR when a
> > > path was deactivated at the SE (which we would notice via PNO anyway),
> > > but no CRW when the path was reactivated - not very useful. When trying
> > > to report this as an issue, we got the answer that we of course need to
> > > use the OS interface to vary off the path beforehand. Silly penguins.]  
> > ... ...
> > 
> > > 
> > > My recommendation would be to generate a fitting CRW if the wording
> > > allows to do so.  
> > Nod. I'm trying this already.
> > 
> > > I would hope that getting as many useful indications as possible is
> > > most helpful to the OS.  
> > Nod. Trying this too.
> > My prototype work tries to sync the belowing information from host
> > kernel to qemu:
> > 1. the real SCHIB, so stsch from guest could get the updated path masks.
> 
> How far do you want to go with mirroring? I think you need to modify at
> least the devno in the pmcw, no?
I didn't think this very deep. For now, I only sync the PIM, POM, PAM
and CHPIDs lazily.

For devno... I need to think more. If the qemu command has a given
"devno" for the vfio-ccw device, maybe we should not override its dev_id
with the real one "device number".

> 
> > 2. the Store Subchannel Description information,
Ref. chp_ssd_get_mask().
I can get the valid CHPIDs for those channel paths defined for the
device associated with the specified subchannel.

> > and with the new added support for the SCLP read channel path
> > information command, guest could get the configure status of the
> > path.
> 
> That's also a chsc, right?
Right.

> 
> > 3. still working on support CHSC store channel path description command.
> 
> I'm currently wondering how many of those chscs are optional. OTOH, if
> a modern Linux guest cannot work properly without them, it makes no
> sense to leave them out.
Nod.

But I think I need to define the criteria for "work properly". For
example, with the current code, a Linux guest with a passed through
device works, while lschp shows the Cfg. as 3 (not recognized), and the
Shared and PCHID as "-". For this case, do you think it "work properly"?

> 
> > 
> > > (I had added the path-come CRW handling in Linux back then and
> > > afterwards wondered why we did not get it - I must have interpreted
> > > the PoP in the same way as you did.)  
> > I've a bugfix patch in the kernel side, and it has been accepted by the
> > s390 maintainers. May be this could be a clue? Post it here:
> > 
> > When channel path is identified as the report source code (RSC)
> > of a CRW, and initialized (CRW_ERC_INIT) is recognized as the
> > error recovery code (ERC) by the channel subsystem, it indicates
> > a "path has come" event.
> > 
> > Let's handle this case in chp_process_crw().
> > 
> > diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
> > index 7e0d4f724dda..432fc40990bd 100644
> > --- a/drivers/s390/cio/chp.c
> > +++ b/drivers/s390/cio/chp.c
> > @@ -559,6 +559,7 @@ static void chp_process_crw(struct crw *crw0, struct
> > crw *crw1,
> >         chpid.id = crw0->rsid;
> >         switch (crw0->erc) {
> >         case CRW_ERC_IPARM: /* Path has come. */
> > +       case CRW_ERC_INIT:
> >                 if (!chp_is_registered(chpid))
> >                         chp_new(chpid);
> >                 chsc_chp_online(chpid);
> > 
> > Notice:
> > At the very beginning, I replaced CRW_ERC_IPARM with CRW_ERC_INIT. But
> > Sebstian Ott suggested:
> > "I don't know of a machine that actually implements a CRW
> > at all when a chpid is configured online on the SE/HMC.
> > 
> > Because of potential regressions I don't want to remove CRW_ERC_IPARM
> > here. I'm good with adding CRW_ERC_INIT though."
> 
> Yeah, that makes sense, especially with the confusing state channel
> path machine check handling is in from the architecture side.
> 
> > 
> > > 
> > > I'll double check with how I'd interpret the PoP today.
> > >   
> > Thanks.
> 
> I have read through the PoP and the outcome is a bit disappointing.
> Much of it is a bit vague. I still think that you can err on the side
> of overindication, though.
> 
I agree. Unless somebody tells me it's forbidden by the PoP explicitly,
or it will break Linux guest from working properly, I will would this as
the way to go.

-- 
Dong Jia Shi
