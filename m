Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B716C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA18220673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEhKFNIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA18220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUWE-0008Rj-2o
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipUVU-0007Yu-Sh
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipUVT-0007eo-Ol
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:53:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipUVT-0007ap-GR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578563614;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s46TB4gYdA75mF/WjjCkh0IGG8+pmCR9htiZTZZtlP8=;
 b=VEhKFNInG+8CBxVY+/EEoR1YphMbtH0hSecPapxqcLa0qvWbEEKlFdw31bnkffM//cCTWh
 duAfdWw15Hd+EsGma4V3+O/PLZLQ0Hv+XAblEu/wdxuGf1ndBuNGXC14wI2oaDC/dWZIci
 Kjf22t81Ket22Ru6bs/IOgUhSmYzr/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-H3Ib-EIJPjyRM6wG6UQVIw-1; Thu, 09 Jan 2020 04:53:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 859068014DA;
 Thu,  9 Jan 2020 09:53:30 +0000 (UTC)
Received: from redhat.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0225E66834;
 Thu,  9 Jan 2020 09:53:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: cenjiahui <cenjiahui@huawei.com>
Subject: Re: [PATCH 1/3] migration/multifd: fix nullptr access in terminating
 multifd threads
In-Reply-To: <20191023043002.8788-1-cenjiahui@huawei.com>
 (cenjiahui@huawei.com's message of "Wed, 23 Oct 2019 12:30:02 +0800")
References: <20191023043002.8788-1-cenjiahui@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 09 Jan 2020 10:53:27 +0100
Message-ID: <87pnftymzs.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: H3Ib-EIJPjyRM6wG6UQVIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fangying1@huawei.com, zhouyibo3@huawei.com, dgilbert@redhat.com,
 peterx@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cenjiahui <cenjiahui@huawei.com> wrote:
> From: Jiahui Cen <cenjiahui@huawei.com>
>
> One multifd channel will shutdown all the other multifd's IOChannel when =
it
> fails to receive an IOChannel. In this senario, if some multifds had not
> received its IOChannel yet, it would try to shutdown its IOChannel which =
could
> cause nullptr access at qio_channel_shutdown.
>
> Here is the coredump stack:
>     #0  object_get_class (obj=3Dobj@entry=3D0x0) at qom/object.c:908
>     #1  0x00005563fdbb8f4a in qio_channel_shutdown (ioc=3D0x0, how=3DQIO_=
CHANNEL_SHUTDOWN_BOTH, errp=3D0x0) at io/channel.c:355
>     #2  0x00005563fd7b4c5f in multifd_recv_terminate_threads (err=3D<opti=
mized out>) at migration/ram.c:1280
>     #3  0x00005563fd7bc019 in multifd_recv_new_channel (ioc=3Dioc@entry=
=3D0x556400255610, errp=3Derrp@entry=3D0x7ffec07dce00) at migration/ram.c:1=
478
>     #4  0x00005563fda82177 in migration_ioc_process_incoming (ioc=3Dioc@e=
ntry=3D0x556400255610, errp=3Derrp@entry=3D0x7ffec07dce30) at migration/mig=
ration.c:605
>     #5  0x00005563fda8567d in migration_channel_process_incoming (ioc=3D0=
x556400255610) at migration/channel.c:44
>     #6  0x00005563fda83ee0 in socket_accept_incoming_migration (listener=
=3D0x5563fff6b920, cioc=3D0x556400255610, opaque=3D<optimized out>) at migr=
ation/socket.c:166
>     #7  0x00005563fdbc25cd in qio_net_listener_channel_func (ioc=3D<optim=
ized out>, condition=3D<optimized out>, opaque=3D<optimized out>) at io/net=
-listener.c:54
>     #8  0x00007f895b6fe9a9 in g_main_context_dispatch () from /usr/lib64/=
libglib-2.0.so.0
>     #9  0x00005563fdc18136 in glib_pollfds_poll () at util/main-loop.c:21=
8
>     #10 0x00005563fdc181b5 in os_host_main_loop_wait (timeout=3D100000000=
0) at util/main-loop.c:241
>     #11 0x00005563fdc183a2 in main_loop_wait (nonblocking=3Dnonblocking@e=
ntry=3D0) at util/main-loop.c:517
>     #12 0x00005563fd8edb37 in main_loop () at vl.c:1791
>     #13 0x00005563fd74fd45 in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at vl.c:4473
>
> To fix it up, let's check p->c before calling qio_channel_shutdown.
>
> Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
> Signed-off-by: Ying Fang <fangying1@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


