Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61704C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EEB206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtBpMRKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EEB206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUlr-0001oZ-9E
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipUkd-0000I5-3g
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipUka-0005PF-Ap
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:09:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40999
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipUka-0005KA-01
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578564551;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2jZsJ9J5f56T828w5lTsn8vd2lOZ4Cx09XLeNp14tw=;
 b=DtBpMRKX7agqVjHz0jcn6Y4KCcGI0Gb3XNRluVI4gHeL6tKhjUUYMz2oGV0QbQGVNSlJJI
 dohi2UquMT4vz1icDzjvwd0Ssxng0q0KflQfrswJsF7hCc3YX/kCv97VNgVaVp8zcsrTvl
 WUSbP/s9gb/aSDfJAIf8iU3jlJWp/FI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-_xjLp5OuOh-er_-hHwSnXQ-1; Thu, 09 Jan 2020 05:09:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD3A4800D5A;
 Thu,  9 Jan 2020 10:09:06 +0000 (UTC)
Received: from redhat.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 845E61A8E2;
 Thu,  9 Jan 2020 10:09:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: cenjiahui <cenjiahui@huawei.com>
Subject: Re: [PATCH 2/3] migration/multifd: fix destroyed mutex access in
 terminating multifd threads
In-Reply-To: <20191023034738.10309-2-cenjiahui@huawei.com>
 (cenjiahui@huawei.com's message of "Wed, 23 Oct 2019 11:47:37 +0800")
References: <20191023034738.10309-1-cenjiahui@huawei.com>
 <20191023034738.10309-2-cenjiahui@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 09 Jan 2020 11:08:59 +0100
Message-ID: <87lfqhym9w.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _xjLp5OuOh-er_-hHwSnXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: quintela@redhat.com
Cc: fangying1@huawei.com, zhouyibo3@huawei.com, dgilbert@redhat.com,
 peterx@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cenjiahui <cenjiahui@huawei.com> wrote:
> From: Jiahui Cen <cenjiahui@huawei.com>
>
> One multifd will lock all the other multifds' IOChannel mutex to inform t=
hem
> to quit by setting p->quit or shutting down p->c. In this senario, if som=
e
> multifds had already been terminated and multifd_load_cleanup/multifd_sav=
e_cleanup
> had destroyed their mutex, it could cause destroyed mutex access when try=
ing
> lock their mutex.
>
> Here is the coredump stack:
>     #0  0x00007f81a2794437 in raise () from /usr/lib64/libc.so.6
>     #1  0x00007f81a2795b28 in abort () from /usr/lib64/libc.so.6
>     #2  0x00007f81a278d1b6 in __assert_fail_base () from /usr/lib64/libc.=
so.6
>     #3  0x00007f81a278d262 in __assert_fail () from /usr/lib64/libc.so.6
>     #4  0x000055eb1bfadbd3 in qemu_mutex_lock_impl (mutex=3D0x55eb1e2d198=
8, file=3D<optimized out>, line=3D<optimized out>) at util/qemu-thread-posi=
x.c:64
>     #5  0x000055eb1bb4564a in multifd_send_terminate_threads (err=3D<opti=
mized out>) at migration/ram.c:1015
>     #6  0x000055eb1bb4bb7f in multifd_send_thread (opaque=3D0x55eb1e2d19f=
8) at migration/ram.c:1171
>     #7  0x000055eb1bfad628 in qemu_thread_start (args=3D0x55eb1e170450) a=
t util/qemu-thread-posix.c:502
>     #8  0x00007f81a2b36df5 in start_thread () from /usr/lib64/libpthread.=
so.0
>     #9  0x00007f81a286048d in clone () from /usr/lib64/libc.so.6
>
> To fix it up, let's destroy the mutex after all the other multifd threads=
 had
> been terminated.
>
> Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
> Signed-off-by: Ying Fang <fangying1@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


