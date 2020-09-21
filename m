Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA4C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55252206FB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Upc6fJNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55252206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQDA-0000Or-Bt
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKQ3Y-0001BC-4K
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKQ3V-00023R-Qe
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600711008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DElZVDpVrvikhEMqYpemIud3QV2F+LB6/wtUX2RAoUI=;
 b=Upc6fJNQHj2oMkHU2lSDImHwqz/aPeRDwZ8Ob1eECj7jCY+C/M4ktRMobRqoVGA29YzP9j
 nEmDs8D9jR1LbizscKuXRZG2iuNTKEUS4zc1gK0SUfpkldnqzASNo0Nl9HmS5lqjqefqx4
 jR+RH/QQU+GmbA1xFQC8WVxgxUriHrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-r09Dw6GBMHCvDs4K15Q2Fw-1; Mon, 21 Sep 2020 13:56:44 -0400
X-MC-Unique: r09Dw6GBMHCvDs4K15Q2Fw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54AA48015AA;
 Mon, 21 Sep 2020 17:56:43 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2742410013BD;
 Mon, 21 Sep 2020 17:56:41 +0000 (UTC)
Date: Mon, 21 Sep 2020 18:56:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Dov Murik <dovmurik@linux.vnet.ibm.com>
Subject: Re: [PATCH] migration: Truncate state file in xen-save-devices-state
Message-ID: <20200921175639.GP3221@work-vm>
References: <20200921094830.114028-1-dovmurik@linux.vnet.ibm.com>
 <20200921111723.GF3221@work-vm>
 <f1ae6a96-322d-faaf-7ab8-1481cffa7aa7@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <f1ae6a96-322d-faaf-7ab8-1481cffa7aa7@linux.vnet.ibm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: anthony.perard@citrix.com, sstabellini@kernel.org, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dov Murik (dovmurik@linux.vnet.ibm.com) wrote:
> 
> 
> On 21/09/2020 14:17, Dr. David Alan Gilbert wrote:
> > * Dov Murik (dovmurik@linux.vnet.ibm.com) wrote:
> > > When running the xen-save-devices-state QMP command, if the filename
> > > already exists it will be truncated before dumping the devices' state
> > > into it.
> > > 
> > > Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> > > ---
> > 
> > OK, that looks fine to me, so:
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> > > 
> > > Note that I found the above issue while trying to debug
> > > xen-load-devices-state which simply fails (prints "Configuration section
> > > missing" to stderr) directly after xen-save-devices-state (in the same
> > > VM).  I wonder if I should file a bug report as-is or investigate some
> > > more.  Advice welcome.
> > 
> > I don't try the xen-* commands normally; I've cc'ing in Stefano and
> > Anthony.
> 
> Thanks Dave.  Just to be clear, I'm running this without Xen at all; but
> these commands seem to work OK for dumping/restoring guest's devices
> state (without RAM) -- if I modify the code to circumvent the mentioned
> problem.

Yeh, although you can't rely on them not doing something Xen in the
future.  There are a few other similar ways of doing what you want; eg.
if your RAM is 'shared' then you can set the x-ignore-shared migration
capability.

Dave

> Dov
> 
> > 
> > Dave
> > 
> > > 
> > > -Dov
> > > 
> > > ---
> > >   migration/savevm.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 304d98ff78..e1b26672cc 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -2803,7 +2803,8 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
> > >       vm_stop(RUN_STATE_SAVE_VM);
> > >       global_state_store_running();
> > > -    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT, 0660, errp);
> > > +    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT | O_TRUNC,
> > > +                                    0660, errp);
> > >       if (!ioc) {
> > >           goto the_end;
> > >       }
> > > -- 
> > > 2.20.1
> > > 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


