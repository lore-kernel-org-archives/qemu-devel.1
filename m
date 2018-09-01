Received: from eggs.gnu.org ([2001:4830:134:3::10]:32905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvwd3-000440-55
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 23:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvwcT-0007F0-Mg
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 23:30:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:40564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fvwcT-0007DT-Ex
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 23:30:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fvwcR-0005qI-Rf
	for <qemu-devel@nongnu.org>; Sat, 01 Sep 2018 03:30:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C492D2E8023
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 03:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Sep 2018 03:20:07 -0000
From: elypter <elypter@yahoo.de>
Reply-To: Bug 1790260 <1790260@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153577200805.24343.11078147907776574944.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1790260] [NEW] binfmt support not working for x86
 host and x86_64 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

this is a problem in the qemu-binfmt-conf.sh script and maybe somewhere
else. the version i checked is the current github mirror
https://github.com/qemu/qemu/blob/master/scripts/qemu-binfmt-conf.sh

i am running linux mint 19 32bit on a 32bit x86 cpu and i want to run
some applications that are only available as x86_64 packages. i use
multiarch and qemu and it works for simple applications like cacafire.
however i want to run the application natively from the shell without
having to use qemu-x86_64 <path>. i also installed the binfmt-support
package. when i run update-binfmts --display then an extry for x86_64 is
missing and transparent execution is not working.

the problem seems to be in the qemu-binfmt-conf.sh script. it disables
the creation of entries for cpus of the same family. this is not a
problem if you are using a 64bit cpu because 32bit binaries run on it
natively but it doesnt work in the opposite way. hacking line 310 from

         if [ "$host_family" !=3D "$family" ] ; then

to

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ "$cpu" =3D "x86_=
64" ] || [ "$host_family" !=3D "$family" ] ;
then

and running it with the --systemd ALL parameter causes a x86_64 config
file to be created. it still doesnt work but that might have different
causes.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  this is a problem in the qemu-binfmt-conf.sh script and maybe somewhere
  else. the version i checked is the current github mirror
  https://github.com/qemu/qemu/blob/master/scripts/qemu-binfmt-conf.sh
  =

  i am running linux mint 19 32bit on a 32bit x86 cpu and i want to run
  some applications that are only available as x86_64 packages. i use
  multiarch and qemu and it works for simple applications like cacafire.
  however i want to run the application natively from the shell without
  having to use qemu-x86_64 <path>. i also installed the binfmt-support
  package. when i run update-binfmts --display then an extry for x86_64 is
  missing and transparent execution is not working.
  =

  the problem seems to be in the qemu-binfmt-conf.sh script. it disables
  the creation of entries for cpus of the same family. this is not a
  problem if you are using a 64bit cpu because 32bit binaries run on it
- natively but it doesnt work in the opposite way. hacking line 310 to
+ natively but it doesnt work in the opposite way. hacking line 310 from
  =

-          if [ "$cpu" =3D "x86_64" ] || [ "$host_family" !=3D "$family" ] ;
+          if [ "$host_family" !=3D "$family" ] ; then
+ =

+ to
+ =

+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ "$cpu" =3D "x8=
6_64" ] || [ "$host_family" !=3D "$family" ] ;
  then
  =

  and running it with the --systemd ALL parameter causes a x86_64 config
  file to be created. it still doesnt work but that might have different
  causes.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1790260

Title:
  binfmt support not working for x86 host and x86_64 guest

Status in QEMU:
  New

Bug description:
  this is a problem in the qemu-binfmt-conf.sh script and maybe
  somewhere else. the version i checked is the current github mirror
  https://github.com/qemu/qemu/blob/master/scripts/qemu-binfmt-conf.sh

  i am running linux mint 19 32bit on a 32bit x86 cpu and i want to run
  some applications that are only available as x86_64 packages. i use
  multiarch and qemu and it works for simple applications like cacafire.
  however i want to run the application natively from the shell without
  having to use qemu-x86_64 <path>. i also installed the binfmt-support
  package. when i run update-binfmts --display then an extry for x86_64
  is missing and transparent execution is not working.

  the problem seems to be in the qemu-binfmt-conf.sh script. it disables
  the creation of entries for cpus of the same family. this is not a
  problem if you are using a 64bit cpu because 32bit binaries run on it
  natively but it doesnt work in the opposite way. hacking line 310 from

           if [ "$host_family" !=3D "$family" ] ; then

  to

  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ "$cpu" =3D "x8=
6_64" ] || [ "$host_family" !=3D "$family" ] ;
  then

  and running it with the --systemd ALL parameter causes a x86_64 config
  file to be created. it still doesnt work but that might have different
  causes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1790260/+subscriptions
