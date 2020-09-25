Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA308C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B082075E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlD4lbvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B082075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLm1M-0005pe-BK
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 07:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLm0f-000505-UH
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 07:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLm0e-0000Et-2o
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 07:35:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601033727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wbKWqSEdwRPS+cJHs9ki71kWr+XRUJYMEk4oqcfksU=;
 b=XlD4lbvfbXLDDmDreNowoWxIFzodZTEb7W0FS2KYSZ8freJUk4cqU56VnFUdI/n2BYl45v
 8C4dXimoiTTe8zRY0tdHBe7/A9hECkMWcL5Qf2pretCletth7a5/Z7L2SCbPH19kuHnzly
 W+IHzj7vEPUcE5+LAxU0ThB9ORejNz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-gfPK_doGP_2s_yA2HJ5mxg-1; Fri, 25 Sep 2020 07:35:24 -0400
X-MC-Unique: gfPK_doGP_2s_yA2HJ5mxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 738CF871805;
 Fri, 25 Sep 2020 11:35:23 +0000 (UTC)
Received: from work-vm (ovpn-114-177.ams2.redhat.com [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21FD91002C1B;
 Fri, 25 Sep 2020 11:35:14 +0000 (UTC)
Date: Fri, 25 Sep 2020 12:35:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [Virtio-fs] tools/virtiofs: Multi threading seems to hurt
 performance
Message-ID: <20200925113512.GH2873@work-vm>
References: <20200918213436.GA3520@redhat.com>
 <CAJFHJroSeg=Zk1VaHBzwurNTkziFzupiiVf_Y-2TDQ7nmdAERg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJFHJroSeg=Zk1VaHBzwurNTkziFzupiiVf_Y-2TDQ7nmdAERg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chirantan Ekbote (chirantan@chromium.org) wrote:
> On Sat, Sep 19, 2020 at 6:36 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Hi All,
> >
> > virtiofsd default thread pool size is 64. To me it feels that in most of
> > the cases thread pool size 1 performs better than thread pool size 64.
> >
> > I ran virtiofs-tests.
> >
> > https://github.com/rhvgoyal/virtiofs-tests
> >
> > And here are the comparision results. To me it seems that by default
> > we should switch to 1 thread (Till we can figure out how to make
> > multi thread performance better even when single process is doing
> > I/O in client).
> >
> 
> FWIW, we've observed the same behavior in crosvm. Using a thread pool
> for the virtiofs server consistently gave us worse performance than
> using a single thread.

Interesting; so it's not just us doing something silly!
It does feel like you *should* be able to get some benefit from multiple
threads; so I guess some more investigation needed at some time.

Dave

> Chirantan
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


