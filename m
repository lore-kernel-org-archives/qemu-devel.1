Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6094AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340792065D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340792065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLAA-0004I5-Gj
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lma@suse.de>) id 1jvL9C-00036j-T4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:39:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lma@suse.de>) id 1jvL9A-0000x0-Eo
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:39:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7FAF7B13B;
 Tue, 14 Jul 2020 13:39:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jul 2020 13:38:58 +0000
From: Lin Ma <lma@suse.de>
To: qemu-devel@nongnu.org
Subject: Re: The issue about adding multipath device's targets into
 qemu-pr-helper's namespace
In-Reply-To: <a5a06a77fea035344943bdc930a344cd@suse.de>
References: <a5a06a77fea035344943bdc930a344cd@suse.de>
User-Agent: Roundcube Webmail
Message-ID: <c63b4427ee9058e47eb2f0445677f5ff@suse.de>
X-Sender: lma@suse.de
Received-SPF: pass client-ip=195.135.220.15; envelope-from=lma@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:34:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-07-14 13:30, Lin Ma wrote:
> Hi all,
> 
> I have a namespace question about passthrough disk(multipath device).
> In case of enabling namespace and cgroups in qemu.conf, The target(s) 
> of the
> multipath device won't be added into qemu-pr-helper's namespace under 
> certain
> situation, It causes the PERSISTENT RESERVE command failure in guest.
> 
> While user starts a vm,
> To build namespace, The qemuDomainSetupDisk() will be invoked via 
> threadA(this
> thread id will be the qemu's pid),
> To build cgroup, The qemuSetupImagePathCgroup() will be invoked via 
> threadB.
> 
> Both of the functions invoke the virDevMapperGetTargets() trying to 
> parse a
> multipath device to target paths string, Then fill the targetPaths[].
> 
> The issue I experienced is:
> After libvirtd started, Everything works well for the first booted vm 
> which has
> the passthrough multipath device.
> But If I shut it down & start it again, OR keep it running & start 
> another vm
> which has other passthrough multipath device, Then the target(s) of the 
> fresh
> started vm won't be added into the related qemu-pr-helper's namespace 
> and it
> causes PERSISTENT RESERVE command failure in the corresponding guest.
> I digged into code, In this situation, The targetPaths[] in
> qemuDomainSetupDisk()
> won't be filled, it keeps NULL after virDevMapperGetTargets() returns.
> The virDevMapperGetTargets doesn't fill targetPaths[] because the 
> dm_task_run()
> of libdevmapper returns 0 with errno 9(Bad file descriptor).
> So far, I don't understand why the dm_task_run() return 0 in this 
> situation.
> BTW, The virDevMapperGetTargets() can always successfully fill the 
> targetPaths[]
> in qemuSetupImagePathCgroup().
> 
> Please refer to the following 2 tests:
> The multipath configuration on host:
> host:~ # multipath -l
> vm1-data (3600140582d9024bc13f4b8db5ff12de0) dm-11 FreeNAS,lv68
> size=6.0G features='0' hwhandler='1 alua' wp=rw
> `-+- policy='service-time 0' prio=0 status=active
>   `- 2:0:0:2 sdd 8:48 active undef running
> vm2-data (36001405fc5f29ace3ec4fb8acd32aae5) dm-8 FreeNAS,lv46
> size=4.0G features='0' hwhandler='1 alua' wp=rw
> `-+- policy='service-time 0' prio=0 status=active
>   `- 2:0:0:1 sde 8:64 active undef running
> 
> ===================================================================
> Test A:
> host:~ # systemctl restart libvirtd
> host:~ # virsh list
>  Id   Name   State
> --------------------
> 
> host:~ #
> host:~ # virsh domblklist vm1
>  Target   Source
> ------------------------------------------
>  vda      /opt/vms/vm1/disk0.qcow2
>  sda      /dev/mapper/vm1-data
> 
> host:~ #
> host:~ # virsh start vm1
> Domain vm1 started
> 
> host:~ # virsh list
>  Id   Name        State
> ---------------------------
>  1    vm1        running
> 
> host:~ # nsenter -t $(pidof qemu-pr-helper) -a bash
> host:~ # ls -l /dev/sd*
> brw-rw---- 1 root disk 8, 48 Jul 14 16:30 /dev/sdd
> host:~ # exit
> exit
> host:~ #
> 
> vm1:~ # lsscsi
> [0:0:0:0]    disk    FreeNAS  lv68             0123   /dev/sda
> vm1:~ #
> vm1:~ # sg_persist --in -k /dev/sda
>   FreeNAS   lv68              0123
>   Peripheral device type: disk
>   PR generation=0x0, there are NO registered reservation keys
> vm1:~ #
> 
> host:~ # virsh shutdown vm1
> Domain vm1 is being shutdown
> 
> host:~ # virsh list
>  Id   Name   State
> --------------------
> 
> host:~ #
> host:~ # virsh start vm1
> Domain vm1 started
> 
> host:~ # virsh list
>  Id   Name        State
> ---------------------------
>  2    vm1        running
> 
> host:~ # nsenter -t $(pidof qemu-pr-helper) -a bash
> host:~ # ls -l /dev/sd*
> ls: cannot access '/dev/sd*': No such file or directory
> host:~ # exit
> exit
> host:~ #
> 
> vm1:~ # sg_persist --in -k /dev/sda
>   FreeNAS   lv68              0123
>   Peripheral device type: disk
> PR in (Read keys): Aborted command
> Aborted command
> vm1:~ #
> ===================================================================
> Test B:
> host:~ # systemctl restart libvirtd
> host:~ # virsh list
>  Id   Name   State
> --------------------
> 
> host:~ #
> host:~ # virsh domblklist vm1
>  Target   Source
> ------------------------------------------
>  vda      /opt/vms/vm1/disk0.qcow2
>  sda      /dev/mapper/vm1-data
> 
> host:~ #
> host:~ # virsh start vm1
> Domain vm1 started
> 
> host:~ # virsh list
>  Id   Name        State
> ---------------------------
>  1    vm1        running
> 
> host:~ # nsenter -t $(pidof qemu-pr-helper) -a bash
> host:~ # ls -l /dev/sd*
> brw-rw---- 1 root disk 8, 48 Jul 14 17:28 /dev/sdd
> host:~ # exit
> exit
> host:~ #
> 
> vm1:~ # lsscsi
> [2:0:0:0]    disk    FreeNAS  lv68             0123   /dev/sda
> vm1:~ #
> vm1:~ # sg_persist --in -k /dev/sda
>   FreeNAS   lv68              0123
>   Peripheral device type: disk
>   PR generation=0x0, there are NO registered reservation keys
> vm1:~ #
> 
> host:~ # virsh list
>  Id   Name        State
> ---------------------------
>  1    vm1        running
> 
> host:~ #
> host:~ # virsh domblklist vm2
>  Target   Source
> ------------------------------------------
>  vda      /opt/vms/vm2/disk0.qcow2
>  sda      /dev/mapper/vm2-data
> 
> host:~ #
> host:~ # virsh start vm2
> Domain vm2 started
> 
> host:~ # virsh list
>  Id   Name        State
> ---------------------------
>  1    vm1        running
>  2    vm2        running
> 
> host:~ # nsenter -t $(qemu-pr-helper pid of vm2) -a bash
> host:~ # ls -l /dev/sd*
> ls: cannot access '/dev/sd*': No such file or directory
> host:~ # exit
> exit
> host:~ #
> 
> vm2:~ # lsscsi
> [0:0:0:0]    disk    FreeNAS  lv46             0123   /dev/sda
> vm2:~ #
> vm2:~ # sg_persist --in -k /dev/sda
>   FreeNAS   lv46              0123
>   Peripheral device type: disk
> PR in (Read keys): Aborted command
> Aborted command
> vm2:~ #
> ===================================================================
> 
> Any comments will be much appreciated.
> 
> Thanks in advance,
> Lin

Oops, It shouldn't be sent to qemu ml, It should be sent to libvirt ml, 
Sorry about it.

Lin


