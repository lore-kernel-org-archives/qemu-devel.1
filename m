Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE89C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27E6206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTi9qapE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27E6206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nRG-000137-Q2
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5nQk-0000eL-5k
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:52:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5nQi-0007jx-Hk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597225939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgfRW+67zchbINoy1QU7LsBb+7qffotwoqOBjFG0t4o=;
 b=cTi9qapEkC6hF4JwujxYM+zwfTcd2vyAZE9EOOJZ+6LYcZ5tGqiPb2kmNWyuN335syxueW
 5YcrENnhA1DHYq4vhqKTOVJP4DOfLD62UEteei6O/KQvnz0UTpyRJqfJPheCByEuAt9hvY
 b0PBfNlMzVg1E68d+Tl+4LFV6mTLQi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-3SGo3M_qNv-7cktpZhWzvA-1; Wed, 12 Aug 2020 05:52:15 -0400
X-MC-Unique: 3SGo3M_qNv-7cktpZhWzvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 995488015C4;
 Wed, 12 Aug 2020 09:52:14 +0000 (UTC)
Received: from work-vm (ovpn-113-233.ams2.redhat.com [10.36.113.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E60960BF3;
 Wed, 12 Aug 2020 09:52:13 +0000 (UTC)
Date: Wed, 12 Aug 2020 10:52:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH 2/2] migration: add vsock as data channel support
Message-ID: <20200812095211.GB2810@work-vm>
References: <20200806074030.174-1-longpeng2@huawei.com>
 <20200806074030.174-3-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200806074030.174-3-longpeng2@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Longpeng(Mike) (longpeng2@huawei.com) wrote:
> The vsock channel is more widely use in some new features, for example,
> the Nitro/Enclave. It can also be used as the migration channel.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

OK; it might be worth adding some tests for this.

Can I ask what your use case is - is this migrating an L2 inside an L1
or what?


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 3160b95..fcf7974 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -383,7 +383,8 @@ void qemu_start_incoming_migration(const char *uri, Error **errp)
>      if (!strcmp(uri, "defer")) {
>          deferred_incoming_migration(errp);
>      } else if (strstart(uri, "tcp:", &p) ||
> -               strstart(uri, "unix:", NULL)) {
> +               strstart(uri, "unix:", NULL) ||
> +               strstart(uri, "vsock:", NULL)) {
>          socket_start_incoming_migration(p ? p : uri, errp);
>  #ifdef CONFIG_RDMA
>      } else if (strstart(uri, "rdma:", &p)) {
> @@ -2072,7 +2073,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>      }
>  
>      if (strstart(uri, "tcp:", &p) ||
> -        strstart(uri, "unix:", NULL)) {
> +        strstart(uri, "unix:", NULL) ||
> +        strstart(uri, "vsock:", NULL)) {
>          socket_start_outgoing_migration(s, p ? p : uri, &local_err);
>  #ifdef CONFIG_RDMA
>      } else if (strstart(uri, "rdma:", &p)) {
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


