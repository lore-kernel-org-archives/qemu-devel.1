Received: from eggs.gnu.org ([2001:4830:134:3::10]:39792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dKPko-0001aS-FH
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dKPkn-0000Du-IB
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:51:38 -0400
Date: Mon, 12 Jun 2017 14:51:29 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170612135129.GA32008@redhat.com>
References: <cover.1497240079.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1497240079.git.jcody@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/2] Parse 'filename' option for RBD/iSCSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org

On Mon, Jun 12, 2017 at 12:05:12AM -0400, Jeff Cody wrote:
> We need to be able to parse the 'filename' option for both rbd and iscs=
i,
> because there may exist images in the wild that have json backing files=
,
> that specify the filename argument.
>=20
> Marking the series as RFC at least partially for the precedence given t=
o
> arguments; as written, these patches will give preference to the 'filen=
ame'
> parameter over passed options.

I tested this as follows:

(1) Prepare a test image.  By using the =E2=80=98qemu-img rebase -u=E2=80=
=99 option we
can set the formerly correct / now incorrect backing option to an
arbitrary json string of our choosing:

$ qemu-img create test.img -f qcow2 10M
$ qemu-img rebase -u -b 'json:{"file.driver":"rbd","file.filename":"rbd:r=
bd/rbd.img:mon_host=3D127.0.0.0"}' test.img=20

(2) With upstream qemu:

$ qemu-system-x86_64 -hda test.img=20
qemu-system-x86_64: -hda test.img: Could not open backing file: Parameter=
s 'pool' and 'image' are required

(3) With upstream qemu + these two patches:

$ ~/d/qemu/x86_64-softmmu/qemu-system-x86_64 -hda test.img
[hangs and eventually reports a timeout because I don't really
have a Ceph server]

So I would say that these patches, superficially at least, do seem to
work.  Although I wasn't able to test them against a real Ceph server.

  Tested-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
