Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A92C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CAC22205
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTWVlzuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CAC22205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGo3n-0005EV-MV
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGo2v-0004iY-ET
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:45:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24745
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGo2t-0002ir-8Y
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599849914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f2DMxgxOO5AHc7IexSZtjC0zu5brfza+kArxINiHJi8=;
 b=gTWVlzuHtPDz5rkWsr/dWxyaUMcOTgbYCJiHlQN+PPpql16lXmbLSN1hsJgIUTvDtLYAqB
 jrXsop44ubJephYNDFGQl7LmSQyWlkzo7+TiGKai5LGx2vRqTPe9IviHEkxCuINmC4KyU5
 3iklj655jWgjrDpz5PbQOIxQrwrHyEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-H56wNqA8McOMquWPugrSGQ-1; Fri, 11 Sep 2020 14:45:10 -0400
X-MC-Unique: H56wNqA8McOMquWPugrSGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58CB31007476;
 Fri, 11 Sep 2020 18:45:09 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C0475C22B;
 Fri, 11 Sep 2020 18:44:51 +0000 (UTC)
Date: Fri, 11 Sep 2020 19:44:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 14/32] savevm: VMS_RESTART and cprsave restart
Message-ID: <20200911184449.GT3310@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-15-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-15-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steve Sistare (steven.sistare@oracle.com) wrote:
> Add the VMS_RESTART variant of vmstate, for use when upgrading qemu in place
> on the same host without a reboot.  Invoke it using:
>   cprsave <filename> restart
> 
> VMS_RESTART supports guest ram mapped by private anonymous memory, versus
> VMS_REBOOT which requires that guest ram be mapped by persistent shared
> memory.  Subsequent patches complete its implementation.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

You should find with the enum like Eric suggests this mostly disappears;
but also you might want to put it after the patches that implement it.

Dave

> ---
>  hmp-commands.hx             | 4 +++-
>  include/migration/vmstate.h | 1 +
>  migration/savevm.c          | 4 +++-
>  monitor/qmp-cmds.c          | 2 +-
>  qapi/migration.json         | 1 +
>  5 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7517876..11a2089 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -369,7 +369,7 @@ ERST
>      {
>          .name       = "cprsave",
>          .args_type  = "file:s,mode:s",
> -        .params     = "file 'reboot'",
> +        .params     = "file 'restart'|'reboot'",
>          .help       = "create a checkpoint of the VM in file",
>          .cmd        = hmp_cprsave,
>      },
> @@ -380,6 +380,8 @@ SRST
>    in *file*.
>    If *mode* is 'reboot', the checkpoint can be cprload'ed after a host kexec
>    reboot.
> +  If *mode* is 'restart', the checkpoint can be cprload'ed after restarting
> +  qemu.
>    exec() /usr/bin/qemu-exec if it exists, else exec /usr/bin/qemu-system-x86_64,
>    passing all the original command line arguments.  The VCPUs remain paused.
>  ERST
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index c58551a..8239b84 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -162,6 +162,7 @@ typedef enum {
>      VMS_MIGRATE  = (1U << 1),
>      VMS_SNAPSHOT = (1U << 2),
>      VMS_REBOOT   = (1U << 3),
> +    VMS_RESTART  = (1U << 4),
>      VMS_MODE_ALL = ~0U
>  } VMStateMode;
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 00f493b..38cc63a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2708,6 +2708,8 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
>  
>      if (!strcmp(mode, "reboot")) {
>          op = VMS_REBOOT;
> +    } else if (!strcmp(mode, "restart")) {
> +        op = VMS_RESTART;
>      } else {
>          error_setg(errp, "cprsave: bad mode %s", mode);
>          return;
> @@ -2973,7 +2975,7 @@ void load_cpr_snapshot(const char *file, Error **errp)
>          return;
>      }
>  
> -    ret = qemu_loadvm_state(f, VMS_REBOOT);
> +    ret = qemu_loadvm_state(f, VMS_REBOOT | VMS_RESTART);
>      qemu_fclose(f);
>      if (ret < 0) {
>          error_setg(errp, "Error %d while loading VM state", ret);
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 8c400e6..8a74c6e 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -164,7 +164,7 @@ void qmp_cont(Error **errp)
>  
>  char *qmp_cprinfo(Error **errp)
>  {
> -    return g_strdup("reboot");
> +    return g_strdup("reboot restart");
>  }
>  
>  void qmp_cprsave(const char *file, const char *mode, Error **errp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8190b16..d22992b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1639,6 +1639,7 @@
>  #
>  # @file: name of checkpoint file
>  # @mode: 'reboot' : checkpoint can be cprload'ed after a host kexec reboot.
> +#        'restart': checkpoint can be cprload'ed after restarting qemu.
>  #
>  # Since 5.0
>  ##
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


