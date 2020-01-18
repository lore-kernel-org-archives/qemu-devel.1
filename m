Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67047C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F15620730
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYPATsqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F15620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ishuP-0002SB-9I
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 01:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ishtT-0001YK-Ip
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ishtS-0000Zv-5I
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:47:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ishtS-0000Yt-23
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579330056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2p7Zf2TpHmpHzxxQ//niTn1MREF0HG6y9uH6LGw9rZM=;
 b=dYPATsqLDSmdgvU9V2szOjmcaJ+763IY3hL8aQgPTUTKknoROfsaeUb0Ub++rwr4atBWI+
 tX8dQmLDOseWJlCLq0jxrjMONrS8+sxeKyxofrlKMdiOz/VssGNRRCMrCiqmsSsV4WqYh1
 OTZ1hj8s7p5gOObIu+h9w0isMlpNi2g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-5KLERwBkM-qj20yV6VDhYA-1; Sat, 18 Jan 2020 01:47:35 -0500
Received: by mail-wr1-f72.google.com with SMTP id c17so11378401wrp.10
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 22:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xwE2SHz3bhUqrn9zsMbUEy1mlKQ+6G4R/DUx/g5udw0=;
 b=auPThha8Uqq+J9m00uBbKOuM+WnPpjl7hMBKaJVetCqKAHBc8kKRvSRjhSjy9XfP+h
 +POCIv32gzSHYez6PnCZrkf80VLREiIzo+gcG1X58kYSBjUFSOOOUtt7KQh3ycDhHnWi
 Dw18naomPWTAK54NyXI1AZdq5/YnavK1jTQUJFvnPeKW/u0XakA2QQiqHksxT88lNDZq
 G3Z4vd38Q986qBY94mdO4x5u33J+zrhkYmPvRWQSDu1IpZSmQrRFizTVgE7Jku9RG8R3
 FUrnihJ69glBuhgNHsIpJDIHdmHnzDaP50dGBtQ7/uFAdLjLnzPIikT+y6J6LI8hMhLv
 vEnA==
X-Gm-Message-State: APjAAAW6Hyqnl4mODO4WVEJrwirFly075uMeH/VFS0cNRtaWHEFYZdl9
 hBugTU46uSC7xGSSPR/5LIquk5nIDqpfslFBetx8Cb+Wp3WDaDYUZq2H+oG943hX7xKMtzJt6MA
 4tIq1tnVrJmDjLyc=
X-Received: by 2002:a5d:4805:: with SMTP id l5mr6852037wrq.3.1579330053997;
 Fri, 17 Jan 2020 22:47:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyc2E6eSnVNhESMMDPnEG2PHt1kvI8gg7DpEy2voUtKbWtoqYTOHcojIHXPNHVSq36aK6GW/g==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr6852008wrq.3.1579330053669;
 Fri, 17 Jan 2020 22:47:33 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id p17sm2514004wmk.30.2020.01.17.22.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 22:47:33 -0800 (PST)
Subject: Re: [PATCH v7 08/11] hw/core: deprecate old reset functions and
 introduce new ones
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-9-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2976a5cc-142c-7a53-119b-9dc8c9e4d366@redhat.com>
Date: Sat, 18 Jan 2020 07:47:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115123620.250132-9-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: 5KLERwBkM-qj20yV6VDhYA-1
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
> Deprecate device_legacy_reset(), qdev_reset_all() and
> qbus_reset_all() to be replaced by new functions
> device_cold_reset() and bus_cold_reset() which uses resettable API.
>=20
> Also introduce resettable_cold_reset_fn() which may be used as a
> replacement for qdev_reset_all_fn and qbus_reset_all_fn().
>=20
> Following patches will be needed to look at legacy reset call sites
> and switch to resettable api. The legacy functions will be removed
> when unused.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/qdev-core.h  | 27 +++++++++++++++++++++++++++
>   include/hw/resettable.h |  9 +++++++++
>   hw/core/bus.c           |  5 +++++
>   hw/core/qdev.c          |  5 +++++
>   hw/core/resettable.c    |  5 +++++
>   5 files changed, 51 insertions(+)
>=20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 1b4b420617..b84fcc32bf 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -406,6 +406,13 @@ int qdev_walk_children(DeviceState *dev,
>                          qdev_walkerfn *post_devfn, qbus_walkerfn *post_b=
usfn,
>                          void *opaque);
>  =20
> +/**
> + * @qdev_reset_all:
> + * Reset @dev. See @qbus_reset_all() for more details.
> + *
> + * Note: This function is deprecated and will be removed when it becomes=
 unused.
> + * Please use device_cold_reset() now.
> + */
>   void qdev_reset_all(DeviceState *dev);
>   void qdev_reset_all_fn(void *opaque);
>  =20
> @@ -418,10 +425,28 @@ void qdev_reset_all_fn(void *opaque);
>    * hard reset means that qbus_reset_all will reset all state of the dev=
ice.
>    * For PCI devices, for example, this will include the base address reg=
isters
>    * or configuration space.
> + *
> + * Note: This function is deprecated and will be removed when it becomes=
 unused.
> + * Please use bus_cold_reset() now.
>    */
>   void qbus_reset_all(BusState *bus);
>   void qbus_reset_all_fn(void *opaque);
>  =20
> +/**
> + * device_cold_reset:
> + * Reset device @dev and perform a recursive processing using the resett=
able
> + * interface. It triggers a RESET_TYPE_COLD.
> + */
> +void device_cold_reset(DeviceState *dev);
> +
> +/**
> + * bus_cold_reset:
> + *
> + * Reset bus @bus and perform a recursive processing using the resettabl=
e
> + * interface. It triggers a RESET_TYPE_COLD.
> + */
> +void bus_cold_reset(BusState *bus);
> +
>   /**
>    * device_is_in_reset:
>    * Return true if the device @dev is currently being reset.
> @@ -452,6 +477,8 @@ void qdev_machine_init(void);
>    * device_legacy_reset:
>    *
>    * Reset a single device (by calling the reset method).
> + * Note: This function is deprecated and will be removed when it becomes=
 unused.
> + * Please use device_cold_reset() now.
>    */
>   void device_legacy_reset(DeviceState *dev);
>  =20
> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
> index 3f90da5b5b..0c1adf49ee 100644
> --- a/include/hw/resettable.h
> +++ b/include/hw/resettable.h
> @@ -221,6 +221,15 @@ bool resettable_is_in_reset(Object *obj);
>    */
>   void resettable_change_parent(Object *obj, Object *newp, Object *oldp);
>  =20
> +/**
> + * resettable_cold_reset_fn:
> + * Helper to call resettable_reset((Object *) opaque, RESET_TYPE_COLD).
> + *
> + * This function is typically useful to register a reset handler with
> + * qemu_register_reset.
> + */
> +void resettable_cold_reset_fn(void *opaque);
> +
>   /**
>    * resettable_class_set_parent_phases:
>    *
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 2698f715bd..3dc0a825f0 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -68,6 +68,11 @@ int qbus_walk_children(BusState *bus,
>       return 0;
>   }
>  =20
> +void bus_cold_reset(BusState *bus)
> +{
> +    resettable_reset(OBJECT(bus), RESET_TYPE_COLD);
> +}
> +
>   bool bus_is_in_reset(BusState *bus)
>   {
>       return resettable_is_in_reset(OBJECT(bus));
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 5fac4cd8fc..a7a7abe569 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -361,6 +361,11 @@ void qbus_reset_all_fn(void *opaque)
>       qbus_reset_all(bus);
>   }
>  =20
> +void device_cold_reset(DeviceState *dev)
> +{
> +    resettable_reset(OBJECT(dev), RESET_TYPE_COLD);
> +}
> +
>   bool device_is_in_reset(DeviceState *dev)
>   {
>       return resettable_is_in_reset(OBJECT(dev));
> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
> index e99bb30058..7647ef6863 100644
> --- a/hw/core/resettable.c
> +++ b/hw/core/resettable.c
> @@ -264,6 +264,11 @@ void resettable_change_parent(Object *obj, Object *n=
ewp, Object *oldp)
>       }
>   }
>  =20
> +void resettable_cold_reset_fn(void *opaque)
> +{
> +    resettable_reset((Object *) opaque, RESET_TYPE_COLD);
> +}
> +
>   void resettable_class_set_parent_phases(ResettableClass *rc,
>                                           ResettableEnterPhase enter,
>                                           ResettableHoldPhase hold,
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


