Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEF5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52D020663
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52D020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtD4u-0002xB-VN
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lma@suse.de>) id 1jtBIs-0001og-IG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 10:44:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:33104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lma@suse.de>) id 1jtBIq-0004WY-Gz
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 10:44:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8CDA9AC40;
 Wed,  8 Jul 2020 14:44:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Jul 2020 14:44:01 +0000
From: lma <lma@suse.de>
To: qemu-devel@nongnu.org
Subject: Questions about online resizing a lun passthrough disk with
 virtio-scsi
User-Agent: Roundcube Webmail
Message-ID: <af3e33e4a5bb15d9f0b30c8de4941a37@suse.de>
X-Sender: lma@suse.de
Received-SPF: pass client-ip=195.135.220.15; envelope-from=lma@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:20:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Jul 2020 12:35:46 -0400
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

I have questions about online resizing a scsi lun passthrough disk.
Here is my test scenario:
host A:
- the local 50GB sata /dev/sdd1 is configured as a physical volume,
   Created a 10GB logical volume.
- exported the lv by iscsi target by targetcli.

host B:
- connected to the above iscsi target to obtain a 'local' scsi disk,
   say the /dev/sdb.
- scsi lun passed through this /dev/sdb to a qemu-kvm linux guest.

hostA:~ # lvresize -L +5G /dev/vg0/lv0
hostB:~ # rescan-scsi-bus.sh -s //this script is in sg3_utils, '-s'
look for resized disks.
hostB:~ # block_resize via qmp to notify qemu self and guest os.
guest:~ # rescan-scsi-bus.sh -s
guest:~ # use the extended disk space.

My questions are:
Is the 'block_resize' mandatory to notify guest os after online resizing
a lun passed through disk? I'm curious it because I found there're 
couple
of ways can make guest os realize the disk capacity change.
e.g:
* run 'block_resize' via qmp to let virtio-scsi notify the frontend 
about
   capacity change.
* run 'rescan-scsi-bus.sh -s' inside guest.
* run 'sg_readcap --16 /dev/sda' inside guest.

I knew that the purpose of 'block_resize' is not only to notify guest 
os,
but also to update some internal structure's member, say 
bs->total_sectors.
What if I forgot to run 'block_resize', but run 'rescan-scsi-bus.sh -s' 
in guest?
In this case, Although the qemu's bs->total_sectors value isn't updated 
due
to missing 'block_resize', The guest os is still able to see the 
capacity
change, I'm curious is there any potential risks while using the 
extended
disk space in guest?

What is the best practice for online resizing a lun passed through disk?
Are all of below steps mandatory? OR may I omit either step 3 of 4?
1. online resize on storage side.
2. scsi rescan to realize the capacity change on hypervisor side.
3. block_resize via qmp.
4. scsi rescan to realize the capacity change in guest.
5. use the extended disk space in guest.

Many thanks,
Lin

