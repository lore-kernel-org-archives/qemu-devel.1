Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E45C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA9D21D46
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJiML/iB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA9D21D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrVQ-00006y-56
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMJ-00085r-0p
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMG-0007tB-QZ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r2dy6VyzVqM/+uH8zQ00z+zsZiVOxWZqCNJ5Gg+oQlE=;
 b=VJiML/iBHouW618AeaWD7BTuHAcQsqSJPhwX5vUIUV+exlbYzkE7NA7pynEcKtPAaKsQ/0
 4YXkFLqe6bfzUw5q34UrijfEtF9drOKip/WiBTqpxPzhxwASJxTUoCZTdUmDlVNUJWjJvJ
 Doo9LQmuaBlvfINCIXELT/8aJKuluE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-HJlqJZiZNySdFl2VOS-WFQ-1; Fri, 09 Oct 2020 08:18:46 -0400
X-MC-Unique: HJlqJZiZNySdFl2VOS-WFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24204805F0B
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 12:18:45 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EDE95C1BB;
 Fri,  9 Oct 2020 12:18:43 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 00/23] i386: KVM: expand Hyper-V features early
Date: Fri,  9 Oct 2020 14:18:19 +0200
Message-Id: <20201009121842.1938010-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Another week another RFC. KVM patches are still in flight, so RFC again.

Changes since RFCv2:
- Rebase.
- Split "i386: drop FEAT_HYPERV feature leaves" into several patches and
  re-shuffle patches to minimize the code churn and make it easier to
  review. [Eduardo]
- Added "i386: provide simple 'hyperv=on' option to x86 machine types" on
  top.

This pairs with
https://lore.kernel.org/kvm/20200929150944.1235688-1-vkuznets@redhat.com/T/#t

Upper layer tools like libvirt want to figure out which Hyper-V features are
supported by the underlying stack (QEMU/KVM) but currently they are unable to
do so. We have a nice 'hv_passthrough' CPU flag supported by QEMU but it has
no effect on e.g. QMP's 

query-cpu-model-expansion type=full model={"name":"host","props":{"hv-passthrough":true}}

command as we parse Hyper-V features after creating KVM vCPUs and not at
feature expansion time. To support the use-case we first need to make 
KVM_GET_SUPPORTED_HV_CPUID ioctl a system-wide ioctl as the existing
vCPU version can't be used that early. This is what KVM part does. With
that done, we can make early Hyper-V feature expansion (this series).

In addition, add a simple 'hyperv=on' option to x86 machine types which
enables (and requires from KVM) all currently supported Hyper-V enlightenments.
Unlike 'hv_passthrough' mode, this is going to be migratable.

Vitaly Kuznetsov (23):
  WIP: update linux/headers
  i386: fill in FEAT_HYPERV_EDX from edx instead of eax
  i386: drop x86_cpu_get_supported_feature_word() forward declaration
  i386: move hyperv_vendor_id initialization to x86_cpu_realizefn()
  i386: move hyperv_interface_id initialization to x86_cpu_realizefn()
  i386: move hyperv_version_id initialization to x86_cpu_realizefn()
  i386: move hyperv_limits initialization to x86_cpu_realizefn()
  i386: keep hyperv_vendor string up-to-date
  i386: invert hyperv_spinlock_attempts setting logic with
    hv_passthrough
  i386: always fill Hyper-V CPUID feature leaves from X86CPU data
  i386: stop using env->features[] for filling Hyper-V CPUIDs
  i386: introduce hyperv_feature_supported()
  i386: introduce hv_cpuid_get_host()
  i386: drop FEAT_HYPERV feature leaves
  i386: introduce hv_cpuid_cache
  i386: split hyperv_handle_properties() into
    hyperv_expand_features()/hyperv_fill_cpuids()
  i386: move eVMCS enablement to hyperv_init_vcpu()
  i386: switch hyperv_expand_features() to using error_setg()
  i386: adjust the expected KVM_GET_SUPPORTED_HV_CPUID array size
  i386: prefer system KVM_GET_SUPPORTED_HV_CPUID ioctl over vCPU's one
  i386: use global kvm_state in hyperv_enabled() check
  i386: expand Hyper-V features during CPU feature expansion time
  i386: provide simple 'hyperv=on' option to x86 machine types

 docs/hyperv.txt             |   8 +
 hw/i386/x86.c               |  30 ++
 include/hw/i386/x86.h       |   7 +
 linux-headers/asm-x86/kvm.h |  20 ++
 linux-headers/linux/kvm.h   |  27 +-
 target/i386/cpu.c           | 149 ++++------
 target/i386/cpu.h           |  12 +-
 target/i386/kvm-stub.c      |   5 +
 target/i386/kvm.c           | 526 ++++++++++++++++++++----------------
 target/i386/kvm_i386.h      |   1 +
 10 files changed, 457 insertions(+), 328 deletions(-)

-- 
2.25.4


