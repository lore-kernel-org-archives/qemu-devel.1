Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C570C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D192078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJJ3TEb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D192078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZu2-0008Uq-7w
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZsz-0007lN-38
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:45:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27063
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZsy-00037C-6O
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591692331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9Em717wjftRxsCd8KgRWAuZ4pdfibzpJI7degPyFR48=;
 b=FJJ3TEb0Lb5vI633CzqrS+f5eycM7AHAeLgo/Obl+blu3JaAu81gF0YRHqkJ97cYwt8EVC
 SqUl3n+nokqOrbfyDXnZzqR3sQraJzyyLpP/gTHCdpixt7xdoO7vDeazPvnTUmmh039/oI
 6uL+psWPg2J9m/I7anltDjAa/TqbSTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-MmeoqJn1MLWx-DwVFr8_iQ-1; Tue, 09 Jun 2020 04:45:29 -0400
X-MC-Unique: MmeoqJn1MLWx-DwVFr8_iQ-1
Received: by mail-wm1-f72.google.com with SMTP id b63so661379wme.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Em717wjftRxsCd8KgRWAuZ4pdfibzpJI7degPyFR48=;
 b=oSPKZ4t7Sed/96CNDCYgqvWnmguPiYPh5ly5NHZwdm+xOVlQ6jzeyn5tfeqTEIiUpK
 UQQTyfFBan+uKs/OhEllGi9mkVqiOShMsjNSvVyRi4USfPAtc1V3VZln4iK2If+PG8B4
 nvtiR6dgBgRx058K8DNN4qpwoLQgYSdpXgRCQOJ1OnshxCgfZho3WDsI3c7O+GO8jX2J
 P58mSOJ/MtVXuFrxSKb0LyGNTxc7Mm4RTVp1NegxGDnErHWv9khqjG2k2jZeYO5C+U10
 01JJL73HxPdMcB5oxyxehx4akMvDpfMJKeZlCB4aLOQj3BHtx1vEl00sMRG0JI89uYgx
 BPtQ==
X-Gm-Message-State: AOAM533JjhLyWQ+29hAf27jns15nZT7w/Qv6ImHBzENSCoW7B7x1UMl4
 QoP9n0D6l0QsxvYPjS+aVBzJjw6yBWFdw0/4ScVh7AbyMNxg3egwQQ/3dUoqADN8yvRRy3aXm+l
 f3sYqNbj0fbJpxJU=
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr2853799wmj.35.1591692327845;
 Tue, 09 Jun 2020 01:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu9sOxk3Ydu6SMMBrG5tYSkhItOAB/VRNHRDJyabofKdpt3t9/Tesk3m+foU1fH15Kv7XQKw==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr2853782wmj.35.1591692327593;
 Tue, 09 Jun 2020 01:45:27 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s2sm2109704wmh.11.2020.06.09.01.45.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:45:27 -0700 (PDT)
Subject: Re: [PATCH v2 46/58] qdev: Drop qdev_realize() support for null bus
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-47-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <ac4cb234-0c4b-d783-8641-a0b0867370d4@redhat.com>
Date: Tue, 9 Jun 2020 10:45:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-47-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 3:45 PM, Markus Armbruster wrote:
> The "null @bus means main system bus" convenience feature is no longer
> used.  Drop it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/qdev.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index a1fdebb3aa..78a06db76e 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -408,8 +408,7 @@ void qdev_init_nofail(DeviceState *dev)
>  /*
>   * Realize @dev.
>   * @dev must not be plugged into a bus.
> - * Plug @dev into @bus if non-null, else into the main system bus.
> - * This takes a reference to @dev.
> + * Plug @dev into @bus.  This takes a reference to @dev.
>   * If @dev has no QOM parent, make one up, taking another reference.
>   * On success, return true.
>   * On failure, store an error through @errp and return false.
> @@ -419,18 +418,7 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>      Error *err = NULL;
>  
>      assert(!dev->realized && !dev->parent_bus);
> -
> -    if (!bus) {
> -        /*
> -         * Assert that the device really is a SysBusDevice before we
> -         * put it onto the sysbus.  Non-sysbus devices which aren't
> -         * being put onto a bus should be realized with
> -         * object_property_set_bool(OBJECT(dev), true, "realized",
> -         * errp);
> -         */
> -        g_assert(object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE));
> -        bus = sysbus_get_default();
> -    }
> +    assert(bus);

Hmm what about renaming that to sysbus_init_nofail() and keep
qdev_init_nofail() (without the bus part)?

>  
>      qdev_set_parent_bus(dev, bus);
>  
> 


