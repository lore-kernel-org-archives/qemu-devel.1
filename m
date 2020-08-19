Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73A2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EEC20882
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQTzTMDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EEC20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PiC-00073i-PT
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8Ph1-00064p-88
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:07:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8Pgz-0006hW-Cy
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597849676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8tgCh1Gnl/SY6X0TB387F8Q22JTqiJcByf/+qfD2asA=;
 b=NQTzTMDKRy6ebCNW+vUjo2KFhaagTSoH9fQP4dCtYX2VbjfV29CT3sahzv3+7RgG7z3kvE
 bJ3+1qFt4l37X0oxHIcBJxMlp6DsUk0pyP3gwFBCZfm0nlSG23CU88lh7d7E696vYrmmkI
 EeAAYcq+///B6OdvubqHhWCiQK0RKEc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-0OkMt_0jNgqBip-wFsqlIA-1; Wed, 19 Aug 2020 11:07:53 -0400
X-MC-Unique: 0OkMt_0jNgqBip-wFsqlIA-1
Received: by mail-wr1-f70.google.com with SMTP id t3so9456941wrr.5
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 08:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8tgCh1Gnl/SY6X0TB387F8Q22JTqiJcByf/+qfD2asA=;
 b=KoAg7Kr0nnd92E5n04weDepYxLnREZlPTmjMM8ygl2Nq00QViRmaksF1SLNsC602VV
 eCZnLs+EUB0Mx9rK4xA1LZnhQ7TlryHRpDH8Jj244opeEym7G4dA6HwWx2i3kc0ZrpfZ
 NGxrvDifclHDQuPTN4FzKZDBF+3PWCSdI2J2jeDiHX9JUet9x3s+YLRVZxs8Qgpb0kMg
 GHokDMFMiwjZFpcexOmA0kiTFP39nG96uQol0tHrKGLzUd7avHE3RbB+LwMzIIXNBRy/
 a4lDj9mdVkLqscyB5cDtt0HI1NPZofSmyJKdOZvD557xAFI6srCJ6OQYyW8+/2tj5f6H
 537w==
X-Gm-Message-State: AOAM5306QLC+Q0vdfvjp/alxfBSY6sDEj6zJGnenkSQEsPJv0bYB2SmP
 dzEmpDtXYmcZXy8+6PMEukLOUoZ0vnWKasMl0H+kj4Sh8t9H7cv3wJtGVNYaAwIppdCSLrzc4q2
 /BzHsm330b3BI8pU=
X-Received: by 2002:adf:f045:: with SMTP id t5mr26722024wro.288.1597849672007; 
 Wed, 19 Aug 2020 08:07:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPk/Gyen6s/XGYChUwTT2debHrwSdlauktExNrXSK3sYw+0BVrHA5zJ2UiDotbZJW8WpEvCg==
X-Received: by 2002:adf:f045:: with SMTP id t5mr26722005wro.288.1597849671761; 
 Wed, 19 Aug 2020 08:07:51 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w10sm6569123wmk.0.2020.08.19.08.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 08:07:51 -0700 (PDT)
Subject: Re: [PATCH] virtio: vdpa: omit check return of g_malloc
To: Li Qiang <liq3ea@163.com>, mst@redhat.com, jasowang@redhat.com
References: <20200819144309.67579-1-liq3ea@163.com>
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
Message-ID: <2a946eec-5158-0bca-e9c9-b7c81d557b1b@redhat.com>
Date: Wed, 19 Aug 2020 17:07:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819144309.67579-1-liq3ea@163.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 4:43 PM, Li Qiang wrote:
> If g_malloc fails, the application will be terminated.

Which we don't want... better to use g_try_malloc() instead?

> No need to check the return value of g_malloc.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/virtio/vhost-vdpa.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 4580f3efd8..403ae3ae07 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -320,10 +320,8 @@ static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t *data,
>      struct vhost_vdpa_config *config;
>      int ret;
>      unsigned long config_size = offsetof(struct vhost_vdpa_config, buf);
> +
>      config = g_malloc(size + config_size);
> -    if (config == NULL) {
> -        return -1;
> -    }
>      config->off = offset;
>      config->len = size;
>      memcpy(config->buf, data, size);
> @@ -340,9 +338,6 @@ static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *config,
>      int ret;
>  
>      v_config = g_malloc(config_len + config_size);
> -    if (v_config == NULL) {
> -        return -1;
> -    }
>      v_config->len = config_len;
>      v_config->off = 0;
>      ret = vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, v_config);
> 


