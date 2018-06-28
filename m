Received: from eggs.gnu.org ([2001:4830:134:3::10]:60531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYYxm-0002Dq-9C
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYYxj-00010g-6j
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:33022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fYYxi-0000xA-VV
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fYYxf-0006KT-9u
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 15:35:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7881A2E8215
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 15:35:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Jun 2018 15:27:11 -0000
From: Frank Heimes <1779162@bugs.launchpad.net>
Reply-To: Bug 1779162 <1779162@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153019917547.30104.5346308426919888166.malonedeb@wampee.canonical.com>
Message-Id: <153019963187.18448.16538535058429175201.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1779162] Re: qemu versions 2.10 and 2.11 have
 error during migration of larger guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Also affects: qemu
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Also affects: ubuntu-z-systems
   Importance: Undecided
       Status: New

** Changed in: ubuntu-z-systems
   Importance: Undecided =3D> Critical

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779162

Title:
  qemu versions 2.10 and 2.11 have error during migration of larger
  guests

Status in Ubuntu Cloud Archive:
  New
Status in Ubuntu on IBM z Systems:
  New
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Artful:
  Won't Fix

Bug description:
  =3D=3D Comment: #0 - Christian Borntraeger  - 2018-06-28 06:39:27 =3D=3D
  Migration fails with larger guests (e.g. 10GB)  on a z system prints an e=
rror message in the log =


  see /var/log/libvirt/qemu/...
  [...]
  qemu-system-s390x: KVM_S390_SET_CMMA_BITS failed: Bad address

  This messes up guest state for the CMMA values (guest data corruption)

  This is fixed with

  commit 46fa893355e0bd88f3c59b886f0d75cbd5f0bbbe
  Author:     Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
  AuthorDate: Thu Jan 18 18:51:44 2018 +0100
  Commit:     Cornelia Huck <cohuck@redhat.com>
  CommitDate: Mon Jan 22 11:04:52 2018 +0100

      s390x: fix storage attributes migration for non-small guests
      =

      Fix storage attribute migration so that it does not fail for guests
      with more than a few GB of RAM.
      With such guests, the index in the buffer would go out of bounds,
      usually by large amounts, thus receiving -EFAULT from the kernel.
      Migration itself would be successful, but storage attributes would th=
en
      not be migrated completely.
      =

      This patch fixes the out of bounds access, and thus migration of all
      storage attributes when the guest have large amounts of memory.
      =

      Cc: qemu-stable@nongnu.org
      Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
      Fixes: 903fd80b03243476 ("s390x/migration: Storage attributes device")
      Message-Id: <1516297904-18188-1-git-send-email-imbrenda@linux.vnet.ib=
m.com>
      Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
      Signed-off-by: Cornelia Huck <cohuck@redhat.com>

  This fix is part of 2.11.1 so the qemu in bionic is fine.
  The qemu in artful, as well as the qemu in the cloud archives for 16.04 n=
eed this fix, so we have
  affected qemus in 17.10 and 16.04. =


  Regarding 16.04:
  The bug only triggers for host kernels >=3D 4.13 - in other words when yo=
u combine HWE kernel with the qemu from the cloud archive.

To manage notifications about this bug go to:
https://bugs.launchpad.net/cloud-archive/+bug/1779162/+subscriptions
