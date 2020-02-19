Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D892C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA9424654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTtTFkcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA9424654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Npi-0007Cg-BV
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 06:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j4NoA-0006Hh-3W
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j4No8-0004Xc-AZ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:46:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45724
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j4No8-0004XB-6Y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582112783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMHTra8XgW0Lfzs5jPKH7c0H1FtCNmxKAFmw26cbOVE=;
 b=eTtTFkcUZhNuuurpkKxsD0V4dkJaCgiKs5PnbfIe1nlrTtM6TaOHlDzjmlB+b8zMuurYEJ
 sFijK12LlbFEfgkt8IpLyLdB1tUts1qRI2caKw3o12bsHOHUa0w5J0vQHGYPc9VR89Uixk
 iozeuSvre549kBRvoArFHBySRfKWp0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-WcdFAUNaOKqF1uodmu8N7w-1; Wed, 19 Feb 2020 06:46:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 419D2800D50;
 Wed, 19 Feb 2020 11:46:14 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F369D19E9C;
 Wed, 19 Feb 2020 11:46:12 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: kchamart@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] qemu-cpu-models.rst: Document -noTSX, mds-no, taa-no,
 and tsx-ctrl
Date: Wed, 19 Feb 2020 12:46:07 +0100
Message-Id: <20200219114607.1855-3-kchamart@redhat.com>
In-Reply-To: <20200219114607.1855-1-kchamart@redhat.com>
References: <20200219114607.1855-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WcdFAUNaOKqF1uodmu8N7w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Add the '-noTSX' variants for CascadeLake and SkyLake.

- Document the three MSR bits: 'mds-no', 'taa-no', and 'tsx-ctrl'

  Two confusing things about 'mds-no' (and the first point applies to
  the other two MSRs too):

  (1) The 'mds-no' bit will _not_ show up in the guest's /proc/cpuinfo.
      Rather it is used to fill in the guest's sysfs:

        /sys/devices/system/cpu/vulnerabilities/mds:Not affected

      Paolo confirmed on IRC as such.

  (2) There are _three_ variants[+] of CascadeLake CPUs, with different
      stepping levels: 5, 6, and 7.  To quote wikichip.org[*]:

        "note that while steppings 6 & 7 are fully mitigated, earlier
        stepping 5 is not protected against MSBDS, MLPDS, nor MDSUM"

      The above is also indicated in the Intel's document[+], as
      indicated by "No" under the three columns of MFBDS, MSBDS, and
      MLPDS.

  I've expressed this in the docs without belabouring the details.

      [+] https://software.intel.com/security-software-guidance/insights/pr=
ocessors-affected-microarchitectural-data-sampling
      [*] https://en.wikichip.org/wiki/intel/microarchitectures/cascade_lak=
e#Key_changes_from_Skylake

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
[Retaining the change-log from the Texinfo-variant of this patch, which
is now no-longer needed:
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg06455.html]

v3:
 - Address feedback from Paolo
 - Add URL to the deep-dive on Intel's MDS
v2:
 - Address feedback from DanPB
 - Add sections on 'taa-no' and 'tsx-ctrl'
Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 docs/system/qemu-cpu-models.rst | 61 ++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/docs/system/qemu-cpu-models.rst b/docs/system/qemu-cpu-models.=
rst
index 2332fba1f9..5030dbef64 100644
--- a/docs/system/qemu-cpu-models.rst
+++ b/docs/system/qemu-cpu-models.rst
@@ -51,15 +51,18 @@ mixture of host CPU models between machines, if live mi=
gration
 compatibility is required, use the newest CPU model that is compatible
 across all desired hosts.
=20
+* Intel Xeon Processor (Cascade Lake, 2019), with "stepping" levels 6 or
+  7 only.  (The Cascade Lake Xeon processor with *stepping 5 is
+  vulnerable to MDS variants*.)
+
+  * ``Cascadelake-Server``
+  * ``Cascadelake-Server-noTSX``
+
 * Intel Xeon Processor (Skylake, 2016)
=20
   * ``Skylake-Server``
   * ``Skylake-Server-IBRS``
-
-* Intel Core Processor (Skylake, 2015)
-
-  * ``Skylake-Client``
-  * ``Skylake-Client-IBRS``
+  * ``Skylake-Server-IBRS-noTSX``
=20
 * Intel Core Processor (Broadwell, 2014)
=20
@@ -172,6 +175,54 @@ features are included if using "Host passthrough" or "=
Host model".
   Requires the host CPU microcode to support this feature before it
   can be used for guest CPUs.
=20
+``mds-no``
+  Recommended to inform the guest OS that the host is *not* vulnerable
+  to any of the MDS variants ([MFBDS] CVE-2018-12130, [MLPDS]
+  CVE-2018-12127, [MSBDS] CVE-2018-12126).
+
+  This is an MSR (Model-Specific Register) feature rather than a CPUID fea=
ture,
+  so it will not appear in the Linux ``/proc/cpuinfo`` in the host or
+  guest.  Instead, the host kernel uses it to populate the MDS
+  vulnerability file in ``sysfs``.
+
+  So it should only be enabled for VMs if the host reports @code{Not
+  affected} in the ``/sys/devices/system/cpu/vulnerabilities/mds`` file.
+
+``taa-no``
+  Recommended to inform that the guest that the host is ``not``
+  vulnerable to CVE-2019-11135, TSX Asynchronous Abort (TAA).
+
+  This too is an MSR feature, so it does not show up in the Linux
+  ``/proc/cpuinfo`` in the host or guest.
+
+  It should only be enabled for VMs if the host reports ``Not affected``
+  in the ``/sys/devices/system/cpu/vulnerabilities/tsx_async_abort``
+  file.
+
+``tsx-ctrl``
+  Recommended to inform the guest that it can disable the Intel TSX
+  (Transactional Synchronization Extensions) feature; or, if the
+  processor is vulnerable, use the Intel VERW instruction (a
+  processor-level instruction that performs checks on memory access) as
+  a mitigation for the TAA vulnerability.  (For details, refer to this
+  `Intel's deep-dive into
+  MDS <https://software.intel.com/security-software-guidance/insights/deep=
-dive-intel-analysis-microarchitectural-data-sampling>`_.)
+
+  Expose this to the guest OS if and only if: (a) the host has TSX
+  enabled; *and* (b) the guest has ``rtm`` CPU flag enabled.
+
+  By disabling TSX, KVM-based guests can avoid paying the price of
+  mitigting TSX-based attacks.
+
+  Note that ``tsx-ctrl`` too is an MSR feature, so it does not show
+  up in the Linux ``/proc/cpuinfo`` in the host or guest.
+
+  To validate that Intel TSX is indeed disabled for the guest, there are
+  two ways: (a) check for the *absence* of ``rtm`` in the guest's
+  ``/proc/cpuinfo``; or (b) the
+  ``/sys/devices/system/cpu/vulnerabilities/tsx_async_abort`` file in
+  the guest should report ``Mitigation: TSX disabled``.
+
=20
 Preferred CPU models for AMD x86 hosts
 --------------------------------------
--=20
2.21.0


