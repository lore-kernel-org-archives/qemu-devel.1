Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148FBC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56ED2075C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOlR925d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56ED2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZqxK-0003dI-Tk
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 01:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZqvo-0002YJ-Kq
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZqvl-0001Kp-Jq
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:36:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZqvl-0001JL-8l
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574836564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNPxK5+Mrft52f8nq32eA3vAGdWlJ1YAyxJdvz49c1E=;
 b=NOlR925deux40hV/mIt6pFmlGvJobtc7dAcYQ8QQJrj8DBf7A2gJ9a+kTeagrrkfHAvUqP
 I4GGc/SKovycz/GaFYlAOZjxUEu/cHPH2Yf7SO5mw7foE8uRDruzt4autHdo4xaR4s/0D5
 kXi1dLqfaShproteCAVAhsFNVM5/YQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-83g6laKNPu2BMrqli7FjZw-1; Wed, 27 Nov 2019 01:35:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750AB1801B9E;
 Wed, 27 Nov 2019 06:35:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21D06600C8;
 Wed, 27 Nov 2019 06:35:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A72671138606; Wed, 27 Nov 2019 07:35:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH] usbredir: remove 'remote wake' capability from
 configuration descriptor
References: <20191126212245.27735-1-yuri.benditovich@daynix.com>
Date: Wed, 27 Nov 2019 07:35:53 +0100
In-Reply-To: <20191126212245.27735-1-yuri.benditovich@daynix.com> (Yuri
 Benditovich's message of "Tue, 26 Nov 2019 23:22:45 +0200")
Message-ID: <87a78hltbq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 83g6laKNPu2BMrqli7FjZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: yan@daynix.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yuri Benditovich <yuri.benditovich@daynix.com> writes:

> If the redirected device has this capability, Windows guest may
> place the device into D2 and expect it to wake when the device
> becomes active, but this will never happen. For example, when
> internal Bluetooth adapter is redirected, keyboards and mice
> connected to it do not work. Setting global property
> 'usb-redir.nowake=3Doff' keeps 'remote wake' as is.

"usb-redir.nowake=3Doff" is a double negation.  Gets weirder when dusted
with syntactic sugar: "usb-redir.nonowake".  Can we think of a better
name?  Naming is hard...  What about "usb-redir.wakeup=3Don"?

> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/usb/redirect.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index e0f5ca6f81..e95898fe80 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -113,6 +113,7 @@ struct USBRedirDevice {
>      /* Properties */
>      CharBackend cs;
>      bool enable_streams;
> +    bool suppress_remote_wake;
>      uint8_t debug;
>      int32_t bootindex;
>      char *filter_str;
> @@ -1989,6 +1990,23 @@ static void usbredir_control_packet(void *priv, ui=
nt64_t id,
>              memcpy(dev->dev.data_buf, data, data_len);
>          }
>          p->actual_length =3D len;
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
>          usb_generic_async_ctrl_complete(&dev->dev, p);
>      }
>      free(data);
> @@ -2530,6 +2548,7 @@ static Property usbredir_properties[] =3D {
>      DEFINE_PROP_UINT8("debug", USBRedirDevice, debug, usbredirparser_war=
ning),
>      DEFINE_PROP_STRING("filter", USBRedirDevice, filter_str),
>      DEFINE_PROP_BOOL("streams", USBRedirDevice, enable_streams, true),
> +    DEFINE_PROP_BOOL("nowake", USBRedirDevice, suppress_remote_wake, tru=
e),
>      DEFINE_PROP_END_OF_LIST(),
>  };

The default is .nowake=3Don.  Is that a guest-visible change?  Do we need
compat properties to keep it off for existing machine types?


