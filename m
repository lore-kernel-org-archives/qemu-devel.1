Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D13C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7402311C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9+bDNuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7402311C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmLx-0005WV-CR
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKmKF-0004Hl-Tp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKmKD-0003oL-V7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600796613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G1GH/JQo7RHlFBngpw8Fg8Gnzl+blDAxAJqYRY8uo64=;
 b=S9+bDNuLHLsIKJD8YtDpAcXoeZGs4e5V6g18unNQJZ1l+W9H82evb5w3TpQBdFiCjfNEee
 sHKt9f+TcvfsqSOP2qIVU4D9MRCfZFP8KQonWNFyA3nDqtlh84O/neqmh42hmIuYk06uM/
 /iJ5tDHDbIjfGND3wkp8Uwwn4z59lkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-vaT7caujOVC0DZFEnPITDQ-1; Tue, 22 Sep 2020 13:43:11 -0400
X-MC-Unique: vaT7caujOVC0DZFEnPITDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAF56186DD28;
 Tue, 22 Sep 2020 17:43:10 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-78.rdu2.redhat.com [10.10.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4270A7EEDA;
 Tue, 22 Sep 2020 17:42:59 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 85842223B13; Tue, 22 Sep 2020 13:42:55 -0400 (EDT)
Date: Tue, 22 Sep 2020 13:42:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] virtiofsd: Used glib "shared" thread pool
Message-ID: <20200922174255.GC57620@redhat.com>
References: <20200921213216.GE13362@redhat.com>
 <20200922125957.GN1989025@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922125957.GN1989025@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 01:59:57PM +0100, Daniel P. Berrangé wrote:
> On Mon, Sep 21, 2020 at 05:32:16PM -0400, Vivek Goyal wrote:
> > glib offers thread pools and it seems to support "exclusive" and "shared"
> > thread pools.
> > 
> > https://developer.gnome.org/glib/stable/glib-Thread-Pools.html#g-thread-pool-new
> > 
> > Currently we use "exlusive" thread pools but its performance seems to be
> > poor. I tried using "shared" thread pools and performance seems much
> > better. I posted performance results here.
> > 
> > https://www.redhat.com/archives/virtio-fs/2020-September/msg00080.html
> > 
> > So lets switch to shared thread pools. We can think of making it optional
> > once somebody can show in what cases exclusive thread pools offer better
> > results. For now, my simple performance tests across the board see
> > better results with shared thread pools.
> 
> I'm really curious why  there's any perf difference between shared and
> exclusive thread pools in the GLib impl.
> 
> Looking at the code the main difference between the two is appears to
> be around the way threads are spawned, specifically around the scheduler
> attributes assigned.
> 
> In the shared case, the threads in the pool will have their scheduler
> attributes copied from the very first thread that calls g_thread_pool_new.
> 
> In the exclusive case, the threads in the pool will inherit their
> scheduler attributes from the thread which pushs the job that
> causes the worker thread to be created.
> 
> By schedular attributes, I mean all the items in the 'struct schedattr'
> filled by sched_getattr()
> 
> IOW, if threads in virtiofsd have varying schedular attributes this
> could possibly explain the difference in performance you see between
> the two setups.

Hi Daniel,

Few things.

- I think scheduler attributes are same for the thread creating
  pool as well as for thread pushing the job for virtiofsd.

- My glib2 is old (2.58.3) and I think that did not have sched_getattr()
  stuff.

- One difference I noticed is that in case of shared pool, it does not
  create extra threads if client is doing one request at a time. While
  exclusive pool seemed to push every request to a new thread in pool
  in sort of round robin fashion. It feels keeping requests being served
  from same thread helps in this particilar workload case.

Thanks
Vivek

> 
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  tools/virtiofsd/fuse_virtio.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: qemu/tools/virtiofsd/fuse_virtio.c
> > ===================================================================
> > --- qemu.orig/tools/virtiofsd/fuse_virtio.c	2020-09-21 17:28:27.444438015 -0400
> > +++ qemu/tools/virtiofsd/fuse_virtio.c	2020-09-21 17:28:30.584568910 -0400
> > @@ -695,7 +695,7 @@ static void *fv_queue_thread(void *opaqu
> >      struct fuse_session *se = qi->virtio_dev->se;
> >      GThreadPool *pool;
> >  
> > -    pool = g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size, TRUE,
> > +    pool = g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size, FALSE,
> >                               NULL);
> >      if (!pool) {
> >          fuse_log(FUSE_LOG_ERR, "%s: g_thread_pool_new failed\n", __func__);
> > 
> > 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


