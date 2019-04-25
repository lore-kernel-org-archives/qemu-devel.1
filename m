Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51025C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9C1206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9C1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34507 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJkd4-0000vN-GC
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 16:05:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYU-0005l7-H8
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYQ-0007LM-6G
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJkYP-0005ZT-Uh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1B5230BCE55;
	Thu, 25 Apr 2019 20:00:53 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 26A945C1B5;
	Thu, 25 Apr 2019 20:00:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 17:00:47 -0300
Message-Id: <20190425200051.19906-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 25 Apr 2019 20:00:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] Remove some qdev_get_machine() calls from
 CONFIG_USER_ONLY
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Like Xu <like.xu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425200047.CiGB-x_1Hm1OKbLO5jtPvn5PaYt4DBFYzK6-RpW_GPM@z>

This series moves some qdev code outside qdev.o, so it can be
compiled only in CONFIG_SOFTMMU.

The code being moved includes two qdev_get_machine() calls, so
this will make it easier to move qdev_get_machine() to
CONFIG_SOFTMMU later.

After this series, there's one remaining qdev_get_machine() call
that seems more difficult to remove:

    static void device_set_realized(Object *obj, bool value, Error **errp)
    {
        /* [...] */
        if (!obj->parent) {
            gchar *name = g_strdup_printf("device[%d]", unattached_count++);

            object_property_add_child(container_get(qdev_get_machine(),
                                                    "/unattached"),
                                      name, obj, &error_abort);
            unattached_parent = true;
            g_free(name);
        }
        /* [...] */
    }

This one is tricky because on system emulation mode it needs
"/machine" to already exist, but in user-only mode it needs to
implicitly create a "/machine" container.

Eduardo Habkost (4):
  machine: Move gpio code to hw/core/gpio.c
  move qdev hotplug code to qdev-hotplug.c
  qdev: Don't compile hotplug code in user-mode emulation
  qdev-hotplug: Don't check type of qdev_get_machine()

 hw/core/bus.c                |  11 --
 hw/core/gpio.c               | 206 ++++++++++++++++++++++++++++++++
 hw/core/qdev-hotplug-stubs.c |  44 +++++++
 hw/core/qdev-hotplug.c       |  64 ++++++++++
 hw/core/qdev.c               | 219 -----------------------------------
 hw/core/Makefile.objs        |   5 +-
 tests/Makefile.include       |   3 +-
 7 files changed, 320 insertions(+), 232 deletions(-)
 create mode 100644 hw/core/gpio.c
 create mode 100644 hw/core/qdev-hotplug-stubs.c
 create mode 100644 hw/core/qdev-hotplug.c

-- 
2.18.0.rc1.1.g3f1ff2140


