Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A129C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D81A20848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="wtYM5bw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D81A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCGo-000564-AC
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kNCFk-00046w-QZ; Tue, 29 Sep 2020 05:48:57 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:54370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kNCFg-0007jq-0e; Tue, 29 Sep 2020 05:48:55 -0400
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 03D922E182B;
 Tue, 29 Sep 2020 12:48:41 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 vjhjzQjrRW-mew05FSc; Tue, 29 Sep 2020 12:48:40 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1601372920; bh=Lns98uKhHAlRMhbR+H0QtruPlIAVQxl/oZtiQ/pNS1M=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=wtYM5bw6hP06O//Y+dvrWfBsJkvkLk4RlvQqJIDoUnRMNy0QBs1PZc2MO/cB9O+Xx
 /n8oGjY8P/aHOVF8lBufQEf9xJNMUjYEZd/L2LWme15SEzvrg21JnztqQ53lH1PD1k
 +d/Y3LQfUTVbOwEHaqnB3zybAd+DfSPvH+iiTFl4=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:303::1:c])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 v2OBNEwTka-memmTJ1A; Tue, 29 Sep 2020 12:48:40 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Tue, 29 Sep 2020 12:48:38 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 0/7] vhost-user-blk: fix the migration issue and
 enhance qtests
Message-ID: <20200929094830.GA32457@dimastep-nix>
References: <cover.1599813294.git.dimastep@yandex-team.ru>
 <20200924072506-mutt-send-email-mst@kernel.org>
 <20200927064822.GA3761@dimastep-nix>
 <20200929031212-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929031212-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 thuth@redhat.com, qemu-block@nongnu.org, lvivier@redhat.com,
 stefanha@gmail.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, raphael.norwitz@nutanix.com, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 03:13:09AM -0400, Michael S. Tsirkin wrote:
> On Sun, Sep 27, 2020 at 09:48:28AM +0300, Dima Stepanov wrote:
> > On Thu, Sep 24, 2020 at 07:26:14AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Sep 11, 2020 at 11:39:42AM +0300, Dima Stepanov wrote:
> > > > v4 -> v5:
> > > >   - vhost: check queue state in the vhost_dev_set_log routine
> > > >     tests/qtest/vhost-user-test: prepare the tests for adding new
> > > >     dev class
> > > >     tests/qtest/vhost-user-test: add support for the
> > > >     vhost-user-blk device
> > > >     tests/qtest/vhost-user-test: add migrate_reconnect test
> > > >     Reviewed-by: Raphael Norwitz
> > > >   - Update qtest, by merging vhost-user-blk "if" case with the
> > > >     virtio-blk case.
> > > 
> > > I dropped patches 3-7 since they were stalling on some systems.
> > > Pls work with Peter Maydell (cc'd) to figure it out.
> > Thanks!
> > 
> > Peter, can you share any details for the stalling errors with me?
> 
> I can say for sure that even on x86/linux the affected tests take
> much longer to run with these applied.
> I'd suggest making sure there are no timeouts involved in the good case ....
Could you help me to reproduce it? Because on my system i see only 10+ seconds
increase for the qos-test set to pass (both x86_64 and i386). So on the
current master i'm running it like:
  - ./configure  --target-list="x86_64-softmmu i386-softmmu"
  - with no patch set:
    time QTEST_QEMU_BINARY=./build/x86_64-softmmu/qemu-system-x86_64 ./build/tests/qtest/qos-test
    real    0m6.394s
    user    0m3.643s
    sys     0m3.477s
  - without patch 7 (where i include vhost-user-net tests also):
    real    0m9.955s
    user    0m4.133s
    sys     0m4.397s
  - full patch set:
    real    0m17.263s
    user    0m4.530s
    sys     0m4.802s
For i386 target i see pretty the same numbers:
  time QTEST_QEMU_BINARY=./build/i386-softmmu/qemu-system-i386 ./build/tests/qtest/qos-test
  real    0m17.386s
  user    0m4.503s
  sys     0m4.911s
So it looks like that i'm missing some step to reproduce an issue.

And if i run the exact test it takes ~2-3s to pass:
  $ time QTEST_QEMU_BINARY=./build/x86_64-softmmu/qemu-system-x86_64 ./build/tests/qtest/qos-test -p /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/vhost-user-blk-pci/vhost-user-blk/vhost-user-blk-tests/reconnect
  /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/vhost-user-blk-pci/vhost-user-blk/vhost-user-blk-tests/reconnect: OK
  real    0m2.253s
  user    0m0.118s
  sys     0m0.104s
And same numbers for i386.

> 
> > > 
> > > 
> > > > v3 -> v4:
> > > >   - vhost: recheck dev state in the vhost_migration_log routine
> > > >     Reviewed-by: Raphael Norwitz
> > > >   - vhost: check queue state in the vhost_dev_set_log routine
> > > >     Use "continue" instead of "break" to handle non-initialized
> > > >     virtqueue case.
> > > > 
> > > > v2 -> v3:
> > > >   - update commit message for the 
> > > >     "vhost: recheck dev state in the vhost_migration_log routine" commit
> > > >   - rename "started" field of the VhostUserBlk structure to
> > > >     "started_vu", so there will be no confustion with the VHOST started
> > > >     field
> > > >   - update vhost-user-test.c to always initialize nq local variable
> > > >     (spotted by patchew)
> > > > 
> > > > v1 -> v2:
> > > >   - add comments to connected/started fields in the header file
> > > >   - move the "s->started" logic from the vhost_user_blk_disconnect
> > > >     routine to the vhost_user_blk_stop routine
> > > > 
> > > > Reference e-mail threads:
> > > >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
> > > >   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
> > > > 
> > > > If vhost-user daemon is used as a backend for the vhost device, then we
> > > > should consider a possibility of disconnect at any moment. There was a general
> > > > question here: should we consider it as an error or okay state for the vhost-user
> > > > devices during migration process?
> > > > I think the disconnect event for the vhost-user devices should not break the
> > > > migration process, because:
> > > >   - the device will be in the stopped state, so it will not be changed
> > > >     during migration
> > > >   - if reconnect will be made the migration log will be reinitialized as
> > > >     part of reconnect/init process:
> > > >     #0  vhost_log_global_start (listener=0x563989cf7be0)
> > > >     at hw/virtio/vhost.c:920
> > > >     #1  0x000056398603d8bc in listener_add_address_space (listener=0x563989cf7be0,
> > > >         as=0x563986ea4340 <address_space_memory>)
> > > >     at softmmu/memory.c:2664
> > > >     #2  0x000056398603dd30 in memory_listener_register (listener=0x563989cf7be0,
> > > >         as=0x563986ea4340 <address_space_memory>)
> > > >     at softmmu/memory.c:2740
> > > >     #3  0x0000563985fd6956 in vhost_dev_init (hdev=0x563989cf7bd8,
> > > >         opaque=0x563989cf7e30, backend_type=VHOST_BACKEND_TYPE_USER,
> > > >         busyloop_timeout=0)
> > > >     at hw/virtio/vhost.c:1385
> > > >     #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=0x563989cf7990)
> > > >     at hw/block/vhost-user-blk.c:315
> > > >     #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=0x563989cf7990,
> > > >         event=CHR_EVENT_OPENED)
> > > >     at hw/block/vhost-user-blk.c:379
> > > > The first patch in the patchset fixes this issue by setting vhost device to the
> > > > stopped state in the disconnect handler and check it the vhost_migration_log()
> > > > routine before returning from the function.
> > > > qtest framework was updated to test vhost-user-blk functionality. The
> > > > vhost-user-blk/vhost-user-blk-tests/migrate_reconnect test was added to reproduce
> > > > the original issue found.
> > > > 
> > > > Dima Stepanov (7):
> > > >   vhost: recheck dev state in the vhost_migration_log routine
> > > >   vhost: check queue state in the vhost_dev_set_log routine
> > > >   tests/qtest/vhost-user-test: prepare the tests for adding new dev
> > > >     class
> > > >   tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
> > > >   tests/qtest/vhost-user-test: add support for the vhost-user-blk device
> > > >   tests/qtest/vhost-user-test: add migrate_reconnect test
> > > >   tests/qtest/vhost-user-test: enable the reconnect tests
> > > > 
> > > >  hw/block/vhost-user-blk.c          |  19 ++-
> > > >  hw/virtio/vhost.c                  |  39 ++++-
> > > >  include/hw/virtio/vhost-user-blk.h |  10 ++
> > > >  tests/qtest/libqos/virtio-blk.c    |  14 +-
> > > >  tests/qtest/vhost-user-test.c      | 290 +++++++++++++++++++++++++++++++------
> > > >  5 files changed, 322 insertions(+), 50 deletions(-)
> > > > 
> > > > -- 
> > > > 2.7.4
> > > 
> 

