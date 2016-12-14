Received: from eggs.gnu.org ([2001:4830:134:3::10]:57936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cH5PS-0003MQ-KU
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cH5PP-0003Fl-Hc
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:59:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cH5PP-0003FZ-8Y
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:59:31 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBE8xSjm094829
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 03:59:29 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b29d1ptn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 03:59:29 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 14 Dec 2016 08:59:22 -0000
Date: Wed, 14 Dec 2016 09:59:06 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <CAJSP0QUHdEYN+gW61eV-REGYRP84SpdOT8R7OPF5jCjUJpaMEQ@mail.gmail.com>
References: <1473773430-19616-1-git-send-email-maxime.coquelin@redhat.com>
	<20161213212745.1976.91005@loki>
	<20161214084451.2a5236d2.cornelia.huck@de.ibm.com>
	<94a0c474-4998-b03a-9353-d41d0e4e690f@redhat.com>
	<CAJSP0QUHdEYN+gW61eV-REGYRP84SpdOT8R7OPF5jCjUJpaMEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161214095906.45e00d81.cornelia.huck@de.ibm.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Dave Gilbert <dgilbert@redhat.com>

On Wed, 14 Dec 2016 08:41:55 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Dec 14, 2016 at 8:28 AM, Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
> >
> >
> > On 12/14/2016 08:44 AM, Cornelia Huck wrote:
> >>>
> >>> > 14:44 < stefanha> Not sure if anyone can think of a nicer solution.
> >>> > 14:45 < stefanha> But we're going to have to keep lying to the guest if
> >>> > we want to preserve migration compatibility
> >>> > 14:45 < stefanha> The key change in behavior with the patch you
> >>> > identified is:
> >>> > 14:46 < stefanha> if (!virtio_has_feature(vdev->host_features,
> >>> > VIRTIO_F_VERSION_1)) {
> >>> > 14:46 < stefanha> virtio_pci_disable_modern(proxy);
> >>> > 14:46 < stefanha> Previously it didn't care about vdev->host_features.
> >>> > It simply allowed VERSION_1 when proxy's disable_modern boolean was false.
> >>> > 14:47 < mdroth> stefanha: ok, that explains why it seems to work with
> >>> > disable-modern=true
> >>> > 14:48 < stefanha> mdroth: Your Ubuntu kernel old but 14.04 LTS is
> >>> > definitely still around so I don't think we can ship QEMU 2.8 like this.
> >>> > 14:49 < stefanha> mdroth: Let's summarize it on the mailing list and
> >>> > see what Michael Tsirkin and Maxime Coquelin think.
> >>> > 14:49 < mdroth> stefanha: i suppose a potential workaround would be to
> >>> > tell users to set disable-modern= to match their vhost capabilities, but
> >>> > it's hard for them to apply that retroactively if they're looking to migrate
> >>
> >> Another thought: Maybe this bug only surfaced right now because older
> >> qemus defaulted virtio-pci to legacy?
> >>
> >> (I think modern virtio-pci with old vhost resulted in a config that was
> >> rejected at least by Linux guests. Because pci defaulted to legacy, we
> >> only had the post-plugged workaround for ccw before.)
> >
> >
> > Yes, for PCI with old vhost, modern enabled and recent kernel on guest,
> > we get this failure at virtio-pci probe time:
> >
> > virtio_net virtio0: virtio: device uses modern interface but does not have
> > VIRTIO_F_VERSION_1.
> 
> Is this error a regression in QEMU 2.8?

I think it pokes up because modern virtio-pci is now by default on. It
was broken before if the user wanted a modern virtio-pci device
explicitly.

(ccw defaulted to virtio 1.0 much earlier, so we had the post-plugged
solution that this patch replaced and which is basically the same for
ccw.)

> 
> It's better to ship with an existing issue still open than with a new
> regression.  We must not break existing users' setups.
> 
> A solution for the next QEMU version is to use a flag in the machine
> type version telling virtio whether or not allow devices (e.g.
> vhost-net) to influence the host feature bits.  Old machine types will
> say no, new machine types will say yes.
> 
> In the meantime I would revert your patch for QEMU 2.8.
> 
> Maxime, Cornelia, Michael: Do you agree?
> 
> Stefan

Reverting the patch should be fine for ccw. What about the virtio-pci
with old vhost mess, though? Defaulting to modern would mean that users
get unusable devices in that setup.
