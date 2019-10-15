Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CF0ECE58E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 09:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04272064B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 09:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04272064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKJ1P-00085Y-QK
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 05:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iKJ0l-0007W2-N5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iKJ0k-0000sk-6a
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:20:59 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:50063)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iKJ0j-0000qU-Uh
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:20:58 -0400
Received: from player698.ha.ovh.net (unknown [10.109.146.168])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 202296C058
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 11:20:48 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 26D5DAF72600;
 Tue, 15 Oct 2019 09:20:43 +0000 (UTC)
Date: Tue, 15 Oct 2019 11:20:39 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
Message-ID: <20191015112039.620997e3@bahia.lan>
In-Reply-To: <2456208.kOTvEbKLdM@silver>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <1590425.yRI6RxI3rl@silver> <20191008111459.048e659f@bahia.lan>
 <2456208.kOTvEbKLdM@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10335761147260934464
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeefgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.50.107
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 08 Oct 2019 14:05:28 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> 
> I wonder though whether virtio-fs suffers from the same file ID collisions 
> problem when sharing multiple file systems.
> 

I gave a try and it seems that virtio-fs might expose the inode numbers from
different devices in the host, unvirtualized AND with the same device in the
guest:

# mkdir -p /var/tmp/virtio-fs/proc
# mount --bind /proc /var/tmp/virtio-fs/proc
# virtiofsd -o vhost_user_socket=/tmp/vhostqemu -o source=/var/tmp/virtio-fs -o cache=always

and then started QEMU with:

-chardev socket,id=char0,path=/tmp/vhostqemu \
-device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=myfs \
-m 4G -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
-numa node,memdev=mem

In the host:

$ stat /var/tmp/virtio-fs
  File: /var/tmp/virtio-fs
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: fd00h/64768d    Inode: 787796      Links: 4
Access: (0775/drwxrwxr-x)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
Context: unconfined_u:object_r:user_tmp_t:s0
Access: 2019-10-15 11:08:52.070080922 +0200
Modify: 2019-10-15 11:02:09.887404446 +0200
Change: 2019-10-15 11:02:09.887404446 +0200
 Birth: 2019-10-13 19:13:04.009699354 +0200
[greg@bahia ~]$ stat /var/tmp/virtio-fs/FOO
  File: /var/tmp/virtio-fs/FOO
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: fd00h/64768d    Inode: 790740      Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
Context: unconfined_u:object_r:user_tmp_t:s0
Access: 2019-10-15 11:02:09.888404448 +0200
Modify: 2019-10-15 11:02:09.888404448 +0200
Change: 2019-10-15 11:02:09.888404448 +0200
 Birth: 2019-10-15 11:02:09.887404446 +0200
[greg@bahia ~]$ stat /var/tmp/virtio-fs/proc/fs
  File: /var/tmp/virtio-fs/proc/fs
  Size: 0               Blocks: 0          IO Block: 1024   directory
Device: 4h/4d   Inode: 4026531845  Links: 5
Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:proc_t:s0
Access: 2019-10-01 14:50:09.223233901 +0200
Modify: 2019-10-01 14:50:09.223233901 +0200
Change: 2019-10-01 14:50:09.223233901 +0200
 Birth: -

In the guest:

[greg@localhost ~]$ stat /mnt
  File: /mnt
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 2dh/45d Inode: 787796      Links: 4
Access: (0775/drwxrwxr-x)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
Context: system_u:object_r:unlabeled_t:s0
Access: 2019-10-15 11:08:52.070080922 +0200
Modify: 2019-10-15 11:02:09.887404446 +0200
Change: 2019-10-15 11:02:09.887404446 +0200
 Birth: -
[greg@localhost ~]$ stat /mnt/FOO
  File: /mnt/FOO
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 2dh/45d Inode: 790740      Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
Context: system_u:object_r:unlabeled_t:s0
Access: 2019-10-15 11:02:09.888404448 +0200
Modify: 2019-10-15 11:02:09.888404448 +0200
Change: 2019-10-15 11:02:09.888404448 +0200
 Birth: -
[greg@localhost ~]$ stat /mnt/proc/fs
  File: /mnt/proc/fs
  Size: 0               Blocks: 0          IO Block: 1024   directory
Device: 2dh/45d Inode: 4026531845  Links: 5
Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:unlabeled_t:s0
Access: 2019-10-01 14:50:09.223233901 +0200
Modify: 2019-10-01 14:50:09.223233901 +0200
Change: 2019-10-01 14:50:09.223233901 +0200
 Birth: -

Unless I'm missing something, it seems that "virtio-fs" has the same
issue we had on 9pfs before Christian's patches... :-\

--
Greg

