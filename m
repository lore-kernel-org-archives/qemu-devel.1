Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11F2C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B652078E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0uHdyki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B652078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSZC-0006nh-JV
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMX-0006Iy-TA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMS-000795-Pp
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rcNcfNmBvJj7xlxKdI/XhLpGCnWhWuk9deAUuTkng8=;
 b=L0uHdyki640XY13mLUWlNZmLWhQbXFdOmEJkICkBoAJ84yIuFMMfIbAzNSeRAxRLnlTTKL
 rcQ2aJfWPBWsPiO/DIaty5ItHxH7Pk9Is6Iq7trym07nLgXgqo7MkmlufxO60B2TqyTUNa
 3MmytdIfo1DeZCr2O3ByhHjFRPGYD8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-fAGMGxlZN06FMQs_Rqvo0w-1; Wed, 02 Sep 2020 08:59:31 -0400
X-MC-Unique: fAGMGxlZN06FMQs_Rqvo0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED3C781F021
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:26 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 037B076E01;
 Wed,  2 Sep 2020 12:59:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/39] meson: convert the unit tests
Date: Wed,  2 Sep 2020 08:58:54 -0400
Message-Id: <20200902125917.26021-17-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200828110734.1638685-7-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 256 +----------------------------------------
 tests/meson.build      | 176 +++++++++++++++++++++++++++-
 tests/test-qga.c       |   2 +-
 3 files changed, 179 insertions(+), 255 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9c30949adf..ce0a9fd780 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -38,256 +38,20 @@ export SRC_PATH
 SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
    $(wildcard $(SRC_PATH)/default-configs/*-softmmu.mak)))
 
-check-unit-y += tests/check-qdict$(EXESUF)
-check-unit-y += tests/check-block-qdict$(EXESUF)
-check-unit-y += tests/check-qnum$(EXESUF)
-check-unit-y += tests/check-qstring$(EXESUF)
-check-unit-y += tests/check-qlist$(EXESUF)
-check-unit-y += tests/check-qnull$(EXESUF)
-check-unit-y += tests/check-qobject$(EXESUF)
-check-unit-y += tests/check-qjson$(EXESUF)
-check-unit-y += tests/check-qlit$(EXESUF)
-check-unit-y += tests/test-qobject-output-visitor$(EXESUF)
-check-unit-y += tests/test-clone-visitor$(EXESUF)
-check-unit-y += tests/test-qobject-input-visitor$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-qmp-cmds$(EXESUF)
-check-unit-y += tests/test-string-input-visitor$(EXESUF)
-check-unit-y += tests/test-string-output-visitor$(EXESUF)
-check-unit-y += tests/test-qmp-event$(EXESUF)
-check-unit-y += tests/test-opts-visitor$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-coroutine$(EXESUF)
-check-unit-y += tests/test-visitor-serialization$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-iov$(EXESUF)
-check-unit-y += tests/test-bitmap$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-aio$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-aio-multithread$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-throttle$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-thread-pool$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-hbitmap$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-bdrv-drain$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-bdrv-graph-mod$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-blockjob$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-blockjob-txn$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-block-backend$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-block-iothread$(EXESUF)
-ifeq ($(CONFIG_POSIX),y)
-check-unit-$(CONFIG_BLOCK) += tests/test-image-locking$(EXESUF)
-endif
-check-unit-y += tests/test-x86-cpuid$(EXESUF)
-# all code tested by test-x86-cpuid is inside topology.h
-ifeq ($(CONFIG_SOFTMMU),y)
-check-unit-y += tests/test-xbzrle$(EXESUF)
-check-unit-$(CONFIG_POSIX) += tests/test-vmstate$(EXESUF)
-endif
-check-unit-y += tests/test-cutils$(EXESUF)
-check-unit-y += tests/test-shift128$(EXESUF)
-check-unit-y += tests/test-mul64$(EXESUF)
-check-unit-y += tests/test-int128$(EXESUF)
-# all code tested by test-int128 is inside int128.h
-check-unit-y += tests/rcutorture$(EXESUF)
-check-unit-y += tests/test-rcu-list$(EXESUF)
-check-unit-y += tests/test-rcu-simpleq$(EXESUF)
-check-unit-y += tests/test-rcu-tailq$(EXESUF)
-check-unit-y += tests/test-rcu-slist$(EXESUF)
-check-unit-y += tests/test-qdist$(EXESUF)
-check-unit-y += tests/test-qht$(EXESUF)
-check-unit-y += tests/test-qht-par$(EXESUF)
-check-unit-y += tests/test-bitops$(EXESUF)
-check-unit-y += tests/test-bitcnt$(EXESUF)
-check-unit-y += tests/test-qgraph$(EXESUF)
-check-unit-y += tests/check-qom-interface$(EXESUF)
-check-unit-y += tests/check-qom-proplist$(EXESUF)
-check-unit-y += tests/test-qemu-opts$(EXESUF)
-check-unit-y += tests/test-keyval$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-write-threshold$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-crypto-hash$(EXESUF)
 check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-hash$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-crypto-hmac$(EXESUF)
 check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-hmac$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-crypto-cipher$(EXESUF)
 check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-cipher$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-crypto-secret$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlscredsx509$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlssession$(EXESUF)
-ifndef CONFIG_TSAN
-# Some tests: test-char, test-qdev-global-props, and test-qga,
-# are not runnable under TSan due to a known issue.
-# https://github.com/google/sanitizers/issues/1116
-check-unit-$(CONFIG_SOFTMMU) += tests/test-char$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-qdev-global-props$(EXESUF)
-ifeq ($(CONFIG_GUEST_AGENT),y)
-check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
-endif
-endif
-check-unit-$(CONFIG_SOFTMMU) += tests/test-timed-average$(EXESUF)
-check-unit-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_INOTIFY1)) += tests/test-util-filemonitor$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-util-sockets$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-authz-simple$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-authz-list$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-authz-listfile$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_AUTH_PAM)) += tests/test-authz-pam$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-io-task$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-socket$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-file$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-io-channel-tls$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-command$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-buffer$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-base64$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_GCRYPT))) += tests/test-crypto-pbkdf$(EXESUF)
-check-unit-$(CONFIG_BLOCK) += tests/test-crypto-ivgen$(EXESUF)
-check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-afsplit$(EXESUF)
-check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) += tests/test-crypto-xts$(EXESUF)
-check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-block$(EXESUF)
-check-unit-y += tests/test-logging$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-bufferiszero$(EXESUF)
-check-unit-y += tests/test-uuid$(EXESUF)
-check-unit-y += tests/ptimer-test$(EXESUF)
-check-unit-y += tests/test-qapi-util$(EXESUF)
-ifeq ($(CONFIG_BLOCK)$(CONFIG_REPLICATION)$(CONFIG_POSIX),yyy)
-check-unit-y += tests/test-replication$(EXESUF)
-endif
 
 QEMU_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
 
-
 # Deps that are common to various different sets of tests below
 test-util-obj-y = libqemuutil.a
-test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
-test-qapi-obj-y = $(test-qom-obj-y) tests/libtestqapi.a
-benchmark-crypto-obj-$(CONFIG_BLOCK) = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
-test-crypto-obj-$(CONFIG_BLOCK) = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
-test-io-obj-$(CONFIG_BLOCK) = $(io-obj-y) $(test-crypto-obj-y)
-test-authz-obj-$(CONFIG_BLOCK) = $(test-qom-obj-y) $(authz-obj-y)
-test-block-obj-$(CONFIG_BLOCK) = $(block-obj-y) $(test-io-obj-y) tests/iothread.o
-
-tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
-tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)
-tests/check-qdict$(EXESUF): tests/check-qdict.o $(test-util-obj-y)
-tests/check-block-qdict$(EXESUF): tests/check-block-qdict.o $(test-util-obj-y)
-tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)
-tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
-tests/check-qobject$(EXESUF): tests/check-qobject.o $(test-util-obj-y)
-tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
-tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-util-obj-y)
-tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom-obj-y)
-tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y)
-
-tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(test-io-obj-y) $(chardev-obj-y) tests/socket-helpers.o
-tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
-tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
-tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-block-obj-y)
-tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
-tests/test-bdrv-drain$(EXESUF): tests/test-bdrv-drain.o $(test-block-obj-y) $(test-util-obj-y)
-tests/test-bdrv-graph-mod$(EXESUF): tests/test-bdrv-graph-mod.o $(test-block-obj-y) $(test-util-obj-y)
-tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-util-obj-y)
-tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
-tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-block-obj-y) $(test-util-obj-y)
-tests/test-block-iothread$(EXESUF): tests/test-block-iothread.o $(test-block-obj-y) $(test-util-obj-y)
-tests/test-image-locking$(EXESUF): tests/test-image-locking.o $(test-block-obj-y) $(test-util-obj-y)
-tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
-tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
-tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
-tests/test-bitmap$(EXESUF): tests/test-bitmap.o $(test-util-obj-y)
-tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
-tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/libmigration.fa $(test-util-obj-y) \
-	$(test-io-obj-y)
-tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
-tests/test-int128$(EXESUF): tests/test-int128.o
-tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
-tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
-tests/test-rcu-simpleq$(EXESUF): tests/test-rcu-simpleq.o $(test-util-obj-y)
-tests/test-rcu-tailq$(EXESUF): tests/test-rcu-tailq.o $(test-util-obj-y)
-tests/test-rcu-slist$(EXESUF): tests/test-rcu-slist.o $(test-util-obj-y)
-tests/test-qdist$(EXESUF): tests/test-qdist.o $(test-util-obj-y)
-tests/test-qht$(EXESUF): tests/test-qht.o $(test-util-obj-y)
-tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(test-util-obj-y)
-tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
 tests/atomic64-bench$(EXESUF): tests/atomic64-bench.o $(test-util-obj-y)
 
-tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o hw/core/libhwcore.fa \
-	$(test-qapi-obj-y)
-tests/test-vmstate$(EXESUF): tests/test-vmstate.o migration/libmigration.fa \
-	$(test-io-obj-y)
-tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
-tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
-tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o
-tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
-tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-qapi-obj-y)
-tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-block-obj-y)
-tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
-tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
-
-tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
-
-tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-y) \
-	$(test-block-obj-y)
-
-tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visitor.o $(test-qapi-obj-y)
-tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visitor.o $(test-qapi-obj-y)
-tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y) tests/test-qapi-emit-events.o tests/test-qapi-events.o
-tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visitor.o $(test-qapi-obj-y)
-tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-obj-y)
-tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visitor.o $(test-qapi-obj-y)
-tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qapi-commands.o tests/test-qapi-init-commands.o $(test-qapi-obj-y)
-tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serialization.o $(test-qapi-obj-y)
-tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
-
-tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-y)
-tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
-tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
-tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
-tests/test-qgraph$(EXESUF): tests/test-qgraph.o tests/qtest/libqos/qgraph.o $(test-util-obj-y)
-tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
 tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-hash.o $(test-crypto-obj-y)
-tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-obj-y)
 tests/benchmark-crypto-hmac$(EXESUF): tests/benchmark-crypto-hmac.o $(test-crypto-obj-y)
-tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypto-obj-y)
 tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-crypto-obj-y)
-tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
-tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-y)
-
-ifeq ($(CONFIG_KEYUTILS),y)
-tests/test-crypto-secret.o-libs := -lkeyutils
-endif
-
-tests/crypto-tls-x509-helpers.o-cflags := $(TASN1_CFLAGS)
-tests/crypto-tls-x509-helpers.o-libs := $(TASN1_LIBS)
-tests/pkix_asn1_tab.o-cflags := $(TASN1_CFLAGS)
-
-tests/test-crypto-tlscredsx509.o-cflags := $(TASN1_CFLAGS)
-tests/test-crypto-tlscredsx509$(EXESUF): tests/test-crypto-tlscredsx509.o \
-	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj-y)
-
-tests/test-crypto-tlssession.o-cflags := $(TASN1_CFLAGS)
-tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \
-	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \
-	tests/crypto-tls-psk-helpers.o \
-        $(test-crypto-obj-y)
-tests/test-util-filemonitor$(EXESUF): tests/test-util-filemonitor.o \
-	$(test-util-obj-y)
-tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
-	tests/socket-helpers.o $(test-util-obj-y)
-tests/test-authz-simple$(EXESUF): tests/test-authz-simple.o $(test-authz-obj-y)
-tests/test-authz-list$(EXESUF): tests/test-authz-list.o $(test-authz-obj-y)
-tests/test-authz-listfile$(EXESUF): tests/test-authz-listfile.o $(test-authz-obj-y)
-tests/test-authz-pam$(EXESUF): tests/test-authz-pam.o $(test-authz-obj-y)
-tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
-tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
-        tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
-tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
-        tests/io-channel-helpers.o $(test-io-obj-y)
-tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
-	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \
-	tests/io-channel-helpers.o $(test-io-obj-y)
-tests/test-io-channel-command$(EXESUF): tests/test-io-channel-command.o \
-        tests/io-channel-helpers.o $(test-io-obj-y)
-tests/test-io-channel-buffer$(EXESUF): tests/test-io-channel-buffer.o \
-        tests/io-channel-helpers.o $(test-io-obj-y)
-tests/test-crypto-pbkdf$(EXESUF): tests/test-crypto-pbkdf.o $(test-crypto-obj-y)
-tests/test-crypto-ivgen$(EXESUF): tests/test-crypto-ivgen.o $(test-crypto-obj-y)
-tests/test-crypto-afsplit$(EXESUF): tests/test-crypto-afsplit.o $(test-crypto-obj-y)
-tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-obj-y)
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
@@ -301,8 +65,6 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
 	rm $(INITRD_WORK_DIR)/init
 	rmdir $(INITRD_WORK_DIR)
 
-tests/test-qga$(EXESUF): qga/qemu-ga$(EXESUF)
-tests/test-qga$(EXESUF): tests/test-qga.o tests/qtest/libqtest.o $(test-util-obj-y)
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-obj-y) libvhost-user.a
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
 
@@ -343,19 +105,9 @@ define do_test_tap
 	  "TAP","$@")
 endef
 
-build-unit: $(check-unit-y)
-
-check-unit: $(check-unit-y)
-	$(call do_test_human, $^)
-
 check-speed: $(check-speed-y)
 	$(call do_test_human, $^)
 
-# gtester tests with TAP output
-
-check-report-unit.tap: $(check-unit-y)
-	$(call do_test_tap,$^)
-
 # Per guest TCG tests
 
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
@@ -448,7 +200,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 
 # Consolidated targets
 
-.PHONY: check-block check-unit check check-clean get-vm-images
+.PHONY: check-block check check-clean get-vm-images
 check:
 
 ifeq ($(CONFIG_TOOLS)$(CONFIG_POSIX),yy)
@@ -460,14 +212,12 @@ check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
 	@$<
 endif
 
-check-build: build-unit $(QEMU_IOTESTS_HELPERS-y)
+check-build: $(QEMU_IOTESTS_HELPERS-y)
 
 check-clean:
-	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
+	rm -rf tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
-check: check-unit
-
 clean: check-clean
 
 # Build the help program automatically
diff --git a/tests/meson.build b/tests/meson.build
index 3aeae23d54..bd5d13f6f9 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -1,5 +1,7 @@
+py3 = import('python').find_installation()
+
 qht_bench = executable('qht-bench',
-                       sources: files('qht-bench.c'),
+                       sources: 'qht-bench.c',
                        dependencies: [qemuutil])
 
 test_qapi_outputs = [
@@ -47,6 +49,178 @@ subdir('include')
 libtestqapi = static_library('testqapi', sources: [test_qapi_files, test_qapi_outputs_extra])
 testqapi = declare_dependency(link_with: libtestqapi)
 
+testblock = declare_dependency(dependencies: [block], sources: 'iothread.c')
+
+tests = {
+  'check-block-qdict': [],
+  'check-qdict': [],
+  'check-qnum': [],
+  'check-qstring': [],
+  'check-qlist': [],
+  'check-qnull': [],
+  'check-qobject': [],
+  'check-qjson': [],
+  'check-qlit': [],
+  'test-qobject-output-visitor': [testqapi],
+  'test-clone-visitor': [testqapi],
+  'test-qobject-input-visitor': [testqapi],
+  'test-string-input-visitor': [testqapi],
+  'test-string-output-visitor': [testqapi],
+  'test-qmp-event': [testqapi],
+  'test-opts-visitor': [testqapi],
+  'test-visitor-serialization': [testqapi],
+  'test-bitmap': [],
+  # all code tested by test-x86-cpuid is inside topology.h
+  'test-x86-cpuid': [],
+  'test-cutils': [],
+  'test-shift128': [],
+  'test-mul64': [],
+  # all code tested by test-int128 is inside int128.h
+  'test-int128': [],
+  'rcutorture': [],
+  'test-rcu-list': [],
+  'test-rcu-simpleq': [],
+  'test-rcu-tailq': [],
+  'test-rcu-slist': [],
+  'test-qdist': [],
+  'test-qht': [],
+  'test-bitops': [],
+  'test-bitcnt': [],
+  'test-qgraph': ['qtest/libqos/qgraph.c'],
+  'check-qom-interface': [qom],
+  'check-qom-proplist': [qom],
+  'test-qemu-opts': [],
+  'test-keyval': [testqapi],
+  'test-logging': [],
+  'test-uuid': [],
+  'ptimer-test': ['ptimer-test-stubs.c', meson.source_root() / 'hw/core/ptimer.c'],
+  'test-qapi-util': [],
+}
+
+if have_block
+  tests += {
+    'test-coroutine': [testblock],
+    'test-aio': [testblock],
+    'test-aio-multithread': [testblock],
+    'test-throttle': [testblock],
+    'test-thread-pool': [testblock],
+    'test-hbitmap': [testblock],
+    'test-bdrv-drain': [testblock],
+    'test-bdrv-graph-mod': [testblock],
+    'test-blockjob': [testblock],
+    'test-blockjob-txn': [testblock],
+    'test-block-backend': [testblock],
+    'test-block-iothread': [testblock],
+    'test-write-threshold': [testblock],
+    'test-crypto-hash': [crypto],
+    'test-crypto-hmac': [crypto],
+    'test-crypto-cipher': [crypto],
+    'test-crypto-secret': [crypto, keyutils],
+    'test-authz-simple': [authz],
+    'test-authz-list': [authz],
+    'test-authz-listfile': [authz],
+    'test-io-task': [testblock],
+    'test-io-channel-socket': ['socket-helpers.c', 'io-channel-helpers.c', io],
+    'test-io-channel-file': ['io-channel-helpers.c', io],
+    'test-io-channel-command': ['io-channel-helpers.c', io],
+    'test-io-channel-buffer': ['io-channel-helpers.c', io],
+    'test-crypto-ivgen': [io],
+    'test-crypto-afsplit': [io],
+    'test-crypto-block': [io],
+  }
+  if 'CONFIG_GNUTLS' in config_host and \
+     'CONFIG_TASN1' in config_host
+    tests += {
+      'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
+                                   tasn1, crypto],
+      'test-crypto-tlssession': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
+                                 tasn1, crypto],
+      'test-io-channel-tls': ['io-channel-helpers.c', 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
+                              tasn1, io, crypto]}
+  endif
+  if 'CONFIG_AUTH_PAM' in config_host
+    tests += {'test-authz-pam': [authz]}
+  endif
+  if 'CONFIG_QEMU_PRIVATE_XTS' in config_host
+    tests += {'test-crypto-xts': [crypto, io]}
+  endif
+  if 'CONFIG_POSIX' in config_host
+    tests += {'test-image-locking': [testblock]}
+  endif
+  if 'CONFIG_REPLICATION' in config_host and \
+     'CONFIG_POSIX' in config_host
+    tests += {'test-replication': [testblock]}
+  endif
+  if 'CONFIG_NETTLE' in config_host or 'CONFIG_GCRYPT' in config_host
+    tests += {'test-crypto-pbkdf': [io]}
+  endif
+endif
+
+if have_system
+  tests += {
+    'test-iov': [],
+    'test-qmp-cmds': [testqapi],
+    'test-xbzrle': [migration],
+    'test-vmstate': [migration, io],
+    'test-timed-average': [],
+    'test-util-filemonitor': [],
+    'test-util-sockets': ['socket-helpers.c'],
+    'test-base64': [],
+    'test-bufferiszero': [],
+  }
+  if 'CONFIG_POSIX' in config_host
+    tests += {'test-vmstate': [migration, io]}
+  endif
+  if 'CONFIG_INOTIFY1' in config_host
+    tests += {'test-util-filemonitor': []}
+  endif
+
+  # Some tests: test-char, test-qdev-global-props, and test-qga,
+  # are not runnable under TSan due to a known issue.
+  # https://github.com/google/sanitizers/issues/1116
+  if 'CONFIG_TSAN' not in config_host
+    tests += {
+      'test-char': ['socket-helpers.c', qom, io, chardev],
+      'test-qdev-global-props': [qom, hwcore, testqapi]
+    }
+  endif
+endif
+
+if 'CONFIG_TSAN' not in config_host and \
+   'CONFIG_GUEST_AGENT' in config_host and \
+   'CONFIG_LINUX' in config_host
+  tests += {'test-qga': ['qtest/libqtest.c']}
+endif
+
+test_deps = {
+  'test-qht-par': qht_bench,
+  'test-qga': qga,
+}
+
+test_env = environment()
+test_env.set('G_TEST_SRCDIR', meson.current_source_dir())
+test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
+
+foreach test_name, extra: tests
+  src = [test_name + '.c']
+  deps = [qemuutil]
+  if extra.length() > 0
+    # use a sourceset to quickly separate sources and deps
+    test_ss = ss.source_set()
+    test_ss.add(extra)
+    src += test_ss.all_sources()
+    deps += test_ss.all_dependencies()
+  endif
+  exe = executable(test_name, src, dependencies: deps)
+
+  test(test_name, exe,
+       depends: test_deps.get(test_name, []),
+       env: test_env,
+       args: ['--tap', '-k'],
+       protocol: 'tap',
+       suite: ['unit'])
+endforeach
+
 if have_system and 'CONFIG_POSIX' in config_host
   subdir('qemu-iotests')
 endif
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 122730d326..1e223e992c 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -4,7 +4,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
-#include "libqos/libqtest.h"
+#include "qtest/libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 
-- 
2.26.2



