Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1A3C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C1B23119
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZFt1KH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C1B23119
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlvZ-0002ut-Pt
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKliA-0001C9-5g
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKli7-0007Ae-7C
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600794249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4VDi9te5ohfdxOLIJEB1UqL5Fd8ufn6MFb9MaAx4mm4=;
 b=AZFt1KH9LOYjI5V2bYLFisps29nuaVHpcKxTYnno26QsFjn8p+5PEq+Em77JysxnNlVbND
 qV/giv+FK/+RgVy4I0gB/Yb/OvWPDShHU3puiVDnw4pTWWpWb+gIxvis44zmxWVyOuvWXo
 8lPGuv3JIyQT8+hdwRZ9HBEh7AmQVwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-fAfjUNfMOCej-EALpk958A-1; Tue, 22 Sep 2020 13:04:05 -0400
X-MC-Unique: fAfjUNfMOCej-EALpk958A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B12F19611B3;
 Tue, 22 Sep 2020 17:03:54 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CFF578439;
 Tue, 22 Sep 2020 17:03:34 +0000 (UTC)
Date: Tue, 22 Sep 2020 13:03:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/acpi: speedup acpi tests
Message-ID: <20200922170333.GA57321@habkost.net>
References: <1473173750-11761-1-git-send-email-marcel@redhat.com>
 <5362df9c-00f8-adab-ecd2-481a33e84687@redhat.com>
 <20160906184921-mutt-send-email-mst@kernel.org>
 <41dcdc9b-ba44-3dcf-78b2-72cade130766@redhat.com>
 <20160906221822-mutt-send-email-mst@kernel.org>
 <52fc397d-bd03-e8e7-fd82-61ad278db7c3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <52fc397d-bd03-e8e7-fd82-61ad278db7c3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 06, 2016 at 10:22:26PM +0200, Paolo Bonzini wrote:
> On 06/09/2016 21:21, Michael S. Tsirkin wrote:
> > On Tue, Sep 06, 2016 at 09:11:16PM +0200, Paolo Bonzini wrote:
> >>
> >>
> >> On 06/09/2016 17:51, Michael S. Tsirkin wrote:
> >>>> Just use "-machine accel=kvm:tcg" and let QEMU do the hard work. :)
> >>>>
> >>>> Paolo
> >>>
> >>> Sounds good, but we really need to skip it when gsi
> >>> capability is not there (and when using kernel irqchip)
> >>> (because in that case we can't override apic irq0).
> >>
> >> We should just remove support for !kvm_has_gsi_routing on x86.  It's
> >> been there since November 2008.
> >>
> >> Paolo
> > 
> > Fine by me. Can you post a patch that does this?
> > This one can be a follow-up, and we can also
> > drop the conditional handling from acpi-build.
> 
> Go ahead and merge Marcel's patch.  I can remove kernel_irqchip=off once
> apic irq0 override is assumed.

[4 years later]

Can we remove it now?  I couldn't find out if we can assume
kvm_has_gsi_routing() is true everywhere, or just on a few
architectures.

-- 
Eduardo


