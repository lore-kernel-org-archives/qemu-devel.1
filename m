Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E1C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACF82072E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxR3TYSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACF82072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNezN-0006c4-IG
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNex1-0005QY-7o
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNewy-00053T-Cb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:27:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601483247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TL8akQLFmHomRZTeBE+lrXizsD6oui0EMhFHMQwqMOc=;
 b=SxR3TYSITOt0vYDA23y8L9CXVb1fNiXP13OMbMzfb91rW+oOBsILt5Wy2qcgL4BM6AyzQN
 a/0YbwnFBZDitwqN0Mp/ahXT6yoMi/mNlogJRnoiWDH1UTSF/zWMH3nl5jWgPAg//XNc06
 rJ1SnO+dqxlq/Dg9pM2gTZvgYj63K6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-csdqnFfQOFis3XHeX_Fw-A-1; Wed, 30 Sep 2020 12:24:19 -0400
X-MC-Unique: csdqnFfQOFis3XHeX_Fw-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 631B21084C80;
 Wed, 30 Sep 2020 16:24:17 +0000 (UTC)
Received: from work-vm (ovpn-114-238.ams2.redhat.com [10.36.114.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E47C565F5E;
 Wed, 30 Sep 2020 16:24:12 +0000 (UTC)
Date: Wed, 30 Sep 2020 17:24:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/4] qemu-io-cmds: avoid gcc 10 warning
Message-ID: <20200930162410.GC2783@work-vm>
References: <20200930155859.303148-1-borntraeger@de.ibm.com>
 <20200930155859.303148-4-borntraeger@de.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200930155859.303148-4-borntraeger@de.ibm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> With gcc 10 on Fedora32 I do get:
> 
> Compiling C object libblock.fa.p/qemu-io-cmds.c.o
> In file included from /usr/include/stdio.h:867,
>                  from /home/cborntra/REPOS/qemu/include/qemu/osdep.h:85,
>                  from ../qemu-io-cmds.c:11:
> In function ‘printf’,
>     inlined from ‘help_oneline’ at ../qemu-io-cmds.c:2389:9,
>     inlined from ‘help_all’ at ../qemu-io-cmds.c:2414:9,
>     inlined from ‘help_f’ at ../qemu-io-cmds.c:2424:9:
> /usr/include/bits/stdio2.h:107:10: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
>   107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Let us check for null.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

I'd already posted
'qemu-io-cmds: Simplify help_oneline' that simplifies
this function much more; Kevin picked that up for the block branch a
couple of days ago.

Dave


> ---
>  qemu-io-cmds.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index baeae86d8c85..c2080aa398a9 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -2386,7 +2386,9 @@ static void help_oneline(const char *cmd, const cmdinfo_t *ct)
>      if (cmd) {
>          printf("%s ", cmd);
>      } else {
> -        printf("%s ", ct->name);
> +        if (ct->name) {
> +            printf("%s ", ct->name);
> +        }
>          if (ct->altname) {
>              printf("(or %s) ", ct->altname);
>          }
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


