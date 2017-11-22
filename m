Received: from eggs.gnu.org ([2001:4830:134:3::10]:33764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHTz1-0004yF-Nn
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHTyw-0005pW-Pa
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:18:27 -0500
Date: Wed, 22 Nov 2017 13:18:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122131812.68bf9cab.cohuck@redhat.com>
In-Reply-To: <a59023ce-931b-2c03-b877-11dfa2e4adf1@de.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<66e1c5e3-575f-ec7c-d88c-4ada23f358fa@de.ibm.com>
	<20171121170650.323c6959.cohuck@redhat.com>
	<a59023ce-931b-2c03-b877-11dfa2e4adf1@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 21 Nov 2017 19:10:15 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11/21/2017 05:06 PM, Cornelia Huck wrote:
> > On Tue, 21 Nov 2017 15:45:17 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 11/21/2017 02:44 PM, Cornelia Huck wrote:  
> >>> On Tue, 21 Nov 2017 12:18:25 +0100
> >>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >>>
> >>> Subject: s/unresrict/unrestrict/
> >>>     
> >>>> The default css 0xFE is currently restricted to virtual subchannel
> >>>> devices. The hope when the decision was made was, that non-virtual
> >>>> subchannel devices will come around when guest can exploit multiple
> >>>> channel subsystems. Since the guests generally don't do, the pain
> >>>> of the partitioned (cssid) namespace outweighs the gain.
> >>>>
> >>>> Let us remove the corresponding restrictions (virtual devices
> >>>> can be put only in 0xFE and non-virtual devices in any css except
> >>>> the 0xFE), and inform management software property on all ccw
> >>>> devices.    
> >>>
> >>> I do not really like dropping the restrictions while still keeping the
> >>> default cssid as 0xfe. Putting virtual devices into css 0 seems
> >>> completely fine, but putting non-virtual devices into css 0xfe still
> >>> feels a bit wrong. What about:
> >>>
> >>> - Add a property to specify the default cssid. Compat machines use a
> >>>   default cssid of 0xfe.
> >>> - Default to a cssid of 0.
> >>> - (optional) Warn when putting a non-virtual device into css 0xfe,
> >>>   unless it is the default css.    
> >>
> >> To make it more clear, I think the most compatible solution would be to allow
> >> vfio-ccw also in FE. (But continue to force virtual devices in FE as well).
> >> This was more or less the first proposal that we had. Then we asked ourselves
> >> why not also allow virtual devices in 0?
> >>
> >> I think your proposal of specifying a default css (and then allowing
> >> all devices in that) is actually pretty close to Halils proposal. The only
> >> difference is that Halils variant keeps fe as default css. 
> >> So I think we could even combine both approaches. Use Halils patch as a base
> >> and in addition provide a way to change the default css away from fe. Have to
> >> think about that.  
> > 
> > If keeping the default of 0xfe makes the life of management software
> > easier, sure. As it is, we seem to be far more entrenched with
> > paravirtual devices than I had expected when I first wrote this, so
> > 0xfe might be the sensible choice even if mcss-e is available in the
> > future. In this case, I think we should lift all cssid restrictions.  
> 
> So basically agree with the restriction lifting, but you want to have a
> different method of telling libvirt about it?

Yes.

> [...]
> >>> This allows building a commandline in a compat machine that will not
> >>> work with old qemus, no?    
> >>
> >> I think this is pretty common to have new devices and things that will not
> >> work on old QEMUs but are allowed on compat machines, e.g. virtio-gpu was
> >> added in 2.4 but
> >>
> >> [cborntra@oc7330422307 qemu]$ build/i386-softmmu/qemu-system-i386 -device virtio-gpu-pci -M pc-i440fx-2.2
> >> VNC server running on ::1:5900
> >>
> >> works fine  
> > 
> > It seems a bit more unexpected, though.  
> 
> What I understood from the CPU model discussion is, that the machine version basically sets the migration
> stream format and any "invisible" setting that the user cannot influence. But it is not there to the fence
> the user from specifying new devices or new CPU types (that the old QEMU does not know) or different 
> command lines. You get a compatible machine if you specify an identical command line that will work for
> both.

So we really need a good changelog entry for that one. Mind you, I'm
not really opposed; but if a trap is there, it would be good to have at
least some signage.

> > 
> > (And I'm still not quite sure how all of this interacts with the squash
> > option.)  
> 
> I think we should deprecate the squash option and not use it to simplify things.

I certainly want the squash option to go out when we do this. I just
was a bit unsure about any interactions, but it seems it is not really
problematic.
