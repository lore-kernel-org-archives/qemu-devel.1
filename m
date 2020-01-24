Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D784C32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD312075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NA8ionIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD312075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyNX-00045l-1P
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iuyMp-0003VS-52
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iuyMn-0004J3-MS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:47:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iuyMn-0004Hn-JO
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579870037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhISz/Z8Y2VYAlACLayh/vIORSFCoH7C+nzGwv/zVvI=;
 b=NA8ionIJddIWvB4WoTW7IzOESLkBa7eo3P9/lJXAjkcWlb8F6CR2npk1Ped3g/arYTn8rq
 +Z92MntTwQGFSaTyvaiX7yND20IqzUIS9ZocruoUiY6WqI8/VTrnT2Ng3Z54OeiBIAbdUg
 twbAXRWQVIIxdKH80nCMILBD+im3wTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-tgJA25-pPQeEEaPEeJlv0g-1; Fri, 24 Jan 2020 07:47:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8F881005510;
 Fri, 24 Jan 2020 12:47:11 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D4ED19C69;
 Fri, 24 Jan 2020 12:47:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH] migration/multifd: fix nullptr access in
 multifd_send_terminate_threads
In-Reply-To: <20200110085019.876-1-fengzhimin1@huawei.com> (Zhimin Feng's
 message of "Fri, 10 Jan 2020 16:50:19 +0800")
References: <20200110085019.876-1-fengzhimin1@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 24 Jan 2020 13:47:08 +0100
Message-ID: <87iml13ttf.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: tgJA25-pPQeEEaPEeJlv0g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: zhang.zhanghailiang@huawei.com, dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhimin Feng <fengzhimin1@huawei.com> wrote:
> If the multifd_send_threads is not created when migration is failed,
> multifd_save_cleanup would be called twice. In this senario, the
> multifd_send_state is accessed after it has been released, the result
> is that the source VM is crashing down.
>
> Here is the coredump stack:
>     Program received signal SIGSEGV, Segmentation fault.
>     0x00005629333a78ef in multifd_send_terminate_threads (err=3Derr@entry=
=3D0x0) at migration/ram.c:1012
>     1012            MultiFDSendParams *p =3D &multifd_send_state->params[=
i];
>     #0  0x00005629333a78ef in multifd_send_terminate_threads (err=3Derr@e=
ntry=3D0x0) at migration/ram.c:1012
>     #1  0x00005629333ab8a9 in multifd_save_cleanup () at migration/ram.c:=
1028
>     #2  0x00005629333abaea in multifd_new_send_channel_async (task=3D0x56=
2935450e70, opaque=3D<optimized out>) at migration/ram.c:1202
>     #3  0x000056293373a562 in qio_task_complete (task=3Dtask@entry=3D0x56=
2935450e70) at io/task.c:196
>     #4  0x000056293373a6e0 in qio_task_thread_result (opaque=3D0x56293545=
0e70) at io/task.c:111
>     #5  0x00007f475d4d75a7 in g_idle_dispatch () from /usr/lib64/libglib-=
2.0.so.0
>     #6  0x00007f475d4da9a9 in g_main_context_dispatch () from /usr/lib64/=
libglib-2.0.so.0
>     #7  0x0000562933785b33 in glib_pollfds_poll () at util/main-loop.c:21=
9
>     #8  os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-l=
oop.c:242
>     #9  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at util/main=
-loop.c:518
>     #10 0x00005629334c5acf in main_loop () at vl.c:1810
>     #11 0x000056293334d7bb in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at vl.c:4471
>
> If the multifd_send_threads is not created when migration is failed.
> In this senario, we don't call multifd_save_cleanup in multifd_new_send_c=
hannel_async.
>
> Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


