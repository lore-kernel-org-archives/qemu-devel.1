Received: from eggs.gnu.org ([2001:4830:134:3::10]:50488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhKf-0007ch-J2
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhKa-0005oy-L1
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:05 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:40014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dqhKa-0005nc-EF
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:00 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 752FB6FC63
	for <qemu-devel@nongnu.org>; Sat,  9 Sep 2017 17:05:58 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 09 Sep 2017 17:05:46 +0200
Message-ID: <150496954641.9654.1998704077006846521.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/5] spapr_pci: various cleanups and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Before resuming the huge work on PHB hotplug, here are some patches
that maybe worth to apply.

Patches 1 to 3 are basic improvements.

Patch 4 and 5 may be a bit controversial. Everywhere in the spapr
code where we build an FDT portion, libfdt failures cause QEMU to
exit, even on hotplug paths. Only spapr_pci doesn't do that and
propagates the error instead. My understanding is that a failure
when building the FDT is likely to happen because of a bug in QEMU.

Hence the choice to convert spapr_pci to do like the others. We may
even consider changing _FDT() to abort() instead of exit().

Alternatively, if libfdt failures shouldn't be necessarily fatal,
especially on post-realize paths, then we should probably introduce
an _FDT_ERR() helper to propagate errors. And use it in may places
where we currently terminate QEMU: memory hotplug, CPU hotplug, CAS,
machine reset...

--
Greg

---

Greg Kurz (5):
      spapr_pci: drop useless check in spapr_phb_vfio_get_loc_code()
      spapr_pci: drop useless check in spapr_populate_pci_child_dt()
      spapr_pci: use g_strdup_printf()
      spapr_pci: use the common _FDT() helper
      spapr_pci: handle FDT creation errors with _FDT()


 hw/ppc/spapr_pci.c |   69 ++++++++++++++++------------------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)
