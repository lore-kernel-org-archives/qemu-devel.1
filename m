Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cH6U2-0007KJ-T1
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cH6Tz-0007Vt-Gz
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:08:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cH6Tz-0007Vj-7e
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:08:19 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBEA4ajE022377
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 05:08:17 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b1u96p0x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 05:08:17 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 14 Dec 2016 10:08:13 -0000
Date: Wed, 14 Dec 2016 11:08:05 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <8d1ada4b-2939-5d88-cf8d-b93321f1c81b@redhat.com>
References: <1473773430-19616-1-git-send-email-maxime.coquelin@redhat.com>
	<20161213212745.1976.91005@loki>
	<20161214084451.2a5236d2.cornelia.huck@de.ibm.com>
	<94a0c474-4998-b03a-9353-d41d0e4e690f@redhat.com>
	<CAJSP0QUHdEYN+gW61eV-REGYRP84SpdOT8R7OPF5jCjUJpaMEQ@mail.gmail.com>
	<20161214095906.45e00d81.cornelia.huck@de.ibm.com>
	<8d1ada4b-2939-5d88-cf8d-b93321f1c81b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161214110805.29ae806c.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v2] virtio-bus: Plug devices
 after features are negotiated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Dave Gilbert <dgilbert@redhat.com>

On Wed, 14 Dec 2016 10:44:05 +0100
Maxime Coquelin <maxime.coquelin@redhat.com> wrote:

> On 12/14/2016 09:59 AM, Cornelia Huck wrote:
> > On Wed, 14 Dec 2016 08:41:55 +0000
> > Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> >> On Wed, Dec 14, 2016 at 8:28 AM, Maxime Coquelin
> >> <maxime.coquelin@redhat.com> wrote:
> >>>
> >>>
> >>> On 12/14/2016 08:44 AM, Cornelia Huck wrote:
> >>>>>
> >>>>>> 14:44 < stefanha> Not sure if anyone can think of a nicer solution.
> >>>>>> 14:45 < stefanha> But we're going to have to keep lying to the guest if
> >>>>>> we want to preserve migration compatibility
> >>>>>> 14:45 < stefanha> The key change in behavior with the patch you
> >>>>>> identified is:
> >>>>>> 14:46 < stefanha> if (!virtio_has_feature(vdev->host_features,
> >>>>>> VIRTIO_F_VERSION_1)) {
> >>>>>> 14:46 < stefanha> virtio_pci_disable_modern(proxy);
> >>>>>> 14:46 < stefanha> Previously it didn't care about vdev->host_features.
> >>>>>> It simply allowed VERSION_1 when proxy's disable_modern boolean was false.
> >>>>>> 14:47 < mdroth> stefanha: ok, that explains why it seems to work with
> >>>>>> disable-modern=true
> >>>>>> 14:48 < stefanha> mdroth: Your Ubuntu kernel old but 14.04 LTS is
> >>>>>> definitely still around so I don't think we can ship QEMU 2.8 like this.
> >>>>>> 14:49 < stefanha> mdroth: Let's summarize it on the mailing list and
> >>>>>> see what Michael Tsirkin and Maxime Coquelin think.
> >>>>>> 14:49 < mdroth> stefanha: i suppose a potential workaround would be to
> >>>>>> tell users to set disable-modern= to match their vhost capabilities, but
> >>>>>> it's hard for them to apply that retroactively if they're looking to migrate
> >>>>
> >>>> Another thought: Maybe this bug only surfaced right now because older
> >>>> qemus defaulted virtio-pci to legacy?
> >>>>
> >>>> (I think modern virtio-pci with old vhost resulted in a config that was
> >>>> rejected at least by Linux guests. Because pci defaulted to legacy, we
> >>>> only had the post-plugged workaround for ccw before.)
> >>>
> >>>
> >>> Yes, for PCI with old vhost, modern enabled and recent kernel on guest,
> >>> we get this failure at virtio-pci probe time:
> >>>
> >>> virtio_net virtio0: virtio: device uses modern interface but does not have
> >>> VIRTIO_F_VERSION_1.
> >>
> >> Is this error a regression in QEMU 2.8?
> >
> > I think it pokes up because modern virtio-pci is now by default on. It
> > was broken before if the user wanted a modern virtio-pci device
> > explicitly.
> >
> > (ccw defaulted to virtio 1.0 much earlier, so we had the post-plugged
> > solution that this patch replaced and which is basically the same for
> > ccw.)

FWIW, I played around a bit with virsh managedsave and the 2.7 ccw
machine on a non-virtio-1 vhost kernel. Migrating to/from a 2.7 qemu
works fine for ccw both with current master and with this patch
reverted. Feature handling and friends are simpler on ccw...

> >
> >>
> >> It's better to ship with an existing issue still open than with a new
> >> regression.  We must not break existing users' setups.
> >>
> >> A solution for the next QEMU version is to use a flag in the machine
> >> type version telling virtio whether or not allow devices (e.g.
> >> vhost-net) to influence the host feature bits.  Old machine types will
> >> say no, new machine types will say yes.
> >>
> >> In the meantime I would revert your patch for QEMU 2.8.
> >>
> >> Maxime, Cornelia, Michael: Do you agree?
> >>
> >> Stefan
> >
> > Reverting the patch should be fine for ccw. What about the virtio-pci
> > with old vhost mess, though? Defaulting to modern would mean that users
> > get unusable devices in that setup.
> 
> Just did some tests, and can confirm that reverting the patch would
> re-introduce initial bug, which is breaking virtio-pci when host does
> not support VERSION_1.
> 
> Note that this problem is present in v2.7.0 since:
> 
> commit 9a4c0e220d8a4f82b5665d0ee95ef94d8e1509d5
> Author: Marcel Apfelbaum <marcel@redhat.com>
> Date:   Wed Jul 20 18:28:21 2016 +0300
> 
>      hw/virtio-pci: fix virtio behaviour
> 
>      Enable transitional virtio devices by default.
>      Enable virtio-1.0 for devices plugged into
>      PCIe ports (Root ports or Downstream ports).
> 
>      Using the virtio-1 mode will remove the limitation
>      of the number of devices that can be attached to a machine
>      by removing the need for the IO BAR.
> 
>      Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>      Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>      Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> 
> Maybe better to implement the workaround you proposed Stefan?

Let's summarize a bit:

- current master: default modern, takes vhost capabilities into account
  -> usable device in all cases, but migration broken with old vhost
- reverting this commit: default modern, ignore vhost capabilities
  -> unusable transitional devices with old vhost, but migration works
- lie about features on old machines: default modern, ignore vhost
  capabilites on old machines
  -> unusable transitional devices with old vhost _and_ old machines,
     but migration should work

The third option sounds best right now, but it's not perfect, either.
It's basically the 2.7 machine where it is most likely to bite people,
as older machines defaulted to legacy.
