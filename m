Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D48C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E31320874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEwq9Mp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E31320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNq2-0007cg-Ft
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKNoR-0006su-KO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:33:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21561
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKNoL-0005pl-92
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600702379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ppMqlyz29WQ+6okIWu2qVq1vAw0JRtCNW4i0J0v/ANw=;
 b=AEwq9Mp5nTciB4Uim7JIi8W8kqsZRwdAYAKI7h6wPUT/JSXhicbC70K2Kei99Ufrcmo+2u
 HJbeK/ISarweT+EKkeh90zrJttovnfTNOZyUMjvuk/bF7HWZ7rsyew7wU9Fz++nMmKNZwF
 3guZC+Xo2uXoyb73RBgyir2zzoB6iII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-RGukSrMvN1KslNYISg7Mvw-1; Mon, 21 Sep 2020 11:32:55 -0400
X-MC-Unique: RGukSrMvN1KslNYISg7Mvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76B16186DD3C;
 Mon, 21 Sep 2020 15:32:54 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 920EB78823;
 Mon, 21 Sep 2020 15:32:46 +0000 (UTC)
Date: Mon, 21 Sep 2020 16:32:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200921153243.GK3221@work-vm>
References: <20200918213436.GA3520@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918213436.GA3520@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 07:01:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: jose.carlos.venegas.munoz@intel.com, qemu-devel@nongnu.org,
 cdupontd@redhat.com, virtio-fs-list <virtio-fs@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, archana.m.shinde@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
  I've been doing some of my own perf tests and I think I agree
about the thread pool size;  my test is a kernel build
and I've tried a bunch of different options.

My config:
  Host: 16 core AMD EPYC (32 thread), 128G RAM,
     5.9.0-rc4 kernel, rhel 8.2ish userspace.
  5.1.0 qemu/virtiofsd built from git.
  Guest: Fedora 32 from cloud image with just enough extra installed for
a kernel build.

  git cloned and checkout v5.8 of Linux into /dev/shm/linux on the host
fresh before each test.  Then log into the guest, make defconfig,
time make -j 16 bzImage,  make clean; time make -j 16 bzImage 
The numbers below are the 'real' time in the guest from the initial make
(the subsequent makes dont vary much)

Below are the detauls of what each of these means, but here are the
numbers first

virtiofsdefault        4m0.978s
9pdefault              9m41.660s
virtiofscache=none    10m29.700s
9pmmappass             9m30.047s
9pmbigmsize           12m4.208s
9pmsecnone             9m21.363s
virtiofscache=noneT1   7m17.494s
virtiofsdefaultT1      3m43.326s

So the winner there by far is the 'virtiofsdefaultT1' - that's
the default virtiofs settings, but with --thread-pool-size=1 - so
yes it gives a small benefit.
But interestingly the cache=none virtiofs performance is pretty bad,
but thread-pool-size=1 on that makes a BIG improvement.


virtiofsdefault:
  ./virtiofsd --socket-path=/tmp/vhostqemu -o source=/dev/shm/linux
  ./x86_64-softmmu/qemu-system-x86_64 -M pc,memory-backend=mem,accel=kvm -smp 8 -cpu host -m 32G,maxmem=64G,slots=1 -object memory-backend-memfd,id=mem,size=32G,share=on -drive if=virtio,file=/home/images/f-32-kernel.qcow2 -nographic -chardev socket,id=char0,path=/tmp/vhostqemu -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=kernel
  mount -t virtiofs kernel /mnt

9pdefault
  ./x86_64-softmmu/qemu-system-x86_64 -M pc,accel=kvm -smp 8 -cpu host -m 32G -drive if=virtio,file=/home/images/f-32-kernel.qcow2 -nographic -virtfs local,path=/dev/shm/linux,mount_tag=kernel,security_model=passthrough
  mount -t 9p -o trans=virtio kernel /mnt -oversion=9p2000.L

virtiofscache=none
  ./virtiofsd --socket-path=/tmp/vhostqemu -o source=/dev/shm/linux -o cache=none
  ./x86_64-softmmu/qemu-system-x86_64 -M pc,memory-backend=mem,accel=kvm -smp 8 -cpu host -m 32G,maxmem=64G,slots=1 -object memory-backend-memfd,id=mem,size=32G,share=on -drive if=virtio,file=/home/images/f-32-kernel.qcow2 -nographic -chardev socket,id=char0,path=/tmp/vhostqemu -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=kernel
  mount -t virtiofs kernel /mnt

9pmmappass
  ./x86_64-softmmu/qemu-system-x86_64 -M pc,accel=kvm -smp 8 -cpu host -m 32G -drive if=virtio,file=/home/images/f-32-kernel.qcow2 -nographic -virtfs local,path=/dev/shm/linux,mount_tag=kernel,security_model=passthrough
  mount -t 9p -o trans=virtio kernel /mnt -oversion=9p2000.L,cache=mmap

9pmbigmsize
   ./x86_64-softmmu/qemu-system-x86_64 -M pc,accel=kvm -smp 8 -cpu host -m 32G -drive if=virtio,file=/home/images/f-32-kernel.qcow2 -nographic -virtfs local,path=/dev/shm/linux,mount_tag=kernel,security_model=passthrough
   mount -t 9p -o trans=virtio kernel /mnt -oversion=9p2000.L,cache=mmap,msize=1048576

9pmsecnone
   ./x86_64-softmmu/qemu-system-x86_64 -M pc,accel=kvm -smp 8 -cpu host -m 32G -drive if=virtio,file=/home/images/f-32-kernel.qcow2 -nographic -virtfs local,path=/dev/shm/linux,mount_tag=kernel,security_model=none
   mount -t 9p -o trans=virtio kernel /mnt -oversion=9p2000.L

virtiofscache=noneT1
   ./virtiofsd --socket-path=/tmp/vhostqemu -o source=/dev/shm/linux -o cache=none --thread-pool-size=1
   mount -t virtiofs kernel /mnt

virtiofsdefaultT1
   ./virtiofsd --socket-path=/tmp/vhostqemu -o source=/dev/shm/linux --thread-pool-size=1
    ./x86_64-softmmu/qemu-system-x86_64 -M pc,memory-backend=mem,accel=kvm -smp 8 -cpu host -m 32G,maxmem=64G,slots=1 -object memory-backend-memfd,id=mem,size=32G,share=on -drive if=virtio,file=/home/images/f-32-kernel.qcow2 -nographic -chardev socket,id=char0,path=/tmp/vhostqemu -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=kernel
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


