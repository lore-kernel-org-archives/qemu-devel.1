Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3602C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7947520739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT7yobJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7947520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw8QH-0008CK-M7
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 14:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8PW-0007gF-Gs
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:15:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8PS-00042A-VO
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594923304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wFKIbaN9GQbFjy8LcU37XB170KYmsvXf4aCCnNdoX90=;
 b=HT7yobJ847AJb5/Ad2heQ9hj5MG42Pi0NMihy9Rg5GA8zlFsUInxYA6Xoa0SDDQ/TrJiHA
 SbovjO/6NdTLBB7GSaWqrbip7NpAd7aILOVj4aIBBl6bhZq/Ddxxtq/84Sj1JdSBHsQMNn
 avXfS4BCuGjjozJ4aX1E276v8z7DDbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-Ad74_MXQNOWZvbSklh9EVw-1; Thu, 16 Jul 2020 14:15:01 -0400
X-MC-Unique: Ad74_MXQNOWZvbSklh9EVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A71E019253C2;
 Thu, 16 Jul 2020 18:14:59 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE071001901;
 Thu, 16 Jul 2020 18:14:58 +0000 (UTC)
Date: Thu, 16 Jul 2020 14:14:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-5.1] i386: hvf: Explicitly set CR4 guest/host mask
Message-ID: <20200716181457.GM1274972@habkost.net>
References: <20200714090726.41082-1-r.bolshakov@yadro.com>
 <20200714103932.GB90799@SPB-NB-133.local>
 <CABgObfYgRVpy6WvjzFG0Zb+2bjQp6HYOuZePbtkbxWjLkxBYjw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfYgRVpy6WvjzFG0Zb+2bjQp6HYOuZePbtkbxWjLkxBYjw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: programmingkidx@gmail.com, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-devel <qemu-devel@nongnu.org>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 08:20:04PM +0200, Paolo Bonzini wrote:
> Hi Roman, please ask Peter to apply it directly because I won't be able to
> send a pull request in the next couple of weeks.
> 
> Paolo
> 
> Il mar 14 lug 2020, 12:39 Roman Bolshakov <r.bolshakov@yadro.com> ha
> scritto:
> 
> > On Tue, Jul 14, 2020 at 12:07:27PM +0300, Roman Bolshakov wrote:
> > > Removal of register reset omitted initialization of CR4 guest/host mask.
> > > x86_64 guests aren't booting without it.
> > >
> > > Fixes: 5009ef22c6bb2 ("i386: hvf: Don't duplicate register reset")
> > > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > >
> >
> > If one has a chance to test or review it, it'd be very helpful. That'd
> > allow to include it in RC0.
> >

I'll queue it for my -rc1 pull request.

-- 
Eduardo


