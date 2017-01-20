Received: from eggs.gnu.org ([2001:4830:134:3::10]:37435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUdUp-000520-Iq
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUdUm-0002e6-HV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:01:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cUdUm-0002dT-CB
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:01:04 -0500
Date: Fri, 20 Jan 2017 11:01:01 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170120110101.538bed72@t450s.home>
In-Reply-To: <5881A858.2020203@cn.fujitsu.com>
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1483175588-17006-5-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170118153621.75d8b83d@t450s.home>
	<5881A858.2020203@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v11 4/4] vfio: add 'aer' property to
 expose aercap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

On Fri, 20 Jan 2017 14:04:08 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> On 01/19/2017 06:36 AM, Alex Williamson wrote:
> > On Sat, 31 Dec 2016 17:13:08 +0800
> > Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> >   
> >> From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
> >>
> >> Add 'aer' property, let user choose whether expose the aer capability
> >> or not.  
> > 
> > But that's not what it does, it only controls the behavior in response
> > to non-fatal errors, the capability is exposed regardless.
> >   
> 
> This commit log is legacy, and defaults to off is a result of the
> configuration restriction & your previous discussion, right?
> 
> In current version, if 'aer' property is off, we just allocate the
> config space via pcie_add_capability(), we don't init the AER
> capability, the value is all 0s there, so does that still mean
> "capability is exposed regardless"?

The design has changed, we no longer require a matching host and guest
topology, we can more easily transparently enable non-fatal error
correction.  We need to reevaluate whether previous decisions are still
valid, we cannot blindly assume that a requirement for a previous
design still applies.  Thanks,

Alex
 
> >> Should disable aer feature by default, because only non-fatal
> >> error is supported now.   
> > 
> > Why does that mean it should be disabled by default?  What bad thing
> > happens if we enable this opportunistically?
> >   
> >> Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
> >> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> >> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> >> ---
> >>  hw/vfio/pci.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >> index 9861f72..fc9db66 100644
> >> --- a/hw/vfio/pci.c
> >> +++ b/hw/vfio/pci.c
> >> @@ -3057,6 +3057,8 @@ static Property vfio_pci_dev_properties[] = {
> >>      DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
> >>                         sub_device_id, PCI_ANY_ID),
> >>      DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
> >> +    DEFINE_PROP_BIT("aer", VFIOPCIDevice, features,
> >> +                    VFIO_FEATURE_ENABLE_AER_BIT, false),
> >>      /*
> >>       * TODO - support passed fds... is this necessary?
> >>       * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),  
> > 
> > 
> > 
> > .
> >   
> 
