Received: from eggs.gnu.org ([2001:4830:134:3::10]:53478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5pH6-00019M-9l
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5pH2-0005VA-1c
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:09:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5pH1-0005Uv-RZ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:09:07 -0400
Date: Tue, 10 Apr 2018 10:09:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410090902.GF5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<20180409081923.n2ktwrp2jp7xpoon@sirius.home.kraxel.org>
	<43fbc488-20d6-f5de-0a56-6c28355cc4d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43fbc488-20d6-f5de-0a56-6c28355cc4d4@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Mon, Apr 09, 2018 at 06:50:12PM +0200, Laszlo Ersek wrote:
> On 04/09/18 10:19, Gerd Hoffmann wrote:
> >>> +{ 'enum' : 'SystemFirmwareType',
> >>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
> >>
> >> The naming here is quite a bad mixture between firmware interface
> >> ('bios', 'uefi') and firmware implementations ('slof', 'uboot'). There
> >> could be other implementations of BIOS or UEFI than SeaBIOS and EDK2 ...
> >> so I'd suggest to rather name them 'seabios' and 'edk2' here instead.
> > 
> > uboot for example implements uefi unterfaces too (dunno how complete,
> > but reportly recent versions can run uefi shell and grub just fine).
> 
> Indeed: when I was struggling with this enum type and tried to look for
> more firmware types to add, my googling turned up the "UEFI on Top of
> U-Boot" whitepaper, from Alex and Andreas :)
> 
> Again, this reaches to the root of the problem: when a user creates a
> new domain, using high-level tools, they just want to tick "UEFI". (Dan
> has emphasized this to me several times, so I think I get the idea by
> now, if not the full environment.) We cannot ask the user, "please be
> more specific, do you want UEFI from edk2, or UEFI on top of U-Boot?"
> 
> Instead, each of those firmware images will have to come with a JSON
> document that states "uefi" in SystemFirmware.type, and the host admin
> will be responsible for establishing a priority order between them.
> Then, when the user asks for "UEFI" (and no more details), they'll get
> (compatibly with the target architecture) whichever firmware the host
> admin marked as "higher priority".

Yep, I don't think there's any problem here. If they have asked for
"uefi", they'll get whichever UEFI implementation is the default for
that host. Today it'll be an EDK2 impl, but if there's a uboot impl
of UEFI available instead, that's fine too. If both are available
we'll have some deterministic manner in which we pick one, even if it
as simple as which has alphabetically first filename.

This is really only about getting good default choices. If the user
really badly wants to have a specific firmware, they can still provide
a path to it themselves instead of having libvirt choose it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
