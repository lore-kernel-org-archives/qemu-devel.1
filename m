Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B9C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBCB20E65
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhd4t5XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBCB20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHp5d-00014o-Ti
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kHp4s-0000Wp-I4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kHp4q-0006tx-VP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600092207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJ61TQmGt05vYw/DZO3qxapq5iKMmEZHhYtUqvX2ceM=;
 b=hhd4t5XWyEC8iVd6ec3l5T7cXypNnvDY3z5UdqKZSmLfaUARcWYke1IgcGyXk8peS7Fvz7
 vdsIm+/Lp+l5naVTsVJul5sZn7Ah+RpJCJMT0ebArSRYFZLRwx6w/4NCZloknmycTfAOKz
 fU/DhEx1K8Ke7vDK6+9oOkd+9UYPgoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-zMmteinvNLuujcT19pIyzQ-1; Mon, 14 Sep 2020 10:03:22 -0400
X-MC-Unique: zMmteinvNLuujcT19pIyzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B022380ED8E;
 Mon, 14 Sep 2020 14:03:20 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E107575139;
 Mon, 14 Sep 2020 14:03:19 +0000 (UTC)
Date: Mon, 14 Sep 2020 10:03:19 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 2/7] hw/misc/led: Allow connecting from GPIO output
Message-ID: <20200914140319.GA1618070@habkost.net>
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-3-f4bug@amsat.org>
 <071b68a6-58e4-0d68-e056-ee7ae19e2227@linaro.org>
 <db55f80e-ca2d-d432-134b-a05333a7e124@amsat.org>
 <87imcg4y3l.fsf@dusky.pond.sub.org>
 <f451861f-fa21-6465-865e-9d5e42e165b5@amsat.org>
MIME-Version: 1.0
In-Reply-To: <f451861f-fa21-6465-865e-9d5e42e165b5@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 09:48:45AM +0200, Philippe Mathieu-Daudé wrote:
> On 9/14/20 9:27 AM, Markus Armbruster wrote:
> > Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> > 
> >> Eduardo is already in Cc, adding Markus.
> >>
> >> On 9/12/20 12:44 AM, Richard Henderson wrote:
> >>> On 9/10/20 1:54 PM, Philippe Mathieu-Daudé wrote:
> >>>> Some devices expose GPIO lines.
> >>>>
> >>>> Add a GPIO qdev input to our LED device, so we can
> >>>> connect a GPIO output using qdev_connect_gpio_out().
> >>>>
> >>>> When used with GPIOs, the intensity can only be either
> >>>> minium or maximum. This depends of the polarity of the
> >>>> GPIO (which can be inverted).
> >>>> Declare the GpioPolarity type to model the polarity.
> >>>>
> >>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> >>>> ---
> >>>>  include/hw/misc/led.h  |  8 ++++++++
> >>>>  include/hw/qdev-core.h |  8 ++++++++
> >>>>  hw/misc/led.c          | 17 ++++++++++++++++-
> >>>>  3 files changed, 32 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
> >>>> index f5afaa34bfb..71c9b8c59bf 100644
> >>>> --- a/include/hw/misc/led.h
> >>>> +++ b/include/hw/misc/led.h
> >>>> @@ -38,10 +38,16 @@ typedef struct LEDState {
> >>>>      /* Public */
> >>>>  
> >>>>      uint8_t intensity_percent;
> >>>> +    qemu_irq irq;
> >>>>  
> >>>>      /* Properties */
> >>>>      char *description;
> >>>>      char *color;
> >>>> +    /*
> >>>> +     * When used with GPIO, the intensity at reset is related
> >>>> +     * to the GPIO polarity.
> >>>> +     */
> >>>> +    bool inverted_polarity;
> >>>
> >>> Why are you not using the GpioPolarity enum that you added?
> >>
> >> Because it is migrated...
> >>
> >> Using DEFINE_PROP_BOOL() is simpler that adding hardware specific
> >> enum visitor in hw/core/qdev-properties.c (which is included in
> >> user-mode builds because pulled by the CPU type).
> > 
> > Yes.
> > 
> > You could also use DEFINE_PROP_UINT8(), and use it with your enumeration
> > constants.
> > 
> > I'd be tempted to ditch the enum entirely.  Matter of taste, no big deal
> > either way.
> 
> Done in v6!
> 
> > 
> >> A sane cleanup would be to make get_enum(), set_enum()
> >> and set_default_value_enum() public (prefixed with 'qdev_')
> >> in include/hw/qdev-properties.h.
> > 

Where and how exactly do you expect those functions to be used?
Having additional PropertyInfo structs defined manually would not
be desirable (especially if they are outside qdev*.c).  Having a
DEFINE_PROP_ENUM macro that does the enum magic behind the scenes
would be nice.

> > Purpose?  To be able to define enum properties outside
> > qdev-properties.c?
> 
> Yes, to avoid pulling in PCI and MAC address properties
> into qemu-storage-daemon and linux-user binaries...

I don't understand what enum functions have to do with PCI and
MAC address properties.

-- 
Eduardo


