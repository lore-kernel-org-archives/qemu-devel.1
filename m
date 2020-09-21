Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FBDC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E9120B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CThh/R1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E9120B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMXw-0007ai-3T
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKMUf-0004n1-8g
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKMUb-0000HN-7N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600697311;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1PnikJiiMlxy1QIzox8ciiXQ7dXimCZr1Qzu5ah74Lg=;
 b=CThh/R1SwQaWAzE06uBJHreYAmfFxJPjLstZKgNWPE38+r5IfQ0H0GrbkbDqY+aKqHk6hx
 6+Zz1T+CM6yH7+hHHbFZaGybvEncFr4z7A/1O6sApMyTl5y4z2EbHmWdyAKNAH0ndKGIhe
 b9vEBnNaloG6k84Yh1BMCIwzQ0IQwmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-O9CLcebQPzWKbWDown5zkg-1; Mon, 21 Sep 2020 10:08:22 -0400
X-MC-Unique: O9CLcebQPzWKbWDown5zkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCCC3100559C
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 14:08:21 +0000 (UTC)
Received: from redhat.com (ovpn-113-113.ams2.redhat.com [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 539AA5DEBB;
 Mon, 21 Sep 2020 14:08:06 +0000 (UTC)
Date: Mon, 21 Sep 2020 15:08:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200921140803.GN1942072@redhat.com>
References: <20200918213436.GA3520@redhat.com> <20200921085019.GB3221@work-vm>
 <20200921133516.GA13362@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921133516.GA13362@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: virtio-fs-list <virtio-fs@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 09:35:16AM -0400, Vivek Goyal wrote:
> On Mon, Sep 21, 2020 at 09:50:19AM +0100, Dr. David Alan Gilbert wrote:
> > * Vivek Goyal (vgoyal@redhat.com) wrote:
> > > Hi All,
> > > 
> > > virtiofsd default thread pool size is 64. To me it feels that in most of
> > > the cases thread pool size 1 performs better than thread pool size 64.
> > > 
> > > I ran virtiofs-tests.
> > > 
> > > https://github.com/rhvgoyal/virtiofs-tests
> > > 
> > > And here are the comparision results. To me it seems that by default
> > > we should switch to 1 thread (Till we can figure out how to make
> > > multi thread performance better even when single process is doing
> > > I/O in client).
> > > 
> > > I am especially more interested in getting performance better for
> > > single process in client. If that suffers, then it is pretty bad.
> > > 
> > > Especially look at randread, randwrite, seqwrite performance. seqread
> > > seems pretty good anyway.
> > > 
> > > If I don't run who test suite and just ran randread-psync job,
> > > my throughput jumps from around 40MB/s to 60MB/s. That's a huge
> > > jump I would say.
> > > 
> > > Thoughts?
> > 
> > What's your host setup; how many cores has the host got and how many did
> > you give the guest?
> 
> Got 2 processors on host with 16 cores in each processor. With
> hyperthreading enabled, it makes 32 logical cores on each processor and
> that makes 64 logical cores on host.
> 
> I have given 32 to guest.

FWIW, I'd be inclined to disable hyperthreading in the BIOS for one
test to validate whether it is impacting performance results seen.
Hyperthreads are weak compared to a real CPU, and could result in
misleading data even if you are limiting your guest to 1/2 the host
logical CPUs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


