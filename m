Received: from eggs.gnu.org ([2001:4830:134:3::10]:50282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@os.amperecomputing.com>) id 1gXVnK-0006cD-FJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@os.amperecomputing.com>) id 1gXVnG-00051F-Fw
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:33:10 -0500
Received: from mail-eopbgr770109.outbound.protection.outlook.com
	([40.107.77.109]:6328
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@os.amperecomputing.com>)
	id 1gXVnG-0004xz-2e
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:33:06 -0500
From: Michael Spradling <michael@os.amperecomputing.com>
Date: Thu, 13 Dec 2018 18:33:02 +0000
Message-ID: <20181213183253.GE10456@mswork1>
References: <20181130144404.GA32091@mswork1>
	<faae3e4a-bce7-849a-b510-1c94ffb03413@redhat.com>
In-Reply-To: <faae3e4a-bce7-849a-b510-1c94ffb03413@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9AD210760480B43A519A694E6E3D597@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Loading snapshot with readonly qcow2 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Nov 30 08:58, Eric Blake wrote:
> On 11/30/18 8:44 AM, Michael Spradling wrote:
> > Hello,
> >=20
> > I would like to resume a snapshot via the command line option -loadvm
> > with a read only QCOW2 file.  For my use case, I would ideally like to
> > load multiple instances of different snapshots from the same QCOW2 imag=
e.
> >=20
> > It seems this is not possible at the moment as when a snapshot is loade=
d, QEMU
> > copies some meta data around in the qcow2 image.
> >=20
> > I have also tried to use the "-snapshot" option, which to my understand=
ing
> > creates a new temporary QCOW2 file with a backing file pointing the ori=
ginal
> > image passed on the command line.  This also does not work, when lookin=
g
> > through the source it appears QEMU only supports loading snapshots from=
 writable
> > QCOW2 images and doesn't support loading from images in backing files.
> >=20
> > My question is has anyone looked into loading snapshots from a backing
> > file?  I have attempted to look through the code and this looks to be
> > difficult.  If I attempt to add support for this is there any general
> > advice to follow?  Any other ideas?
>=20
> 'qemu-nbd -l' can serve snapshots from a qcow2 file; perhaps that can be
> used to cobble together something that works for your needs?
>=20
> Sadly, internal snapshots don't get much attention these days, so there m=
ay
> well be missing functionality, but no one is really stepping up to provid=
e
> patches.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

I looked at "qemu-nbd -l" and this seems to only export a readonly
interface.  Really, what I need is a writable temp file that can load a
snapshot snapshot.

Please excuse and correct me if I get some of the terminology of the
sections below wrong.

I went down the path of hacking up some of the qemu qcow2 file system
code to see if I can achieve the ability to restore a snapshot from a
backing file to the temporarily created "-snapshot" qcow2 image.  The
backing file has been marked readonly by the filesystem and the active
image file was created with the "-snapshot" option.  I spend some time
reading the qcow2 documentation and it seems I have to copy the l1 and
l2 table values(are these actual host clusters) from the backing file
snapshot to the active images l1 and l2 tables.  Is there anything else
that may need updated that I have not yet stumbled upon?

I still don't have this working yet and I believe my area of problems is
qcow2_update_snapshot_refcount.  Can anyone explain what this does
exactly.  It seems the function does three different things based on the
value of addend, either -1, 0, 1, but its somewhat unclear.

Thanks,
Michael
