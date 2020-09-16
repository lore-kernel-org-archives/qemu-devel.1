Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F258C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3223223EA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coy38HcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3223223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIakH-0006no-RF
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIahy-0003sS-33
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:55:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37152
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIahv-0005A7-Pf
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600275298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hU94UgIS7Y1inKRFiuVDTpvF27PzAWrRwxDLgo89gq8=;
 b=coy38HcSoc5HdSLm/pWWtwSKBex8fAhiz5iBll0DHrlecYV+xNhY9uFE5+P4Yb5ntxGvCr
 SVZa3XEK24JYfReKJK764IUZEGIZcT6raI7+WM7S8gm5PuJnJvpcA0bbZMTgItHh7+xSZ3
 Q4G1Gowh/uzNq8iiTSqFTqZh+bXkvnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-nUD7uqK1OT6PFXe1K9qd8g-1; Wed, 16 Sep 2020 12:54:50 -0400
X-MC-Unique: nUD7uqK1OT6PFXe1K9qd8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B20D81F03B
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:54:50 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA6015DA71;
 Wed, 16 Sep 2020 16:54:27 +0000 (UTC)
Message-ID: <7569a17e836616459154a60e9a601edbc8003d3f.camel@redhat.com>
Subject: [RFC DOCUMENT 09/12] kubevirt-and-kvm: Add Isolation page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:54:25 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Isolation.md

# Isolation

How is the QEMU process isolated from the host and from other VMs?

## Traditional virtualization

cgroups

* managed by libvirt

SELinux

* libvirt is privileged and QEMU is protected by SELinux policies set
  by libvirt (SVirt)
* QEMU runs with SELinux type `svirt_t`

## KubeVirt

cgroups

* Managed by kubelet
  * No involvement from libvirt
* Memory limits
  * When using hard limits, the entire VM can be killed by Kubernetes
  * Memory consumption estimates are based on heuristics

SELinux

* KubeVirt is not using SVirt and there are no plans to do so
* At the moment, the custom [KubeVirt SELinux policy][] is used to
  ensure libvirt has sufficient privilege to perform its own setup
  steps
  * The standard SELinux type used by containers is `container_t`
  * KubeVirt would like to eventually use the same for VMs as well

Capabilities

* The default set of capabilities is fairly conservative
  * Privileged operation should happen outside of the pod: in
    KubeVirt's case, a good candidate is `virt-handler`, the
    privileged components that runs at the node level
* Additional capabilities can be requested for a pod
  * However, this is frowned upon and considered a liability from the
    security point of view
  * The cluster admin may even set a security policy that prevent
    pods from using certain capabilities
    * In such a scenario, KubeVirt workloads may be entirely unable
      to run

## Specific examples

The following is a list of examples, either historical or current, of
scenarios where libvirt's approach to isolation clashed with
Kubernetes' and changes on either component were necessary.

SELinux

* libvirt use of hugetlbfs for hugepages config is disallowed by
  `container_t`
  * Possibly fixable by using memfd
    * [libvirt memoryBacking docs][]
    * [KubeVirt memfd issue][]
* Use of libvirt+QEMU multiqueue tap support is disallowed by
  `container_t`
  * And there’s no way to pass in this setup from outside the
    existing stack
  * [KubeVirt multiqueue workaround][] extending their SELinux policy to allow
    `attach_queue`
* Passing precreated tap devices to libvirt triggers
  relabelfrom+relabelto `tun_socket` SELinux access
  * This may not be virt stacks fault, seems to happen automatically
    when permissions aren’t correct

Capabilities

* libvirt performs memory locking for VFIO devices unconditionally
  * Previously KubeVirt had to grant `CAP_SYS_RESOURCE` to pods.
    KubeVirt worked around it by duplicating libvirt’s memory pinning
    calculations so the libvirt action would be a no-op, but that is
    fragile and may cause the issue to resurface if libvirt
    calculation logic changes.
  * References: [libvir-list memlock thread][], [KubeVirt memlock
    PR][], [libvirt qemuDomainGetMemLockLimitBytes][], [KubeVirt
    VMI.getMemlockSize][]
* virtiofsd requires `CAP_SYS_ADMIN` capability to perform
  `unshare(CLONE_NEWPID|CLONE_NEWNS)`
  * This is required for certain use cases like running overlayfs in
    the VM on top of virtiofs, but is not a requirement for all
    usecases.
  * References: [KubeVirt virtiofs PR][], [RHEL virtiofs bug][]
* KubeVirt uses libvirt for CPU pinning, which requires the pod to
  have `CAP_SYS_NICE`.
  * Long term, KubeVirt would like to handle that pinning in their
    privileged component virt-handler, so `CAP_SYS_NICE` can be
    dropped.
    * Sidenote: libvirt unconditionally requires `CAP_SYS_NICE` when
      any other running VM is using CPU pinning, however this sounds
      like a plain old bug.
  * References: [KubeVirt CPU pinning PR][], [KubeVirt CPU pinning
    workaround PR][], [RHEL CPU pinning bug][]
* libvirt bridge usage used to require `CAP_NET_ADMIN`
  * This is a historical example for reference. libvirt usage of a
    bridge device always implied tap device creation, which required
    `CAP_NET_ADMIN` privileges for the pod
  * The fix was to teach libvirt to accept a precreated tap device
    and skip some setup operations on it
    * Example XML: `<interface type='ethernet'><target dev='mytap0'
      managed='no'/></interface>`
  * Kubevirt still hasn’t fully managed to drop `CAP_NET_ADMIN`
    though
  * References: [RHEL precreated TAP bug][], [libvirt precreated TAP
    patches][], [KubeVirt precreated TAP PR][], [KubeVirt NET_ADMIN
    issue][], [KubeVirt NET_ADMIN issue][]

[KubeVirt CPU pinning PR]: https://github.com/kubevirt/kubevirt/pull/1381
[KubeVirt CPU pinning workaround PR]: https://github.com/kubevirt/kubevirt/pull/1648
[KubeVirt NET_ADMIN PR]: https://github.com/kubevirt/kubevirt/pull/3290
[KubeVirt NET_ADMIN issue]: https://github.com/kubevirt/kubevirt/issues/3085
[KubeVirt SELinux policy]: https://github.com/kubevirt/kubevirt/blob/master/cmd/virt-handler/virt_launcher.cil
[KubeVirt VMI.getMemlockSize]: https://github.com/kubevirt/kubevirt/blob/f5ffba5f84365155c81d0e2cda4aa709da062230/pkg/virt-handler/isolation/isolation.go#L206
[KubeVirt memfd issue]: https://github.com/kubevirt/kubevirt/issues/3781
[KubeVirt memlock PR]: https://github.com/kubevirt/kubevirt/pull/2584
[KubeVirt multiqueue workaround]: https://github.com/kubevirt/kubevirt/pull/2941/commits/bc55cb916003c54f6cbf329112a4e36d0d874836
[KubeVirt precreated TAP PR]: https://github.com/kubevirt/kubevirt/pull/2837
[KubeVirt virtiofs PR]: https://github.com/kubevirt/kubevirt/pull/3493
[RHEL CPU pinning bug]: https://bugzilla.redhat.com/show_bug.cgi?id=1819801
[RHEL precreated TAP bug]: https://bugzilla.redhat.com/show_bug.cgi?id=1723367
[RHEL virtiofs bug]: https://bugzilla.redhat.com/show_bug.cgi?id=1854595
[libvir-list memlock thread]: https://www.redhat.com/archives/libvirt-users/2019-August/msg00046.html
[libvirt memoryBacking docs]: https://libvirt.org/formatdomain.html#elementsMemoryBacking
[libvirt precreated TAP patches]: https://www.redhat.com/archives/libvir-list/2019-August/msg01256.html
[libvirt qemuDomainGetMemLockLimitBytes]: https://gitlab.com/libvirt/libvirt/-/blob/84bb5fd1ab2bce88e508d416f4bcea520c803ea8/src/qemu/qemu_domain.c#L8712


