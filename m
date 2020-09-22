Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA755C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297BC22206
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlBuYMlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297BC22206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmFg-0001aX-7v
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKm6v-0002HV-7O
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKm6t-0002BW-HI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600795786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4LrXgANAoDDubJnWFFhyhmb1XiVMju8ZpeT0pMliW8=;
 b=LlBuYMlCJi8HBdIyF0sWmC9Gi2j8YcK9CqN9dq/Vdfovrq7VqDz5qggUhj42ry/X8gl/7B
 owlszganJYVwDmpbHc5vM8CQtDFgMKi/bKPWNm7t7ryy/1CIUhvNRJlv+jvGwHdLRtul0F
 SF62Yw3S1Qz06zI5NS2fvsYG5ACBBVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-N_vpnVYnOHKK4iiv8pTGHQ-1; Tue, 22 Sep 2020 13:29:44 -0400
X-MC-Unique: N_vpnVYnOHKK4iiv8pTGHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D6E1884E49;
 Tue, 22 Sep 2020 17:29:34 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDC0A7882A;
 Tue, 22 Sep 2020 17:29:33 +0000 (UTC)
Date: Tue, 22 Sep 2020 13:29:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/acpi: speedup acpi tests
Message-ID: <20200922172933.GC57321@habkost.net>
References: <1473173750-11761-1-git-send-email-marcel@redhat.com>
 <5362df9c-00f8-adab-ecd2-481a33e84687@redhat.com>
 <20160906184921-mutt-send-email-mst@kernel.org>
 <41dcdc9b-ba44-3dcf-78b2-72cade130766@redhat.com>
 <20160906221822-mutt-send-email-mst@kernel.org>
 <52fc397d-bd03-e8e7-fd82-61ad278db7c3@redhat.com>
 <20200922170333.GA57321@habkost.net>
 <f6f1d85c-c805-1164-3e0d-3ca5ede4d8ff@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f6f1d85c-c805-1164-3e0d-3ca5ede4d8ff@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Tue, Sep 22, 2020 at 07:17:24PM +0200, Paolo Bonzini wrote:
> On 22/09/20 19:03, Eduardo Habkost wrote:
> >>  I can remove kernel_irqchip=off once
> >> apic irq0 override is assumed.
> > [4 years later]
> > 
> > Can we remove it now?  I couldn't find out if we can assume
> > kvm_has_gsi_routing() is true everywhere, or just on a few
> > architectures.
> 
> Yes, we can.  Other architectures don't matter, what counts is that we
> can require kvm_has_gsi_routing() == true on x86.

Do we have other architectures where we can assume that?  I'm in
the mood for deleting some code today.

-- 
Eduardo


