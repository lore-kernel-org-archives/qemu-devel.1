Received: from eggs.gnu.org ([2001:4830:134:3::10]:41012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLtFe-0000CV-SQ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLtFY-00032k-Ug
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:05:50 -0500
Date: Mon, 4 Dec 2017 17:05:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171204170537.4b78020e.cohuck@redhat.com>
In-Reply-To: <2b67738e-6ca3-c62a-f6a2-86f448f6ab74@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-2-pasic@linux.vnet.ibm.com>
	<20171204121027.3acec545.cohuck@redhat.com>
	<2b67738e-6ca3-c62a-f6a2-86f448f6ab74@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 4 Dec 2017 16:02:14 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 12/04/2017 12:10 PM, Cornelia Huck wrote:
> > On Fri,  1 Dec 2017 15:31:34 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> The default css 0xfe is currently restricted to virtual subchannel
> >> devices. The hope when the decision was made was, that non-virtual
> >> subchannel devices will come around when guests can exploit multiple
> >> channel subsystems. Since current guests don't do that, the pain of the
> >> partitioned (cssid) namespace outweighs the gain.
> >>
> >> The default css 0xfe is currently restricted to virtual subchannel
> >> devices. The hope when the decision was made was, that non-virtual
> >> subchannel devices will come around when guest can exploit multiple
> >> channel subsystems. Since the guests generally don't do, the pain
> >> of the partitioned (cssid) namespace outweighs the gain.  
> > 
> > Doubled paragraph?
> >   
> 
> Yep. Copy paste mistake.
> 
> >>
> >> Let us remove the corresponding restrictions (virtual devices
> >> can be put only in 0xfe and non-virtual devices in any css except
> >> the 0xfe -- while s390-squash-mcss then remaps everything to cssid 0).
> >>
> >> At the same time, change our schema for generating css bus ids to put
> >> both virtual and non-virtual devices into the default css (spilling over
> >> into other css images, if needed). The intention is to deprecate
> >> s390-squash-mcss. Whit this change devices without a specified devno  
> > 
> > s/Whit/With/  
> 
> Nod
> 
> >   
> >> won't end up hidden to guests not supporting multiple channel subsystems,
> >> unless this can not be avoided (default css full).
> >>
> >> Deprecaton of s390-squash-mcss and indicating the changes via QMP is  
> 
> s/Deprecaton/Deprecation/
> 
> >> expected to follow soon (as separate commits).  
> > 
> > Let's drop this paragraph (the qmp interface should be squashed in, and
> > you mention the deprecation right above.)
> >   
> >>
> >> The adverse effect of getting rid of the restriction on migration should
> >> not be too severe.  Vfio-ccw devices are not live-migratable yet, and for
> >> virtual devices using the extra freedom would only make sense with the
> >> aforementioned guest support in place.
> >>
> >> The auto-generated bus ids are affected by both changes. We hope to not
> >> encounter any auto-generated bus ids in production as Libvirt is always
> >> explicit about the bus id.  Since 8ed179c937 ("s390x/css: catch section
> >> mismatch on load", 2017-05-18) the worst that can happen because the same
> >> device ended up having a different bus id is a cleanly failed migration.
> >> I find it hard to reason about the impact of changed auto-generated bus
> >> ids on migration for command line users as I don't know which rules is
> >> such an user supposed to follow.  
> > 
> > Should we document somewhere that guests supposed to be migrated should
> > make sure that they use explicit devnos?
> >   
> 
> I think having a document collecting such migration rules and best practices
> for command line users (and implicitly also for implementers of management
> software) would be a good idea. Maybe there is such a documentation, but
> I don't know where. The devnos should be a part of it for sure. But I'm
> not volunteering for creating this kind of documentation. Natural languages
> aren't my forte.

I would not mind someone else doing this.

> 
> >>
> >> Another pain-point is down- or upgrade of QEMU for command line users.
> >> The old way and the new way of doing vfio-ccw are mutually incompatible.
> >> Libvirt is only going to support the new way, so for libvirt users, the
> >> possible problems at QEMU downgrade are the following. If a domain
> >> contains virtual devices placed into a css different than 0xfe the domain
> >> will refuse to start with a QEMU not having this patch. Putting devices
> >> into a css different that 0xfe however won't make much sense in the near
> >> future (guest support). Libvirt will refuse to do vfio-ccw with a QEMU
> >> not having this patch. This is business as usual.  
> > 
> > My writing style would be to have this as a shorter, bulleted list -
> > but no need to rewrite this if this is understandable to the others on
> > cc:
> >   
> 
> If you want, we can iterate on the description. My primary concern was
> to agree on how to advertise this change.

Let's skip that.

> 
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
