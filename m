Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65937C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5C5207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsoHV4uE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5C5207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZH6-0006iC-Fz
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZFO-0005BD-Us
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:04:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32575
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZFN-0004Mf-Vf
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591689876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XCfTtqBrWFkMFwGQvL63ziNTB8W82SIknjoVUOaZITY=;
 b=dsoHV4uE/CPRVK7s+7IVawNjmoXOC6JGyowho4kseISS97TZ9d7v1uWl6MRSCSJ5mFSNAa
 R5a0K2ZddjQQBQJxJidAloJQNMmuOUSWcUUspeg/L3jwLc9WryqaFckZ9gGB52i2+nbzBh
 f6I41EiI7qQqor4YwaXImwHphlL2J28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-SQvEE4BrPUecaKugX94bsw-1; Tue, 09 Jun 2020 04:04:35 -0400
X-MC-Unique: SQvEE4BrPUecaKugX94bsw-1
Received: by mail-wr1-f71.google.com with SMTP id j16so8208064wre.22
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XCfTtqBrWFkMFwGQvL63ziNTB8W82SIknjoVUOaZITY=;
 b=EudgnLqh4Tl+tfqwYhaCGoFvnxFr8aUB/kUPsrRIdQFv/E11WpGRNMNXGNQ3raeyAG
 cIeQnSsvJNHz0Tue4OY5sftdLbwLCX426i0Obm1/hwPQ9o9W+jWiUrrUySsovuBHaxWR
 cLGkq29OmPsFt8FxxuNte99/lK5FRV/MLf+YSS9ppr+jQehjZgMebmgqn/zvHYUVcxe0
 7iL/Lr8Ar4aVFBkbIsR8q7VdmINwOeYh76YfiNCfMg/iCenlL9XDvP3GBTgNfnGBLvut
 1JIrs1DQevHmo9XbgqTgdAat1NM6R8X59ujP+GjN3oDbg+WlYw0k0v3OwU8WCaL3ARiQ
 Ruhw==
X-Gm-Message-State: AOAM531lnje07nkpTYLZFCmUED9tLBY6WvxVcgfkCUkhEkLcJ+uGY3yh
 OszlWA5knkbOO3LUk1FVgzCiSFDvQFC4PH+xZ2AVplYWz0sMPCr+8VBjSaRQS6bojdp0tSCEijq
 Z5/bMcaukrF/vLUk=
X-Received: by 2002:a5d:6144:: with SMTP id y4mr3102790wrt.185.1591689873637; 
 Tue, 09 Jun 2020 01:04:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVznDwksuPHxMbFv+Q6BGCXudZ9/IS84TOlC2qo8MEF8JLF/ZguAuMwfCNTxdKl+YhfIEdVg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr3102771wrt.185.1591689873438; 
 Tue, 09 Jun 2020 01:04:33 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id h7sm2052251wml.24.2020.06.09.01.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:04:32 -0700 (PDT)
Subject: Re: [PATCH v2 08/58] qdev: Convert to qdev_unrealize() manually
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-9-armbru@redhat.com>
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
Message-ID: <78de0144-5601-1a85-6a1e-14fb8320f903@redhat.com>
Date: Tue, 9 Jun 2020 10:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-9-armbru@redhat.com>
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/qdev-core.h | 1 -
>  hw/core/qdev.c         | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index fba29308f7..be6f7c4736 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -328,7 +328,6 @@ void qdev_init_nofail(DeviceState *dev);
>  bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
>  bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
>  void qdev_unrealize(DeviceState *dev);
> -
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
>  HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index b7355fbcd0..4768244f31 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -421,7 +421,7 @@ static void device_reset_child_foreach(Object *obj, ResettableChildCallback cb,
>  void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
>                                    DeviceState *dev, Error **errp)
>  {
> -    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +    qdev_unrealize(dev);
>  }
>  
>  /*
> @@ -1183,7 +1183,7 @@ static void device_unparent(Object *obj)
>      BusState *bus;
>  
>      if (dev->realized) {
> -        object_property_set_bool(obj, false, "realized", &error_abort);
> +        qdev_unrealize(dev);
>      }
>      while (dev->num_child_bus) {
>          bus = QLIST_FIRST(&dev->child_bus);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


