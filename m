Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978C6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B4A2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvkehilX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B4A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaeNU-0001CG-Hd
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 07:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jaeMw-0000kw-4m
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:55:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jaeMv-0000SC-B4
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589802940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUCUZ9NJwN4WFfrHpcgbGGTP3TYy4s6wVLw1GDd8SZs=;
 b=hvkehilXn33spmPtZq0GH7CHxB6duSs9h/sZGhGEMDHbSE48tlad3NfQ9O+Xu6WT3Ix1MX
 5tDz+5bW+V4Fuv3dun5E5xpvRQN8bBcYqsQQzJeHegHpK57oBPsFNSzPnTYVf/VKd3pkHF
 P7MteRdY5s9SnrOVpRN4HmMYUbWKk/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-_vl_JODRMdmnrbej8Y_UXw-1; Mon, 18 May 2020 07:55:38 -0400
X-MC-Unique: _vl_JODRMdmnrbej8Y_UXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E21A3800D24;
 Mon, 18 May 2020 11:55:37 +0000 (UTC)
Received: from work-vm (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1CC1579A5;
 Mon, 18 May 2020 11:55:36 +0000 (UTC)
Date: Mon, 18 May 2020 12:55:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= 5/6]
 migration/qemu-file.c: Don't ratelimit a shutdown fd
Message-ID: <20200518115534.GD2786@work-vm>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <f3ea4250e6982598ffffc73924a6917dbc823c87.1589193382.git.lukasstraub2@web.de>
 <1dc261c8dce6421b80071c0eb3528afd@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1dc261c8dce6421b80071c0eb3528afd@huawei.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_HK_NAME_DR=0.01,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> > This causes the migration thread to hang if we failover during checkpoint. A
> > shutdown fd won't cause network traffic anyway.
> > 
> 
> I'm not quite sure if this modification can take side effect on normal migration process or not,
> There are several places calling it.
> 
> Maybe Juan and Dave can help ;)
> 
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  migration/qemu-file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c index
> > 1c3a358a14..0748b5810f 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -660,7 +660,7 @@ int64_t qemu_ftell(QEMUFile *f)  int
> > qemu_file_rate_limit(QEMUFile *f)  {
> >      if (f->shutdown) {
> > -        return 1;
> > +        return 0;
> >      }

This looks wrong to me; I'd be curious to understand how it's hanging
for you.
'1' means 'stop what you're doing', 0 means carry on; carrying on with a
shutdown fd sounds wrong.

If we look at ram.c we have:

        while ((ret = qemu_file_rate_limit(f)) == 0 ||
                !QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
            int pages;
        ....

so if it returns '1', as it does at the moment it should cause it to
exit the ram_save_iterate loop - which is what we want if it's failing.
Thus I think you need to find the actual place it's stuck in this case -
I suspect it's repeatedly calling ram_save_iterate and then exiting it,
but if that's happening perhaps we're missing a qemu_file_get_error
check somewhere.

Dave

> >      if (qemu_file_get_error(f)) {
> >          return 1;
> > --
> > 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


