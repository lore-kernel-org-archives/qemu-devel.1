Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187B5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F3C20795
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvrtbxaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F3C20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISve-0004b2-8h
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kISl1-0007VK-4i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kISkw-0005bM-CL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600244733;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FmiDxG7EyMCs7YyNrVuHeU0Ntl4VVPuwJoAtctCyH0=;
 b=cvrtbxaNySF7kA9fgPU7D/QqG4YxAaAd4bmMajGKXaeIFcaq9EdZQny6j4otAJrWeL51Mo
 bryVPfciRerkmg9vOAbKQTPZbJWBSCDD1Z3zFeI310ISFBZxyGDbM7zwDLApf2lSm8rkTG
 GuR8VuK0pdsuvNk0vVQFbiCd4penbB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-uwsPSRKFPPKX81wg2q3oQQ-1; Wed, 16 Sep 2020 04:25:31 -0400
X-MC-Unique: uwsPSRKFPPKX81wg2q3oQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7342564089;
 Wed, 16 Sep 2020 08:25:30 +0000 (UTC)
Received: from redhat.com (ovpn-113-248.ams2.redhat.com [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DAA060BE5;
 Wed, 16 Sep 2020 08:25:24 +0000 (UTC)
Date: Wed, 16 Sep 2020 09:25:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 5/9] migration: control whether snapshots are ovewritten
Message-ID: <20200916082522.GB1535709@redhat.com>
References: <20200915113523.2520317-1-berrange@redhat.com>
 <20200915113523.2520317-6-berrange@redhat.com>
 <871rj2uprf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <871rj2uprf.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 09:47:32AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The traditional HMP "savevm" command will overwrite an existing snapshot
> > if it already exists with the requested name. This new flag allows this
> > to be controlled allowing for safer behaviour with a future QMP command.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/migration/snapshot.h | 2 +-
> >  migration/savevm.c           | 4 ++--
> >  monitor/hmp-cmds.c           | 2 +-
> >  replay/replay-snapshot.c     | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
> > index c85b6ec75b..d7db1174ef 100644
> > --- a/include/migration/snapshot.h
> > +++ b/include/migration/snapshot.h
> > @@ -15,7 +15,7 @@
> >  #ifndef QEMU_MIGRATION_SNAPSHOT_H
> >  #define QEMU_MIGRATION_SNAPSHOT_H
> >  
> > -int save_snapshot(const char *name, Error **errp);
> > +int save_snapshot(const char *name, bool overwrite, Error **errp);
> >  int load_snapshot(const char *name, Error **errp);
> >  
> >  #endif
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 76972d69b0..2025e3e579 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2658,7 +2658,7 @@ int qemu_load_device_state(QEMUFile *f)
> >      return 0;
> >  }
> >  
> > -int save_snapshot(const char *name, Error **errp)
> > +int save_snapshot(const char *name, bool overwrite, Error **errp)
> >  {
> >      BlockDriverState *bs;
> >      QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
> > @@ -2685,7 +2685,7 @@ int save_snapshot(const char *name, Error **errp)
> >      }
> >  
> >      /* Delete old snapshots of the same name */
> > -    if (name) {
> > +    if (name && overwrite) {
> >          if (bdrv_all_delete_snapshot(name, false, NULL, errp) < 0) {
> >              return ret;
> >          }
> 
> Are you sure this is sane?
> 
> To see what happens, I set a breakpoint on this function, set overwrite
> to false.  I got a *second* snapshot with the same ID.

Sigh. No, it doesn't do what I was meaning it to, and I forgot to add
a test case for this scenario in the last patch.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


