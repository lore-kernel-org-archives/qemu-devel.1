Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F389C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E302F20659
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gB3d0gw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E302F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic5sE-0003n6-Om
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 05:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ic5ny-0002IX-EN
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ic5nr-0000wc-2L
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:53:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30928
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ic5nq-0000ly-R8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575370388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OldWRIEIJH5oAJkUIuZ/HVo+3cNtdpameexrTOpj0MA=;
 b=gB3d0gw8jvZqashVuJB6LdwZex88E9oscHFB3pKOfqGw+meABlYc4PmrrmhfV73VD9nw8+
 FiE0AcC9Pi454VtVD5HE6auK+eNMP8KW5l7a1VFH22ubkhyB1JDANpyxxv0XQQHCeoS5xD
 sjua5HzK2ivjxng1KH1f0Cb6UHbFMOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-TA1GREflMvujz85JFqPEmg-1; Tue, 03 Dec 2019 05:53:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE3B2100550E;
 Tue,  3 Dec 2019 10:53:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9513E19C69;
 Tue,  3 Dec 2019 10:53:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3995111AB5; Tue,  3 Dec 2019 11:53:02 +0100 (CET)
Date: Tue, 3 Dec 2019 11:53:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 2/2] usb-redir: remove 'remote wakeup' flag from
 configuration descriptor
Message-ID: <20191203105302.wm7tcy3f4ysuesrf@sirius.home.kraxel.org>
References: <20191202123430.7125-1-yuri.benditovich@daynix.com>
 <20191202123430.7125-3-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20191202123430.7125-3-yuri.benditovich@daynix.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TA1GREflMvujz85JFqPEmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: yan@daynix.com, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> +        /*
> +         * If this is GET_DESCRIPTOR request for configuration descripto=
r,
> +         * remove 'remote wakeup' flag from it to prevent idle power dow=
n
> +         * in Windows guest
> +         */
> +        if (dev->suppress_remote_wake &&
> +            control_packet->requesttype =3D=3D USB_DIR_IN &&
> +            control_packet->request =3D=3D USB_REQ_GET_DESCRIPTOR &&
> +            control_packet->value =3D=3D (USB_DT_CONFIG << 8) &&
> +            control_packet->index =3D=3D 0 &&
> +            /* bmAttributes field of config descriptor */
> +            len > 7 && (dev->dev.data_buf[7] & USB_CFG_ATT_WAKEUP)) {
> +                DPRINTF("Removed remote wake %04X:%04X\n",
> +                    dev->device_info.vendor_id,
> +                    dev->device_info.product_id);
> +                dev->dev.data_buf[7] &=3D ~USB_CFG_ATT_WAKEUP;
> +            }

Hmm, not much opportunity to factor out stuff to share with usb-host.
Ok then.

I think checkpatch has complains for this too, otherwise it looks fine.

cheers,
  Gerd


