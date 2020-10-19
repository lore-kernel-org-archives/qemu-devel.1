Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD2CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D0022268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrJqfMxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D0022268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSFV-00072l-3v
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kUSEH-0006Is-RH
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kUSEE-0005zf-OX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603102640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d8ddGxTzgy0HtCDRrfpC7GHFE6vB0l6gTHWt152MyzM=;
 b=hrJqfMxhNtNt+tjFhuPFyQ+Y9+VUc34v4u2oQO/nQPKeHSx67eWV1uiF4+/19iCPv+vc/h
 21UH2VjAD9qBAHZbTp9GfRpmd6bESZX/bjw81RC5cz12nMfI976k0ZqSH6LLiLPIduB+K7
 soh2buHVZAICoNX+HMfFRMTJ0eW6BJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-m8eJzDPqNIqMX7ztx2YXjA-1; Mon, 19 Oct 2020 06:17:19 -0400
X-MC-Unique: m8eJzDPqNIqMX7ztx2YXjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F32ED1006702
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 10:17:17 +0000 (UTC)
Received: from work-vm (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BC5550B44;
 Mon, 19 Oct 2020 10:17:10 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:17:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 02/14] spice: add QemuSpiceOps, move migrate_info
Message-ID: <20201019101707.GD3565@work-vm>
References: <20201019075224.14803-1-kraxel@redhat.com>
 <20201019075224.14803-3-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201019075224.14803-3-kraxel@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> Add QemuSpiceOps struct.  This struct holds function pointers to the
> spice functions.  It will be initialized with pointers to the stub
> functions.  When spice gets initialized the function pointers will
> be re-written to the real functions.
> 
> The spice stubs will move from qemu-spice.h to spice-module.c for that,
> because they will be needed for both "CONFIG_SPICE=n" and "CONFIG_SPICE=y
> but spice module not loaded" cases.
> 
> This patch adds the infrastructure and starts with moving
> qemu_spice_migrate_info() to QemuSpiceOps.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/qemu-spice-module.h |  5 +++++
>  include/ui/qemu-spice.h        |  5 -----
>  monitor/misc.c                 |  2 +-
>  ui/spice-core.c                |  5 +++++
>  ui/spice-module.c              | 10 ++++++++++
>  5 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
> index 1af0e659a109..7a9963dd5810 100644
> --- a/include/ui/qemu-spice-module.h
> +++ b/include/ui/qemu-spice-module.h
> @@ -18,6 +18,11 @@
>  #ifndef QEMU_SPICE_MODULE_H
>  #define QEMU_SPICE_MODULE_H
>  
> +struct QemuSpiceOps {
> +    int (*migrate_info)(const char *h, int p, int t, const char *s);
> +};
> +

I realise that's mostly a move, but if you need to repost, can you
expand those 4 single character parameter names?

Dave

>  extern int using_spice;
> +extern struct QemuSpiceOps qemu_spice;
>  
>  #endif
> diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
> index ab523788b9a9..3157016c2bb4 100644
> --- a/include/ui/qemu-spice.h
> +++ b/include/ui/qemu-spice.h
> @@ -60,11 +60,6 @@ static inline int qemu_spice_set_pw_expire(time_t expires)
>  {
>      return -1;
>  }
> -static inline int qemu_spice_migrate_info(const char *h, int p, int t,
> -                                          const char *s)
> -{
> -    return -1;
> -}
>  
>  static inline int qemu_spice_display_add_client(int csock, int skipauth,
>                                                  int tls)
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 4a859fb24a21..32e6a8c13d07 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -437,7 +437,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
>              return;
>          }
>  
> -        if (qemu_spice_migrate_info(hostname,
> +        if (qemu_spice.migrate_info(hostname,
>                                      has_port ? port : -1,
>                                      has_tls_port ? tls_port : -1,
>                                      cert_subject)) {
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index a7fa5743585f..b03d743cf9b9 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -993,8 +993,13 @@ int qemu_spice_display_is_running(SimpleSpiceDisplay *ssd)
>      return spice_display_is_running;
>  }
>  
> +static struct QemuSpiceOps real_spice_ops = {
> +    .migrate_info = qemu_spice_migrate_info,
> +};
> +
>  static void spice_register_config(void)
>  {
> +    qemu_spice = real_spice_ops;
>      qemu_add_opts(&qemu_spice_opts);
>  }
>  opts_init(spice_register_config);
> diff --git a/ui/spice-module.c b/ui/spice-module.c
> index f86b0ac517dc..f1939545a684 100644
> --- a/ui/spice-module.c
> +++ b/ui/spice-module.c
> @@ -21,3 +21,13 @@
>  #include "ui/qemu-spice-module.h"
>  
>  int using_spice;
> +
> +static int qemu_spice_migrate_info_stub(const char *h, int p, int t,
> +                                        const char *s)
> +{
> +    return -1;
> +}
> +
> +struct QemuSpiceOps qemu_spice = {
> +    .migrate_info = qemu_spice_migrate_info_stub,
> +};
> -- 
> 2.27.0
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


