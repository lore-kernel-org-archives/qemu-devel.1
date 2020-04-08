Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9178DC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5366E20753
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSxMvRbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5366E20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM8sX-0003rw-GE
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 07:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jM8ry-0003NZ-Ho
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jM8rx-00076r-DH
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:27:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jM8rx-00076P-8d
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586345264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IWaCHSrm43djrcIXCaapWZOA96JlErcxZmws/WgzFA=;
 b=LSxMvRbV3RXRn0CVrZIsgKXBp9qxv6SA37WLnFnPCiScpekgCDx2kCBx2C0oB4cvTjn64a
 LjSLJRpoItldEO8/IauLImzR1YWrmcMvWIN9CsBaxOAwYRZBB1BmlAbpf5BKareMezmoIr
 eUuVvEYMGaFVJGQrl5lOF6XQ02t+f3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-6GMxJ8GpMqSUzE6GcqTYGA-1; Wed, 08 Apr 2020 07:27:43 -0400
X-MC-Unique: 6GMxJ8GpMqSUzE6GcqTYGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 115E48018A3;
 Wed,  8 Apr 2020 11:27:42 +0000 (UTC)
Received: from localhost (unknown [10.40.208.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58A621001DF2;
 Wed,  8 Apr 2020 11:27:29 +0000 (UTC)
Date: Wed, 8 Apr 2020 13:27:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 07/12] acpi: move aml builder code for rtc device
Message-ID: <20200408132727.374c470d@redhat.com>
In-Reply-To: <20200407102658.x5tb4txcpvmtxfj7@sirius.home.kraxel.org>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-8-kraxel@redhat.com>
 <20200403120921.258db9a5@redhat.com>
 <20200406082517.uyz7zv4jiqqjbcli@sirius.home.kraxel.org>
 <20200406141705.77d90b68@redhat.com>
 <20200407102658.x5tb4txcpvmtxfj7@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 12:26:58 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, Apr 06, 2020 at 02:17:05PM +0200, Igor Mammedov wrote:
> > On Mon, 6 Apr 2020 10:25:17 +0200
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   
> > > On Fri, Apr 03, 2020 at 12:09:21PM +0200, Igor Mammedov wrote:  
> > > > On Fri,  3 Apr 2020 10:04:57 +0200
> > > > Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > >     
> > > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > > ---    
> > > > [...]    
> > > > > +static void rtc_build_aml(ISADevice *isadev, Aml *scope)
> > > > > +{
> > > > > +    Aml *dev;
> > > > > +    Aml *crs;
> > > > > +
> > > > > +    crs = aml_resource_template();
> > > > > +    aml_append(crs, aml_io(AML_DECODE16, 0x0070, 0x0070, 0x10, 0x02));
maybe replace magic 0x0070 with macro
  RTC_BASE_ADDR

and do the same in realize

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index dc4269cc55..a1f27f4883 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -908,7 +908,6 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
 {
     ISADevice *isadev = ISA_DEVICE(dev);
     RTCState *s = MC146818_RTC(dev);
-    int base = 0x70;
 
     s->cmos_data[RTC_REG_A] = 0x26;
     s->cmos_data[RTC_REG_B] = 0x02;
@@ -951,7 +950,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     qemu_register_suspend_notifier(&s->suspend_notifier);
 
     memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
-    isa_register_ioport(isadev, &s->io, base);
+    isa_register_ioport(isadev, &s->io, RTC_BASE_ADDR);
 
     /* register rtc 0x70 port for coalesced_pio */
     memory_region_set_flush_coalesced(&s->io);
@@ -960,7 +959,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
     memory_region_add_coalescing(&s->coalesced_io, 0, 1);
 
-    qdev_set_legacy_instance_id(dev, base, 3);
+    qdev_set_legacy_instance_id(dev, RTC_BASE_ADDR, 3);
     qemu_register_reset(rtc_reset, s);
 
     object_property_add_tm(OBJECT(s), "date", rtc_get_date, NULL);


> > > > > +    aml_append(crs, aml_irq_no_flags(8));
> > > > > +    aml_append(crs, aml_io(AML_DECODE16, 0x0072, 0x0072, 0x02, 0x06));

one more comment, is this last io record correct?
(looking at realize it maps only 2 bytes at 0x70)
    
> > > > 
> > > > since this is made a part of device, can we fetch io port values from
> > > > device instead of hard-codding values here?    
> > > 
> > > No, the rtc device hasn't a configurable io port address.  
> > what I'm after is consistent code, so if we switch to taking
> > io_base/irq from ISA device, then do it everywhere.  
> 
> The patch series does it consistently where it makes sense.
> That IMHO isn't the case for the rtc.  It has a fixed address.
> You can't have multiple instances if it.  And because of that
> there isn't a variable in the device state struct where I could
> read the iobase from ...

ok

> 
> > So we don't have a zoo of devices doing the same thing in multiple
> > ways.  
> 
> It's two ways: hardcoded for devices which can't move and
> read-from-device for devices which can move.
> 
> cheers,
>   Gerd
> 


