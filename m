Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96685C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6493E204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MK138J+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6493E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZte0-0000pD-JZ
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 04:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZtdM-0000Ni-Ei
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZtdK-0003TT-Of
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:29:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZtdK-0003T2-Kh
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574846953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlU5ABjySGp9kW3YtTMWw4j5vcrBh2Ge57gcwTiQEXs=;
 b=MK138J+QA0pNGGnsFeYYtBrwxNuCxuyko6rDwiHmZarSk52It5Bkhiec+8BXsShGfMZeFZ
 WO54EUgWr0tLa27mzOxmdX2Bs+ysgv6WZ5FeWaYItqKH5WW/w9Aodww0UlQ7uFPI+uXdqQ
 dl9HeOwWxOX0WMdHic8eQ6ArKaul+0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-gRTMfI74OWa0JEP0G-0WHw-1; Wed, 27 Nov 2019 04:29:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D165012A7E22;
 Wed, 27 Nov 2019 09:29:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2EAE5D6C8;
 Wed, 27 Nov 2019 09:29:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 307551138606; Wed, 27 Nov 2019 10:29:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH] usbredir: remove 'remote wake' capability from
 configuration descriptor
References: <20191126212245.27735-1-yuri.benditovich@daynix.com>
 <87a78hltbq.fsf@dusky.pond.sub.org>
 <CAOEp5OdsYhxD4LE9Qu981uiB+33Xc81z8H=cuwTS6tbU9x_UkA@mail.gmail.com>
Date: Wed, 27 Nov 2019 10:29:06 +0100
In-Reply-To: <CAOEp5OdsYhxD4LE9Qu981uiB+33Xc81z8H=cuwTS6tbU9x_UkA@mail.gmail.com>
 (Yuri Benditovich's message of "Wed, 27 Nov 2019 09:36:21 +0200")
Message-ID: <87lfs1hdlp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: gRTMfI74OWa0JEP0G-0WHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yuri Benditovich <yuri.benditovich@daynix.com> writes:

> On Wed, Nov 27, 2019 at 8:36 AM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Yuri Benditovich <yuri.benditovich@daynix.com> writes:
>>
>> > If the redirected device has this capability, Windows guest may
>> > place the device into D2 and expect it to wake when the device
>> > becomes active, but this will never happen. For example, when
>> > internal Bluetooth adapter is redirected, keyboards and mice
>> > connected to it do not work. Setting global property
>> > 'usb-redir.nowake=3Doff' keeps 'remote wake' as is.
>>
>> "usb-redir.nowake=3Doff" is a double negation.  Gets weirder when dusted
>> with syntactic sugar: "usb-redir.nonowake".  Can we think of a better
>> name?  Naming is hard...  What about "usb-redir.wakeup=3Don"?
> '"wakeup" is good but "wakeup=3Don" makes an impression that we add the
> capability to the device even if it does not have one.

True.

> disable_wake? suppress_wake? clear_wake? wake_allowed?

Let's have a look at what the property does:

>> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>> > ---
>> >  hw/usb/redirect.c | 19 +++++++++++++++++++
>> >  1 file changed, 19 insertions(+)
>> >
>> > diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
>> > index e0f5ca6f81..e95898fe80 100644
>> > --- a/hw/usb/redirect.c
>> > +++ b/hw/usb/redirect.c
>> > @@ -113,6 +113,7 @@ struct USBRedirDevice {
>> >      /* Properties */
>> >      CharBackend cs;
>> >      bool enable_streams;
>> > +    bool suppress_remote_wake;
>> >      uint8_t debug;
>> >      int32_t bootindex;
>> >      char *filter_str;
>> > @@ -1989,6 +1990,23 @@ static void usbredir_control_packet(void *priv,=
 uint64_t id,
>> >              memcpy(dev->dev.data_buf, data, data_len);
>> >          }
>> >          p->actual_length =3D len;
>> > +        /*
>> > +         * If this is GET_DESCRIPTOR request for configuration descri=
ptor,
>> > +         * remove 'remote wakeup' flag from it to prevent idle power =
down
>> > +         * in Windows guest
>> > +         */
>> > +        if (dev->suppress_remote_wake &&
>> > +            control_packet->requesttype =3D=3D USB_DIR_IN &&
>> > +            control_packet->request =3D=3D USB_REQ_GET_DESCRIPTOR &&
>> > +            control_packet->value =3D=3D (USB_DT_CONFIG << 8) &&
>> > +            control_packet->index =3D=3D 0 &&
>> > +            /* bmAttributes field of config descriptor */
>> > +            len > 7 && (dev->dev.data_buf[7] & USB_CFG_ATT_WAKEUP)) {
>> > +                DPRINTF("Removed remote wake %04X:%04X\n",
>> > +                    dev->device_info.vendor_id,
>> > +                    dev->device_info.product_id);
>> > +                dev->dev.data_buf[7] &=3D ~USB_CFG_ATT_WAKEUP;
>> > +            }

If the property is true, and this is a GET_DESCRIPTOR control packet
with USB_CFG_ATT_WAKEUP bit set, unset it.  Correct?

Assuming it is: "suppress_wakup" feels okay to me.

Whatever we pick, I recommend naming the USBRedirDevice member like the
property.  It's currently named @suppress_remote_wake.

>> >          usb_generic_async_ctrl_complete(&dev->dev, p);
>> >      }
>> >      free(data);
>> > @@ -2530,6 +2548,7 @@ static Property usbredir_properties[] =3D {
>> >      DEFINE_PROP_UINT8("debug", USBRedirDevice, debug, usbredirparser_=
warning),
>> >      DEFINE_PROP_STRING("filter", USBRedirDevice, filter_str),
>> >      DEFINE_PROP_BOOL("streams", USBRedirDevice, enable_streams, true)=
,
>> > +    DEFINE_PROP_BOOL("nowake", USBRedirDevice, suppress_remote_wake, =
true),
>> >      DEFINE_PROP_END_OF_LIST(),
>> >  };
>>
>> The default is .nowake=3Don.  Is that a guest-visible change?  Do we nee=
d
>> compat properties to keep it off for existing machine types?
>
> Guest will see the device as one without 'remote wake' capability.
> IMO, in the worst case this does not change anything, in the best case
> this will suppress device power transition to D2 and the device will
> work.
> Including existing machine types.
> Probably I did not understand the idea of 'compat property', can you
> please provide an example of some existing compat property?
> And, of course, we can keep existing behavior by default and advise to
> turn this property on to make these devices work.

Guest-visible changes require care.  Consider:

* Live migration

  This is meant to be transparent to the guest, even when we migrate to
  a different version of QEMU.  Guest-visible hardware changes are
  no-no.

* Cold reboot ("dead" migration)

  Guests should cope with hardware changes on cold reboot.
  Nevertheless, users do not appreciate surprise changes, so we better
  control them.  Also, the Windows reactivation spectre lurks.

Our general rule is to keep the guest ABI stable for released machine
types, and change it only in the latest, not-yet-released machine type.

To achieve this, we guard the change by a device property, which
defaults to the new behavior (your patch does that already).  We use
compat properties to flip the default to old behavior for released
machine types.

We occasionally make exceptions for sufficiently harmless guest-visible
changes.  If you think yours is, make your case in your commit message.

Example: USB device property "full-path"

hw/usb/bus.c has

    static Property usb_props[] =3D {
        DEFINE_PROP_STRING("port", USBDevice, port_path),
        DEFINE_PROP_STRING("serial", USBDevice, serial),
--->    DEFINE_PROP_BIT("full-path", USBDevice, flags,
--->                    USB_DEV_FLAG_FULL_PATH, true),
        DEFINE_PROP_BIT("msos-desc", USBDevice, flags,
                        USB_DEV_FLAG_MSOS_DESC_ENABLE, true),
        DEFINE_PROP_END_OF_LIST()
    };

The property is on by default.  We flip the default to off for machine
type pc-1.0 and older:

    static void pc_i440fx_1_0_machine_options(MachineClass *m)
    {
        static GlobalProperty compat[] =3D {
            PC_CPU_MODEL_IDS("1.0")
            { TYPE_ISA_FDC, "check_media_rate", "off" },
            { "virtio-balloon-pci", "class", stringify(PCI_CLASS_MEMORY_RAM=
) },
            { "apic-common", "vapic", "off" },
--->        { TYPE_USB_DEVICE, "full-path", "no" },
        };

        pc_i440fx_1_1_machine_options(m);
        m->hw_version =3D "1.0";
        compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
    }

Done in commit eeb0cf9abf "usb/vmstate: add parent dev path" (v1.1.0).


