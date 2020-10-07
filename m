Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C64C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB9F215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCY9dxhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB9F215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBl2-0007mk-7b
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQBfk-0003I7-Rv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQBfh-000777-PE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602085684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3bLGhH3VZCQrwNeTrqclwMhr30WXj6AmOhDSHN1dYQ8=;
 b=WCY9dxhxpNWmuoBh+pQrqkv855R31Dphh+PBdL1PyG9j/FDBT1EkMeC7j8tm7c4/XGwVtj
 c7OGdsI1AdzyljhzDbBCOBwuoqcHbX9lwMD4ehc9tFx2RBIALtGePGguq0dnnU57Wn7WJR
 RMlksfbO7izqHu6fN2nt6cecpMQHUI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-wxnZHm_RPJSJ_vbLHy2acw-1; Wed, 07 Oct 2020 11:48:02 -0400
X-MC-Unique: wxnZHm_RPJSJ_vbLHy2acw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5146487951B;
 Wed,  7 Oct 2020 15:48:01 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 111C75579B;
 Wed,  7 Oct 2020 15:48:00 +0000 (UTC)
Date: Wed, 7 Oct 2020 11:48:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Purpose of QOM properties registered at realize time?
Message-ID: <20201007154800.GW7303@habkost.net>
References: <20201006220647.GR7303@habkost.net>
 <CAFEAcA_se7jErv9AFM2D7UdDMurB9Lb6W9aAXD6648spQ6idKg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_se7jErv9AFM2D7UdDMurB9Lb6W9aAXD6648spQ6idKg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 07, 2020 at 03:28:52PM +0100, Peter Maydell wrote:
> On Tue, 6 Oct 2020 at 23:06, Eduardo Habkost <ehabkost@redhat.com> wrote:
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
> QOM properties are not solely provided for the benefit of the user.
> We also use them a lot in board and SoC code as the interface
> by which C code says "create an object, configure it, connect it".
> 

Right.  I'm trying to get a better understand of how exactly QOM
is used internally when it's not user-visible.  Not being able to
distinguish internal and external usage when looking at the code
makes it very difficult to clean up external QOM-based
interfaces.


> (This was partly motivated in the original QOM design I think by the idea
> being that eventually one might be able to completely define a board model
> purely declaratively by specifying all the devices and properties and
> wiring everything up that way. Needless to say we've never really
> taken any serious steps towards actually doing that.)

Thanks for the explanation.

Now, how do I locate the code that depends on those QOM
properties to work?  When the property name is visible in the
code, I can grep for the property name.  But I don't know how to
find users of the GPIOs exposed by qdev_pass_gpios().

> 
> > For reference, these are the cases I've found:
> >
> > $ git grep -nwpE 'object_property_add_alias|qdev_pass_gpios|qdev_alias_all_properties' | grep -A1 realize
> > hw/arm/allwinner-a10.c=71=static void aw_a10_realize(DeviceState *dev, Error **errp)
> > hw/arm/allwinner-a10.c:89:    qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
> 
> This kind of thing, and also the sd-bus cases, is where an SoC device wants
> to expose some GPIO lines or an sd-bus which is actually implemented by
> a device which exists inside the SoC (and which the SoC has created and
> wired up). The effect is that for the user of the SoC object the gpio/sd-bus
> can be used as if it was directly implemented by the SoC object, when it's
> actually just being passed through to the internal device.
> 
> I'd have to look at the code to find out whether it's really necessary in all
> cases to do this pass-through setup at realize rather than instance-init.
> 
> In this case:
> 
> > hw/arm/armv7m.c=149=static void armv7m_realize(DeviceState *dev, Error **errp)
> > hw/arm/armv7m.c:219:    qdev_pass_gpios(DEVICE(&s->nvic), dev, NULL);
> 
> there's a comment on the immediately preceding lines which explains what
> the code is doing and why it is being done in realize:
> 
>  215     /* Alias the NVIC's input and output GPIOs as our own so the board
>  216      * code can wire them up. (We do this in realize because the
>  217      * NVIC doesn't create the input GPIO array until realize.)
>  218      */
> 
> Possibly one could move the code in the devices which creates the
> GPIO array/sdbus/whatever so that it does so in instance_init
> rather than in realize, and then more of these "alias a connection
> through" bits of code could also move to instance_init. But there are
> cases where the GPiO/etc can only be created in realize because
> the number of GPIOs depends on properties of the device and so isn't
> know at instance_init time.
> 
> -- PMM
> 

-- 
Eduardo


