Received: from eggs.gnu.org ([209.51.188.92]:34172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gm1Pw-0005lX-TY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gm1Pv-0000xx-Pi
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:09:00 -0500
Date: Tue, 22 Jan 2019 14:13:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190122141301.5f69a9b0.cohuck@redhat.com>
In-Reply-To: <d31d1ba2-579a-eaa1-1e41-0745fd0291b9@redhat.com>
References: <20190122094143.8857-1-david@redhat.com>
	<cd0a559f-6a44-20b9-39ad-4368d08f79af@redhat.com>
	<d31d1ba2-579a-eaa1-1e41-0745fd0291b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/pci: Warn when adding PCI devices
 without the 'zpci' feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Tue, 22 Jan 2019 11:06:46 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 22.01.19 10:50, Thomas Huth wrote:
> > On 2019-01-22 10:41, David Hildenbrand wrote:  
> >> We decided to always create the PCI host bridge, even if 'zpci' is not
> >> enabled (due to migration compatibility).  
> > 
> > Couldn't we disable the host bridge for newer machine types, and just
> > create it on the old ones for migration compatibility?  

I very dimly remember some problems with that approach.

> 
> I think we can with a compat property. However I somewhat dislike that
> the error/warning will then be "no bus" vs. "zpci CPU feature not
> enabled". Somebody who has no idea about that will think he somehow has
> to create a PCI bus on the QEMU comandline.

Agreed, "zpci cpu feature not enabled" gives a much better clue.

> 
> ... however
> 
> >   
> >> This however right now allows
> >> to add zPCI/PCI devices to a VM although the guest will never actually see
> >> them, confusing people that are using a simple CPU model that has no
> >> 'zpci' enabled - "Why isn't this working" (David Hildenbrand)
> >>
> >> Let's check for 'zpci' and at least print a warning that this will not
> >> work as expected. We could also bail out, however that might break
> >> existing QEMU commandlines.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/s390x/s390-pci-bus.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> >> index b86a8bdcd4..e7d4f49611 100644
> >> --- a/hw/s390x/s390-pci-bus.c
> >> +++ b/hw/s390x/s390-pci-bus.c
> >> @@ -863,6 +863,11 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >>  {
> >>      S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
> >>  
> >> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
> >> +        warn_report("Adding PCI or zPCI devices without the 'zpci' CPU feature."
> >> +                    " The guest will not be able to see/use these devices.");
> >> +    }  
> > 
> > I think it would be better to bail out. The hotplug clearly can not work
> > in this case, and the warn report might go unnoticed, so blocking the
> > hotplug process is likely better to get the attention of the user.  
> 
> ... we could also create the bus but bail out here in case the compat
> property strikes (a.k.a. new QEMO machine type).

Now you confused me... why should failing be based on a compat property?
