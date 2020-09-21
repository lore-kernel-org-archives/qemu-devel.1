Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8A2C4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FDC23A6B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fryisHvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FDC23A6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKVWT-00046E-5V
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 19:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1kKVVh-0003fb-5D
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1kKVVf-0003uX-Br
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:46:16 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0265A23A65;
 Mon, 21 Sep 2020 23:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600731971;
 bh=787xebecrPi0gb3hcV0ivWfnEknCH+707PnyNQKMYlc=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=fryisHvyDKVeLD4Jug1+DJF7xBpf31KPWYzT39KLRnblJvxqlvUTQgvv+PjCSlaHr
 0C94jTu69T7W6VVQpqMOpznfvbhpEWWREuPElqzPxBMzchHxM+E+xS1za5Y8NI/B+Y
 pBmEVFSXrAz0uto0B6yrUh+w68ctPjWjYCSNSgHg=
Date: Mon, 21 Sep 2020 16:46:10 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration: Truncate state file in xen-save-devices-state
In-Reply-To: <20200921175639.GP3221@work-vm>
Message-ID: <alpine.DEB.2.21.2009211645530.1495@sstabellini-ThinkPad-T480s>
References: <20200921094830.114028-1-dovmurik@linux.vnet.ibm.com>
 <20200921111723.GF3221@work-vm>
 <f1ae6a96-322d-faaf-7ab8-1481cffa7aa7@linux.vnet.ibm.com>
 <20200921175639.GP3221@work-vm>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 19:46:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: sstabellini@kernel.org, Paul Durrant <paul@xen.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, anthony.perard@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding Paul


On Mon, 21 Sep 2020, Dr. David Alan Gilbert wrote:
> * Dov Murik (dovmurik@linux.vnet.ibm.com) wrote:
> > 
> > 
> > On 21/09/2020 14:17, Dr. David Alan Gilbert wrote:
> > > * Dov Murik (dovmurik@linux.vnet.ibm.com) wrote:
> > > > When running the xen-save-devices-state QMP command, if the filename
> > > > already exists it will be truncated before dumping the devices' state
> > > > into it.
> > > > 
> > > > Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> > > > ---
> > > 
> > > OK, that looks fine to me, so:
> > > 
> > > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > 
> > > > 
> > > > Note that I found the above issue while trying to debug
> > > > xen-load-devices-state which simply fails (prints "Configuration section
> > > > missing" to stderr) directly after xen-save-devices-state (in the same
> > > > VM).  I wonder if I should file a bug report as-is or investigate some
> > > > more.  Advice welcome.
> > > 
> > > I don't try the xen-* commands normally; I've cc'ing in Stefano and
> > > Anthony.
> > 
> > Thanks Dave.  Just to be clear, I'm running this without Xen at all; but
> > these commands seem to work OK for dumping/restoring guest's devices
> > state (without RAM) -- if I modify the code to circumvent the mentioned
> > problem.
> 
> Yeh, although you can't rely on them not doing something Xen in the
> future.  There are a few other similar ways of doing what you want; eg.
> if your RAM is 'shared' then you can set the x-ignore-shared migration
> capability.
> 
> Dave
> 
> > Dov
> > 
> > > 
> > > Dave
> > > 
> > > > 
> > > > -Dov
> > > > 
> > > > ---
> > > >   migration/savevm.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > > index 304d98ff78..e1b26672cc 100644
> > > > --- a/migration/savevm.c
> > > > +++ b/migration/savevm.c
> > > > @@ -2803,7 +2803,8 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
> > > >       vm_stop(RUN_STATE_SAVE_VM);
> > > >       global_state_store_running();
> > > > -    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT, 0660, errp);
> > > > +    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT | O_TRUNC,
> > > > +                                    0660, errp);
> > > >       if (!ioc) {
> > > >           goto the_end;
> > > >       }
> > > > -- 
> > > > 2.20.1
> > > > 
> > 
> -- 
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

