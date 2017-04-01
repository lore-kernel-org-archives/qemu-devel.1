Received: from eggs.gnu.org ([2001:4830:134:3::10]:34032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cuHxP-0002gn-Fr
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cuHxM-0002jV-5U
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:16:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cuHxL-0002iM-T8
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:16:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6847C001601
	for <qemu-devel@nongnu.org>; Sat,  1 Apr 2017 12:16:34 +0000 (UTC)
Date: Sat, 1 Apr 2017 13:16:31 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170401121631.GM30620@redhat.com>
References: <20170331205133.23906-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170331205133.23906-1-rjones@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] main-loop: Acquire main_context lock
 around os_host_main_loop_wait.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, fziglio@redhat.com

On Fri, Mar 31, 2017 at 09:51:33PM +0100, Richard W.M. Jones wrote:
> When running virt-rescue the serial console hangs from time to time.
> Virt-rescue runs an ordinary Linux kernel "appliance", but there is
> only a single idle process running inside, so the qemu main loop is
> largely idle.  With virt-rescue >=3D 1.37 you may be able to observe th=
e
> hang by doing:
>=20
>   $ virt-rescue -e ^] --scratch
>   ><rescue> while true; do ls -l /usr/bin; done

I know that people have had problems reproducing this bug.

It's easily reproducible, *if* you have the newest version of
virt-rescue.  Both the old and new versions of virt-rescue run qemu
with `-serial stdio', but in the old version the qemu chardev was
literally connected to stdio (the tty), and in the new version
virt-rescue has its own poll loop connected to the qemu chardev.  For
some reason this changes the scheduling in some way to make the bug
much more evident.

Unfortunately the new version was only available in Fedora Rawhide.

So what I have done for Fedora users is to backport the new
virt-rescue to the version of libguestfs available in Fedora 25 and
Fedora 26, in these versions:

  Fedora 25:
  libguestfs-tools-c >=3D 1.36.3-2.fc25
  https://bodhi.fedoraproject.org/updates/FEDORA-2017-0a9af45644
  or https://koji.fedoraproject.org/koji/taskinfo?taskID=3D18714553

  Fedora 26:
  libguestfs-tools-c >=3D 1.36.3-2.fc26
  https://bodhi.fedoraproject.org/updates/?packages=3Dlibguestfs (coming)
  or https://koji.fedoraproject.org/koji/taskinfo?taskID=3D18714548

You can tell if you have the old or new version of virt-rescue: The
new version has new options `-e' and `-i' (these were not present in
the old version), and also prints the following message when starting up:

  The virt-rescue escape key is =E2=80=98^]=E2=80=99.  Type =E2=80=98^] h=
=E2=80=99 for help.

After ensuring you have the new version of virt-rescue installed,
reproducing the bug should be as simple as:

  $ virt-rescue --scratch
  ><rescue> while true; do ls -l /usr/bin; done

If you want to run virt-rescue against a different version of qemu:

  $ LIBGUESTFS_BACKEND=3Ddirect LIBGUESTFS_HV=3D/path/to/qemu \
        virt-rescue --scratch

HTH,

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
