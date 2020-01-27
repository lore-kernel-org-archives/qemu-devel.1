Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ACE2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcMfJVxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ACE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3KZ-00078O-NT
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iw3Jm-0006ad-6G
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iw3Jk-0003DE-Mf
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:16:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37415
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iw3Jk-0003CT-JJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w8Qg62ZlGlE/CqcpWbTqc7YvnbeHBeatRtd4VGc0/Ck=;
 b=IcMfJVxVChjZmu3SLuDOt9+5XKE8pxkwfd4F2gySpHyaik0Mwp2vrHFcB55BYrh/EjFIM6
 nHfzGJ1eTL4l9N1nOYNXWIL0KJD4BlcA3EVkowAB5hW2mi3m0YenYQBikpCFYsCGtvyqoB
 MGrrkmMmocoXZny87bwYEspBVHg0PLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-uvJwv1cHORm3mWBtEBloOw-1; Mon, 27 Jan 2020 07:16:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB846800D48;
 Mon, 27 Jan 2020 12:16:30 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-97.ams2.redhat.com [10.36.117.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 681B685735;
 Mon, 27 Jan 2020 12:16:29 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] qemu-cpu-models: Document -noTSX, mds-no, taa-no,
 and tsx-ctrl
Date: Mon, 27 Jan 2020 13:16:24 +0100
Message-Id: <20200127121625.27078-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: uvJwv1cHORm3mWBtEBloOw-1
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
Cc: pbonzini@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Add the '-noTSX' variants for CascadeLake and SkyLake.

- Document the three MSR bits: 'mds-no', 'taa-no', and 'tsx-ctrl'

  Two confusing about 'mds-no' (and the first point applies to the other
  two MSRs too):

  (1) The 'mds-no' will _not_ show up in the guest's /proc/cpuinfo.
      Rather it is used to fill in the guest's sysfs:

        sys/devices/system/cpu/vulnerabilities/mds:Not affected

      Paolo confirmed on IRC as such.

  (2) There are _three_ variants[+] of CascadeLake CPUs, with different
      stepping levels: 5, 6, and 7.  To quote wikichip.org[*]:

        "note that while steppings 6 & 7 are fully mitigated, earlier
        stepping 5 is not protected against MSBDS, MLPDS, nor MDSUM"

      The above is also indicated in the Intel's document[+], as
      indicated by "No" under the three columns of MFBDS, MSBDS, and
      MLPDS.

      [+] https://software.intel.com/security-software-guidance/insights/pr=
ocessors-affected-microarchitectural-data-sampling
      [*] https://en.wikichip.org/wiki/intel/microarchitectures/cascade_lak=
e#Key_changes_from_Skylake

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
v3:
 - Address feedback from Paolo
 - Add URL to the deep-dive on Intel's MDS
v2:
 - Address feedback from DanPB
 - Add sections on 'taa-no' and 'tsx-ctrl'
---
 docs/qemu-cpu-models.texi | 65 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
index f88a1def0d042cc25213259172a648f0a9c514dc..8be3fc34570c5af10557b862c46=
7f5520245a85a 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/qemu-cpu-models.texi
@@ -72,14 +72,25 @@ between machines, if live migration compatibility is re=
quired, use the newest
 CPU model that is compatible across all desired hosts.
=20
 @table @option
+
+@item @code{Cascadelake-Server}
+@item @code{Cascadelake-Server-noTSX}
+
+Intel Xeon Processor (Cascade Lake, 2019), with "stepping" levels
+6 or 7 only.  (The Cascade Lake Xeon processor with @b{stepping 5 is
+vulnerable to MDS variants}.)
+
+
 @item @code{Skylake-Server}
 @item @code{Skylake-Server-IBRS}
+@item @code{Skylake-Server-noTSX-IBRS}
=20
 Intel Xeon Processor (Skylake, 2016)
=20
=20
 @item @code{Skylake-Client}
 @item @code{Skylake-Client-IBRS}
+@item @code{Skylake-Client-noTSX-IBRS}
=20
 Intel Core Processor (Skylake, 2015)
=20
@@ -214,9 +225,61 @@ Must be explicitly turned on for all Intel CPU models.
=20
 Requires the host CPU microcode to support this feature before it
 can be used for guest CPUs.
+
+@item @code{mds-no}
+
+Recommended to inform the guest OS that the host is @i{not} vulnerable
+to any of the MDS variants ([MFBDS] CVE-2018-12130, [MLPDS]
+CVE-2018-12127, [MSBDS] CVE-2018-12126).
+
+This is an MSR (Model-Specific Register) feature rather than a CPUID
+feature, so it will not appear in the Linux @code{/proc/cpuinfo} in the
+host or guest.  Instead, the host kernel uses it to populate the MDS
+vulnerability file in @code{sysfs}.
+
+So it should only be enabled for VMs if the host reports @code{Not
+affected} in the @code{/sys/devices/system/cpu/vulnerabilities/mds}
+file.
+
+@item @code{taa-no}
+
+Recommended to inform that the guest that the host is @i{not} vulnerable
+to CVE-2019-11135, TSX Asynchronous Abort (TAA).
+
+This too is an MSR feature, so it does not show up in the Linux
+@code{/proc/cpuinfo} in the host or guest.
+
+It should only be enabled for VMs if the host reports @code{Not
+affected} in the
+@code{/sys/devices/system/cpu/vulnerabilities/tsx_async_abort} file.
+
+@item @code{tsx-ctrl}
+
+Recommended to inform the guest that it can disable the Intel TSX
+(Transactional Synchronization Extensions) feature; or, if the processor
+is vulnerable, use the Intel VERW instruction (a processor-level
+instruction that performs checks on memory access) as a mitigation for
+the TAA vulnerability.  (For details, refer to
+@url{https://software.intel.com/security-software-guidance/insights/deep-d=
ive-intel-analysis-microarchitectural-data-sampling,
+this Intel's deep-dive into MDS}.
+
+Expose this to the guest OS if and only if: (a) the host has TSX
+enabled; and (b) the guest has @code{rtm} CPU flag enabled.
+
+By disabling TSX, KVM-based guests can avoid paying the price of
+mitigting TSX-based attacks.
+
+Note that @code{tasx-ctrl} too is an MSR feature, so it does not show up
+in the Linux @code{/proc/cpuinfo} in the host or guest.
+
+To validate that Intel TSX is indeed disabled for the guest, there are
+two ways: (a) check for the @i{absence} of @code{rtm} in the guest's
+@code{/proc/cpuinfo}; or (b) the
+@code{/sys/devices/system/cpu/vulnerabilities/tsx_async_abort} file in
+the guest should report @code{Mitigation: TSX disabled}.
+
 @end table
=20
-
 @node preferred_cpu_models_amd_x86
 @subsubsection Preferred CPU models for AMD x86 hosts
=20
--=20
2.21.0


