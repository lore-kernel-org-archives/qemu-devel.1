Received: from eggs.gnu.org ([2001:4830:134:3::10]:35780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1eAWRk-0002qv-GH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1eAWRg-000132-HT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:31:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1eAWRg-000105-B0
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:31:16 -0400
Received: from mail-yw0-f197.google.com ([209.85.161.197])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1eAWRe-0003Dm-0d
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:31:14 +0000
Received: by mail-yw0-f197.google.com with SMTP id t11so2594473ywg.12
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 00:31:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171102153424.GP32533@redhat.com>
References: <CAATJJ0KveNV1tHT-w5TCL9_TrCdMzp34=fGfhMm7NzZux=7K+Q@mail.gmail.com>
	<CAATJJ0L6Xs6vbauBeznVuf+e_GjRLbU2Kz8MWSrBHzD_+wLhhQ@mail.gmail.com>
	<20171102153424.GP32533@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 3 Nov 2017 08:30:42 +0100
Message-ID: <CAATJJ0KSKFKDz7sW4qtRDCJpRv3fin+RxCL6U-TKeQPgZUK5BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Libvirt Devel <libvir-list@redhat.com>

On Thu, Nov 2, 2017 at 4:34 PM, Daniel P. Berrange <berrange@redhat.com> wrote:
>
> On Thu, Nov 02, 2017 at 04:14:06PM +0100, Christian Ehrhardt wrote:
> > Ping - since there wasn't any reply so far - any best practices one could
> > share?
> >
> > Let me add a TL;DR:
> > - bump of ipxe rom versions change the size of virtio-net-pci.rom
> > - that breaks on migration "Length mismatch"
> >
> > I'd guess the size of that rom has to be fixed up on the fly, but if that
> > is really ok and how/where is the question.
>
> The actual ROM contents will be transferred in the migration stream, so
> the fact that the target host has ROMs with different content is not
> important. The key thing that matters is that QEMU the target host loads
> the ROMs at the same location, so that when the ROM contents is overwritten
> with data from the incoming migration scheme, it all ends up at the same
> place as it was on the source.


Thanks Daniel for your answer, although you try to kill my remaining
hopes of a better solution :-)
But if the actual ROM content is migrated over anyway "all I'd have to
do" is to make clear that the newer system (qemu) knows that the
incoming rom has a different size than it thinks.
I thought that was what the machine types and their mechanisms were
for, but so far I only scratched like 10% of those - maybe they don't
cover these rom sizes?

>
> Getting this to happen requires pre-planning when building the ROMs. By
> the time you hit the size change during migration it is too late and your
> VM is basically doomed. When building you need to add padding. IIUC for
> RHEL we artificially increased the size of the seabios and ipxe ROMs to
> 256k. So when later RHEL updates ship new seabios/ipxe they still fit in
> the 256k region previously allowed for.


That would have been a good solution to this - if it was done in the past :-)
If I end up forced to draw a line anyway, that is a good way to start
over safe against further size changes.
