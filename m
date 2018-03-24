Received: from eggs.gnu.org ([208.118.235.92]:54741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ezpDe-0006Ft-Um
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ezp7e-0001se-0v
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1ezp7d-0001rk-QN
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:46:37 -0400
Date: Sat, 24 Mar 2018 19:46:34 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180324194634.GW2787@redhat.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<1521915220-65389-15-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521915220-65389-15-git-send-email-mjc@sifive.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 26/26] RISC-V: Workaround for critical
 mstatus.FS MTTCG bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, patches@groups.riscv.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Maydell <peter.maydell@linaro.org>

On Sat, Mar 24, 2018 at 11:13:40AM -0700, Michael Clark wrote:
> This change is a workaround for a bug where mstatus.FS
> is not correctly reporting dirty when MTTCG and SMP are
> enabled which results in the floating point register file
> not being saved during context switches. This a critical
> bug for RISC-V in QEMU as it results in floating point
> register file corruption when running SMP Linux in the
> RISC-V 'virt' machine.
>=20
> This workaround will return dirty if mstatus.FS is
> switched from off to initial or clean. We have checked
> the specification and it is legal for an implementation
> to return either off, or dirty, if set to initial or clean.
>=20
> This workaround will result in unnecessary floating point
> save restore. When mstatus.FS is off, floating point
> instruction trap to indicate the process is using the FPU.
> The OS can then save floating-point state of the previous
> process using the FPU and set mstatus.FS to initial or
> clean. With this workaround, mstatus.FS will always return
> dirty if set to a non-zero value, indicating floating point
> save restore is necessary, versus misreporting mstatus.FS
> resulting in floating point register file corruption.
>=20
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>

I tested this by running qemu from git with and without this patch,
both times compiling and running the =E2=80=9Csched.c=E2=80=9D test progr=
am:

http://oirase.annexia.org/tmp/sched.c

In my tests it fixes the problem, and therefore:

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
