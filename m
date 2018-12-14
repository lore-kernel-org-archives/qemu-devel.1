Received: from eggs.gnu.org ([2001:4830:134:3::10]:41811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@os.amperecomputing.com>) id 1gXpwF-0001fJ-8U
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@os.amperecomputing.com>) id 1gXpwB-0001JN-EP
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:03:43 -0500
Received: from mail-dm3nam03on0727.outbound.protection.outlook.com
	([2a01:111:f400:fe49::727]:6551
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@os.amperecomputing.com>)
	id 1gXpwB-0001Gi-7X
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:03:39 -0500
From: Michael Spradling <michael@os.amperecomputing.com>
Date: Fri, 14 Dec 2018 16:03:34 +0000
Message-ID: <20181214160328.GB20905@mswork1>
References: <20181130144404.GA32091@mswork1>
	<faae3e4a-bce7-849a-b510-1c94ffb03413@redhat.com>
	<20181213183253.GE10456@mswork1>
	<93edfff5-9cc2-8b19-b5a5-48ee4c7c0007@redhat.com>
In-Reply-To: <93edfff5-9cc2-8b19-b5a5-48ee4c7c0007@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0B06403EDE6034C97EEAFF59A92513D@prod.exchangelabs.com>
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

On Dec 13 15:43, Eric Blake wrote:
> On 12/13/18 12:33 PM, Michael Spradling wrote:
>=20
> > > > My question is has anyone looked into loading snapshots from a back=
ing
> > > > file?  I have attempted to look through the code and this looks to =
be
> > > > difficult.  If I attempt to add support for this is there any gener=
al
> > > > advice to follow?  Any other ideas?
> > >=20
> > > 'qemu-nbd -l' can serve snapshots from a qcow2 file; perhaps that can=
 be
> > > used to cobble together something that works for your needs?
> > >=20
>=20
> >=20
> > I looked at "qemu-nbd -l" and this seems to only export a readonly
> > interface.  Really, what I need is a writable temp file that can load a
> > snapshot snapshot.
>=20
> Can you combine -s (create a writable temp file) with -l to get what you
> want?
>=20
> /me tries:
>=20
> $ qemu-img create -f qcow2 a 1M
> Formatting 'a', fmt=3Dqcow2 size=3D1048576 cluster_size=3D65536 lazy_refc=
ounts=3Doff
> refcount_bits=3D16
> $ qemu-io -c 'w -P 1 0 512' a
> wrote 512/512 bytes at offset 0
> 512 bytes, 1 ops; 0.0487 sec (10.257 KiB/sec and 20.5137 ops/sec)
> $ qemu-img snapshot -c snap a
> $ qemu-io -c 'w -P 2 0 512' a
> wrote 512/512 bytes at offset 0
> 512 bytes, 1 ops; 0.0752 sec (6.645 KiB/sec and 13.2903 ops/sec)
> $ qemu-nbd -l snap -s a
> Failed to load snapshot: Can't find snapshot
>=20
> I can confirm that 'qemu-nbd -s a' lets me write data that is discarded o=
n
> disconnect (lsof says a temp file in /var/tmp/vl.XXXXXX was created); and
> that 'qemu-nbd -l snap a' lets me read the snapshot data. But mixing the =
two
> fails, and it would be a nice bug to fix.

I briefly looked at the code and is seams to be using the same base
functions as qemu does.  So, if I get this working for the model it
might also start working for qemu-nbd.

>=20
> >=20
> > Please excuse and correct me if I get some of the terminology of the
> > sections below wrong.
> >=20
> > I went down the path of hacking up some of the qemu qcow2 file system
> > code to see if I can achieve the ability to restore a snapshot from a
> > backing file to the temporarily created "-snapshot" qcow2 image.  The
> > backing file has been marked readonly by the filesystem and the active
> > image file was created with the "-snapshot" option.  I spend some time
> > reading the qcow2 documentation and it seems I have to copy the l1 and
> > l2 table values(are these actual host clusters) from the backing file
> > snapshot to the active images l1 and l2 tables.  Is there anything else
> > that may need updated that I have not yet stumbled upon?
>=20
> Mucking with the l1 and l2 tables implies that you are directly manipulat=
ing
> qcow2 contents.  It's much nicer if you can come up with a solution where
> qemu-img does all the qcow2 work for you, and you just worry about
> guest-visible data.  Or are you actually patching the code compiled into
> qemu-img?
>=20
Ideally, I want to not modify old images or create new images with
qemu-img, so I have been not modifing qemu-img, but qemu directly
itself.  My use case will have several snapshots in an image.(say
100).  I will then later resume each of these snapshots in a qemu
session in parallel.  This is why I have gone done the route of modifying
the temp snapshots file /var/tmp/vl.XXXXX L1 and l2 tables.  My
understanding is if these are updated and the cluster doesn't exists in
the temp file the code will then look for it in the backing file.  Still
researching this area.

> >=20
> > I still don't have this working yet and I believe my area of problems i=
s
> > qcow2_update_snapshot_refcount.  Can anyone explain what this does
> > exactly.  It seems the function does three different things based on th=
e
> > value of addend, either -1, 0, 1, but its somewhat unclear.
>=20
> Every cluster of qcow2 is reference-counted, to track which portions of t=
he
> file are (supposed to be) in use according to following the metadata trai=
ls.
> When internal snapshots are used, this is implemented by incrementing the
> refcount for each cluster that is reachable both from the snapshot and fr=
om
> the current L1 table (update_snapshot_refcount +1), then when writing to =
the
> cluster we break the reference count by writing the new data to a new
> allocation and decrementing the reference count of the old cluster. When
> trimming clusters, we decrement the refcount, and if it goes to 0 the
> cluster can be reused for something else.

I think I understand this.  That would satifys addend being a -1 or 1.
I am still unclear why you would call the fuction with addend being 0.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

Thanks for your help so far.
Michael
