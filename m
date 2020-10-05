Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1954CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E997206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTERyAwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E997206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOpz-0002Jh-6r
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 07:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPOoQ-0001Lc-LW
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 07:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPOoM-0007dE-Pf
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 07:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601897865;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qk+SFyBVdivTyRtoQPIJcXegG5qJ9PzIJfMCacsEiI=;
 b=JTERyAwdugt0n5bwlgpa+9nVYxHy9uhe01wBU2VB0VUig+XrglXs/qlPn9CaB95NAQ3WBE
 TYtGkKfemeyArVyCkY81lFVsMwBAA8dCqhr7YANaO0cvQKeej3UXJuncOSOV0dnipJdlZM
 6jL1d9YldO7Zvvt9BRn/ArrUCf/IAMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-HA5aQ3OMPjOIhR8_knRWCA-1; Mon, 05 Oct 2020 07:37:42 -0400
X-MC-Unique: HA5aQ3OMPjOIhR8_knRWCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04BAD1DDFD;
 Mon,  5 Oct 2020 11:37:41 +0000 (UTC)
Received: from redhat.com (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0387C5C1BD;
 Mon,  5 Oct 2020 11:37:37 +0000 (UTC)
Date: Mon, 5 Oct 2020 12:37:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 10/10] migration: introduce
 snapshot-{save,load,delete} QMP commands
Message-ID: <20201005113735.GI2385272@redhat.com>
References: <20201002162747.3123597-1-berrange@redhat.com>
 <20201002162747.3123597-11-berrange@redhat.com>
 <ef01ef63-7b95-88c2-5d31-103d29f9f64f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ef01ef63-7b95-88c2-5d31-103d29f9f64f@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 02:46:07PM -0500, Eric Blake wrote:
> On 10/2/20 11:27 AM, Daniel P. Berrangé wrote:
> > savevm, loadvm and delvm are some of the few HMP commands that have never
> > been converted to use QMP. The reasons for the lack of conversion are
> > that they blocked execution of the event thread, and the semantics
> > around choice of disks were ill-defined.
> > 
> > Despite this downside, however, libvirt and applications using libvirt
> > have used these commands for as long as QMP has existed, via the
> > "human-monitor-command" passthrough command. IOW, while it is clearly
> > desirable to be able to fix the problems, they are not a blocker to
> > all real world usage.
> > 
> > Meanwhile there is a need for other features which involve adding new
> > parameters to the commands. This is possible with HMP passthrough, but
> > it provides no reliable way for apps to introspect features, so using
> > QAPI modelling is highly desirable.
> > 
> > This patch thus introduces new snapshot-{load,save,delete} commands to
> > QMP that are intended to replace the old HMP counterparts. The new
> > commands are given different names, because they will be using the new
> > QEMU job framework and thus will have diverging behaviour from the HMP
> > originals. It would thus be misleading to keep the same name.
> > 
> > While this design uses the generic job framework, the current impl is
> > still blocking. The intention that the blocking problem is fixed later.
> > None the less applications using these new commands should assume that
> > they are asynchronous and thus wait for the job status change event to
> > indicate completion.
> > 
> > In addition to using the job framework, the new commands require the
> > caller to be explicit about all the block device nodes used in the
> > snapshot operations, with no built-in default heuristics in use.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---

> > +++ b/tests/qemu-iotests/group
> > @@ -291,6 +291,7 @@
> >  277 rw quick
> >  279 rw backing quick
> >  280 rw migration quick
> > +310 rw quick
> >  281 rw quick
> >  282 rw img quick
> >  283 auto quick
> 
> What's wrong with sorted order? I get the renumbering to appease a merge
> conflict, but it also requires rearrangement ;)

This file is a conflict magnet when rebasing to git master if you just
append to the end of it. So I picked a number many bigger than current
max, and stuffed the new entry in the middle to avoid rebase conflicts.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


