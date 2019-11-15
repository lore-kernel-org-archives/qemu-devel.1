Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE023C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA452073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYrn+hIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA452073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeTv-0004he-5h
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iVeP8-0007Pw-6f
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iVeP6-0000YN-87
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iVeP6-0000Y5-3x
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573835099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JvsBFjlBi+I/DQztVqVIvuEGZXJYhHsDOOp2pK429Fo=;
 b=XYrn+hIYYd56TeZ2dxr7S1BDRDFe0l3rSrvpc+m8F+KK5/pvvGkMoHIbbcM4QZAjy1sRtE
 F8tbYED2e1I3aPbwa9f5rXpJe/FyCJMpDZBZIuLp/HKx5k3aG1LxOdyzwomAvVDINNX1P3
 G+G2FjGGHKm2tVzEo1/8QBhsWNWqd7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-vCFVXrMONWapwkLfkFedxg-1; Fri, 15 Nov 2019 11:24:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2D851010CA2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 16:24:56 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-60.ams2.redhat.com [10.36.117.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB7B610016E8;
 Fri, 15 Nov 2019 16:24:51 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v3] Add a blog post on "Micro-Optimizing KVM VM-Exits"
Date: Fri, 15 Nov 2019 17:24:41 +0100
Message-Id: <20191115162441.27302-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: vCFVXrMONWapwkLfkFedxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: aarcange@redhat.com, thuth@redhat.com,
 Kashyap Chamarthy <kchamart@redhat.com>, dgilbert@redhat.com,
 rjones@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This blog post summarizes the talk "Micro-Optimizing KVM VM-Exits"[1],
given by Andrea Arcangeli at the recently concluded KVM Forum 2019.

[1] https://kvmforum2019.sched.com/event/Tmwr/micro-optimizing-kvm-vm-exits=
-andrea-arcangeli-red-hat-inc

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
v3:
 - Address feedback from Laszlo
 - Change the extension to .md and other small feedback from Thomas Huth
   on IRC
v2: Address Rich W.M Jones' feedback
---
 ...2019-11-15-micro-optimizing-kvm-vmexits.md | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 _posts/2019-11-15-micro-optimizing-kvm-vmexits.md

diff --git a/_posts/2019-11-15-micro-optimizing-kvm-vmexits.md b/_posts/201=
9-11-15-micro-optimizing-kvm-vmexits.md
new file mode 100644
index 0000000000000000000000000000000000000000..ccb38a3956ef8e841417ddb9e70=
df44967caef4e
--- /dev/null
+++ b/_posts/2019-11-15-micro-optimizing-kvm-vmexits.md
@@ -0,0 +1,117 @@
+---
+layout: post
+title: "Micro-Optimizing KVM VM-Exits"
+date:   2019-11-15
+author: Kashyap Chamarthy
+categories: [kvm, optimizations]
+---
+
+Background on VM-Exits
+----------------------
+
+KVM (Kernel-based Virtual Machine) is the Linux kernel module that
+allows a host to run virtualized guests (Linux, Windows, etc).  The KVM
+"guest execution loop", with QEMU (the open source emulator and
+virtualizer) as its user space, is roughly as follows: QEMU issues the
+ioctl(), KVM_RUN, to tell KVM to prepare to enter the CPU's "Guest Mode"
+-- a special processor mode which allows guest code to safely run
+directly on the physical CPU.  The guest code, which is inside a "jail"
+and thus cannot interfere with the rest of the system, keeps running on
+the hardware until it encounters a request it cannot handle.  Then the
+processor gives the control back (referred to as "VM-Exit") either to
+kernel space, or to the user space to handle the request.  Once the
+request is handled, native execution of guest code on the processor
+resumes again.  And the loop goes on.
+
+There are dozens of reasons for VM-Exits (Intel's Software Developer
+Manual outlines 64 "Basic Exit Reasons").  For example, when a guest
+needs to emulate the CPUID instruction, it causes a "light-weight exit"
+to kernel space, because CPUID (among a few others) is emulated in the
+kernel itself, for performance reasons.  But when the kernel _cannot_
+handle a request, e.g. to emulate certain hardware, it results in a
+"heavy-weight exit" to QEMU, to perform the emulation.  These VM-Exits
+and subsequent re-entries ("VM-Enters"), even the light-weight ones, can
+be expensive.  What can be done about it?
+
+Guest workloads that are hard to virtualize
+-------------------------------------------
+
+At the 2019 edition of the KVM Forum in Lyon, kernel developer, Andrea
+Arcangeli, addressed the kernel part of minimizing VM-Exits.
+
+His talk touched on the cost of VM-Exits into the kernel, especially for
+guest workloads (e.g. enterprise databases) that are sensitive to their
+performance penalty.  However, these workloads cannot avoid triggering
+VM-Exits with a high frequency.  Andrea then outlined some of the
+optimizations he's been working on to improve the VM-Exit performance in
+the KVM code path -- especially in light of applying mitigations for
+speculative execution flaws (Spectre v2, MDS, L1TF).
+
+Andrea gave a brief recap of the different kinds of speculative
+execution attacks (retpolines, IBPB, PTI, SSBD, etc).  Followed by that
+he outlined the performance impact of Spectre-v2 mitigations in context
+of KVM.
+
+The microbechmark: CPUID in a one million loop
+----------------------------------------------
+
+Andrea constructed a synthetic microbenchmark program (without any GCC
+optimizations or caching) which runs the CPUID instructions one million
+times in a loop.  This microbenchmark is meant to focus on measuring the
+performance of a specific area of the code -- in this case, to test the
+latency of VM-Exits.
+
+While stressing that the results of these microbenchmarks do not
+represent real-world workloads, he had two goals in mind with it: (a)
+explain how the software mitigation works; and (b) to justify to the
+broader community the value of the software optimizations he's working
+on in KVM.
+
+Andrea then reasoned through several interesting graphs that show how
+CPU computation time gets impacted when you disable or enable the
+various kernel-space mitigations for Spectre v2, L1TF, MDS, et al.
+
+The proposal: "KVM Monolithic"
+------------------------------
+
+Based on his investigation, Andrea proposed a patch series, ["KVM
+monolithc"](https://lwn.net/Articles/800870/), to get rid of the KVM
+common module, 'kvm.ko'.  Instead the KVM common code gets linked twice
+into each of the vendor-specific KVM modules, 'kvm-intel.ko' and
+'kvm-amd.ko'.
+
+The reason for doing this is that the 'kvm.ko' module indirectly calls
+(via the "retpoline" technique) the vendor-specific KVM modules at every
+VM-Exit, several times.  These indirect calls=E2=80=94via function pointer=
s in
+the C source code=E2=80=94were not optimal before, but the "retpoline"
+mitigation (which isolates indirect branches, that allow a CPU to
+execute code from arbitrary locations, from speculative execution) for
+Spectre v2 compounds the problem, as it degrades performance.
+
+This approach will result in a few MiB of increased disk space for
+'kvm-intel.ko' and 'kvm-amd.ko', but the upside in saved indirect calls,
+and the elimination of "retpoline" overhead at run-time more than
+compensate for it.
+
+With the "KVM Monolithic" patch series applied, Andrea's microbenchmarks
+show a double-digit improvement in performance with default mitigations
+(for Spectre v2, et al) enabled on both Intel 'VMX' and AMD 'SVM'.  And
+with 'spectre_v2=3Doff' or for CPUs with IBRS_ALL in ARCH_CAPABILITIES
+"KVM monolithic" still improve[s] performance, albiet it's on the order
+of 1%.
+
+Conclusion
+----------
+
+Removal of the common KVM module has a non-negligible positive
+performance impact.  And the "KVM Monolitic" patch series is still
+actively being reviewed, modulo some pending clean-ups.  Based on the
+upstream review discussion, KVM Maintainer, Paolo Bonzini, and other
+reviewers seemed amenable to merge the series.
+
+Although, we still have to deal with mitigations for 'indirect branch
+prediction' for a long time, reducing the VM-Exit latency is important
+in general; and more specifically, for guest workloads that happen to
+trigger frequent VM-Exits, without having to disable Spectre v2
+mitigations on the host, as Andrea stated in the cover letter of his
+patch series.
--=20
2.21.0


