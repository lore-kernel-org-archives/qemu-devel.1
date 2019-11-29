Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D00BC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21866216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Q6mhWuGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21866216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahrw-0008S8-7D
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 10:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iahR2-0004vZ-4h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iahQv-0006ik-22
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:39:46 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iahQu-0006J1-Gc
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:39:44 -0500
Received: by mail-oi1-x243.google.com with SMTP id o12so26208108oic.9
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=68Rd/tu1dOffmnGRfw3iEccusmAPrnJ6YjSc+2ugT7A=;
 b=Q6mhWuGSv/dXUhvIAovA4XN+L8TNuGSfR6AG/AJtU3vDSsNuXBft9QfD4iwTIfQwEH
 9dUT7cFge7W3Q1I/6MBrC7F+/w43dJg0g/UaV+6sNvoy5k+RRLwoH3U1DQheCFCZiA5U
 tvzyvBku2TJ/CKJIrCRmHdSjzI3SYiBPxu+WK059lmMQQEKjWEgHPmY4H/RlxGcJDI9f
 cmPE6GvEvdVEz+IqXFAYAFH3A+Oj4vUFMlw9Z7Djlj/qKNPqGg31EGPPeo8Mf0Nb/XRQ
 +RVRrP+MdcXbGG9f2o9ctQEmOPyeKSrgovElUGg0VWSAgpoPWfN63GDvw8hRr2S4rtjJ
 +w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=68Rd/tu1dOffmnGRfw3iEccusmAPrnJ6YjSc+2ugT7A=;
 b=maWA2Nwa5yxbd762l+t5e644pAAqVd7NxhRI2dnTAUfOXfMZGwnaZP1jypoTodOAFt
 dxwpAy1zmYvozVoh7YOqvOV19wTqU8Uq+Kcmklhqy+7fZZMFC6ukQ5+a6WYovPpHq0r1
 PDlX50pbDk1fm3SCosefTPenOj3jhJj/mrthdZ5WHr8LDgWVlvpx2W2Wkqo6KO2U+D6c
 SLy6XxPxgvozZjcNoBVrjGPlk30yytVOBYfiDQACiRjYQNj2CIqXyyzetlD0LAEm+2Ph
 B6qTQKGFIV51FuYQIPR0vqEsZdkEANPvkpLWxv6ho84ApAS8a5wsfIFDQQajjXIXJu3z
 gmYg==
X-Gm-Message-State: APjAAAVZqUNsI7IXU2qpzxhy6dH5PDs4RQE9OjqPoDa8mvhg0DjXA846
 ICCLzuod1t/ZQwcWQZI9r0lL1w==
X-Google-Smtp-Source: APXvYqyvYf2kH/xWCiTZBKYJ8Ph4KnMg+D1jDAQnwP9N1oDI0jga/a2nbmlrhPvyxiokMnymLVilTg==
X-Received: by 2002:aca:728a:: with SMTP id
 p132mr12995370oic.113.1575038376505; 
 Fri, 29 Nov 2019 06:39:36 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id l20sm7286547oii.26.2019.11.29.06.39.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 29 Nov 2019 06:39:35 -0800 (PST)
Date: Fri, 29 Nov 2019 08:39:34 -0600
From: Corey Minyard <cminyard@mvista.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v4 31/37] smbus-eeprom: remove PROP_PTR
Message-ID: <20191129143934.GA3176@minyard.net>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-32-marcandre.lureau@redhat.com>
 <20191121224351.GN3556@minyard.net>
 <CAJ+F1CKCp2McVyeEou4erXaGZmPmByKCtT0SpK9RVfmcqc9Opw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKCp2McVyeEou4erXaGZmPmByKCtT0SpK9RVfmcqc9Opw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Reply-To: cminyard@mvista.com
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 01:06:41PM +0400, Marc-André Lureau wrote:
> Hi Corey
> 
> On Fri, Nov 22, 2019 at 2:44 AM Corey Minyard <cminyard@mvista.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 07:24:36PM +0400, Marc-André Lureau wrote:
> > > Instead, set the initial data field directly.
> > >
> > > (the initial data is an array of 256 bytes. As I don't know if it may
> > > change over time, I keep the pointer to original buffer as is, but it
> > > might be worth to consider to copy it instead)
> >
> > This looks ok to me, I can add it to my tree.  I think we are in hard
> > freeze now, so this will have to wait until that's done.
> 
> Thanks, I think I would rather keep it in this series, as the goal is
> to remove PROP_PTR, and tracking various subsystems will be tedious.
> Instead, we can hopefully do it in one go.
> 
> Does it get your reviewed-by then?

Yes, I thought I had done that.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> 
> >
> > -corey
> >
> > >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/i2c/smbus_eeprom.c | 17 ++++++++---------
> > >  1 file changed, 8 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> > > index 54c86a0112..533c728b3b 100644
> > > --- a/hw/i2c/smbus_eeprom.c
> > > +++ b/hw/i2c/smbus_eeprom.c
> > > @@ -44,7 +44,7 @@
> > >  typedef struct SMBusEEPROMDevice {
> > >      SMBusDevice smbusdev;
> > >      uint8_t data[SMBUS_EEPROM_SIZE];
> > > -    void *init_data;
> > > +    uint8_t *init_data;
> > >      uint8_t offset;
> > >      bool accessed;
> > >  } SMBusEEPROMDevice;
> > > @@ -129,14 +129,14 @@ static void smbus_eeprom_reset(DeviceState *dev)
> > >
> > >  static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
> > >  {
> > > +    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
> > > +
> > >      smbus_eeprom_reset(dev);
> > > +    if (eeprom->init_data == NULL) {
> > > +        error_setg(errp, "init_data cannot be NULL");
> > > +    }
> > >  }
> > >
> > > -static Property smbus_eeprom_properties[] = {
> > > -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
> > > -    DEFINE_PROP_END_OF_LIST(),
> > > -};
> > > -
> > >  static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
> > >  {
> > >      DeviceClass *dc = DEVICE_CLASS(klass);
> > > @@ -146,9 +146,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
> > >      dc->reset = smbus_eeprom_reset;
> > >      sc->receive_byte = eeprom_receive_byte;
> > >      sc->write_data = eeprom_write_data;
> > > -    dc->props = smbus_eeprom_properties;
> > >      dc->vmsd = &vmstate_smbus_eeprom;
> > > -    /* Reason: pointer property "data" */
> > > +    /* Reason: init_data */
> > >      dc->user_creatable = false;
> > >  }
> > >
> > > @@ -172,7 +171,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
> > >
> > >      dev = qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
> > >      qdev_prop_set_uint8(dev, "address", address);
> > > -    qdev_prop_set_ptr(dev, "data", eeprom_buf);
> > > +    SMBUS_EEPROM(dev)->init_data = eeprom_buf;
> > >      qdev_init_nofail(dev);
> > >  }
> > >
> > > --
> > > 2.24.0
> > >
> >
> 
> 
> -- 
> Marc-André Lureau

