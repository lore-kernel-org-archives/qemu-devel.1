Received: from eggs.gnu.org ([2001:4830:134:3::10]:54128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH5ao-0005fT-9D
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH5aT-0007Nc-3W
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:15:50 -0500
Date: Tue, 21 Nov 2017 11:15:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121111522.04dd2faf.cohuck@redhat.com>
In-Reply-To: <20171121065125.GG5859@bjsdjshi@linux.vnet.ibm.com>
References: <20171114082547.GB12696@bjsdjshi@linux.vnet.ibm.com>
	<20171114115014.3b3d709d.cohuck@redhat.com>
	<20171121065125.GG5859@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Questions about usability mess that caused by
 differentiating address based on devices types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, fiuczy@linux.vnet.ibm.com, bwalk@linux.vnet.ibm.com, shalini@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

On Tue, 21 Nov 2017 14:51:26 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2017-11-14 11:50:14 +0100]:
> 
> Hallo Conny,
> 
> After spending some time, just some updates for this one.
> 
> > On Tue, 14 Nov 2017 16:25:47 +0800
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> > > So that we can remove the restrictions for the cssid validation for each
> > > type of device. Even we could drop the s390-squash-mcss, and just allow
> > > the user to define any device in any css.  
> > 
> > Opening up the different csses for all devices might help, but we need
> > to be careful:
> > - We still want to keep the chpids separated. Probably not a problem
> >   right now.
> > - We need to be able to point to a default css, especially as there are
> >   no MCSS-E capable OSs around yet.
> > - You need to double check if there are further restrictions on the
> >   allowed css ids. (I know that 0xff is reserved for special usage as
> >   well; but I can't find out more.)
> > - Backwards compatibility and migration: We certainly don't want old
> >   setups to break, and compat machines need to force the old scheme.
> > 
> > All best tested out via a prototype :)
> >   
> After a round of internal discussion, Halil now has a prototype. I think
> sooner he will post his patch with our internal agreement, and we can
> continuing talking based on that then.

Please post upstream as soon as it make sense. Makes discussion
easier :)

> 
> > > 
> > > 3. If we have to keep the squash property, then when squashing, it's
> > > somewhat like "I don't care for the cssid", so is it possible for us to
> > > not check the cssid in the device devno?
> > > Libvirt would be benifited with this when automatically generating the
> > > addresses.  
> > 
> > I think we still need to keep the squashing around for compatibility,
> > but we may be able to give it the chop for something like 3.0.
> > 
> > (And we probably need to keep the existing restrictions in compat mode.)
> >   
> Can we just drop the squash property, right after we opened up all the
> csses?
> We do not support LGM for vfio-ccw, and there is no libvirt user until
> now. So what else case could it be to stop us from dropping it?

IIRC, we still require a non-0xfe cssid for non-virtual devices with
the squash parameter; they are just mapped into the default css later.
Just dropping the parameter would break existing command lines, and
accepting but ignoring it makes a previously working commandline
suddenly non-working (not all devices visible to guest).

We either need to follow the proper deprecation procedure (which means
that the parameter will stay around for two releases), or kill it in a
3.0 release (if that comes earlier). But we should be able to get rid
of it at least in the long run.

> > > To sum up, we got the feeling that, this mess is not only for Libvirt
> > > but also for QEMU cmd line users. And we are wondering if there is some
> > > way to improve it.  
> > 
> > Using css 0xfe seems to be an idea that turned out not to be as useful
> > as we hoped it would be. Maybe the right way forward is indeed to open
> > up the csses for all devices (although there might be a case for
> > putting non-virtual devices not into 0xfe by default and instead making
> > 0 the default css).
> > 
> > Another thing: Should libvirt give its users enough rope to hang
> > themselves by allowing to create domains with devices all over the
> > channel subsystem images?
> >   
> I think the commit message of Halil's patch will show you the idea.
> Let's wait for some moment.

Yup, let's see what he comes up with.
