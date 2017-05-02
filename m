Received: from eggs.gnu.org ([2001:4830:134:3::10]:48987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d5TH1-0001v2-3Q
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d5TGx-0003S5-JA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:35:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1d5TGx-0003QA-Cp
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:35:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8638DDF04C
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 08:35:01 +0000 (UTC)
Received: from localhost (ovpn-116-144.ams2.redhat.com [10.36.116.144])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2EF3C17AB0
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 08:35:01 +0000 (UTC)
Date: Tue, 2 May 2017 09:35:00 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170502083500.GA27432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Writing a C library to generate qemu command lines and
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>

Firstly, is there such a thing already?  (libvirt doesn't count since
it cannot generate -readconfig configuration files)

Well, I have written one.  It's in C and doesn't have any dependencies
beyond the standard C library:

  https://github.com/rwmjones/libguestfs/tree/max-disks/common/qemuopts

It models command line parameters as either flags (eg. =E2=80=98-nodefcon=
fig=E2=80=99),
flags with a single argument (=E2=80=98-name guest=E2=80=99), or flags ta=
king a list
(eg. =E2=80=98-drive file=3Dfoo,id=3Dbar=E2=80=99 modeled as a list of st=
rings).

I'm immediately aware that there are shortcomings with this approach
(see below).  Is there a better model to use for qemu command line
options that also allows -readconfig config files to be generated?

Some of the more obvious problems:

* I don't know if single flags can be translated into config files.

* Config files treat the "id=3D.." parameter as special, eg:
  =E2=80=98-drive file=3Dfoo,id=3Dbar=E2=80=99 is translated to:

  [drive "bar"]
    file =3D "foo"

* There's no clear mapping between some command line parameters and
  the config file, eg. =E2=80=98-m 2048 -kernel foo=E2=80=99 should be tr=
anslated into:

  [memory]
    size =3D "2048"
  [machine]
    kernel =3D "foo"

  but my library couldn't do that translation without a look-up table
  that would duplicate the internals of qemu.

There are also unknown unknowns:

* Is comma-quoting (ie. doubling any commas) sufficient?  Or are there
  other forms of quoting?  A quick look at options parsing in qemu
  doesn't show any.

* From the point of view of a client generating command lines, is there
  any significance to dotted names (eg. =E2=80=98-drive file.driver=3Dssh=
,...=E2=80=99)

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
