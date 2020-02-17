Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F5C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0E32070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmjuHuW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0E32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gln-00048g-K3
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3gl5-0003Ph-AT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3gl3-0003lS-HV
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:48:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3gl3-0003kP-8w
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581947300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODgSmBmfR6M+p/MtCLtNi9/r7CBd/ujvgstxCO/Pdh8=;
 b=fmjuHuW4yLIfO6o03weYZ9chN06w4GpqUqAWTcc5dhhOvOeL9JRasPn3hPphcLvzodqpXT
 MwxjR8bbQS/yQuzTmY4+KV0fHNYGN5FVmM/vKv5zChB/0Jj0cNtwUGDzUo15CpRBL0j1QO
 AmGiMI36STI8SK3WMUz7Dsh8BVcKlkI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-F60iPl1XNGul5O1YohXndg-1; Mon, 17 Feb 2020 08:48:13 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so8974903wrm.16
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 05:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X2mdI2L3JfM6pPabXCTJuyBJC3fWo6ELdnmYb5tuTlY=;
 b=bBeUDgseTxjfurR6H48SGzhlNxcpOzCbFtI68MjnfEwk26INe+oCqKklER+xxGWFkb
 6EOi2a/2xIpVDBcu+2QV68MAkobkwaORpIQBhm4x4fyeLZOAHVHX0QoBBCCbaY79tLFP
 SckDkcu4PzlwaGAu+Lei2eTXc56iSRCylHPvnVNij8gAZUsUi39l9hWqFBj1oflDAT7p
 0WVXIkcl0Sy/zxyVRkW1fmTHlYfsfUUtTL5kpPTs1OdlUmcLMZrUz091zc1bskzNP9/O
 +BMKZhDOXWJyuUTk8bfWzNkVg18XFITHNhE7AJuIdLKEv64fNCs767BH1aU6ePgxh8s5
 cx9w==
X-Gm-Message-State: APjAAAXMOq6anEh0hGYg1jJQwLLu0APdY/w17d41JTQicX3acrbdmGMb
 6kmFtHWl882EWIoI5lM6MYUZg0LihA2mZSiXoQiCKSyXAH/pxafl2K1tW3GCoe4nX5rLegpsIKv
 vSUgN0rXh3R8Z9rQ=
X-Received: by 2002:a5d:5742:: with SMTP id q2mr17562081wrw.145.1581947292896; 
 Mon, 17 Feb 2020 05:48:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ0Kmy44SbMQW3lQ0/ggyppWRX17v6NE5MRe/fekigDqL0eEI8CLPhSDehtfyQFkcDFz7G4Q==
X-Received: by 2002:a5d:5742:: with SMTP id q2mr17562060wrw.145.1581947292647; 
 Mon, 17 Feb 2020 05:48:12 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id n8sm1133005wrx.42.2020.02.17.05.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 05:48:12 -0800 (PST)
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
Date: Mon, 17 Feb 2020 14:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: F60iPl1XNGul5O1YohXndg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 2/17/20 2:25 PM, Peter Maydell wrote:
> On Sat, 15 Feb 2020 at 15:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> In commit f3a508eb4e the Euler Robot reported calling timer_new()
>> in instance_init() can leak heap memory. The easier fix is to
>> delay the timer creation at instance realize(). Similarly move
>> timer_del() into a new instance unrealize() method.
>>
>> This case was found with the following coccinelle script:
>>
>>      @ match @
>>      identifier instance_init;
>>      typedef Object;
>>      identifier obj;
>>      expression val, scale;
>>      identifier clock_type, callback, opaque;
>>      position pos;
>>      @@
>>      static void instance_init(Object *obj)
>>      {
>>        <...
>>      (
>>        val =3D timer_new@pos(clock_type, scale, callback, opaque);
>>      |
>>        val =3D timer_new_ns@pos(clock_type, callback, opaque);
>>      |
>>        val =3D timer_new_us@pos(clock_type, callback, opaque);
>>      |
>>        val =3D timer_new_ms@pos(clock_type, callback, opaque);
>>      )
>>        ...>
>>      }
>>
>>      @ script:python @
>>      f << match.instance_init;
>>      p << match.pos;
>>      @@
>>      print "check %s:%s:%s in %s()" % (p[0].file, p[0].line, p[0].column=
, f)
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>>   hw/ipmi/ipmi_bmc_extern.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
>> index f9a13e0a44..9144ac6c38 100644
>> --- a/hw/ipmi/ipmi_bmc_extern.c
>> +++ b/hw/ipmi/ipmi_bmc_extern.c
>> @@ -463,6 +463,15 @@ static void ipmi_bmc_extern_realize(DeviceState *de=
v, Error **errp)
>>
>>       qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
>>                                chr_event, NULL, ibe, NULL, true);
>> +
>> +    ibe->extern_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeo=
ut, ibe);
>> +}
>> +
>> +static void ipmi_bmc_extern_unrealize(DeviceState *dev, Error **errp)
>> +{
>> +    IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(dev);
>> +
>> +    timer_del(ibe->extern_timer);
>>   }
>>
>>   static int ipmi_bmc_extern_post_migrate(void *opaque, int version_id)
>> @@ -502,7 +511,6 @@ static void ipmi_bmc_extern_init(Object *obj)
>>   {
>>       IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(obj);
>>
>> -    ibe->extern_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeo=
ut, ibe);
>>       vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
>>   }
>>
>> @@ -510,7 +518,6 @@ static void ipmi_bmc_extern_finalize(Object *obj)
>>   {
>>       IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(obj);
>>
>> -    timer_del(ibe->extern_timer);
>>       timer_free(ibe->extern_timer);
>>   }
>=20
> So we now call timer_new in realize, and timer_del in unrealize,
> but timer_free in finalize. This seems unbalanced -- why not
> call timer_free in unrealize too, if we're moving things?
>=20
> Also, this is a case of code that's actually doing things right:
> we free the memory that we allocated in init in finalize. So
> we're not fixing any leak here, we're just moving code around
> (which is reasonable if we're trying to standardize on "call
> timer_new in realize, not init", but should be noted in the
> commit message).

While I understand your point, I am confused because the documentation=20
on unrealize() and finalize() is rather scarce (and not obvious for=20
non-native english speaker). I think I'm not understanding QOM instance=20
lifetime well (in particular hotplug devices) so I will let this series go.

Similar confusions:

* https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg03079.html

Eduardo Habkost wrote:
 > Philippe Mathieu-Daud=C3=A9 wrote:
 >> IIUC when we use both init() and realize(), realize() should
 >> only contains on code that consumes the object properties...
 >> But maybe the design is not clear. Then why not move all the
 >> init() code to realize()?
 >
 > Normally I would recommend the opposite: delay as much as
 > possible to realize(), to avoid unwanted side effects when
 > (e.g.) running qom-list-properties.

* https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04143.html

David Hildenbrand wrote:
 >> Philippe Mathieu-Daud=C3=A9 wrote:
 >> Similarly to your other cleanups, shouldn't we move the
 >> timer_new_ns() into a realize() function, then do the
 >> timer_del() in unrealize()?
 >
 > include/hw/qdev-core.h
 >
 > "Trivial field initializations should go into
 > #TypeInfo.instance_init. Operations depending on @props
 > static properties should go into @realize."

>=20
> thanks
> -- PMM
>=20


