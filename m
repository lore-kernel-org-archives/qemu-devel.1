Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC5C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BDB24182
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhpQ83q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BDB24182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLCE-000798-V5
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 16:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAt-0005TT-DF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAh-0006ea-JH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603313840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IZHcolpJh9GUkCtn3jobejedGZlFkRyLFKL54dVNaLU=;
 b=EhpQ83q/6l/EqezDC0P0+DUtt6U8ocgN31lIQvDMFxBDIG2Og29CTyIQ6SJuUqrvFlvxpu
 ZLt9iNReKQcprjd/lgbxNakJsfOKmjyBliJAg61pTc1AGJ28wlqpt/6eEn2vFDKqDt2VRB
 mQEaVAM1SRb75zbguxzxjxSzx1phP9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-HdUbXz9uPeeaZaCTaRgoRg-1; Wed, 21 Oct 2020 16:57:19 -0400
X-MC-Unique: HdUbXz9uPeeaZaCTaRgoRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 182E01006C94
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:57:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CFBF6EF62;
 Wed, 21 Oct 2020 20:57:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/22] cleanup qemu_init and make sense of command line
 processing
Date: Wed, 21 Oct 2020 16:56:54 -0400
Message-Id: <20201021205716.2359430-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: jsnow@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series cleans up qemu_init, grouping together code that does
a similar function.  In particular:

* generic initialization of various subsystemd is placed in separate
functions

* code that was randomly placed in vl.c is moved to machine.c

* early options that affect the whole program are grouped
together (-sandbox, -name, -trace, -L)

* pure syntactic sugar options (-mem-prealloc, -watchdog)
are grouped together

* the creation of backends is split into an "early" (before -machine)
and a "late" (after -machine) part


The remaining code that I have not split deals mostly with setting
up the machine object; this includes -smp, -boot, -m, -numa.  With
this refactoring, one can (almost) see some clearly delimited phases:

* before the machine is created, only backends can be created
(e.g. early -object processing).  In principle more initialization
could be moved before the machine is created: the machine class is
available and it can be used to decide which default devices to create.

* after the machine is created, the accelerator needs to be established

* after the accelerator is established, board setup can
proceed and devices can be created


Apart from the obvious absence of commands like machine-set and accel-set
(and making chardev-add, blockdev-add etc. available in preconfig mode),
the following complications are the blockers for pure-QMP configuration
of machines:

* as usual, there is no hook into board creation code to communicate
the backends for on-board devices.  This is because serial_hd,
nd_table etc. don't have a QAPI/QMP representation.

* the current "preconfig" loop does not let you configure enough, since it
ends before devices can be created and the regular monitor loop only
starts after qdev_machine_creation_done.  Perhaps x-exit-preconfig would
execute everything up to (and excluding) qdev_machine_creation_done,
while the rest would be deferred to the first "cont" command using a vm
state change notifier.

Paolo

Paolo Bonzini (22):
  semihosting: fix order of initialization functions
  machine: remove deprecated -machine enforce-config-section option
  machine: move UP defaults to class_base_init
  machine: move SMP initialization from vl.c
  vl: extract validation of -smp to machine.c
  vl: remove bogus check
  trace: remove argument from trace_init_file
  vl: split various early command line options to a separate function
  vl: move various initialization routines out of qemu_init
  vl: extract qemu_init_subsystems
  vl: move prelaunch part of qemu_init to a new function
  vl: move bios_name out of softmmu/vl.c
  vl: extract various command line validation snippets to a new function
  vl: preconfig and loadvm are mutually exclusive
  vl: extract various command line desugaring snippets to a new function
  vl: create "-net nic -net user" default earlier
  vl: load plugins as late as possible
  vl: move semihosting command line fallback to qemu_finish_machine_init
  vl: extract default devices to separate functions
  vl: move CHECKPOINT_INIT after preconfig
  vl: separate qemu_create_early_backends
  vl: separate qemu_create_late_backends

 bsd-user/main.c                      |    6 +-
 docs/system/deprecated.rst           |   12 +-
 hw/core/machine.c                    |   68 +-
 include/hw/boards.h                  |    2 +-
 include/hw/qdev-core.h               |    8 -
 include/sysemu/sysemu.h              |    1 +
 linux-user/main.c                    |    6 +-
 migration/migration.c                |   12 +-
 qemu-img.c                           |    6 +-
 qemu-io.c                            |    6 +-
 qemu-nbd.c                           |    6 +-
 qemu-options.hx                      |    8 -
 scsi/qemu-pr-helper.c                |    6 +-
 softmmu/qdev-monitor.c               |    6 -
 softmmu/vl.c                         | 1249 +++++++++++++-------------
 storage-daemon/qemu-storage-daemon.c |    9 +-
 trace/control.c                      |   10 +-
 trace/control.h                      |   12 +-
 18 files changed, 704 insertions(+), 729 deletions(-)

-- 
2.26.2


