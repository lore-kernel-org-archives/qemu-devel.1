Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E6AC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E954207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJvwT/PO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E954207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKJrM-0007i9-K8
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKJpB-0006Pr-8C
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKJp9-0007mz-CQ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600687054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Qb3ETkr5QwxWU6cCxpFsZBdfYKJYlYFZv6lT4XL9Og=;
 b=hJvwT/POjwny8ekscfmuGK6kkHtnrQuTfa4u32yOc5uI5hoLhHRNiRXPj84XM6tSlfVt17
 /qWU9kB1efWhUPsmoU/di2oj+acb2ti0SuXY5/hNkXi0a69OWhRWWeb1AoTy+QIeOtn1Nj
 VjA66H3YSYx2VKCeupnuY3vUEJ+NQtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-Ia5eRWPpNluaekwjhEoi_g-1; Mon, 21 Sep 2020 07:17:28 -0400
X-MC-Unique: Ia5eRWPpNluaekwjhEoi_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BF2B8018AB;
 Mon, 21 Sep 2020 11:17:27 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B41BA610AF;
 Mon, 21 Sep 2020 11:17:25 +0000 (UTC)
Date: Mon, 21 Sep 2020 12:17:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Dov Murik <dovmurik@linux.vnet.ibm.com>, sstabellini@kernel.org,
 anthony.perard@citrix.com
Subject: Re: [PATCH] migration: Truncate state file in xen-save-devices-state
Message-ID: <20200921111723.GF3221@work-vm>
References: <20200921094830.114028-1-dovmurik@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200921094830.114028-1-dovmurik@linux.vnet.ibm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dov Murik (dovmurik@linux.vnet.ibm.com) wrote:
> When running the xen-save-devices-state QMP command, if the filename
> already exists it will be truncated before dumping the devices' state
> into it.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> ---

OK, that looks fine to me, so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> 
> Note that I found the above issue while trying to debug
> xen-load-devices-state which simply fails (prints "Configuration section
> missing" to stderr) directly after xen-save-devices-state (in the same
> VM).  I wonder if I should file a bug report as-is or investigate some
> more.  Advice welcome.

I don't try the xen-* commands normally; I've cc'ing in Stefano and
Anthony.

Dave

> 
> -Dov
> 
> ---
>  migration/savevm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 304d98ff78..e1b26672cc 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2803,7 +2803,8 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>      vm_stop(RUN_STATE_SAVE_VM);
>      global_state_store_running();
>  
> -    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT, 0660, errp);
> +    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT | O_TRUNC,
> +                                    0660, errp);
>      if (!ioc) {
>          goto the_end;
>      }
> -- 
> 2.20.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


