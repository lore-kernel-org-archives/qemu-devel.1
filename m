Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E35DC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701BD21534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqAmYFfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701BD21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLLm-0004uM-Ce
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJL2V-0001FI-0b
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJL2Q-00053g-Sd
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600453392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jq9l+kzdow5XorcSZvdmI7GZ6zKMEcNZ1n30x4cnL6A=;
 b=fqAmYFfT2rqhgXJ39gefzbpxYjqCaDFbCsYm6prHU8vQxylFOiMeyGeT/jDU389cOaCuet
 JNFCrOZ0bslwU1vnri4vajtiMSEAO/jUmcK9yAQbhtnmhyeczbtCINmJhzTbhMqO4XwUQ4
 VGnP92FzVBuD6Ox6h9bMIUXQiickNWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-LSLnktNPM6S2hlgI4Gel1g-1; Fri, 18 Sep 2020 14:23:08 -0400
X-MC-Unique: LSLnktNPM6S2hlgI4Gel1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D00C1084D78;
 Fri, 18 Sep 2020 18:23:07 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFD649CBA;
 Fri, 18 Sep 2020 18:23:04 +0000 (UTC)
Date: Fri, 18 Sep 2020 14:23:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 0/3] qom: Replace INTERFACE_CHECK with OBJECT_CHECK
Message-ID: <20200918182303.GE7594@habkost.net>
References: <20200916193101.511600-1-ehabkost@redhat.com>
 <CAJ+F1CLo=mz6LhRTx0PTF-NiabiaCNwm-U=7VEhQXUmryQoqvw@mail.gmail.com>
 <40730966-469a-de4d-29bd-03c7c409b3cf@redhat.com>
 <CAJ+F1CL+mBt3c+GW3DPcfJROrpxWFFM_4vXGQqRb+E9ceS7cag@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL+mBt3c+GW3DPcfJROrpxWFFM_4vXGQqRb+E9ceS7cag@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 11:25:30AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Sep 17, 2020 at 11:19 AM Philippe Mathieu-Daudé <philmd@redhat.com>
> wrote:
> 
> > On 9/16/20 11:31 PM, Marc-André Lureau wrote:
> > > Hi
> > >
> > > On Wed, Sep 16, 2020 at 11:35 PM Eduardo Habkost <ehabkost@redhat.com
> > > <mailto:ehabkost@redhat.com>> wrote:
> > >
> > >     This series replaces INTERFACE_CHECK with OBJECT_CHECK because
> > >     both macros are exactly the same.
> > >
> > >     The last patch is a new run of the OBJECT_CHECK ->
> > >     DECLARE*_CHECKER* converter script that will convert the former
> > >     INTERFACE_CHECK-based macros.
> > >
> > >
> > > Well, at least having a different macro allows to tweak qom
> > > implementation or replace it with something different more easily.
> > >
> > > I have some wip branch somewhere where I actually made Interface a
> > > different beast than Object (it was saving some fields, and avoiding
> > > some potentially wrong casts iirc - I didn't bother to upstream that
> > > yet). Also I have a different branch where I played with GObject to
> > > replace qom. In both cases, your proposal would have, or would make, the
> > > work more complicated.
> >
> > Considering "wip branch not bothered to upstream" as "fork",
> > your comment from [*] applies here...
> >
> >   You can't blame upstream from doing cleanups and modernization, or
> >   stagnating. Forks are forks, with all the pain they carry. If they
> >   want to avoid the maintenance cost, they have to do the extra effort
> >   to get it upstream. This is also a "sneaky way" to remind them that
> >   effort is better spent in this direction.
> >
> > [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg720284.html
> >
> >
> Fair enough. Note I didn't nack it, but in general the proposal seems to
> blurry some worthy semantic difference between object & interface. Maybe
> #define alias INTERFACE_CHECK with OBJECT_CHECK instead ?

I'm actually considering deleting INTERFACE_CHECK and
OBJECT_CHECK completely after we finish the boilerplate
conversion, and tell everybody to use
OBJECT_DECLARE_INTERFACE/OBJECT_DECLARE_TYPE instead.

-- 
Eduardo


