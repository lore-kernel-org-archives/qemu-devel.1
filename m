Received: from eggs.gnu.org ([2001:4830:134:3::10]:40130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fYpRN-0006yB-9U
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fYpRJ-0007Ps-QZ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:11:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fYpRJ-0007PA-GE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:11:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5T95imL023627
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 05:11:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jwhpt8nqh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 05:11:36 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Fri, 29 Jun 2018 10:11:33 +0100
Date: Fri, 29 Jun 2018 14:41:26 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180627125604.15275-1-quintela@redhat.com>
	<20180627125604.15275-17-quintela@redhat.com>
	<20180628095547.GA24412@localhost.localdomain>
	<87h8lnw4pa.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87h8lnw4pa.fsf@secure.laptop>
Message-Id: <20180629091126.GA17425@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 16/16] migration: fix crash in when incoming
 client channel setup fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jun 28, 2018 at 01:06:25PM +0200, Juan Quintela wrote:
> Balamuruhan S <bala24@linux.vnet.ibm.com> wrote:
> > On Wed, Jun 27, 2018 at 02:56:04PM +0200, Juan Quintela wrote:
> >> From: Daniel P. Berrang=E9 <berrange@redhat.com>
>=20
> ....
>=20
> > Hi Juan,
> >
> > I tried to perform multifd enabled migration and from qemu monitor
> > enabled mutlifd capability on source and target,
> > (qemu) migrate_set_capability x-multifd on
> > (qemu) migrate -d tcp:127.0.0.1:4444
> >
> > The migration succeeds and its cool to have the feature :)
>=20
> Thanks.
>=20
> > (qemu) info migrate
> > globals:
> > store-global-state: on
> > only-migratable: off
> > send-configuration: on
> > send-section-footer: on
> > decompress-error-check: on
> > capabilities: xbzrle: off rdma-pin-all: off auto-converge: off
> > zero-blocks: off compress: off events: off postcopy-ram: off x-colo:
> > off release-ram: off block: off return-path: off
> > pause-before-switchover: off x-multifd: on dirty-bitmaps: off
> > postcopy-blocktime: off late-block-activate: off
> > Migration status: completed
> > total time: 1051 milliseconds
> > downtime: 260 milliseconds
> > setup: 17 milliseconds
> > transferred ram: 8270 kbytes
>=20
> What is your setup?  This value looks really small.  I can see that you

I have applied this patchset to upstream qemu to test multifd migration,

qemu commandline is as below,

/home/bala/qemu/ppc64-softmmu/qemu-system-ppc64 --enable-kvm --nographic =
\
-vga none -machine pseries -m 4G,slots=3D32,maxmem=3D32G -smp 16,maxcpus=3D=
32 \
-device virtio-blk-pci,drive=3Drootdisk -drive file=3D/home/bala/hostos-p=
pc64le.qcow2,\
if=3Dnone,cache=3Dnone,format=3Dqcow2,id=3Drootdisk -monitor telnet:127.0=
.0.1:1234,\
server,nowait -net nic,model=3Dvirtio -net user -redir tcp:2000::22

> have 4GB of RAM, it should be a bit higher.  And setup time is also
> quite low from my experience.

sure, I will try with 32G mem. I am not aware about the setup time value.

>=20
> > throughput: 143.91 mbps
>=20
> I don't know what networking are you using, but my experience is that
> increasing packet_count to 64 or so helps a lot to increase bandwidth.

how do I configure packet_count to 64 ?

>=20
> What is your networking, page_count and number of channels?

I tried local host migration but need to work on multihost migration.
page_count and number of channels are default values,

x-multifd-channels: 2
x-multifd-page-count: 16

>=20
> > remaining ram: 0 kbytes
> > total ram: 4194560 kbytes
> > duplicate: 940989 pages
> > skipped: 0 pages
> > normal: 109635 pages
> > normal bytes: 438540 kbytes
> > dirty sync count: 3
> > page size: 4 kbytes
> >
> >
> > But when I just enable the multifd in souce but not in target
> >
> > source:
> > x-multifd: on
> >
> > target:
> > x-multifd: off
> >
> > when migration is triggered with,
> > migrate -d tcp:127.0.0.1:4444 (port I used)
> >
> > The VM is lost in source with Segmentation fault.
> >
> > I think the correct way is to enable multifd on both source and targe=
t
> > similar to postcopy, but in this negative scenario we should consider
> > the right way of handling not to loose the VM instead error out
> > appropriately.
>=20
> It is necesary to enable both sides.  And it "used" to be that it
> dectected correctly when it was not enable on one of the sides.  Check
> should be lost in some rebase, or any other change.
>=20
> Will take a look.

Thank you.

-- Bala

>=20
> > Please correct me if I miss something.
>=20
> Sure, thanks for the report.
>=20
> Later, Juan.
>=20
