Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD07FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7773E2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROGbY4EL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7773E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZgS-0008IU-Nh
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZfV-0007nD-CB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:31:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZfU-0000sA-89
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591691494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v++jBaaHshM7iDNYkIXV/8PBWyVIhKHEt4iMAAOkn/M=;
 b=ROGbY4EL7Ilm0YRrJd7hbME5I3S4/8VCLGjaLo1dGfDmIlm59dDGt02Af2NsobhfOPEoxA
 OCn2Tj6Ge6CjrlF0y4CCmApABunN2DLmLuiRqUGS21SQbwSmYiUErbEKDGGqCmTDwABAA+
 VCUVO4frFNCRapZIQgDyPR3aZ7YtE00=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-hICrcI_hNAqWRZlRFUaihA-1; Tue, 09 Jun 2020 04:31:33 -0400
X-MC-Unique: hICrcI_hNAqWRZlRFUaihA-1
Received: by mail-wr1-f69.google.com with SMTP id a4so8286365wrp.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v++jBaaHshM7iDNYkIXV/8PBWyVIhKHEt4iMAAOkn/M=;
 b=Ow1lTZZTUlh1XnS8FS5UfdXGrnnZm3h/9l1U3hkL7wYQon5PjOkLyIhcaJynTt3fJN
 YKMfyFpLdPR/jwU0Ilx0oWLgzyJtsInbPc57L5f41KUsCZGgZFcQhJ5PYciCSXJepOA4
 2Ez0Fkgc/O4G3DWAU/R9WvP0ZU1oBrznYjWaEezuWa2+x3I1dE8LtAStc+4eZ6rh8CPL
 lFXbal72+d17UIKgQfXLno9g2vyousxFeC0Nk6/3BRiOwu9Y7i+STm8T0wXgeS2F/pwY
 16Bsw17KeNxMLfNfgq+o+THTuYWV2J8tFEaBsKc0qC15jtjSXyQzLR/I0WntwcgbChpt
 XG3A==
X-Gm-Message-State: AOAM532rYdbPOfoPHPAevgQehEudytIXScSy9WN4+BlOPJt4Jb7tdO/F
 UDSbBgxzS5G6AZDkOiWfsU7lQiz5xVV+nWWIEt278sEZlEFN0edW6lNGK25vb7rIUBmFHoo5pR3
 QHEsVwTqJOFsCJG8=
X-Received: by 2002:adf:9481:: with SMTP id 1mr3094595wrr.396.1591691491312;
 Tue, 09 Jun 2020 01:31:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgEvFxLSGignIVIxcQ0vFxUzFlWZJQBiLELhLl+6hg/zv7QKYx1S3zX74zR7nIohLVcASvVg==
X-Received: by 2002:adf:9481:: with SMTP id 1mr3094578wrr.396.1591691491054;
 Tue, 09 Jun 2020 01:31:31 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id p16sm2607443wru.27.2020.06.09.01.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:31:30 -0700 (PDT)
Subject: Re: [PATCH v2 33/58] auxbus: Convert a use of qdev_set_parent_bus()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-34-armbru@redhat.com>
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
Message-ID: <4ab8b272-341f-7dcc-6ef5-3d24b951940a@redhat.com>
Date: Tue, 9 Jun 2020 10:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-34-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

On 5/29/20 3:44 PM, Markus Armbruster wrote:
> Convert qdev_set_parent_bus()/qdev_init_nofail() to qdev_realize();
> recent commit "qdev: New qdev_new(), qdev_realize(), etc." explains
> why.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/display/xlnx_dp.c | 2 +-
>  hw/misc/auxbus.c     | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 900d95fc93..e6e7f0037f 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1266,7 +1266,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>  
>      aux_bus_realize(s->aux_bus);
>  
> -    qdev_init_nofail(DEVICE(s->dpcd));
> +    qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
>      aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
>  
>      qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index 113f4278aa..e7a5d26158 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -70,7 +70,6 @@ AUXBus *aux_bus_init(DeviceState *parent, const char *name)
>      bus = AUX_BUS(qbus_create(TYPE_AUX_BUS, parent, name));
>      auxtoi2c = object_new_with_props(TYPE_AUXTOI2C, OBJECT(bus), "i2c",
>                                       &error_abort, NULL);
> -    qdev_set_parent_bus(DEVICE(auxtoi2c), BUS(bus));
>  
>      bus->bridge = AUXTOI2C(auxtoi2c);
>  
> @@ -83,7 +82,7 @@ AUXBus *aux_bus_init(DeviceState *parent, const char *name)
>  
>  void aux_bus_realize(AUXBus *bus)
>  {
> -    qdev_init_nofail(DEVICE(bus->bridge));
> +    qdev_realize(DEVICE(bus->bridge), BUS(bus), &error_fatal);
>  }
>  
>  void aux_map_slave(AUXSlave *aux_dev, hwaddr addr)
> @@ -280,7 +279,6 @@ DeviceState *aux_create_slave(AUXBus *bus, const char *type)
>  
>      dev = qdev_new(type);
>      assert(dev);
> -    qdev_set_parent_bus(dev, &bus->qbus);
>      return dev;
>  }
>  
> 

This one was not obvious...

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


