Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA89C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 18:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02239206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 18:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gB6NedRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02239206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjSNl-0006Hh-8M
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 14:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjSN5-0005RB-UC
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 14:56:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjSN4-0006hg-6b
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 14:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591901772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LC4wrLQ0N98xWnE9vqw7dCI+fKfJpGOvG2zaE5zHi2I=;
 b=gB6NedRJ27TTHWlHne1s2EhgX+bfw8RhmabbMdwYWv+9+7KfcZYjFtF8yW7P1PsNo4KAjX
 3n6vBtEG2Qjihfx476vDo0EtVkkGEK9Do3Cij2ZgS/pPUI1SRNCK/HArNCfyETYtatK7q2
 PtE6RI7vM2gSFFFQdtW9AMKjOKXZ130=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-vp3oJmxMNyOZShszXOCFeQ-1; Thu, 11 Jun 2020 14:56:11 -0400
X-MC-Unique: vp3oJmxMNyOZShszXOCFeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D89E100A68D;
 Thu, 11 Jun 2020 18:56:10 +0000 (UTC)
Received: from work-vm (ovpn-114-116.ams2.redhat.com [10.36.114.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E5837FE82;
 Thu, 11 Jun 2020 18:56:09 +0000 (UTC)
Date: Thu, 11 Jun 2020 19:56:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH 6/9] monitor/hmp-cmds: add 'goto end' to reduce duplicate
 code.
Message-ID: <20200611185606.GB2969@work-vm>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
 <20200603080904.997083-7-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <20200603080904.997083-7-maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Yes OK; I don't particularly like goto's; especially in these simpler
cases, but it's OK.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor/hmp-cmds.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index acdd6baff3..e8cf72eb3a 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1501,8 +1501,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>                                  read_only,
>                                  BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN, &err);
>              if (err) {
> -                hmp_handle_error(mon, err);
> -                return;
> +                goto end;
>              }
>          }
>  
> @@ -1511,6 +1510,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>                                     &err);
>      }
>  
> +end:
>      hmp_handle_error(mon, err);
>  }
>  
> @@ -1629,13 +1629,13 @@ void hmp_object_add(Monitor *mon, const QDict *qdict)
>  
>      opts = qemu_opts_from_qdict(qemu_find_opts("object"), qdict, &err);
>      if (err) {
> -        hmp_handle_error(mon, err);
> -        return;
> +        goto end;
>      }
>  
>      obj = user_creatable_add_opts(opts, &err);
>      qemu_opts_del(opts);
>  
> +end:
>      hmp_handle_error(mon, err);
>  
>      if (obj) {
> -- 
> 2.17.1
> 
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


