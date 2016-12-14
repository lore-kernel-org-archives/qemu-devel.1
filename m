Received: from eggs.gnu.org ([2001:4830:134:3::10]:55974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cH59T-0004Pk-0N
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cH59R-0007Wd-RS
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:43:03 -0500
MIME-Version: 1.0
In-Reply-To: <94a0c474-4998-b03a-9353-d41d0e4e690f@redhat.com>
References: <1473773430-19616-1-git-send-email-maxime.coquelin@redhat.com>
	<20161213212745.1976.91005@loki>
	<20161214084451.2a5236d2.cornelia.huck@de.ibm.com>
	<94a0c474-4998-b03a-9353-d41d0e4e690f@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Dec 2016 08:41:55 +0000
Message-ID: <CAJSP0QUHdEYN+gW61eV-REGYRP84SpdOT8R7OPF5jCjUJpaMEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Dave Gilbert <dgilbert@redhat.com>

On Wed, Dec 14, 2016 at 8:28 AM, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
> On 12/14/2016 08:44 AM, Cornelia Huck wrote:
>>>
>>> > 14:44 < stefanha> Not sure if anyone can think of a nicer solution.
>>> > 14:45 < stefanha> But we're going to have to keep lying to the guest if
>>> > we want to preserve migration compatibility
>>> > 14:45 < stefanha> The key change in behavior with the patch you
>>> > identified is:
>>> > 14:46 < stefanha> if (!virtio_has_feature(vdev->host_features,
>>> > VIRTIO_F_VERSION_1)) {
>>> > 14:46 < stefanha> virtio_pci_disable_modern(proxy);
>>> > 14:46 < stefanha> Previously it didn't care about vdev->host_features.
>>> > It simply allowed VERSION_1 when proxy's disable_modern boolean was false.
>>> > 14:47 < mdroth> stefanha: ok, that explains why it seems to work with
>>> > disable-modern=true
>>> > 14:48 < stefanha> mdroth: Your Ubuntu kernel old but 14.04 LTS is
>>> > definitely still around so I don't think we can ship QEMU 2.8 like this.
>>> > 14:49 < stefanha> mdroth: Let's summarize it on the mailing list and
>>> > see what Michael Tsirkin and Maxime Coquelin think.
>>> > 14:49 < mdroth> stefanha: i suppose a potential workaround would be to
>>> > tell users to set disable-modern= to match their vhost capabilities, but
>>> > it's hard for them to apply that retroactively if they're looking to migrate
>>
>> Another thought: Maybe this bug only surfaced right now because older
>> qemus defaulted virtio-pci to legacy?
>>
>> (I think modern virtio-pci with old vhost resulted in a config that was
>> rejected at least by Linux guests. Because pci defaulted to legacy, we
>> only had the post-plugged workaround for ccw before.)
>
>
> Yes, for PCI with old vhost, modern enabled and recent kernel on guest,
> we get this failure at virtio-pci probe time:
>
> virtio_net virtio0: virtio: device uses modern interface but does not have
> VIRTIO_F_VERSION_1.

Is this error a regression in QEMU 2.8?

It's better to ship with an existing issue still open than with a new
regression.  We must not break existing users' setups.

A solution for the next QEMU version is to use a flag in the machine
type version telling virtio whether or not allow devices (e.g.
vhost-net) to influence the host feature bits.  Old machine types will
say no, new machine types will say yes.

In the meantime I would revert your patch for QEMU 2.8.

Maxime, Cornelia, Michael: Do you agree?

Stefan
