Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799F9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0E72072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ls4p+oxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0E72072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDhsW-0005Nd-Dv
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kDhrz-0004uN-6K
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:33:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25399
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kDhrx-0005Kh-Dm
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599111188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8YnI2EVTu9QY3lllKoF3XAE+WjNhqXgXVYxPXfrwta4=;
 b=Ls4p+oxU5nn80LCFRuhbxv6ovWi57eXwoyRqNxU8zpcsZdbLdPt3wpfPeRrlYRi54i4WLd
 f6CMWhua+X9ZX+FLykYlwtJucrWrmWDl2ELDeoAQNOWAe1Fdl+Yc57wuFyTAtCsaRYOcAf
 Vp9T0u0YGZf3l+TkGq+8zzGYOeSMNlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-JEpNZK_iNQ62iZxDTJ_zxA-1; Thu, 03 Sep 2020 01:33:03 -0400
X-MC-Unique: JEpNZK_iNQ62iZxDTJ_zxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FDD01074644;
 Thu,  3 Sep 2020 05:33:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE54A5C1C2;
 Thu,  3 Sep 2020 05:33:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F342516E31; Thu,  3 Sep 2020 07:33:00 +0200 (CEST)
Date: Thu, 3 Sep 2020 07:33:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] usb-host: workaround libusb bug
Message-ID: <20200903053300.4fokdkv34bjsx3ze@sirius.home.kraxel.org>
References: <20200824110057.32089-1-kraxel@redhat.com>
 <878sdt618f.fsf@linaro.org>
 <20200902080937.p6fweexn7cxzru5p@sirius.home.kraxel.org>
 <87wo1c45d9.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87wo1c45d9.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 02, 2020 at 03:31:46PM +0100, Alex Bennée wrote:
> 
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> >> > +#include <linux/usbdevice_fs.h>
> >
> >> > +        int rc = ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);
> >> 
> >> This (further) breaks a bunch of the Travis jobs - I assume because libusb doesn't
> >> always have this symbol:
> >> 
> >>   ../hw/usb/host-libusb.c:954:32: error: ‘USBDEVFS_GET_SPEED’ undeclared (first use in this function)
> >
> > It isn't libusb, it is the kernel (linux/usbdevice_fs.h).
> >
> > /me checks git ...
> > Added in 4.13, so available for quite a while.
> > I guess that is the prehistoric ubuntu version travis has?
> >
> > Given that we only need that workaround with rather new libusb versions
> > (which have libusb_wrap_sys_device() support) which most likely isn't
> > present in that old ubuntu version we can probably just do this:
> >
> > diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> > index 08604f787fdf..c25102f3aca1 100644
> > --- a/hw/usb/host-libusb.c
> > +++ b/hw/usb/host-libusb.c
> > @@ -942,7 +942,7 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
> >      usb_host_ep_update(s);
> >  
> >      libusb_speed = libusb_get_device_speed(dev);
> > -#ifdef CONFIG_LINUX
> > +#if LIBUSB_API_VERSION >= 0x01000107 && defined(CONFIG_LINUX)
> >      if (hostfd && libusb_speed == 0) {
> >          /*
> >           * Workaround libusb bug: libusb_get_device_speed() does not
> 
> That works. Do you want to include that in your next PR or send a patch
> for me to include in my testing/next PR?

Patch is on the list already:
https://patchwork.ozlabs.org/project/qemu-devel/patch/20200902081445.3291-1-kraxel@redhat.com/

Feel free to include it in testing pull.

take care,
  Gerd


