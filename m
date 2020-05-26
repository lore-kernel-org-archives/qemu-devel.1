Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF7420787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A24rgQYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF7420787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdYBx-0000tH-51
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYAl-00082n-Rh
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:55:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYAk-0005I1-GN
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590494105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tZzQZvFafVdRBPokeGJ1nlMpZN2oZAmyg5S27RZF0/I=;
 b=A24rgQYqE0+iuvaCmo6/Ojb7OvCM67Vu+uI0S0iwb7fbRUeavLP82mWeEwjPKHxBYbipYN
 gP+RB8z4s6QIhGUgvKhwpgOVtMYyXFUmRUWPtdvv1qsheTUvzuM9dq/8JdBKKErrqyh3LM
 lZL0DIaBAXD/kaQh8gTPowyfnveI8LM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-CpLXtyFRNeis_LiIlNZTyA-1; Tue, 26 May 2020 07:55:03 -0400
X-MC-Unique: CpLXtyFRNeis_LiIlNZTyA-1
Received: by mail-ed1-f69.google.com with SMTP id dk23so8848823edb.15
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 04:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tZzQZvFafVdRBPokeGJ1nlMpZN2oZAmyg5S27RZF0/I=;
 b=MUqrXiwXUdKZr0i1ZV+6XekiJvIckAzaYBIo3O+pmZ7d9vEcCR1zL/z2sOM8TiEgw4
 7wBXyyx0wqK3rKTV53et2uQepZUFABo11R0+fsGmfBWL7+EVEBzK8um8wyfMqZtspR6P
 IZXsxgn8zwiTf3oXOHds/I7JryNe5DvuRma0jrFLmNzPl39ofDDviUVAWqXuNUuZT8ck
 kJJkMn5D6Vjuum4hCKiUcGLGrP5wGfeLgf6FVUgL6pS8dRDaX4JssHEo5muw/gh0O+00
 RivcRQOHP8iOfbY0qhF2Wfke+TCo1OC5oJYVKy1LvCACYkJDAAlBXNX1Tt6G3UYeOB6P
 rcTg==
X-Gm-Message-State: AOAM5302WbxaegICVw20Rz9jL5ePpGJ9doFUztmkSL86mq1NSECzOMx8
 goZpoPhUUFRAh4HXHxyJ0ziAsiOPx0aD8J9XFGCA27Z2wH9LOOIePp5vwmOwJv1v8W41YJViNZQ
 tlLoRy3o6+xXFTys=
X-Received: by 2002:a05:6402:b0b:: with SMTP id
 bm11mr20184073edb.92.1590494101768; 
 Tue, 26 May 2020 04:55:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6zHdi6r657KsaTqozH3cYif5s6xrlizOKwA8/jGPpuivhWojNSXwyO7/TTwrhZYZaaKypew==
X-Received: by 2002:a05:6402:b0b:: with SMTP id
 bm11mr20184062edb.92.1590494101585; 
 Tue, 26 May 2020 04:55:01 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id ci6sm17904242ejc.60.2020.05.26.04.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 04:55:01 -0700 (PDT)
Subject: Re: [PATCH 30/55] auxbus: New aux_realize_bus(), pairing with
 aux_init_bus()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-31-armbru@redhat.com>
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
Message-ID: <bed7f417-fc23-8170-28ad-9e49a92ecc1c@redhat.com>
Date: Tue, 26 May 2020 13:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-31-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 4:55 PM, Markus Armbruster wrote:
> aux_init_bus() encapsulates the creation of an aux-bus and its
> aux-to-i2c-bridge device.
> 
> Create aux_realize_bus() to similarly encapsulate their realization.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/misc/auxbus.h | 7 +++++++
>  hw/display/xlnx_dp.c     | 2 +-
>  hw/misc/auxbus.c         | 5 +++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
> index a539a98c4b..6ab6cf5bb6 100644
> --- a/include/hw/misc/auxbus.h
> +++ b/include/hw/misc/auxbus.h
> @@ -93,6 +93,13 @@ struct AUXSlave {
>   */
>  AUXBus *aux_init_bus(DeviceState *parent, const char *name);

Previous to your patch, but aux_init_bus() is misnamed.

I'd rather rename this one aux_bus_init() ...

>  
> +/**
> + * aux_realize_bus: Realize an AUX bus.
> + *
> + * @bus: The AUX bus.
> + */
> +void aux_realize_bus(AUXBus *bus);

... and this one aux_bus_realize().

If you mind :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>  /*
>   * aux_request: Make a request on the bus.
>   *
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index dd6aa172f3..b1d90cab1d 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1264,7 +1264,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>      DisplaySurface *surface;
>      struct audsettings as;
>  
> -    qdev_init_nofail(DEVICE(s->aux_bus->bridge));
> +    aux_realize_bus(s->aux_bus);
>  
>      qdev_init_nofail(DEVICE(s->dpcd));
>      aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index 7fb020086f..9b4ccfa39c 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -81,6 +81,11 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *name)
>      return bus;
>  }
>  
> +void aux_realize_bus(AUXBus *bus)
> +{
> +    qdev_init_nofail(DEVICE(bus->bridge));
> +}
> +
>  void aux_map_slave(AUXSlave *aux_dev, hwaddr addr)
>  {
>      DeviceState *dev = DEVICE(aux_dev);
> 


