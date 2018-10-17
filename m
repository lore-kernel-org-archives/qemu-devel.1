Received: from eggs.gnu.org ([2001:4830:134:3::10]:60582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCkRJ-0007p5-SA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCkRH-0002Wg-72
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:56:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCkRE-0002KF-Te
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:56:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<87murdf73g.fsf_-_@dusky.pond.sub.org>
	<20181017063443.bfjm5yh47cx3vva3@sirius.home.kraxel.org>
Date: Wed, 17 Oct 2018 13:56:05 +0200
In-Reply-To: <20181017063443.bfjm5yh47cx3vva3@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Wed, 17 Oct 2018 08:34:43 +0200")
Message-ID: <878t2wiy7e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] No more chameleon devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Wed, Oct 17, 2018 at 07:57:39AM +0200, Markus Armbruster wrote:
>> Laine Stump <laine@redhat.com> writes:
>> 
>> [...]
>> > In the end, having a device that changed PCI ID depending on what kind
>> > of slot it was plugged into was an idea "too clever for its own good",
>> > should be avoided when new devices are added in the future, and we
>> > should at least provide an alternative that doesn't do that for existing
>> > devices.
>> 
>> That means for each chameleon PCI/PCIe device:
>> 
>> * create a pair of devices that can only go into one kind of slot
>> * deprecate the chameleon
>
> I think virtio devices are the only ones which actually change the pci
> id and have non-trivial differences.
>
> qemu-xhci can likewise be plugged into both pci and pcie slots.  When
> plugged into a pcie slot it'll have pcie endpoint capability.  That is
> the only difference though.  Do you consider that a chameleon device?

Since the enticing simplicity of letting PCI device models go into PCIe
slots as well is exactly what lured us into this mess, I do.

I believe all we actually saved by creating chameleons was a bunch of
QOM types.  New, non-chameleon PCIe devices would have shared the actual
device model code with the existing, non-chameleon PCI devices.

Correcting the design mistake now involves yet another set of QOM types,
for backward compatibility.

A loss of simplicity we failed to consider properly back then was at the
external interface.  Traditionally, a qdev has a bus type (printed by
-device help), and it can go into a slot provided by such a bus.  But
chameleon PCI qdevs can also go into a slot provided by a PCIe bus.  The
interface is now less regular, for no convincing reason.
