Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D069FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF977229C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItdchixR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF977229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIadS-0005jN-Pt
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIacG-0004Mj-7v
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIacD-0004Ud-Jz
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600274944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78ptYJF0a1spvRhiWagzrnpAvYN+bN18Y5w63SnF4u4=;
 b=ItdchixR5ECnd4O5ZmmewchKN8GGT9wiPTcDEwvhvQrM1Klbqd+bSopzgNGodmcuL6zrKV
 gqEW3z0mYjRDV2pBNv/+7YM0xwyOOVSvwPglIyv50mkoyhW55M+OyZki89gmDJicHEuJ5K
 VZdqc0JyDeCrGyJVDgNpZXNqbwOt/hY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-CTb69B7TO8eTj2714vIapg-1; Wed, 16 Sep 2020 12:48:52 -0400
X-MC-Unique: CTb69B7TO8eTj2714vIapg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3557E10BBEC3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:48:51 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B0802C31E;
 Wed, 16 Sep 2020 16:48:41 +0000 (UTC)
Message-ID: <5ec07dad98aaea8f2d8c5f4bf54f852b9dab89f1.camel@redhat.com>
Subject: [RFC DOCUMENT 04/12] kubevirt-and-kvm: Add Storage page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:48:39 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: vromanso@redhat.com, alitke@redhat.com, rmohr@redhat.com,
 stefanha@redhat.com, crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Storage.md

# Storage

This document describes the known use-cases and architecture options
we have for Linux Virtualization storage in [KubeVirt][].

## Problem description

The main goal of Kubevirt is to leverage the storage subsystem of
Kubernetes (built around [CSI][] and [Persistent Volumes][] aka PVs),
in order to let both workloads (VMs and containers) leverage the same
storage. As a consequence Kubevirt is limited in its use of QEMU
storage subsystem and features. That means:

* Storage solutions should be implemented in k8s in a way that can be
  consumed by both containers and VMs.
* VMs can only consume (and provide) storage features which are
  available in the pod, through k8s APIs. For example, a VM will not
  support disk snapshots if it’s attached to a storage provider that
  doesn’t support it. Ditto for incremental backup, block jobs,
  encryption, etc.

## Current situation

### Storage handled outside of QEMU

In this scenario, the VM pod uses a [Persistent Volume Claim
(PVC)][Persistent Volumes] to give QEMU access to a raw storage
device or fs mount, which is provided by a [CSI][] driver. QEMU
**doesn’t** handle any of the storage use-cases such as thin
provisioning, snapshots, change block tracking, block jobs, etc.

This is how things work today in KubeVirt.

![Storage handled outside of QEMU][Storage-Current]

Devices and interfaces:

* PVC: block or fs
* QEMU backend: raw device or raw image
* QEMU frontend: virtio-blk
  * alternative: emulated device for wider compatibility and Windows
    installations
  * CDROM (sata)
  * disk (sata)

Pros:

* Simplicity
* Sharing the same storage model with other pods/containers

Cons:

* Limited feature-set (fully off-loaded to the storage provider from
  CSI).
* No VM snapshots (disk + memory)
* Limited opportunities for fine-tuning and optimizations for
  high-performance.
* Hotplug is challenging, because the set of PVCs in a pod is
  immutable.

Questions and comments

* How to optimize this in QEMU?
  * Can we bypass the block layer for this use-case? Like having SPDK
    inside the VM pod?
    * Rust-based storage daemon (e.g. [vhost_user_block][]) running
      inside the VM pod alongside QEMU (bypassing the block layer)
  * We should be able to achieve high-performance with local NVME
    storage here, with multiple polling IOThreads and multi queue.
* See [this blog post][PVC resize blog] for information about the PVC
  resize feature.  To implement this for VMs we could have kubevirt
  watch PVCs and respond to capacity changes with a corresponding
  call to resize the image file (if applicable) and to notify qemu of
  the enlarged device.
* Features such as incremental backup (CBT) and snapshots could be
  implemented through a generic CSI backend... Device mapper?
  Stratis? (See [Other Topics](#other-topics))

## Possible alternatives

### Storage device passthrough (highest performance)

Device passthrough via PCI VFIO, SCSI, or vDPA. No storage use-cases
and no CSI, as the device is passed directly to the guest.

![Storage device passthrough][Storage-Passthrough]

Devices and interfaces:

* N/A (hardware passthrough)

Pros:

* Highest possible performance (same as host)

Cons:

* No storage features anywhere outside of the guest.
* No live-migration for most cases.

### File-system passthrough (virtio-fs)

File mount volumes (directories, actually) can be exposed to QEMU via
[virtio-fs][] so that VMs have access to files and directories.

![File-system passthrough (virtio-fs)][Storage-Virtiofs]

Devices and interfaces:

* PVC: file-system

Pros:

* Simplicity from the user-perspective
* Flexibility
* Great for heterogeneous workloads that share data between
  containers and VMs (ie. OpenShift pipelines)

Cons:

* Performance when compared to block device passthrough

Questions and comments:

* Feature is still quite new (The Windows driver is fresh out of the
  oven)

### QEMU storage daemon in CSI for local storage

The qemu-storage-daemon is a user-space daemon that exposes QEMU’s
block layer to external users. It’s similar to [SPDK][], but includes
the implementation of QEMU block layer features such as snapshots and
bitmap tracking for incremental backup (CBT). It also allows the
splitting of one single NVMe device, allowing multiple QEMU VMs to
share one NVMe disk.

In this architecture, the storage daemon runs as part of CSI (control
plane), with the data-plane being either a vhost-user-blk interface
for QEMU or a fs-mount export for containers.

![QEMU storage daemon in CSI for local storage][Storage-QSD]

Devices and interfaces:

* CSI:
  * fs mount with a vhost-user-blk socket for QEMU to open
  * (OR) fs mount via NBD or FUSE with the actual file-system
    contents
* qemu-storage-daemon backend: NVMe local device w/ raw or qcow2
  * alternative: any driver supported by QEMU, such as file-posix.
* QEMU frontend: virtio-blk
  * alternative: any emulated device (CDROM, virtio-scsi, etc)
  * In this case QEMU itself would be consuming vhost-user-blk and
    emulating the device for the guest

Pros:

* The NVMe driver from the storage daemon can support partitioning
  one NVMe device into multiple blk devices, each shared via a
  vhost-user-blk connection.
* Rich feature set, exposing features already implemented in the QEMU
  block layer to regular pods/containers:
  * Snapshots and thin-provisioning (qcow2)
  * Incremental Backup (CBT)
* Compatibility with use-cases from other projects (oVirt, OpenStack,
  etc)
  * Snapshots, thin-provisioning, CBT and block jobs via QEMU

Cons:

* Complexity due to cascading and splitting of components.
* Depends on the evolution of CSI APIs to provide the right
  use-cases.

Questions and comments:

* Local restrictions: QEMU and qemu-storage-daemon should be running
  on the same host (for vhost-user-blk shared memory to work).
* Need to cascade CSI providers for volume management (resize,
  creation, etc)
* How to share a partitioned NVMe device (from one storage daemon)
  with multiple pods?
* See also: [kubevirt/kubevirt#3208][] (similar idea for
  vhost-user-net).
* We could do hotplugging under the hood with the storage daemon.
  * To expose a new PV, a new qemu-storage-daemon pod can be created
    with a corresponding PVC. Conversely, on unplug, the pod can be
    deleted. Ideally, we might have a 1:1 relationship between PVs
    and storage daemon pods (though 1:n for attaching multiple guests
    to a single daemon).
  * This requires that we can create a new unix socket connection
    from new storage daemon pods to the VMs. The exact way to achieve
    this is still to be figured out. According to Adam Litke, the
    naive way would require elevated privileges for both pods.
  * After having the socket (either the file or a file descriptor)
    available in the VM pod, QEMU can connect to it.
* In order to avoid a mix of block devices having a PVC in the VM pod
  and others where we just passed the unix socket, we can completely
  avoid the PVC case for the VM pod:
  * For exposing a PV to QEMU, we would always go through the storage
    daemon (i.e. the PVC moves from the VM pod to the storage daemon
    pod), so the VM pod always only gets a unix socket connection,
    unifying the two cases.
  * Using vhost-user-blk from the storage daemon pod performs the
    same (or potentially better if this allows for polling that we
    wouldn’t have done otherwise) as having a PVC directly in the VM
    pod, so while it looks like an indirection, the actual I/O path
    would be comparable.
  * This architecture would also allow using the native
    Gluster/Ceph/NBD/… block drivers in the QEMU process without
    making them special (because they wouldn’t use a PVC either),
    unifying even more cases.
  * Kubernetes has fairly low per-node Pod limits by default so we
    may need to be careful about 1:1 Pod/PVC mapping.  We may want to
    support aggregation of multiple storage connections into a single
    q-s-d Pod.

## Other topics

### Device Mapper

Another possibility is to leverage the device-mapper from Linux to
provide features such as snapshots and even like Incremental Backup.
For example, [dm-era][] seems to provide the basic primitives for
bitmap tracking.

This could be part of scenario number 1, or cascaded with other PVs
somewhere else.

Is this already being used? For example, [cybozu-go/topolvm][] is a
CSI LVM Plugin for k8s.

### Stratis

[Stratis][] seems to be an interesting project to be leveraged in the
world of Kubernetes.

### vhost-user-blk in other CSI backends

Would it make sense for other CSI backends to implement support for
vhost-user-blk?

[CSI]: https://kubernetes.io/blog/2019/01/15/container-storage-interface-ga/
[KubeVirt]: https://kubevirt.io/
[PVC resize blog]: 
https://kubernetes.io/blog/2018/07/12/resizing-persistent-volumes-using-kubernetes/
[Persistent Volumes]: https://kubernetes.io/docs/concepts/storage/persistent-volumes/
[SPDK]: https://spdk.io/
[Storage-Current]: 
https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Storage-Current.png
[Storage-Passthrough]: 
https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Storage-Passthrough.png
[Storage-QSD]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Storage-QSD.png
[Storage-Virtiofs]: 
https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Storage-Virtiofs.png
[Stratis]: https://stratis-storage.github.io/
[cybozu-go/topolvm]: https://github.com/cybozu-go/topolvm
[dm-era]: https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/era.html
[kubevirt/kubevirt#3208]: https://github.com/kubevirt/kubevirt/pull/3208
[vhost_user_block]: 
https://github.com/cloud-hypervisor/cloud-hypervisor/tree/master/vhost_user_block
[virtio-fs]: https://virtio-fs.gitlab.io/


