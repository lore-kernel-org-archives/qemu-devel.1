Received: from eggs.gnu.org ([2001:4830:134:3::10]:51389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fLoUX-0007qA-FQ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fLoUV-00021Z-6W
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:33:09 -0400
Date: Thu, 24 May 2018 12:32:51 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180524113251.GB4660@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518180440-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: ehabkost@redhat.com, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

I read the whole thread and the fundamental problem is that you're
mixing layers.  Let qcow2 be a disk image format, and let management
layers deal with metadata and how to run qemu.

What's going to happen when you have (eg) an OVA file containing qcow2
files, and the qcow2 files all have different metadata from each other
and from the actual metadata in the OVA?  Even the case where you've
got =E2=80=98-hda file1.qcow2 -hdb file2.qcow2=E2=80=99 is not properly d=
efined.  What
happens if someone uses =E2=80=98-M mach1 -hda file.qcow2=E2=80=99 and th=
e machine
type in the qcow2 file conflicts with the command line?

BTW we have a tooling (libguestfs) which can tell you what devices are
supported by the guest.  virt-v2v already uses libguestfs to find out
the full list of devices supported by guests, and uses that to drive
conversion.  At some point we're going to extend virt-inspector to
make this a bit easier (patches and other contributions welcome,
there's a huge list of work to do on libguestfs and not enough
developers to get through it).

There is however a seed of a good idea in the thread:

> I don't think QEMU needs to use this information automatically,
> necessarily.  I think the first step is to simply make QEMU save
> this information in the disk image, and making qemu-img able to
> read and write this information.

It would be nice if qcow2 added arbitrary data sections (which would
always be ignored by qemu) for storing additional data.  This could be
used to create a compact qcow2 + metadata format to rival OVA for
management layers to use, and there are various other uses too.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
