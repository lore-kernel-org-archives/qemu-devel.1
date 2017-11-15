Received: from eggs.gnu.org ([2001:4830:134:3::10]:50968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eEwFV-0004Nr-9J
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eEwFS-0000kc-5A
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:52:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eEwFR-0000kD-Rv
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:52:54 -0500
Date: Wed, 15 Nov 2017 11:52:46 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171115115246.GA1955@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Effect of qemu-img convert -m and -W options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libguestfs@redhat.com
Cc: qemu-devel@nongnu.org, pl@kamp.de

[CC to qemu-devel since I'm obviously doing something wrong here,
I'm just not sure what.]

I was getting ready to add multiple threads to =E2=80=98qemu-img convert=E2=
=80=99 (the
longest part of v2v conversions) when I noticed that it had them
already!  (To be fair this was only added in February this year so no
wonder we didn't notice.)

To enable parallel convert we would need to use the =E2=80=98qemu-img con=
vert
-W=E2=80=99 option (which allows out-of-order writes to the destination) =
and
=E2=80=98qemu-img convert -m <#num-coroutines>=E2=80=99 option to select =
the
parallelism (defaults to 8).  The documentation refers to coroutines
but I verified from strace that it is using real threads.

I did some testing to see what effect this has.  For this I used a
large guest image which is approximately a third full of random data
(the rest being sparsely allocated):

  Source format:       raw
  Source virtual size: 100 GB
  Source used space:   31 GB =20
  Target format:       qcow2
  Version:             qemu-img-2.10.0-7.fc28.x86_64
  Conversion command:
    rm -f /to/target
    time qemu-img convert [-W] [-m ##] -f raw source.img -O qcow2 /to/tar=
get

Source and target are regular files on two different disks.  The test
machine is a Xeon E5 with 16 real cores.

----------------------------------------------------------------------
                  Non-preallocated output
                  (times are in seconds)
                   without -W       -W

-m 1                153              -

-m 4                155             157

-m 8 [default]      158             231

-m 16 [max]         166             166
----------------------------------------------------------------------

The documentation for =E2=80=98-W=E2=80=99 notes that this is only recomm=
ended for
preallocated outputs (which the test above does not use).  So let's
try using a preallocated qcow2 output.

  Conversion command:
    # the same target file is reused each time
    time qemu-img convert -n [-W] [-m ##] -f raw source.img -O qcow2 /to/=
target

----------------------------------------------------------------------
                   Preallocated output
                  (times are in seconds)
                   without -W       -W

-m 1                147              -

-m 4                146             145

-m 8 [default]      146             199

-m 16 [max]         147             146
----------------------------------------------------------------------

Based on this there seems to be some issue with the =E2=80=98-W=E2=80=99 =
option -- I
even thought I might have it backwards, but checking the code it does
seem like =E2=80=98-W=E2=80=99 enables (rather than disables) out of orde=
r writes.
Also some bizarre interaction between =E2=80=98-W=E2=80=99 and =E2=80=98-=
m 8=E2=80=99.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
