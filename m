Received: from eggs.gnu.org ([2001:4830:134:3::10]:54016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSd1H-0001uK-0z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSd1D-00048I-Tz
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:38:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dSd1D-00047r-Na
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:38:31 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk>
Date: Wed, 05 Jul 2017 07:38:26 +0200
In-Reply-To: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk> (Mark
	Cave-Ayland's message of "Tue, 4 Jul 2017 19:25:41 +0100")
Message-ID: <8760f7fnot.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Managing architectural restrictions with -device
 and libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>

Copying Marcel for PCI expertise.

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> Hi all,
>
> I've been working on a patchset that brings the sun4u machine on
> qemu-system-sparc64 much closer to a real Ultra 5, however due to
> various design restrictions I need to be able to restrict how devices
> are added to the machine with -device.
>
> On a real Ultra 5, the root PCI bus (sabre) has 2 PCI bridges (simba A
> and simba B) with the onboard devices attached to simba A with 2 free
> slots, and an initially empty simba B.
>
> Firstly, is it possible to restrict the machine so that devices cannot
> be directly plugged into the root PCI bus, but only behind one of the
> PCI bridges? There is also an additional restriction in that slot 0
> behind simba A must be left empty to ensure that the ebus (containing
> the onboard devices) is the first device allocated.

I figure sabre, simba A, simba B and the onboard devices attached to
simba A are all created by MachineClass init().

What device provides "the ebus", and how is it created?

Can you provide a list of all onboard PCI devices and how they are
connected?  Diagram would be best.

The real sabre has two slots, and doesn't support hot (un)plug.  Can we
simply model that?  If yes, the root PCI bus is full after init(), and
remains full.  Takes care of "cannot directly plugged into the root PCI
bus".

> Secondly, how does libvirt handle these type of restrictions? Is it able
> to get the information from QEMU or is there some kind of libvirt
> profile that needs to be updated? And do newer versions of libvirt have
> the ability to attach devices behind PCI bridges using a GUI such as
> virt-manager, or is that only something that can only be done by
> directly editing the domain XML?

Got nothing to add to Dan's reply.
