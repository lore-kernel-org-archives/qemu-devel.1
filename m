Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5405BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A45920776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRPpLJfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A45920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdy6L-0005kB-7l
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdy5T-0004HL-So
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:35:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdy5R-00068w-Nn
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590593720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9bSfFjS0Nj2cluGha6pXYmnl6bsGUryxzjLZtvPQsY=;
 b=iRPpLJfrvUXquDuqd9YByttJgGH7PwZDNI+W0Sjv5gzbKTdBD/5hEnFHQ3OIQIjRC0Ck4o
 tLDr71X9/StMIhy8KMJljgh02T5tmbb8El4oa8MpilgZccDJIETbkZ2p0+G7yk8UcNdHv0
 /JoMN851S/rGnu8Y1Yg3rNd0I6vzWRQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-aWAaiX6UP6O8BpljGsZDJA-1; Wed, 27 May 2020 11:35:18 -0400
X-MC-Unique: aWAaiX6UP6O8BpljGsZDJA-1
Received: by mail-ej1-f72.google.com with SMTP id hb26so5112464ejb.16
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z9bSfFjS0Nj2cluGha6pXYmnl6bsGUryxzjLZtvPQsY=;
 b=I6jr4y6rcLYuyclF+JVnVcANytiz9jo8QIy7hWuBjigg6ODFZw3KaG8qN+VgKRs6i9
 L49gz5NVv7G71lF0YpWUQY8Tims01BxvhdwOfBO5qtleWrUeo/omGTsZx1g5cTxK56hQ
 IdNY4ue2dHNU60yR9M+CuvGa1j+7onwMTi//ru/9WCVwC6bi/zi+Fq1QJxGr8q5Viqw+
 D3R2iN8PS6o32hXURfb++B4nwVqzOsxVM9hSjfarNym0CRWT4jUcVZmf7TfKiIClCQlr
 SrwOuUdYof9tqplyHztNjfH2JR/XAUzViTIKFg7Ruw0XdqothUZQxMrhaWx9fUGE1us3
 YYgQ==
X-Gm-Message-State: AOAM533j9n5lDub+Vw5ahAJZ/gIbR8eZZWnULLvt+Tf4UpnSm1Ejz3Rm
 FNixtD5C+OmblinUZ3Fa9dSaRlfF7Ev/E8xhYBDhhahfKxntGABX6tojUULHpgiTTxUKLATP1uO
 NlyS1k94al2K5R4c=
X-Received: by 2002:a17:906:13ca:: with SMTP id
 g10mr6603608ejc.433.1590593717409; 
 Wed, 27 May 2020 08:35:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw2CTdnfZ3TsiTNtarlNs2KreCjUkPLU+/AiFWblSE+mOkaWC2wlKoExcP9Bp9sHxkOfvJjQ==
X-Received: by 2002:a17:906:13ca:: with SMTP id
 g10mr6603588ejc.433.1590593717115; 
 Wed, 27 May 2020 08:35:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id s8sm2447405edj.64.2020.05.27.08.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 08:35:16 -0700 (PDT)
Subject: Re: [PATCH] hw/pci: Fix crash when running QEMU with "-nic
 model=rocker"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200527153152.9211-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85cf7423-47e8-898a-c1da-e527adcaaa6b@redhat.com>
Date: Wed, 27 May 2020 17:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200527153152.9211-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/20 17:31, Thomas Huth wrote:
> QEMU currently aborts when being started with "-nic model=rocker" or with
> "-net nic,model=rocker". This happens because the "rocker" device is not
> a normal NIC but a switch, which has different properties. Thus we should
> only consider real NIC devices for "-nic" and "-net". These devices can
> be identified by the "netdev" property, so check for this property before
> adding the device to the list.
> 
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Fixes: 52310c3fa7dc854d ("net: allow using any PCI NICs in -net or -nic")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/pci/pci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 70c66965f5..46214f8287 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1887,7 +1887,18 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>          if (test_bit(DEVICE_CATEGORY_NETWORK, dc->categories) &&
>              dc->user_creatable) {
>              const char *name = object_class_get_name(list->data);
> -            g_ptr_array_add(pci_nic_models, (gpointer)name);
> +            /*
> +             * A network device might also be something else than a NIC, see
> +             * e.g. the "rocker" device. Thus we have to look for the "netdev"
> +             * property, too. Unfortunately, some devices like virtio-net only
> +             * create this property during instance_init, so we have to create
> +             * a temporary instance here to be able to check it.
> +             */
> +            Object *obj = object_new_with_class(OBJECT_CLASS(dc));
> +            if (object_property_find(obj, "netdev", NULL)) {
> +                g_ptr_array_add(pci_nic_models, (gpointer)name);
> +            }
> +            object_unref(obj);
>          }
>          next = list->next;
>          g_slist_free_1(list);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


