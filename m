Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D77FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278ED2080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrFuoFdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278ED2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxDy-0002xC-DL
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlxCw-000234-E4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:16:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlxCu-0007st-IM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592496963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ecBPYoUQSZ2xQOtDylUsOFbogOrLqJKnFlY04/OxxoU=;
 b=JrFuoFdhECarRJeaZHjWqQpVq/suDp8tahkWINISJhuSbqwcgNQrRS1ZIqqWh9PBDbsp0u
 d1ciVlXaz8Apzc6SCKkfPjB8iN8OHTdYSmOlr31irZwK3IWk+uijJGK5UZZDGlweXOLObj
 kBITLM/Y8yMe/4Kwrsn5ou5loSs/NOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-AFxf8oGqOXCU3aVdKECJPg-1; Thu, 18 Jun 2020 12:16:00 -0400
X-MC-Unique: AFxf8oGqOXCU3aVdKECJPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76654835B40
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:15:59 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D35FB5C1D0;
 Thu, 18 Jun 2020 16:15:58 +0000 (UTC)
To: qemu list <qemu-devel@nongnu.org>
From: Auger Eric <eric.auger@redhat.com>
Subject: [question] qemu abort when object-add is called with an already used
 id
Message-ID: <0f47e285-3811-ba08-297f-e3ff5bd5f2c3@redhat.com>
Date: Thu, 18 Jun 2020 18:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

While testing PCDIMM hotplug/coldplug I noted qemu aborts if we attempt
to add from the QMP monitor an object whose id is already in use.

for instance
object-add qom-type=memory-backend-ram id=mem1 props.size=4294967296
while mem1 is already used.

We get:
Unexpected error in object_property_try_add() at qom/object.c:1167:
attempt to add duplicate property 'mem1' to object (type 'container')

This is due to the fact &error_abort is passed to object_property_try_add().

Is it the expected behavior?

Thanks

Eric


Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
[Switching to Thread 0x7ffff7fd0e80 (LWP 411617)]
0x00007ffff5a1370f in raise () from /lib64/libc.so.6
(gdb) where
#0  0x00007ffff5a1370f in raise () at /lib64/libc.so.6
#1  0x00007ffff59fdb25 in abort () at /lib64/libc.so.6
#2  0x000055555581e0dc in error_handle_fatal (errp=<optimized out>,
err=0x555556bc40b0) at util/error.c:40
#3  0x0000555555c572ad in error_setv
    (errp=0x555556557b18 <error_abort>, src=0x555555e34ff3
"qom/object.c", line=1167, func=0x555555e35720 <__func__.18519>
"object_property_try_add", err_class=ERROR_CLASS_GENERIC_ERROR,
fmt=<optimized out>, ap=0x7fffffffd7a0, suffix=0x0) at util/error.c:73
#4  0x0000555555c57430 in error_setg_internal
    (errp=errp@entry=0x555556557b18 <error_abort>,
src=src@entry=0x555555e34ff3 "qom/object.c", line=line@entry=1167,
func=func@entry=0x555555e35720 <__func__.18519>
"object_property_try_add", fmt=fmt@entry=0x555555e35438 "attempt to add
duplicate property '%s' to object (type '%s')") at util/error.c:97
#5  0x0000555555b5bf48 in object_property_try_add
    (obj=obj@entry=0x5555567ef280, name=name@entry=0x7ffee4003f80
"mem1", type=type@entry=0x5555573c0dc0 "child<memory-backend-ram>",
get=get@entry=0x555555b5d6b0 <object_get_child_property>,
set=set@entry=0x0, release=release@entry=0x555555b5b930
<object_finalize_child_property>, opaque=0x5555569158a0,
errp=0x555556557b18 <error_abort>) at qom/object.c:1166
#6  0x0000555555b5cf5c in object_property_add
    (opaque=0x5555569158a0, release=0x555555b5b930
<object_finalize_child_property>, set=0x0, get=0x555555b5d6b0
<object_get_child_property>, type=0x5555573c0dc0
"child<memory-backend-ram>", name=0x7ffee4003f80 "mem1",
obj=0x5555567ef280) at qom/object.c:1664
#7  0x0000555555b5cf5c in object_property_add_child (obj=0x5555567ef280,
name=name@entry=0x7ffee4003f80 "mem1", child=child@entry=0x5555569158a0)
at qom/object.c:1664
#8  0x0000555555b5e961 in user_creatable_add_type
    (type=type@entry=0x7ffee4004410 "memory-backend-ram",
id=id@entry=0x7ffee4003f80 "mem1", qdict=qdict@entry=0x7ffee40061d0,
v=v@entry=
    0x55555763d3e0, errp=errp@entry=0x7fffffffd9d8) at
qom/object_interfaces.c:85
#9  0x0000555555b5eb66 in user_creatable_add_dict (qdict=0x7ffee40061d0,
keyval=<optimized out>, errp=0x7fffffffd9d8) at qom/object_interfaces.c:131
#10 0x0000555555c06b70 in qmp_dispatch (cmds=0x555556555620
<qmp_commands>, request=<optimized out>, allow_oob=<optimized out>) at
qapi/qmp-dispatch.c:155
#11 0x0000555555b06d01 in monitor_qmp_dispatch (mon=0x555556823800,
req=<optimized out>) at monitor/qmp.c:145
#12 0x0000555555b0751a in monitor_qmp_bh_dispatcher (data=<optimized
out>) at monitor/qmp.c:234
#13 0x0000555555c622c5 in aio_bh_call (bh=0x5555565da750) at
util/async.c:164
#14 0x0000555555c622c5 in aio_bh_poll (ctx=ctx@entry=0x5555565d92c0) at
util/async.c:164
--Type <RET> for more, q to quit, c to continue without paging--



