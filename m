Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6702C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA5C2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcEAvkPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA5C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrHs-0002MC-VY
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxrGg-0001Ix-5b
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:21:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxrGd-0002Dw-Kc
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595334066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=InUzaccrmNy/swXNSDOF02jgXadZa9GzUgDHmoFRGlM=;
 b=ZcEAvkPEFDn2JAGvLKC0M8ddC7+oo6i3VUQWHUKricTGgqYOsdeOPQa6DE1dj5Pht6XReC
 CuWIT9lu3SegXYVSO9S1fScXnw1t4cuDp13iVWhXLunP+bcjuiwf21oYDePyIg9BHhB9V/
 RFvU6jppO08mmli6LJ7GZoVSi4kvEvI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-OI4258SGPDOXVYsYg-0Mqw-1; Tue, 21 Jul 2020 08:21:04 -0400
X-MC-Unique: OI4258SGPDOXVYsYg-0Mqw-1
Received: by mail-wm1-f69.google.com with SMTP id l5so1174849wml.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=InUzaccrmNy/swXNSDOF02jgXadZa9GzUgDHmoFRGlM=;
 b=U0Wmdn7X8Jx9hGI70DmKjUPh0MCrnsbUFS+P3wgyB+LBXbZIfNy0x8bVhnYHgNkK2e
 ZBbmpywN1kOS6J5XAtMZrxGCBV8O/VxqKES5TRNYt7K2ism6nceJ7saGlBU/0G6XRSzT
 4Uxa80vXtINV9GQpOi96NrVWRP+wGu+j+hs2W0zrJ49aTOzGqPRDV/SOcdWKuVpJNWvV
 SGJ5x7Krb/SuvgzDHe4d40DoT+4ozLh9Bhqi1uWf7uXUE/tQbg2vPYZDo3sG2B7PS0hj
 fNA7ErhuzHqVb2NofoyCKRROcT58zp7Qe+lDi70Ye4y8eEu2FSghGcThcmNqJ5Mu+OjX
 d5EQ==
X-Gm-Message-State: AOAM531Epkg9Nt5KD9hX1TyOciBsAyBNBxBMu2uT01sSwaUvqLcezeFZ
 ajEK0XKFKLWaOswxROUclNG4qC3b3eYmQ+M08MdOlooEAIPgNWf8/7LUwYlgrJC1hBbX2Q/s570
 F6ntYXgJF3DVQRfc=
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr3735008wmc.176.1595334063035; 
 Tue, 21 Jul 2020 05:21:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/F5tMyMYTZic5Yw21QrJkItBQDX2aX01SlNhO96UhDuus6gh0iOwcwpAX9GxeYGCNqOe0BQ==
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr3734989wmc.176.1595334062808; 
 Tue, 21 Jul 2020 05:21:02 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id e8sm36266428wrp.26.2020.07.21.05.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 05:21:02 -0700 (PDT)
Subject: Re: [PATCH] virtio: Drop broken and superfluous
 object_property_set_link()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200721121153.1128844-1-armbru@redhat.com>
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
Message-ID: <17baa82c-9341-4b3d-1e20-27a2c8a88818@redhat.com>
Date: Tue, 21 Jul 2020 14:21:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200721121153.1128844-1-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, mst@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, frederic.konrad@adacore.com, arei.gonglei@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 2:11 PM, Markus Armbruster wrote:

Is there a line missing here?

> virtio_crypto_pci_realize() and copies the value of vcrypto->vdev's

                              ^^^

> property "cryptodev" to vcrypto's property:
> 
>     object_property_set_link(OBJECT(vrng), "rng", OBJECT(vrng->vdev.conf.rng),
>                              NULL);
> 
> Since it does so only after realize, this always fails, but the error
> is ignored.
> 
> It's actually superfluous: vcrypto's property is an alias of
> vcrypto->vdev's property, created by virtio_instance_init_common().
> 
> Drop the call.
> 
> Same for virtio_ccw_crypto_realize(), virtio_rng_pci_realize(),
> virtio_ccw_rng_realize().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/s390x/virtio-ccw-crypto.c  | 3 ---
>  hw/s390x/virtio-ccw-rng.c     | 3 ---
>  hw/virtio/virtio-crypto-pci.c | 2 --
>  hw/virtio/virtio-rng-pci.c    | 3 ---
>  4 files changed, 11 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
> index 570c0333fc..358c74fb4b 100644
> --- a/hw/s390x/virtio-ccw-crypto.c
> +++ b/hw/s390x/virtio-ccw-crypto.c
> @@ -23,9 +23,6 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
>      if (!qdev_realize(vdev, BUS(&ccw_dev->bus), errp)) {
>          return;
>      }
> -
> -    object_property_set_link(OBJECT(vdev), "cryptodev",
> -                             OBJECT(dev->vdev.conf.cryptodev), NULL);
>  }
>  
>  static void virtio_ccw_crypto_instance_init(Object *obj)
> diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
> index 4bb8c16d79..2e3a9da5e8 100644
> --- a/hw/s390x/virtio-ccw-rng.c
> +++ b/hw/s390x/virtio-ccw-rng.c
> @@ -24,9 +24,6 @@ static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
>      if (!qdev_realize(vdev, BUS(&ccw_dev->bus), errp)) {
>          return;
>      }
> -
> -    object_property_set_link(OBJECT(dev), "rng", OBJECT(dev->vdev.conf.rng),
> -                             NULL);
>  }
>  
>  static void virtio_ccw_rng_instance_init(Object *obj)
> diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
> index f1cc979d33..198f86e08c 100644
> --- a/hw/virtio/virtio-crypto-pci.c
> +++ b/hw/virtio/virtio-crypto-pci.c
> @@ -57,8 +57,6 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
>          return;
>      }
> -    object_property_set_link(OBJECT(vcrypto), "cryptodev",
> -                             OBJECT(vcrypto->vdev.conf.cryptodev), NULL);
>  }
>  
>  static void virtio_crypto_pci_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
> index 2f0b529b62..8afbb4c209 100644
> --- a/hw/virtio/virtio-rng-pci.c
> +++ b/hw/virtio/virtio-rng-pci.c
> @@ -38,9 +38,6 @@ static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
>          return;
>      }
> -
> -    object_property_set_link(OBJECT(vrng), "rng", OBJECT(vrng->vdev.conf.rng),
> -                             NULL);
>  }
>  
>  static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
> 


