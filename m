Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2087C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD1D20708
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="FgVt3hgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD1D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvm1-0004QU-5n
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kVvk1-0003fo-18
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:00:17 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:56272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kVvjx-0006ZN-Qi
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:00:16 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 239F1C60010;
 Fri, 23 Oct 2020 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1603454408;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyDXa5SvE8RzOJsvyqAQdm6E3s9eEZoycNkwNy8SQss=;
 b=FgVt3hgW7gCcjGG12o07YOVf12zOg8Y0Rd3Z8Gw+BZiccOBP6FYiRXTUfxmRHlXeXVv6p9
 PUMADkAWUIIf4aluGKgwMjiMNJllT0UtyMPIzKHJZNGn4U3kfwupysP86pPri/7XUXKw6W
 qREPI/q0QwfsSKMvygoOGrFDO91N1T0JhMofO4aGYCKgM3XhrSDw66gwPjmsz8vAe57PeH
 Wf1ALyA6qSJhlt3eEn8xTVVYAknBeKhnFH5yzG3lsXSWlHqTdLpDcKgbKsJD+9g6N2T1Yi
 3Gd2bpHbt87ysBZzXG9De9mhcFvq/F3LWDrM61VerKFUbtgyzjes/H98VKmEwA==
Date: Fri, 23 Oct 2020 14:01:15 +0200
From: Luc Michel <luc@lmichel.fr>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] hw/core/qdev-clock: add a reference on aliased clocks
Message-ID: <20201023120115.mpvkqohiaf5urnrq@sekoia-pc.home.lmichel.fr>
References: <20201020091024.320381-1-luc@lmichel.fr>
 <CAJ+F1C+CZhxA1=pW=8H8=E8nCM27YKNuiGJc-jbtcs+TMi6DEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+CZhxA1=pW=8H8=E8nCM27YKNuiGJc-jbtcs+TMi6DEQ@mail.gmail.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1603454409;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyDXa5SvE8RzOJsvyqAQdm6E3s9eEZoycNkwNy8SQss=;
 b=ZkUruou3Z85AZ0i3H27d/VUWqVFmGLVvbuPdbJP/GswkqFJVKYnGV91SmS2CVT1rsnq1nY
 OH3tPyUN8dk4p/q6lhWy7fFe1Ik3LSkGG/rG7KPh5es5KsljG1TggwwdWO3CauxwlHQ8oC
 f1jIwUfhBe7NtmuiLefY+G+RVpFMZf1dhogjSElQ140EKBX6Uo+JW/jZDnrcBs0JNJKkfH
 B1z/Jfk6w7i/wQtHM0qr30EwD+a12Ot6iz8qJPkPpeUMnJ/Tt1yy24qkry+KnLfdT2VUvM
 s9DQOYu6Htvyf7/Q4+Cy6KGTG/PN/LYXFw/6EmjlJSK4LHq2mQ1bqGjXDJ7d7g==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1603454409; a=rsa-sha256; cv=none;
 b=JDlNblsa5tSBAv36E2Jkt2U6Inn3EP6jLxRnLKFit2IzMjkuV0bWkMKI1iuWhjGq73geMLBtImJdzdjZv5tb6X1V3wE1YTUadHyKrMblKo34hNVpdIgasy436BHoaPsxoUL/XgWl+YgYkS4MVoyUK4xclNtLaez/27DhmY75uY8hbX7bwndtw+tyJ3+3U5kqY8Vu3Pe185FN74RiXh3SermlS/GjnYCEv4HabhP/z2X4I1oC2CuwvZKndsbJEwBVqdJ45LRmT22/CQHRdozU9pPYapxNnoCEVyQz38Vz1qPorhDquiRtlQ0qypexnTKXgWqyFs6DPIZ4JerBBzJ0Cg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 08:00:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15:23 Fri 23 Oct     , Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 20, 2020 at 1:11 PM Luc Michel <luc@lmichel.fr> wrote:
> 
> > When aliasing a clock with the qdev_alias_clock() function, a new link
> > property is created on the device aliasing the clock. The link points
> > to the aliased clock and use the OBJ_PROP_LINK_STRONG flag. This
> > property is read only since it does not provide a check callback for
> > modifications.
> >
> > The object_property_add_link() documentation stats that with
> > OBJ_PROP_LINK_STRONG properties, the linked object reference count get
> > decremented when the property is deleted. But it is _not_ incremented on
> > creation (object_property_add_link() does not actually know the link).
> >
> > This commit increments the reference count on the aliased clock to
> > ensure the aliased clock stays alive during the property lifetime, and
> > to avoid a double-free memory error when the property gets deleted.
> >
> > Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > Signed-off-by: Luc Michel <luc@lmichel.fr>
> > ---
> >
> 
> In principle, that makes sense. But I don't see any users of that API yet.
Yes, Peter encountered a double-free error because of this missing
object_ref when he applied my Raspberry PI CPRMAN series, which makes
use of qdev_alias_clock.

Peter: do you consider taking this patch to be able to pick up the
CPRMAN series again?

> 
> It would have been nice to have some unit tests for qdev-clock.h..
Yes I agree.

-- 
Luc

> 
>  hw/core/qdev-clock.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> > index 6a9a340d0f..eb05f2a13c 100644
> > --- a/hw/core/qdev-clock.c
> > +++ b/hw/core/qdev-clock.c
> > @@ -59,10 +59,18 @@ static NamedClockList *qdev_init_clocklist(DeviceState
> > *dev, const char *name,
> >      } else {
> >          object_property_add_link(OBJECT(dev), name,
> >                                   object_get_typename(OBJECT(clk)),
> >                                   (Object **) &ncl->clock,
> >                                   NULL, OBJ_PROP_LINK_STRONG);
> > +        /*
> > +         * Since the link property has the OBJ_PROP_LINK_STRONG flag, the
> > clk
> > +         * object reference count gets decremented on property deletion.
> > +         * However object_property_add_link does not increment it since it
> > +         * doesn't know the linked object. Increment it here to ensure the
> > +         * aliased clock stays alive during this device life-time.
> > +         */
> > +        object_ref(OBJECT(clk));
> >      }
> >
> >      ncl->clock = clk;
> >
> >      QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
> > --
> > 2.28.0
> >
> >
> >
> 
> -- 
> Marc-André Lureau

-- 

