Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BDB20723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWaMOctW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BDB20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jewQ5-0002Gz-Ln
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 04:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jewPO-0001cF-8s
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:59:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54849
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jewPM-0008H5-UU
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590825596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uB/o9fqNrCLaZeek7URsSglCRgQFsRi2htD+jSgn7Zo=;
 b=dWaMOctWLaPvTjV2QUn7MDvBqSSgLdjBRVHriYwKwo2DN/3ypKgsRDL71bWzdi3Pzu4e8r
 B+KpK1+/nG2VHOlm4Or9jRygFjvGW+zjCEzv4377Rgtc46EEAgvyXnTtEOCYimLqtsw2/0
 b9ad5ZQ0Q1O7KmSLhKLcpr7xKtM+Iv8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-sZYxl2KoMKS1Ps9DYeVjBQ-1; Sat, 30 May 2020 03:59:54 -0400
X-MC-Unique: sZYxl2KoMKS1Ps9DYeVjBQ-1
Received: by mail-wm1-f69.google.com with SMTP id 18so1698401wmu.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 00:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uB/o9fqNrCLaZeek7URsSglCRgQFsRi2htD+jSgn7Zo=;
 b=H4pNX/hrR9DlxaBMQ5RM8HwZONxoJn9K5mxoJoK9/iRKm1KGWPu5AQM29KB00vO6Ly
 jjnx7j6qQRXA3Q1Rn3bEf25Ar2kf4PQhUso31abc2RfI3VaEXXpNhy8jTQwC80aFb79C
 9pivk/WO+NVOY9zH2zHvwjjOk0arAjuFdarPWGwEQHLRxukvAqrn7wFfCiX/7+fymDNe
 2zExn7C0SHKqSIfs5tsXrFfquFBwIS7NrDJaBafEil/jugT8obXQLqxzP52+1KMK3ZrX
 lpYlI+s2QFXtmgQ8MAoxuJ3ujZRnxtAB70IrxgqpGEz8TyZf21HXA3r8FIUk5BidNi9d
 7fIw==
X-Gm-Message-State: AOAM533+0GCGtA1AB1Ypwc5xB7Htb3PsmKEnPY3uRyJJOLlGSWBaTuTf
 pysP7r1iwh8rScdTgOpomHKOCPyJU+RI6T+QsU7IbQo6UF8pmFzwBTZTqcRhcWZrPbiLgHxHrcJ
 D09Zcq9U4/bo09x0=
X-Received: by 2002:adf:ce02:: with SMTP id p2mr13347257wrn.152.1590825592931; 
 Sat, 30 May 2020 00:59:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwtm4e7qMnljltirIwJmmkVjac4e2uRrvhCoTwlxQ/o4XTeMuBiaVXx3VuE36gTqS6DF25Pg==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr13347240wrn.152.1590825592664; 
 Sat, 30 May 2020 00:59:52 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id m129sm2620627wmf.2.2020.05.30.00.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2020 00:59:52 -0700 (PDT)
Subject: Re: [PATCH v2 54/58] qdev: Make qdev_realize() support bus-less
 devices
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-55-armbru@redhat.com>
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
Message-ID: <1ef7e53a-c2b0-5c4f-8317-04c5129b4073@redhat.com>
Date: Sat, 30 May 2020 09:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-55-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 01:07:42
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
> So far, qdev_realize() supports only devices that plug into a bus:
> argument @bus cannot be null.  Extend it to support bus-less devices,
> too.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/qdev.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 78a06db76e..50336168f2 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -408,7 +408,7 @@ void qdev_init_nofail(DeviceState *dev)
>  /*
>   * Realize @dev.
>   * @dev must not be plugged into a bus.
> - * Plug @dev into @bus.  This takes a reference to @dev.
> + * If @bus, plug @dev into @bus.  This takes a reference to @dev.
>   * If @dev has no QOM parent, make one up, taking another reference.
>   * On success, return true.
>   * On failure, store an error through @errp and return false.
> @@ -418,9 +418,12 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>      Error *err = NULL;
>  
>      assert(!dev->realized && !dev->parent_bus);
> -    assert(bus);

This simpler form is easier to review IMHO:

       if (!bus) {
            assert(!DEVICE_GET_CLASS(dev)->bus_type);
       }

Whichever you prefer (the simpler the better):
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
> -    qdev_set_parent_bus(dev, bus);
> +    if (bus) {
> +        qdev_set_parent_bus(dev, bus);
> +    } else {
> +        assert(!DEVICE_GET_CLASS(dev)->bus_type);
> +    }
>  
>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
>      if (err) {
> 


