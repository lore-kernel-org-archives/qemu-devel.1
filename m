Received: from eggs.gnu.org ([2001:4830:134:3::10]:41254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5pfS-0004te-WE
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5pfO-0005LT-Vz
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:34:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5pfO-0005LJ-Q5
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:34:18 -0400
Date: Tue, 10 Apr 2018 10:34:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410093412.GI5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180407000117.25640-1-lersek@redhat.com>
	<979bd720-cdb3-6468-1fbd-e8ec1c6c6c8d@redhat.com>
	<8ddd0a2f-b9b1-08c0-0f4d-62e7aea7e96a@redhat.com>
	<20180410062754.eohou7i7chf6w65j@sirius.home.kraxel.org>
	<dc439111-4161-96e6-5b45-4dcee886427d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc439111-4161-96e6-5b45-4dcee886427d@redhat.com>
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Apr 10, 2018 at 11:16:01AM +0200, Laszlo Ersek wrote:
> On 04/10/18 08:27, Gerd Hoffmann wrote:
> >   Hi,
> > 
> >> - I considered adding wildcards (say, blacklist "all" i440fx machtypes,
> >> present and future, for SMM-requiring OVMF builds), but then you get
> >> into version sorting and similar mess. I considered fnmatch() --
> >> basically simple ? and * wildcards -- but that's not expressive enough.
> > 
> > I'd suggest whitelist with wildcards.  So the smm builds would get
> > "pc-q35-*".
> > 
> > libvirt knows about aliases, so it should be able to handle the "q35"
> > shortcut like "pc-q35-${latest}".
> > 
> > Or do you see another issue?
> 
> Well, one issue I see is version sorting; I should say "Q35 but no
> earlier than 2.4", and lexicographically, "2.11" sorts before "2.4".
> 
> Anyway (also asking for Thomas's input here): if we run with your idea
> to refer to exact mapping methods / firmware *implementation* types that
> we know libvirt implements / supports as a "white box", do we still deem
> machine type identification necessary? Because, libvirt already knows
> (for example) that "ovmf_smm" requires pc-q35-2.4 or later. So we just
> have to make a *reference* to that knowledge in the JSON file.

BTW, that's not quite correct - when libvirt handles the "smm" arg it
checks if machine type == q35, and  QEMU version >= 2.4.

It is *not* checking the version of the machine type. ie it will happily
use smm with  pc-q35-2.0, as long as QEMU version is 2.4. Perhaps this is
not quite right, but we don't try to parse the version number out of the
machine type, because we can't assume a specific format for the machine
type version part. eg version can be "2.4", or it can be "rhel-7.0.0"
or something else again on Ubuntu.

IMHO it would be valid to just keep life simple and only record the base
machine type name that can use the firmware ie "pc", "q35", and ignore
the fact that in some cases the firmware might require a specific version
of the machine type.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
