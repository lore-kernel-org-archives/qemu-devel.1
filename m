Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35ABC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0947D247CD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMM0HBmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0947D247CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnZw-0000C0-1m
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kXnYQ-0006qs-6K
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kXnYN-0000x2-AQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603899596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQr/+w7gmmQQjVLPDM+Lfjl5BNSt8sDQkPHf06FLgk0=;
 b=dMM0HBmSOPV72sxyJX+/HAj8/zlGbL/jIg9xo7H30FbdxJ0lPzKirfU7ekV5OSNKL1Thnp
 Xny8sgvH8tc5KIHBN4eJNJGvuxIMefFaaS+06SAgisvZHS8ybXehURLDjsZe1JXg4NHYHo
 ZV8XxE3t6O0a0cSnvJWyBnZ7A63D5DQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-8Kz06wECO9GeHOYFnYK3TQ-1; Wed, 28 Oct 2020 11:39:54 -0400
X-MC-Unique: 8Kz06wECO9GeHOYFnYK3TQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8ADD18C9F45
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 15:39:53 +0000 (UTC)
Received: from localhost (unknown [10.40.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC8A36EF40;
 Wed, 28 Oct 2020 15:39:46 +0000 (UTC)
Date: Wed, 28 Oct 2020 16:39:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: David Gibson <dgibson@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201028163945.64eacc81@redhat.com>
In-Reply-To: <20201028143135.51c0a918@yekko.fritz.box>
References: <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <CAC_L=vUgsh=08m8EEuEucRtdX73X5kw5ov4Ekg7jFjbHsU6f2w@mail.gmail.com>
 <20201026174537.128a4173@yekko.fritz.box>
 <20201027072430-mutt-send-email-mst@kernel.org>
 <20201027135426.765dd19b@redhat.com>
 <20201028143135.51c0a918@yekko.fritz.box>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 14:31:35 +1100
David Gibson <dgibson@redhat.com> wrote:

> On Tue, 27 Oct 2020 13:54:26 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Tue, 27 Oct 2020 07:26:44 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> >  [...]  
> >  [...]  
> >  [...]  
> > [...]
> >  [...]    
> > > > 
> > > > It certainly shouldn't wait an unbounded time.  But a wait with timeout
> > > > seems worth investigating to me.      
> > racy, timeout is bound to break once it's in overcommited env.  
> 
> Hm.  That's no less true at the management layer than it is at the qemu
> layer.
true, but it's user policy which is defined by user not by QEMU.

> 
> > > If it's helpful, I'd add a query to check state
> > > so management can figure out why doesn't guest see device yet.    
> > that means mgmt would have to poll it and forward it to user
> > somehow.  
> 
> If that even makes sense.  In the case of Kata, it's supposed to be
> autonomously creating the VM, so there's nothing meaningful it can
> forward to the user other than "failed to create the container because
> of some hotplug problem that means nothing to you".
> 
> >  [...]  
> > I have more questions wrt the suggestion/workflow:
> > * at what place would you suggest buffering it?
> > * what would be the request in this case, i.e. create PCI device anyways
> > and try to signal hotplug event later?
> > * what would baremethal do in such case?
> > * what to do in case guest is never ready, what user should do in such case?
> > * can be such device be removed?
> > 
> > not sure that all of this is worth of the effort and added complexity.
> > 
> > alternatively:
> > maybe ports can send QMP events about it's state changes, which end user would
> > be able to see + error like in this patch.
> > 
> > On top of it, mgmt could build a better UIx, like retry/notify logic if
> > that's what user really wishes for and configures (it would be up to user to
> > define behaviour).  
> 
> That kind of makes sense if the user is explicitly requesting hotplugs,
> but that's not necessarily the case.
user doesn't have to be a human, it could be some mgmt layer that would
automate retry logic, depending on what actually user needs for particular task
(i.e. fail immediately, retry N time then fail, retry with time out - then fail,
don't care - succeed, ...). The point is for QEMU to provide means for mgmt to
implement whatever policy user would need.

PS:
but then, I know close to nothing about PCI, so all of above might be nonsense.


