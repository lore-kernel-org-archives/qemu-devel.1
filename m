Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABACC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF95224D4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gn4qWz9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF95224D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIahx-0003Ks-U7
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIag4-0001L9-De
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:53:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53970
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIag2-00051e-8n
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600275180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UO2MPl61bpXLCaJVgcXnG/6+JOy2xawFMMO2g98mkbk=;
 b=gn4qWz9L9ltlKSlyFppTEfhsIbwfuz/0K5wyBHFJCH8gvCnYU6yctNfOkJjziVAl879rW/
 PFSqPrg+FvJyewdeK4T99oBjKQ67LFy5cl+K2Jnx/HHj94ARx7iqGHcHk2R24JNgiX7Qt3
 C0QpWxu1pKr8O+xJCMCz89R/Nk57kPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-AgPphmqrN_CXpYfdc3VuUQ-1; Wed, 16 Sep 2020 12:52:58 -0400
X-MC-Unique: AgPphmqrN_CXpYfdc3VuUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1671DEF4F7
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:52:50 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9280516E30;
 Wed, 16 Sep 2020 16:52:18 +0000 (UTC)
Message-ID: <640224075dc9c0ce5e1315e4769b48108822c084.camel@redhat.com>
Subject: [RFC DOCUMENT 07/12] kubevirt-and-kvm: Add CPU Pinning page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:52:15 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=abologna@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 11:53:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: vromanso@redhat.com, rmohr@redhat.com, crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/CPU-Pinning.md

# CPU pinning

As is the case for many of KubeVirt's features, CPU pinning is
partially achieved using standard Kubernetes components: this both
reduces the amount of new code that has to be written and guarantees
better integration with containers running side by side with the VMs.

## Kubernetes CPU Manager

The Static policy allocates exclusive CPUs to pod containers in the
Guaranteed QoS class which request integer CPUs. On a best-effort
basis, the Static policy tries to allocate CPUs topologically in the
following order:

* Allocate all the CPUs in the same processor socket if available and
  the container requests at least an entire socket worth of CPUs.
* Allocate all the logical CPUs (hyperthreads) from the same physical
  CPU core if available and the container requests an entire core
  worth of CPUs.
* Allocate any available logical CPU, preferring to acquire CPUs from
  the same socket.

## KubeVirt dedicated CPU placement

KubeVirt relies on the Kubernetes CPU Manager to allocate dedicated
CPUs to the `virt-launcher` container.

When `virt-launcher` starts, it reads
`/sys/fs/cgroup/cpuset/cpuset.cpus` and generates `<vcpupin>`
configuration for libvirt based on the information found within.
However, affinity changes require `CAP_SYS_NICE` so this additional
capability has to be granted to the VM pod.

Going forward, we would like to perform the affinity change in
`virt-handler` (the privileged component running at the node level),
which would allow the VM pod to work without additional capabilities.


