Received: from eggs.gnu.org ([2001:4830:134:3::10]:57417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8nWz-0007Ng-9L
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8nWx-0001ib-QI
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:53:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f8nWx-0001iP-JL
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:53:51 -0400
Date: Wed, 18 Apr 2018 14:53:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180418135344.GQ27579@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
	<b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
	<20180418122312.ebmd2nrtvk2h5e45@sirius.home.kraxel.org>
	<f8c3945f-d2e7-e4a4-2b38-2736acd99e7c@redhat.com>
	<20180418130619.cmyyyl7fj2wfum7k@sirius.home.kraxel.org>
	<0545cc73-d821-c2d9-e4ab-938e58c34c2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0545cc73-d821-c2d9-e4ab-938e58c34c2b@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Wed, Apr 18, 2018 at 03:30:36PM +0200, Laszlo Ersek wrote:
> On 04/18/18 15:06, Gerd Hoffmann wrote:
> >>> Other question:  Do we want allow to specify which certs/keys are
> >>> enrolled?  Which would probably mean to drop "enrolled-keys" from
> >>> features and make it an optional string instead,
> >>
> >> Not an enum? "Microsoft" below should be an enum constant, shouldn't it?
> > 
> > I don't think so.  If we want allow other certificate providers (not
> > sure it makes sense as all physical hardware actually runs with the
> > microsoft certificates), then we don't want a fixed list here.  So any
> > CA can be listed, be it microsoft, redhat, canonical, verisign or
> > kraxel.org ;)
> 
> I agree (obviously), but then, at what detail do we stop?
> 
> Because, if we go for full flexibility, then we should formalize:
> - the certificate that goes into PK,
> - the list of certificates that go into KEK,
> - the list of certificates that go into db,
> 
> and we should likely formalize "certificate" itself as the following pair:
> - human-readable description (possibly the Common Name of the Subject),
> - SHA256 digest (fingerprint) of the certificate.
> 
> I do think this would totally be overkill, but I don't know where to
> draw the line
> - between the currently proposed @enrolled-keys (or similar enums that
>   stand for well-defined "constellations")
> - and the full details as described above.
> 
> A simple string like "Microsoft" doesn't seem to me helpful for either
> the user or management software -- the former won't know what
> "Microsoft" stands for, and the latter won't want to look for free-form
> strings. (Same issue as with @tags vs. @features.)

Ignoring secboot cert name for a minute, ultimately no matter what we do
in terms of metadata there is always going to be the possibility that
many firmware images all match the criteria libvirt is searching on.

Apps thus need rules to pick one of the many matches, and users need the
ability to override distro defaults. We can achieve that as follows:

Recommend that firmware files are created with a double-digit prefix
eg    50-ovmf.json  50-seabios-256k.json, etc, etc, so they can be
sorted in predictable order

Second, we should define three well known directory locations

 - /usr/share/qemu/firmware  (used by distros packages)
 - /etc/qemu/firmware  (exclusively for sysadmin local additions)
 - $HOME/.config/qemu/firmware (exclusively for per-user local additions)

Apps like libvirt should build list of files from all three locations,
then sort by filename.  If a local directory has a file with same
name as the distro directory, then it should replace the distro provided
file. A zero length file should be simply hide the distro provided file

So for example, distro ships

   /usr/share/qemu/firmware/50-ovmf.json
   /usr/share/qemu/firmware/50-seabios-256k.json

The sysadmin can now prevent the default ovmf being used at all with

  $ touch /etc/qemu/firmware/50-ovmf.json

The sysadmin can replace/alter the distro default ovmf with

  $ vim /etc/qemu/firmware/50-ovmf.json

Or they can provide a parallel ovmf with higher priority

  $ vim /etc/qemu/firmware/10-ovmf.json

Or they can provide a parallel ovmf with lower priority

  $ vim /etc/qemu/firmware/99-ovmf.json

$HOME/.config/qemu/firmware would take prior over /etc/qemu and
/usr/share/qemu. 


Getting back to the question of many ovmf images with various different
secboot keys. The distro can now provide many ovmf images each with
different keys, if desired and determine which one is picked by default.

The end user can provide their over ovmf with personal keys that replaces
the distro microsoft enrolled one entirely, etc.

IOW,  don't think we need to record which certs are use for secboot in
the JSON metadata. Just lets overrides & ordering take care of it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
