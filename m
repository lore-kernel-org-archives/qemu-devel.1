Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8627C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1984D206FB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPz/hW7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1984D206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLA0Y-0004kM-Od
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kL9z7-0004IF-7O
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kL9z4-0004UB-DP
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600887557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EvvKnHN55uswRIt1/KVKg2ByHdM7TnwpCrcplgbZqkg=;
 b=fPz/hW7EWWkJKbDE8ti2Ta+MZv2WH0oB9KHtZ0DbmT8n1iXCg3Dmi/bwEbvJdv+hhZlWgA
 ynzIBgGFvgX+aEKd5N4CKvZ/rUykP6ccUApRFfQIIVDIoUbAuUrfO4zE9q6pzcdEdK6yhV
 8HuklV3THkAczcVyja2N++QQu8gwoKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-LdJ3d8QBN-ewXWBsK8OdUg-1; Wed, 23 Sep 2020 14:59:14 -0400
X-MC-Unique: LdJ3d8QBN-ewXWBsK8OdUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95FE2802B78;
 Wed, 23 Sep 2020 18:59:13 +0000 (UTC)
Received: from work-vm (ovpn-113-46.ams2.redhat.com [10.36.113.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4148719728;
 Wed, 23 Sep 2020 18:59:12 +0000 (UTC)
Date: Wed, 23 Sep 2020 19:59:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Dov Murik <dovmurik@linux.vnet.ibm.com>, sstabellini@kernel.org,
 anthony.perard@citrix.com
Subject: Re: [PATCH] migration: Truncate state file in xen-save-devices-state
Message-ID: <20200923185909.GA150308@work-vm>
References: <20200921094830.114028-1-dovmurik@linux.vnet.ibm.com>
 <20200921111723.GF3221@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200921111723.GF3221@work-vm>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Dov Murik (dovmurik@linux.vnet.ibm.com) wrote:
> > When running the xen-save-devices-state QMP command, if the filename
> > already exists it will be truncated before dumping the devices' state
> > into it.
> > 
> > Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> > ---
> 
> OK, that looks fine to me, so:
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> > 
> > Note that I found the above issue while trying to debug
> > xen-load-devices-state which simply fails (prints "Configuration section
> > missing" to stderr) directly after xen-save-devices-state (in the same
> > VM).  I wonder if I should file a bug report as-is or investigate some
> > more.  Advice welcome.
> 
> I don't try the xen-* commands normally; I've cc'ing in Stefano and
> Anthony.
> 
> Dave
> 
> > 
> > -Dov
> > 
> > ---
> >  migration/savevm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 304d98ff78..e1b26672cc 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2803,7 +2803,8 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
> >      vm_stop(RUN_STATE_SAVE_VM);
> >      global_state_store_running();
> >  
> > -    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT, 0660, errp);
> > +    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT | O_TRUNC,
> > +                                    0660, errp);
> >      if (!ioc) {
> >          goto the_end;
> >      }
> > -- 
> > 2.20.1
> > 
> -- 
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


