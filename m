Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAAAC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F038521D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6XGKTOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F038521D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4Qf-0005yN-RZ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kL4NL-00050e-CY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kL4NI-0000nZ-VP
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600865995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/D5l8yUp/CsLM9H2PxEKgFCFjyndRMLLGgcLXkl2hA=;
 b=L6XGKTOvtyj1E75ZCwH3/whkcbnUNIQBWZ1JQ0TxptyOv0aDWhle4PL3kU0lpdntGyXEk5
 IJtAeuVDuZCHEz6wRzSwktp58hYytMRcu1yl87YAhdN+MMsaR97RKL69cd8oEVKk0yDXNg
 +sk1byyw4RibpcnAN/xJ1CqZ/4zW+iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-O8iTrRj0McWcZSltn57yOA-1; Wed, 23 Sep 2020 08:59:53 -0400
X-MC-Unique: O8iTrRj0McWcZSltn57yOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB37B1021205;
 Wed, 23 Sep 2020 12:59:52 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-176.rdu2.redhat.com [10.10.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3F0C73668;
 Wed, 23 Sep 2020 12:59:49 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 27942223B13; Wed, 23 Sep 2020 08:59:49 -0400 (EDT)
Date: Wed, 23 Sep 2020 08:59:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [Virtio-fs] tools/virtiofs: Multi threading seems to hurt
 performance
Message-ID: <20200923125949.GA88270@redhat.com>
References: <20200918213436.GA3520@redhat.com>
 <CAJFHJroSeg=Zk1VaHBzwurNTkziFzupiiVf_Y-2TDQ7nmdAERg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJFHJroSeg=Zk1VaHBzwurNTkziFzupiiVf_Y-2TDQ7nmdAERg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vgoyal@redhat.com;
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 09:50:59PM +0900, Chirantan Ekbote wrote:
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

Thanks for sharing this information Chirantan. Shared pool seems to
perform better than exclusive pool. Single thread vs shared pool is
sort of mixed result but it looks like one thread beats shared pool
results in many of the tests.

May be we will have to swtich to single thread as default at some point
of time if shared pool does not live up to the expectations.

Vivek


