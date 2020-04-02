Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121B5C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C692063A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODfZM8JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C692063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzHt-0007kO-UK
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJzGv-0006qU-VX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJzGu-0005Zr-1d
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:48:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36103
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJzGs-0005Y1-52
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585831711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WvhiWIhlmD3xO8yJ9iU5TswsksXYCW4iK+N2nbKRdd8=;
 b=ODfZM8JQ4r23xLpLcct9J8X4etWZZdW805PH33jCvePbBQYzbjazpoEpBE6zfy9H0opjxg
 7DsqSodsLVRRT86lWajbw8YcXs4zs5NwwwB/ZCweAA8y/EoqidiC7/fbW4rmWLV0Dp1vq7
 eD5jmWuAlDZbjNnxFvqAtL5tRxamhEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-Z3B4i16wN8W7sSrAK3octA-1; Thu, 02 Apr 2020 08:48:27 -0400
X-MC-Unique: Z3B4i16wN8W7sSrAK3octA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C1F7800D5C;
 Thu,  2 Apr 2020 12:48:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-227.ams2.redhat.com [10.36.114.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0BCADA11C;
 Thu,  2 Apr 2020 12:48:17 +0000 (UTC)
Date: Thu, 2 Apr 2020 14:48:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Reiter <s.reiter@proxmox.com>
Subject: Re: [PATCH v4 0/3] Fix some AIO context locking in jobs
Message-ID: <20200402124816.GC4006@linux.fritz.box>
References: <20200401081504.200017-1-s.reiter@proxmox.com>
MIME-Version: 1.0
In-Reply-To: <20200401081504.200017-1-s.reiter@proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: vsementsov@virtuozzo.com, slp@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.04.2020 um 10:15 hat Stefan Reiter geschrieben:
> Contains three seperate but related patches cleaning up and fixing some
> issues regarding aio_context_acquire/aio_context_release for jobs. Mostly
> affects blockjobs running for devices that have IO threads enabled AFAICT=
.
>=20
> This is based on the discussions here:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07929.html

I'm getting segfaults in some qemu-iotests cases:

    Failures: 155 219 245 255 257 258

This is the backtrace of one of the coredumps I got, looks like use
after free:

(gdb) bt
#0  0x000055bad36ce4dc in qemu_mutex_lock_impl (mutex=3D0xebebebebebebec4b,=
 file=3D0x55bad38c5cbf "util/async.c", line=3D596) at util/qemu-thread-posi=
x.c:76
#1  0x000055bad35d4f4f in job_txn_apply (fn=3D0x55bad35d58b0 <job_finalize_=
single>, job=3D<optimized out>, job=3D<optimized out>) at job.c:168
#2  0x000055bad33aa807 in qmp_job_finalize (id=3D<optimized out>, errp=3Der=
rp@entry=3D0x7ffff6a2ad68) at job-qmp.c:117
#3  0x000055bad357fabb in qmp_marshal_job_finalize (args=3D<optimized out>,=
 ret=3D<optimized out>, errp=3D0x7ffff6a2adc8) at qapi/qapi-commands-job.c:=
204
#4  0x000055bad367f688 in qmp_dispatch (cmds=3D0x55bad3df2880 <qmp_commands=
>, request=3D<optimized out>, allow_oob=3D<optimized out>) at qapi/qmp-disp=
atch.c:155
#5  0x000055bad355bfb1 in monitor_qmp_dispatch (mon=3D0x55bad5b0d2f0, req=
=3D<optimized out>) at monitor/qmp.c:145
#6  0x000055bad355c79a in monitor_qmp_bh_dispatcher (data=3D<optimized out>=
) at monitor/qmp.c:234
#7  0x000055bad36c7ea5 in aio_bh_call (bh=3D0x55bad58fa2b0) at util/async.c=
:164
#8  0x000055bad36c7ea5 in aio_bh_poll (ctx=3Dctx@entry=3D0x55bad58f8ee0) at=
 util/async.c:164
#9  0x000055bad36cb52e in aio_dispatch (ctx=3D0x55bad58f8ee0) at util/aio-p=
osix.c:380
#10 0x000055bad36c7d8e in aio_ctx_dispatch (source=3D<optimized out>, callb=
ack=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:298
#11 0x00007fa3a3f7a06d in g_main_context_dispatch () at /lib64/libglib-2.0.=
so.0
#12 0x000055bad36ca798 in glib_pollfds_poll () at util/main-loop.c:219
#13 0x000055bad36ca798 in os_host_main_loop_wait (timeout=3D<optimized out>=
) at util/main-loop.c:242
#14 0x000055bad36ca798 in main_loop_wait (nonblocking=3Dnonblocking@entry=
=3D0) at util/main-loop.c:518
#15 0x000055bad3340559 in qemu_main_loop () at /home/kwolf/source/qemu/soft=
mmu/vl.c:1664
#16 0x000055bad322993e in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at /home/kwolf/source/qemu/softmmu/main.c:49
(gdb) p *job
$3 =3D {id =3D 0xebebebebebebebeb <error: Cannot access memory at address 0=
xebebebebebebebeb>, driver =3D 0xebebebebebebebeb, refcnt =3D -336860181, s=
tatus =3D 3958107115,=20
  aio_context =3D 0xebebebebebebebeb, co =3D 0xebebebebebebebeb, sleep_time=
r =3D {expire_time =3D -1446803456761533461, timer_list =3D 0xebebebebebebe=
beb, cb =3D 0xebebebebebebebeb,=20
    opaque =3D 0xebebebebebebebeb, next =3D 0xebebebebebebebeb, attributes =
=3D -336860181, scale =3D -336860181}, pause_count =3D -336860181, busy =3D=
 235, paused =3D 235, user_paused =3D 235,=20
  cancelled =3D 235, force_cancel =3D 235, deferred_to_main_loop =3D 235, a=
uto_finalize =3D 235, auto_dismiss =3D 235, progress =3D {current =3D 16999=
940616948018155, total =3D 16999940616948018155},=20
  ret =3D -336860181, err =3D 0xebebebebebebebeb, cb =3D 0xebebebebebebebeb=
, opaque =3D 0xebebebebebebebeb, on_finalize_cancelled =3D {notifiers =3D {=
lh_first =3D 0xebebebebebebebeb}},=20
  on_finalize_completed =3D {notifiers =3D {lh_first =3D 0xebebebebebebebeb=
}}, on_pending =3D {notifiers =3D {lh_first =3D 0xebebebebebebebeb}}, on_re=
ady =3D {notifiers =3D {lh_first =3D=20
    0xebebebebebebebeb}}, on_idle =3D {notifiers =3D {lh_first =3D 0xebebeb=
ebebebebeb}}, job_list =3D {le_next =3D 0xebebebebebebebeb, le_prev =3D 0xe=
bebebebebebebeb}, txn =3D 0xebebebebebebebeb,=20
  txn_list =3D {le_next =3D 0xebebebebebebebeb, le_prev =3D 0xebebebebebebe=
beb}}

Kevin


