Received: from eggs.gnu.org ([2001:4830:134:3::10]:56426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCoCW-0002Br-6v
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCoCR-0001zq-0j
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCoCO-0001TD-OZ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:57:30 -0400
Date: Wed, 17 Oct 2018 12:56:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181017155637.GC31060@habkost.net>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<87murdf73g.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87murdf73g.fsf_-_@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] No more chameleon devices (was: [PATCH] virtio:
 Provide version-specific variants of virtio PCI devices)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Laine Stump <laine@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

(CCing Marcel, in case he has extra details on the complex
Conventional/Express bus/device plugging rules)

On Wed, Oct 17, 2018 at 07:57:39AM +0200, Markus Armbruster wrote:
> Laine Stump <laine@redhat.com> writes:
> 
> [...]
> > In the end, having a device that changed PCI ID depending on what kind
> > of slot it was plugged into was an idea "too clever for its own good",
> > should be avoided when new devices are added in the future, and we
> > should at least provide an alternative that doesn't do that for existing
> > devices.
> 
> That means for each chameleon PCI/PCIe device:
> 
> * create a pair of devices that can only go into one kind of slot
> 
> * deprecate the chameleon
> 
> Yes, please!  Volunteers?
> 
> Do we have similar chameleons outside PCI?

I'm worried that we could be trying to address multiple issues at
the same time, and I'm not sure yet if we should address all of
them in one take.

Right now we need to differentiate non-transitional and
transitional virtio devices, for a few reasons:
* They have different PCI IDs;
* Legacy drivers don't work with non-transitional devices;
* Transitional virtio devices can be plugged to Conventional PCI
  buses; non-transitional ones can't.

This patch addresses that problem.

You seem to be talking about a different issue:
* Some devices (including transitional virtio) can be plugged on
  both Conventional PCI and PCI Express buses (I will call those
  devices "hybrid PCI devices").

The former is a practical problem: management software needs to
be able to ask for a transitional virtio device, depending o the
guest OS being run.

Addressing the latter seems more complex (it would affect other
devices, not just virtio), and I don't see which practical
problems it would solve.

I see some problems it wouldn't solve, though: the system
wouldn't be able to represent the fact that transitional virtio
devices can still work on PCI Express buses, as long as they
support PIO bars; or that Conventional PCI devices can be plugged
to PCI Express root buses.

I don't see problems caused by hybrid conventional/express PCI
devices.  The original problem with virtio devices was just not
being hybrid, it was lying about being hybrid: non-transitional
virtio devices are hybrid, but transitional virtio devices
aren't.

I wouldn't be against abolishing hybrid PCI devices completely if
somebody volunteers to do the work.  I just don't see which
problems this would solve.

-- 
Eduardo
