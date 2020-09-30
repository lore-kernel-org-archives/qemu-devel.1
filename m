Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5E8C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256942076A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlgpHRoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256942076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNgVM-000628-8u
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 14:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNgSH-0003SX-4s
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNgSD-00062i-JF
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:03:52 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601489023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c69AuHOCVWxj7KVRoZ+yeYpM6mrEE2McSVVh5laBh58=;
 b=dlgpHRoBtanU91piYtyOR+WoVaj9c88KItprAl0UZHTnbg4Ego1sQkyD1Idn+zsFX/A40t
 NzxDiiKnIdni1n3ijiV4hANVJbt6JzedR9uORKBF+tpxztk8AXklTLMiSDD7l9Lb/o9c1X
 3Uoqihz/VRCsuRuWs8m4OZB9iVJMyJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-qomsOYGUO8CyUaqnEfQO6Q-1; Wed, 30 Sep 2020 14:03:41 -0400
X-MC-Unique: qomsOYGUO8CyUaqnEfQO6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C97F81E20B
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 18:03:40 +0000 (UTC)
Received: from starship (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBBDF1002C1C;
 Wed, 30 Sep 2020 18:03:29 +0000 (UTC)
Message-ID: <04df3e246ceeefbef0d832841b87fcfcb1baa9ad.camel@redhat.com>
Subject: Re: [PATCH 06/10] device-core: use atomic_set on .realized property
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 30 Sep 2020 21:03:27 +0300
In-Reply-To: <e2cf2854-72bc-2f17-88b8-a2548f184583@redhat.com>
References: <20200925172604.2142227-1-pbonzini@redhat.com>
 <20200925172604.2142227-7-pbonzini@redhat.com>
 <9182aa173b31989e07668194e18f4dcb31981388.camel@redhat.com>
 <e2cf2854-72bc-2f17-88b8-a2548f184583@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-09-30 at 19:44 +0200, Paolo Bonzini wrote:
> On 30/09/20 16:31, Maxim Levitsky wrote:
> > > +
> > > +        qatomic_set(&dev->realized, value);
> > > +        /*
> > > +         * Ensure that concurrent users see this update prior to
> > > +         * any other changes done by unrealize.
> > > +         */
> > > +        smp_wmb();
> > 
> > I''l probably never fully understand where to use read/write/full barrier.
> > If I understand corrctly, read barrier prevents reads done by this thread to be reordered,
> > by the CPU and write barrier prevents writes done by this CPU to be re-ordered.
> 
> I must say that the above is not really satisfactory.  The right thing
> to do would be to say which changes are done by unrealize; then you
> should make sure that *after* reading something that unrealize could
> undo you check if dev->realized is still true.
I didn't fully understand this to be honest.

I just wanted to explain what I know and what I don't know about hardware barriers.

I know that read barriers should be paired with write barriers, like if one CPU has a write barrier,
which ensures the orders of writes to two memory locations, the other CPU can then use a read barrier to ensure
that it sees those writes in this order.

I thus think that reads of dev->realized should be paired with read barrier, 
but here a full memory barrier isn't really needed.

Best regards,
	Maxim Levitsky

> 
> scsi_device_find is one such case, but I'm not convinced it is enough.
> 
> Paolo
> 
> > Both (depending on the macro) usually imply compiler barrier (to avoid compilier re-ordering
> > stuff...)



