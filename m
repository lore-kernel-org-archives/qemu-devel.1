Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED86C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49AAD20656
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaEKVOW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AAD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3jxk-0007MG-G4
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3jww-0006jW-NE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3jwu-0002lu-Ml
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:12:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20404
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3jwu-0002lS-2E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581959566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LXohCu8xudk+6QiHIbftTf4/RotCsc+mPmvBzYm/Ddw=;
 b=YaEKVOW4NvHPPohlNW8FZCrCmsYZ4wVVk5HYzBEJW6kbjEXPh4m7NslKHYI2SI53+V0ib9
 sKFaLYD4OHFDsaYZ5NapW/E0SnKHQnhbD5sSJMFJhksj6L9vmd+mrgEANUe8hcowDWgl46
 hISiL2hVqtIEpnKXzZ4fCrZzQspFhU0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-FlxJpcU8NfCydFzCWoaJJg-1; Mon, 17 Feb 2020 12:12:45 -0500
Received: by mail-wr1-f69.google.com with SMTP id r1so9228688wrc.15
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 09:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xEH0MJHIh3hel+28QiuAyGxtKz1GN1zXFg55ShF8SaA=;
 b=nL8cc/epNB7mdLgYzsWBm69bfRBBMC2Gnl9+OBXVIXNhGHoTk5xpef83/HM7PKxg7c
 7luwUKfiJOI31b2cf5gwpwjIs/WVPS/puCOgpeKwEs3USdQw6w97rB2BsibPvpWBGJrG
 nGqwTQ0M0mDnWP7U2kh/jq6hV4uuGUPJnfbAJ2e8uCTujs7kWNOwxyOEb5dDcP/KzfD3
 RB4lQUw0djoER78WrFsB7alBil3eU/QfkEZd9L+z8fwol6r3hB7hmcZghKUzLrxrw8Pm
 aFPtYuPiYWeZ/aZow8zeGu6rTKSO/DEm8EXo7WdmXie6Oknvi9y6THN/cmMevpsJKOE7
 FHSg==
X-Gm-Message-State: APjAAAWRDdlIWC+1XT19MPqWQq9zB6mQsgvZ+iW0alXmv3/+bifXd/PD
 4EjbgNKEK9kwd5zAbe1qiuFMXUu54MW6EYWu86oGNTC3/ZziigFF5ewLNndGZNWcQ8zqBY6dh+Q
 A/8v9yuNy3+NBDc0=
X-Received: by 2002:adf:8564:: with SMTP id 91mr23847714wrh.252.1581959563788; 
 Mon, 17 Feb 2020 09:12:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSwb7h6J2JLlNV64EA84R6DozxRfZ2sYtutIyuhdJAus4G7fMo/U3+xzkvP3y/4OmGDzGgIQ==
X-Received: by 2002:adf:8564:: with SMTP id 91mr23847682wrh.252.1581959563497; 
 Mon, 17 Feb 2020 09:12:43 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id r5sm1782861wrt.43.2020.02.17.09.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 09:12:43 -0800 (PST)
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
 <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
 <e530629d-c029-1d7c-b5b7-cdbbeb397a4d@redhat.com>
 <CAFEAcA-KzWv=_kZUPNE6yyUSA36XY+q91ihJ_xh4euJ9RsyaLA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2ae28d4-3864-dfc6-2033-93bbd7aa865e@redhat.com>
Date: Mon, 17 Feb 2020 18:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KzWv=_kZUPNE6yyUSA36XY+q91ihJ_xh4euJ9RsyaLA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: FlxJpcU8NfCydFzCWoaJJg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 5:32 PM, Peter Maydell wrote:
> On Mon, 17 Feb 2020 at 16:15, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>> Per this comment in qdev.c, unrealize() is the expected default:
>>
>>       /* by default all devices were considered as hotpluggable,
>>        * so with intent to check it in generic qdev_unplug() /
>>        * device_set_realized() functions make every device
>>        * hotpluggable. Devices that shouldn't be hotpluggable,
>>        * should override it in their class_init()
>>        */
>>       dc->hotpluggable =3D true;
>=20
> This comment sounds like it's documenting what was the
> previous default ("were considered") and making a minimal
> change to avoid breaking existing code where a device
> does want to be hotpluggable but isn't explicitly saying so.
> I forget how exactly it works (the mechanism has changed
> several times) but in practice a sysbus device is generally
> not hotpluggable, and that's what most devices are.
>=20
>> I get for qemu-system-aarch64:
>>
>>
>> - qdev objects missing instance_finalize():
>>
>>       bcm2835-sdhost-bus
>>       PCIE
>>       pxa2xx-mmci-bus
>>       qtest-accel
>>       sdhci-bus
>>       tcg-accel
>=20
> Note that you don't need an instance_finalize() if it
> would have nothing to do, which may be the case here.
>=20
>> - non-hotpluggable devices implementing unrealize():
>>
>>       VGA
>=20
> Not sure which device this is, I couldn't find a TYPE_
> define with this name. Is it an abstract or common
> device type used by the hotpluggable pci VGA card?

This is TYPE_PCI_VGA (hw/display/vga-pci.c).

>=20
>> - hotpluggable devices missing unrealize()
>>
>>       a15mpcore_priv
>>       a9mpcore_priv
>=20
> Most of these are not really hotpluggable. What is
> confusing your test code is that sysbus devices get
> the default 'hotpluggable =3D true' setting, but other
> conditions usually prevent hotplugging. (The reason
> hotpluggable is true is the default is because of
> handling of 'dynamic sysbus' devices which live on
> the 'platform bus'.) In particular, I think that
> anything with !dc->user_creatable can't be hotplugged
> unless board code specifically tries it, which would
> be a bug for most of these devices.

OK, checking '!dc->user_creatable' removes:

     ads7846
     aer915
     corgi-ssp
     dpcd
     ds1338
     i2c-ddc
     lm8323
     max1111
     max7310
     mx25l25635e
     mx66l1g45g
     mx66u51235f
     n25q128
     n25q256a
     n25q512a11
     nand
     pca9552
     pxa2xx-i2c-slave
     s25sl12801
     sd-card
     sii9022
     spitz-lcdtg
     ssd0303
     ssd0323
     sst25vf016b
     sst25wf080
     tmp105
     tmp423
     tosa_dac
     tosa-ssp
     twl92230
     w25q256
     w25q512jv
     wm8750
     zipit-lcd

Previous list only reduced from 300 to 265.

I noticed this function, maybe I need to check parent_bus too:

static bool device_get_hotpluggable(Object *obj, Error **errp)
{
     DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
     DeviceState *dev =3D DEVICE(obj);

     return dc->hotpluggable && (dev->parent_bus =3D=3D NULL ||
                                 qbus_is_hotpluggable(dev->parent_bus));
}

>=20
> Also, if there isn't anything for a device's unrealize
> method to do, it doesn't need to provide one.

This point is hard to check with simply with qtest.

Thanks for your comments, it helped sorting few things out.

>=20
> thanks
> -- PMM
>=20


