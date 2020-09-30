Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47978C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF05A2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWKu34v1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF05A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcOU-0007Qu-Ue
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcLU-0005eM-Qg
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcLR-0005Wy-Kq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:40:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601473232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7b9/7kKgzXwO6Jy62Yqx3GOG8AJCeQNcvRA3j+i46u4=;
 b=VWKu34v1XzPj803RQaER6pQb8Bv/2LO1745fP+DbkLOLXBDqmZUgqPjtEFuqaoZ/HdxSvp
 /JcGWeSwtBSZXsz6qp1lyFg1RhqHXp+8FHjr4TYHWI8tbeCvIuly4mLn9AGKx21GIt1pKb
 cIVBv65DNW1F3Hb8WyuoD6mOzTEHzHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-FSkGhxQVMMa5zgt2c9-YBA-1; Wed, 30 Sep 2020 09:40:30 -0400
X-MC-Unique: FSkGhxQVMMa5zgt2c9-YBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E39EADF00
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:40:29 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE5A619B5;
 Wed, 30 Sep 2020 13:40:28 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 00/19] i386: KVM: expand Hyper-V features early
Date: Wed, 30 Sep 2020 15:40:08 +0200
Message-Id: <20200930134027.1348021-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since RFCv1:
- Took a slightly differenet approach, instead of adding all missing
 Hyper-V feature leaves to feature_word_info[] remove the existing ones
 from there. The logic for handling them is very different and some of
 these leaves are not actually 'feature leaves'. See "i386: drop
 FEAT_HYPERV feature leaves" for details.
- x86_cpu_hyperv_realize introduced [Eduardo].
- Rebased to the latest master.

This pairs with
https://lore.kernel.org/kvm/20200929150944.1235688-1-vkuznets@redhat.com/T/#t
and as KVM part is not yet fully accepted, sending this as RFC.

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

Vitaly Kuznetsov (19):
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
  i386: introduce hv_cpuid_cache
  i386: drop FEAT_HYPERV feature leaves
  i386: split hyperv_handle_properties() into
    hyperv_expand_features()/hyperv_fill_cpuids()
  i386: move eVMCS enablement to hyperv_init_vcpu()
  i386: switch hyperv_expand_features() to using error_setg()
  i386: adjust the expected KVM_GET_SUPPORTED_HV_CPUID array size
  i386: prefer system KVM_GET_SUPPORTED_HV_CPUID ioctl over vCPU's one
  i386: use global kvm_state in hyperv_enabled() check
  i386: expand Hyper-V features during CPU feature expansion time

 linux-headers/asm-x86/kvm.h |  20 ++
 linux-headers/linux/kvm.h   |  27 +-
 target/i386/cpu.c           | 135 +++------
 target/i386/cpu.h           |  12 +-
 target/i386/kvm-stub.c      |   5 +
 target/i386/kvm.c           | 526 ++++++++++++++++++++----------------
 target/i386/kvm_i386.h      |   1 +
 7 files changed, 398 insertions(+), 328 deletions(-)

-- 
2.25.4


