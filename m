Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC03C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A42620678
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ti534zJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A42620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35649 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJhsB-00033k-6S
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 14:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJhrU-0002XD-En
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJhrT-0006Yc-2V
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:13:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39670
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJhrS-0006Xl-Qz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585764790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2tKUk/QhuCp0Q9srCMMtASQj3rNhJof02EQrAhiE6c=;
 b=Ti534zJ5Rzwv58DRKJKEdFw2/keC/rFqMJRU4DuZBioR7yzmXVLSWEaV/pd78XmmNMVCTO
 /nj72C46EYv0ZMwf58BeAMMbaGkWqano9u4iUZmqIHJOqaXL/SNo0iH18Gml3CuHUMsPUd
 /O4mkwkTwlDXVAfftIU3Vm5ArIcqBMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-Go_lJlikNHu0d0WJt6fgOw-1; Wed, 01 Apr 2020 14:13:06 -0400
X-MC-Unique: Go_lJlikNHu0d0WJt6fgOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 166398017F3;
 Wed,  1 Apr 2020 18:13:05 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-172.ams2.redhat.com [10.36.114.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BBC160C05;
 Wed,  1 Apr 2020 18:12:57 +0000 (UTC)
Date: Wed, 1 Apr 2020 20:12:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200401181256.GB27663@linux.fritz.box>
References: <658260883.24.1585644382441@webmail.proxmox.com>
 <20200331125804.GE7030@linux.fritz.box>
 <303038276.59.1585665152860@webmail.proxmox.com>
 <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
 <713436887.61.1585668262838@webmail.proxmox.com>
 <20200331153719.GI7030@linux.fritz.box>
 <518198448.62.1585671498399@webmail.proxmox.com>
 <20200401103748.GA4680@linux.fritz.box>
 <997901084.0.1585755465486@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <997901084.0.1585755465486@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.04.2020 um 17:37 hat Dietmar Maurer geschrieben:
> > > I really nobody else able to reproduce this (somebody already tried t=
o reproduce)?
> >=20
> > I can get hangs, but that's for job_completed(), not for starting the
> > job. Also, my hangs have a non-empty bs->tracked_requests, so it looks
> > like a different case to me.
>=20
> Please can you post the command line args of your VM? I use something lik=
e
>=20
> ./x86_64-softmmu/qemu-system-x86_64 -chardev
> 'socket,id=3Dqmp,path=3D/var/run/qemu-server/101.qmp,server,nowait' -mon
> 'chardev=3Dqmp,mode=3Dcontrol' -pidfile /var/run/qemu-server/101.pid  -m
> 1024 -object 'iothread,id=3Diothread-virtioscsi0' -device
> 'virtio-scsi-pci,id=3Dvirtioscsi0,iothread=3Diothread-virtioscsi0' -drive
> 'file=3D/backup/disk3/debian-buster.raw,if=3Dnone,id=3Ddrive-scsi0,format=
=3Draw,cache=3Dnone,aio=3Dnative,detect-zeroes=3Don'
> -device
> 'scsi-hd,bus=3Dvirtioscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddriv=
e-scsi0,id=3Dscsi0'
> -machine "type=3Dpc,accel=3Dkvm"
>=20
> Do you also run "stress-ng -d 5" indied the VM?

I'm not using the exact same test case, but something that I thought
would be similar enough. Specifically, I run the script below, which
boots from a RHEL 8 CD and in the rescue shell, I'll do 'dd if=3D/dev/zero
of=3D/dev/sda' while the script keeps starting and cancelling backup jobs
in the background.

Anyway, I finally managed to bisect my problem now (did it wrong the
first time) and got this result:

00e30f05de1d19586345ec373970ef4c192c6270 is the first bad commit
commit 00e30f05de1d19586345ec373970ef4c192c6270
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:   Tue Oct 1 16:14:09 2019 +0300

    block/backup: use backup-top instead of write notifiers

    Drop write notifiers and use filter node instead.

    =3D Changes =3D

    1. Add filter-node-name argument for backup qmp api. We have to do it
    in this commit, as 257 needs to be fixed.

    2. There are no more write notifiers here, so is_write_notifier
    parameter is dropped from block-copy paths.

    3. To sync with in-flight requests at job finish we now have drained
    removing of the filter, we don't need rw-lock.

    4. Block-copy is now using BdrvChildren instead of BlockBackends

    5. As backup-top owns these children, we also move block-copy state
    into backup-top's ownership.

    [...]


That's a pretty big change, and I'm not sure how it's related to
completed requests hanging in the thread pool instead of reentering the
file-posix coroutine. But I also tested it enough that I'm confident
it's really the first bad commit.

Maybe you want to try if your problem starts at the same commit?

Kevin


#!/bin/bash

qmp() {
cat <<EOF
{'execute':'qmp_capabilities'}
EOF

while true; do
cat <<EOF
{ "execute": "drive-backup", "arguments": {
  "job-id":"drive_image1","device": "drive_image1", "sync": "full", "target=
": "/tmp/backup.raw" } }
EOF
sleep 1
cat <<EOF
{ "execute": "block-job-cancel", "arguments": { "device": "drive_image1"} }
EOF
sleep 2
done
}

./qemu-img create -f qcow2 /tmp/test.qcow2 4G
for i in $(seq 0 1); do echo "write ${i}G 1G"; done | ./qemu-io /tmp/test.q=
cow2

qmp | x86_64-softmmu/qemu-system-x86_64 \
    -enable-kvm \
    -machine pc \
    -m 1G \
    -object 'iothread,id=3Diothread-virtioscsi0' \
    -device 'virtio-scsi-pci,id=3Dvirtioscsi0,iothread=3Diothread-virtioscs=
i0' \
    -blockdev node-name=3Dmy_drive,driver=3Dfile,filename=3D/tmp/test.qcow2=
 \
    -blockdev driver=3Dqcow2,node-name=3Ddrive_image1,file=3Dmy_drive \
    -device scsi-hd,drive=3Ddrive_image1,id=3Dimage1 \
    -cdrom ~/images/iso/RHEL-8.0-20190116.1-x86_64-dvd1.iso \
    -boot d \
    -qmp stdio -monitor vc


