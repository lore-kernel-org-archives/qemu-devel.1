Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C1C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73AA206F4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bb62M9Rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73AA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ97Q-0001O9-Sy
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQ95j-0008T5-SV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQ95g-0001hL-Qc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602075764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YAC7NOB+gtz3eLsj/JsOKrn9rwcp50yoW4Q24mtEiaQ=;
 b=Bb62M9RfDzWHn3qI5kaYoxbCn9yjONVfOJ5H0WQVDP79cq3wtw8gW427Opq8MYrYb0vkjD
 2mxyBDd4hDEyGYR0cQQj8bGtB3/W0LJoL3x2rXdzthuoIjXJYZbCNy2Xzr0FMpCwOMoNPh
 WBWa8ph+XoHzUf0sr6nmjNIKwIQjvP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-6Tu-Sz0zO3ylFGAV9iP4mg-1; Wed, 07 Oct 2020 09:02:42 -0400
X-MC-Unique: 6Tu-Sz0zO3ylFGAV9iP4mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B9A804013;
 Wed,  7 Oct 2020 13:02:41 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B33BC60BF1;
 Wed,  7 Oct 2020 13:02:40 +0000 (UTC)
Date: Wed, 7 Oct 2020 09:02:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Purpose of QOM properties registered at realize time?
Message-ID: <20201007130240.GU7303@habkost.net>
References: <20201006220647.GR7303@habkost.net>
 <a6e652d9-548f-4d4e-e451-48e3f5e11031@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a6e652d9-548f-4d4e-e451-48e3f5e11031@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 07, 2020 at 02:04:23PM +0200, Paolo Bonzini wrote:
> On 07/10/20 00:06, Eduardo Habkost wrote:
> > Hi,
> > 
> > While trying to understand how QOM properties are used in QEMU, I
> > stumbled upon multiple cases where alias properties are added at
> > realize time.
> > 
> > Now, I don't understand why those properties exist.  As the
> > properties are added at realize time, I assume they aren't
> > supposed to be touched by the user at all.  If they are not
> > supposed to be touched by the user, what exactly is the purpose
> > of those QOM properties?
> 
> In the case of GPIOs, I think they will be used by other devices that
> are added afterwards.

Do you know how exactly are they used?  Is this always wrapped
behind a specific API for GPIOs, or the devices can look for the
properties directly?

I'm concerned by the possibility of having QOM properties as an
undocumented part of an internal API.


> 
> The remaining ones are:
> 
> > hw/arm/allwinner-h3.c=232=static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> > hw/arm/allwinner-h3.c:359:    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
> > --
> > hw/arm/bcm2835_peripherals.c=128=static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
> > hw/arm/bcm2835_peripherals.c:322:    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
> > --
> > hw/arm/bcm2836.c=69=static void bcm2836_realize(DeviceState *dev, Error **errp)
> > hw/arm/bcm2836.c:87:    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
> > --
> > hw/arm/xlnx-zynqmp.c=276=static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
> > hw/arm/xlnx-zynqmp.c:522:        object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus");
> 
> And this are probably usable with "bus=sd-bus" or something like that on
> other devices, too.
> 
> Paolo
> 

-- 
Eduardo


