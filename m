Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A804C31E5E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6818520B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6818520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGgQ-0005lm-Kj
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42962)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hdFQq-0002kr-F3
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hdFQm-0003RX-LK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:49:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hdFQm-0002eD-CR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:49:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CB33308338E;
 Tue, 18 Jun 2019 14:49:14 +0000 (UTC)
Received: from redhat.com (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0B81001DF3;
 Tue, 18 Jun 2019 14:49:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 18 Jun 2019 16:49:10 +0200
Message-ID: <87d0jb9cex.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 18 Jun 2019 14:49:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] KVM call minutes for 2019-06-18
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi

This are the random notes that I took about today community call.
Please review and add anything that you consider relevant.



Multiprocess qemu

Overview
- qemu (basically) runs as a single process
- emulates several devices
- the idea is to run the device emulations in a different process
- QMP/HMP/... still on main process
- rest of devices are going to be in external process
- idea is to reduce priviledge for each process
- questions?
  * how much work is going to be to integrate changes after this
  * most of the changes are new code with proxy objects
  * will not be changes to existing models
  * don't require all emulation run in remote process
  * device backends are run fully on the emulation process
  * leveraging virtio user model
  * expect DMA and IRQ like virtio user
* QEMU assumes that several things have global state
* migration/notifiers/...
* QEMU is able to DMA from one device to other device directly, with multiprocess is difficult
* How to get that global assumptions
* patches already quite big and only do one device so far
* Kevin is experimenthing with an external qemu-storage daemon
* qemu-storage daemon vs process for each image
  * compromise: less isolation but easier to do
* i.e. just doing the full subsystem instead of each device
* multiprocess:
  * devices shouldn't have to be changed, it is the same code that inside qemu
* TCG never claim any security
* qemu: command line and device interface and QMP
  good solotion for QMP, but for the rest
* libvirt/management app will launch the remote devices and just handle fd's to qemu
* When we launch qemu
  qemu needs to know the "proxied" devices through the command line
  move everything to QMP and don't even pass the command line
  spcially don't pass the commandline from qemu to processes
* Any quesntion about how the bus/device are presented?
* why don't use only nemu + virtio?
  nemu and virtio don't handle legacy devices
* cpu usage from multiprocess?
  how much cpu fro the same amount of IOPs:  current implementation use around 9-10% more cpu cycles
  but there are optimizations that could reduce it further
* multiprocess mmio
  create a kernel fd for each multiprocess and decide at device creation time if that range is
  going to be handled by the main qemu or another process.  Something like vhost-user.
  This is an optimizaton, not implemented yet.
* Why do they need legacy?
  Because they are not anly bringing new VM's, also legacy VM's (specially windows).
* Is worth this for legacy?
  Or just enable it for new/modern guests.
* How invasive is this?
  it is important to decide how much security/isolation it brings vs the amount of invasive things
  How much do we gain from using seccomp + unpriviledged qemu + ....
* Discussion about if it makes sense the change
  Does it bring enough new isolation to qemu

Thanks, Juan.

