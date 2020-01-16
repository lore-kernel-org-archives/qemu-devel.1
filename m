Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACB9C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C6A2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOwnCebv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C6A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5Ad-0008UR-TW
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1is59O-0006fm-4B
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1is59N-0004Gc-50
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:25:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31652
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1is59N-0004Fv-10
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579181128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+r2KKIBln1EgB8OPXCN6DKwgwMSYDJi/rJURFxY9v8=;
 b=jOwnCebvkOczqCAa/tQ2dZ2lZr40dBcq5n4QzaQY6kjYIrurKWXFmSpCq2Ih7GlRdHToqf
 +0dPMxLWVlGU2IsWK0jlCp5mS4c/Ism9WR8U1HEcYcfsACbx1/dcEgpFa5CEFj0jjuphSy
 pnIYZG1odgE/g0NpdBMkF51fqdxs+bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-k1yXzKXxMueijhBOn_rT3w-1; Thu, 16 Jan 2020 08:25:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 734CDA16EB;
 Thu, 16 Jan 2020 13:25:22 +0000 (UTC)
Received: from redhat.com (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07C0C60E3E;
 Thu, 16 Jan 2020 13:25:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 04/12] migration/rdma: Create multiRDMA migration
 threads
In-Reply-To: <20200109045922.904-5-fengzhimin1@huawei.com> (Zhimin Feng's
 message of "Thu, 9 Jan 2020 12:59:14 +0800")
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-5-fengzhimin1@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 16 Jan 2020 14:25:20 +0100
Message-ID: <87eevz8ren.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: k1yXzKXxMueijhBOn_rT3w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: zhang.zhanghailiang@huawei.com, armbru@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, jemmy858585@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhimin Feng <fengzhimin1@huawei.com> wrote:
> From: fengzhimin <fengzhimin1@huawei.com>
>
> Creation of the RDMA threads, nothing inside yet.
>
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>

> ---
>  migration/migration.c |   1 +
>  migration/migration.h |   2 +
>  migration/rdma.c      | 283 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 5756a4806e..f8d4eb657e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1546,6 +1546,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>          qemu_mutex_lock_iothread();
> =20
>          multifd_save_cleanup();
> +        multiRDMA_save_cleanup();

Can we merge this with multifd?


> +typedef struct {
> +    /* this fields are not changed once the thread is created */
> +    /* channel number */
> +    uint8_t id;
> +    /* channel thread name */
> +    char *name;
> +    /* channel thread id */
> +    QemuThread thread;
> +    /* sem where to wait for more work */
> +    QemuSemaphore sem;
> +    /* this mutex protects the following parameters */
> +    QemuMutex mutex;
> +    /* is this channel thread running */
> +    bool running;
> +    /* should this thread finish */
> +    bool quit;
> +}  MultiRDMASendParams;

This is basically the same than MultiFBSendParams, same for the rest.

I would very much preffer not to have two sets of threads that are
really equivalent.

Thanks, Juan.


