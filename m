Received: from eggs.gnu.org ([2001:4830:134:3::10]:56373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAHVr-0005mS-V7
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAHVn-0002FZ-UO
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:34:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAHVn-0002DI-OX
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:34:31 -0400
Date: Thu, 2 Nov 2017 15:34:24 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171102153424.GP32533@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAATJJ0KveNV1tHT-w5TCL9_TrCdMzp34=fGfhMm7NzZux=7K+Q@mail.gmail.com>
	<CAATJJ0L6Xs6vbauBeznVuf+e_GjRLbU2Kz8MWSrBHzD_+wLhhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAATJJ0L6Xs6vbauBeznVuf+e_GjRLbU2Kz8MWSrBHzD_+wLhhQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [libvirt] How to best handle the reoccurring of
 rom changes breaking cross version migrations?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Libvirt Devel <libvir-list@redhat.com>

On Thu, Nov 02, 2017 at 04:14:06PM +0100, Christian Ehrhardt wrote:
> Ping - since there wasn't any reply so far - any best practices one could
> share?
> 
> Let me add a TL;DR:
> - bump of ipxe rom versions change the size of virtio-net-pci.rom
> - that breaks on migration "Length mismatch"
> 
> I'd guess the size of that rom has to be fixed up on the fly, but if that
> is really ok and how/where is the question.

The actual ROM contents will be transferred in the migration stream, so
the fact that the target host has ROMs with different content is not
important. The key thing that matters is that QEMU the target host loads
the ROMs at the same location, so that when the ROM contents is overwritten
with data from the incoming migration scheme, it all ends up at the same
place as it was on the source.

Getting this to happen requires pre-planning when building the ROMs. By
the time you hit the size change during migration it is too late and your
VM is basically doomed. When building you need to add padding. IIUC for
RHEL we artificially increased the size of the seabios and ipxe ROMs to
256k. So when later RHEL updates ship new seabios/ipxe they still fit in
the 256k region previously allowed for.

<tangent>
... QEMU could really benefit from more formal docs around migration to
describe how users / vendors can protect themselves from the many pitfalls
like this...
</tangent>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
