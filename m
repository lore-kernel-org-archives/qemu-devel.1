Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60935C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE32620829
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3ueelly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE32620829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNY4-0000bM-NR
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXN81-00071c-Dq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXN7z-0006gk-OS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603798018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkCAJl7bBMwMCvdHq7hbk1BLS6ZbMlCcd+iimsKeKzM=;
 b=Z3ueellyG9Y6Niq7wXDpNyc9nDLCmJj3KwYdrWcmp90IOulrHZpYIvlKwQZLFFirhMynk5
 7AeRXXZEY1aTU0wlIGPLVZJXXDUfPJ8AAbM+gOVQwuy0EXhEKRcmY4hGZHqsf0p7QsdwDN
 xICh3k6SUY+zAWnA0PB0pneajLpwxko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-poalefKbOh-J4bhL0SPNtw-1; Tue, 27 Oct 2020 07:26:56 -0400
X-MC-Unique: poalefKbOh-J4bhL0SPNtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D29B2809DC9;
 Tue, 27 Oct 2020 11:26:55 +0000 (UTC)
Received: from redhat.com (ovpn-115-179.ams2.redhat.com [10.36.115.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 838865D9DD;
 Tue, 27 Oct 2020 11:26:47 +0000 (UTC)
Date: Tue, 27 Oct 2020 07:26:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Gibson <dgibson@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201027072430-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <20201026174537.128a4173@yekko.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 05:45:37PM +1100, David Gibson wrote:
> On Fri, 23 Oct 2020 09:26:48 +0300
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
> 
> > Hi Michael,
> > 
> > On Thu, Oct 22, 2020 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> >  [...]  
> > Simplistic does not mean wrong or incorrect.
> > I fail to see why it is not enough.
> > 
> > What QEMU can do better? Wait an unbounded time for the blinking to finish?
> 
> It certainly shouldn't wait an unbounded time.  But a wait with timeout
> seems worth investigating to me.

If it's helpful, I'd add a query to check state
so management can figure out why doesn't guest see device yet.
But otherwise just buffer the request until such time as
we can deliver it to guest ...


> > What if we have a buggy guest with a kernel stuck in blinking?
> > Is QEMU's responsibility to emulate the operator itself? Because the
> > operator
> > is the one who is supposed to wait.
> > 
> > 
> > Thanks,
> > Marcel
> > 
> > [...]
> 
> 
> -- 
> David Gibson <dgibson@redhat.com>
> Principal Software Engineer, Virtualization, Red Hat



