Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB9AC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C362724686
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiXau9l+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C362724686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ishtp-0001iE-Ow
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 01:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ishsx-0001BW-Sm
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ishsw-0000Gu-5a
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:47:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ishsw-0000GU-2R
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579330025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRqaR56cJpvbai9yAvL+J1q45nyzMQu1qCQvWAgHzcg=;
 b=PiXau9l+OeVC+WuGpWhH9KschJgGL2xvsGzAxPu/vZwfFh9H0OJYNYvTdUb0lgocPj9yp4
 uGqcGgC3wnKYUNLy6vEu7QVqPB235DCtQ6I0ju2uX3wo2C+wzBPZ9u6dSAlJ9C52QvUA/7
 x68RfQpyFpffKrVTPr1MzjL3YyafP7c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-V2FWfPylN6i_liSPVxz6pQ-1; Sat, 18 Jan 2020 01:47:04 -0500
Received: by mail-wr1-f69.google.com with SMTP id r2so11433068wrp.7
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 22:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FSy4R2YwJ1TKNRv5yuXm5LLfi891nwKxTfGM/8JFSko=;
 b=fyFFVwEPGCw++/wCoQMHWXbvCjAWAzoJ+n06zcN2S+ag+s4i0mCSvowl5vlzW31pFt
 MnPhvptJaRzvM2I/s7U6CTWnWwY/3my++QVYTgs0AGwgopHaQKo5g1M46yXdcZ6xfAlM
 hJXQ1buCDx9HvlFni7msZ/63CzSnl5uewtA6MouSuHFBvGsJot3jKaUcQJSAAHBJCov/
 GBGU0L/3bls93xbbYnKfx/SDbQcsAFTXlX/kC+PaSePT8bkZJ8In1cyo/c9m6uKbpwH1
 OEoEWPafQKcpXfacL6iyTsI1lXLjiR3Zd0Tr8jtvd3cm2wIMZVFlVas7kC3PoifJ+OqT
 tDjA==
X-Gm-Message-State: APjAAAW2qldc2HrCjsVAXIQBL0t+iFCK5/V8tu6JUGYJnjEQ7RYTdHko
 MkQwFOox7MSSDUoCnQjS6SEg6NZKx3zCKncvybSTr8kBlDnNLDLnNYVLKSk8awh5vV0IALRS8sV
 DA0eYq87Zi9FNPyA=
X-Received: by 2002:a5d:6692:: with SMTP id l18mr6751148wru.382.1579330022770; 
 Fri, 17 Jan 2020 22:47:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZL76gKdOZnvLXL//P6hmbhY1vnMJv9sk4j+EireginI9abHKGWIUKA21vI/EGHjPy2hAPCA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr6751127wru.382.1579330022473; 
 Fri, 17 Jan 2020 22:47:02 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a16sm37777015wrt.37.2020.01.17.22.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 22:47:01 -0800 (PST)
Subject: Re: [PATCH v7 07/11] hw/core/qdev: update hotplug reset regarding
 resettable
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-8-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7c89613a-a263-29b8-228c-e187ce581724@redhat.com>
Date: Sat, 18 Jan 2020 07:47:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115123620.250132-8-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: V2FWfPylN6i_liSPVxz6pQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 1:36 PM, Damien Hedde wrote:
> This commit make use of the resettable API to reset the device being
> hotplugged when it is realized. Also it ensures it is put in a reset
> state coherent with the parent it is plugged into.
>=20
> Note that there is a difference in the reset. Instead of resetting
> only the hotplugged device, we reset also its subtree (switch to
> resettable API). This is not expected to be a problem because
> sub-buses are just realized too. If a hotplugged device has any
> sub-buses it is logical to reset them too at this point.
>=20
> The recently added should_be_hidden and PCI's partially_hotplugged
> mechanisms do not interfere with realize operation:
> + In the should_be_hidden use case, device creation is
> delayed.
> + The partially_hotplugged mechanism prevents a device to be
> unplugged and unrealized from qdev POV and unrealized.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>=20
> v7 update: inline resettable_state_clear()
>=20
> v6 update: clear the reset state before doing any reset. Although it
> is apparently highly improbable that a device be realized again after
> being unrealized. See here for a discussion about this point and the
> partially_hotplugged/shoud_be_hidden cases.
> https://lists.nongnu.org/archive/html/qemu-devel/2019-11/msg04897.html
> ---
>   include/hw/resettable.h | 11 +++++++++++
>   hw/core/qdev.c          | 15 ++++++++++++++-
>   2 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
> index 3c87ab86c7..3f90da5b5b 100644
> --- a/include/hw/resettable.h
> +++ b/include/hw/resettable.h
> @@ -153,6 +153,17 @@ struct ResettableState {
>       bool exit_phase_in_progress;
>   };
>  =20
> +/**
> + * resettable_state_clear:
> + * Clear the state. It puts the state to the initial (zeroed) state requ=
ired
> + * to reuse an object. Typically used in realize step of base classes
> + * implementing the interface.
> + */
> +static inline void resettable_state_clear(ResettableState *state)
> +{
> +    memset(state, 0, sizeof(ResettableState));
> +}
> +
>   /**
>    * resettable_reset:
>    * Trigger a reset on an object @obj of type @type. @obj must implement
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 310b87e25a..5fac4cd8fc 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -937,6 +937,12 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
>               }
>           }
>  =20
> +        /*
> +         * Clear the reset state, in case the object was previously unre=
alized
> +         * with a dirty state.
> +         */
> +        resettable_state_clear(&dev->reset);
> +
>           QLIST_FOREACH(bus, &dev->child_bus, sibling) {
>               object_property_set_bool(OBJECT(bus), true, "realized",
>                                            &local_err);
> @@ -945,7 +951,14 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
>               }
>           }
>           if (dev->hotplugged) {
> -            device_legacy_reset(dev);
> +            /*
> +             * Reset the device, as well as its subtree which, at this p=
oint,
> +             * should be realized too.
> +             */
> +            resettable_assert_reset(OBJECT(dev), RESET_TYPE_COLD);
> +            resettable_change_parent(OBJECT(dev), OBJECT(dev->parent_bus=
),
> +                                     NULL);
> +            resettable_release_reset(OBJECT(dev), RESET_TYPE_COLD);
>           }
>           dev->pending_deleted_event =3D false;
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


