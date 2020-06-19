Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F92EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1C3207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqXsN73X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1C3207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGIs-0007W3-9M
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmGHa-0005G0-JP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:38:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmGHZ-0004yw-1s
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592570288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0vzAKNhIebVNhmPTwwk2+p6+FeyRJcrmAq4fe7SPCF8=;
 b=QqXsN73Xd3UR+F5S5SrZZdF9D+XDzE2gnwYRobTuq3HE8eO1h/PKFb1AMr471Yos/o0a4o
 BnteE/xhz1LqZmoSjHh4h9j9PzRbOH5CwXqnL9GkkDy016aemJMMsSClgynU1pUM88iTBa
 OGOfaAM81g1QAPhaPJ6Ox1WJUWWLf4I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-ResTKEIXOkKubroV7gEAbw-1; Fri, 19 Jun 2020 08:38:06 -0400
X-MC-Unique: ResTKEIXOkKubroV7gEAbw-1
Received: by mail-wr1-f71.google.com with SMTP id b14so3942987wrp.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 05:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0vzAKNhIebVNhmPTwwk2+p6+FeyRJcrmAq4fe7SPCF8=;
 b=G46F+BR3QgL6fZA+d4oWqpOVIsCbgUCuiUU8L6y7j2fIYpexZSzO2KmKfrhFAaQWba
 lUrwNCtWiwvUbq44X4Qgiy3IiEzrI00IujQLKGu8MHFNO+PS+qysvI2hyJd0g9ldhcxM
 TeCpB/g4HhVLF0j593wX21k5ef3khfAdZRyzvpHSgfDezfUchHzWTZp/gv27Fe13J2Hj
 zuJCKTHlC2WsIs0DsmYDFGqkWkaTZW/FJtEnp6EDro4sZhy7sEv5FDVpDcwlbKHi3KoV
 AwFwphJAaLEvlxLctGXLWoRIkU6hhdDiWfJFqQo/1+16v5aeJVaU+gnQsIMIxmcUyPU7
 AfKg==
X-Gm-Message-State: AOAM532y9dbev+tG6pAAkm4O7/kHVGWcS0tfq1zG97RXnBcJJ+Fr/Z01
 jYihVxVjZ0mu3X/7oNQWxBqtCjx8V5KmT6AQCtff/5EYjoMkQAS0KxJqqD6ZLiZ53yEKmzpNi60
 +iir33+BhXtlnga0=
X-Received: by 2002:adf:a1c1:: with SMTP id v1mr3988944wrv.205.1592570285590; 
 Fri, 19 Jun 2020 05:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKe+Jqm+9+qRBocH+ge+ctOBwEa9VJyyU/fXDgduU6zy7HpK/JjOJEWzFAFBJZy+Rk1KZCjw==
X-Received: by 2002:adf:a1c1:: with SMTP id v1mr3988925wrv.205.1592570285337; 
 Fri, 19 Jun 2020 05:38:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id z16sm7179070wrm.70.2020.06.19.05.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 05:38:04 -0700 (PDT)
Subject: Re: [PATCH] xen: Actually fix build without passthrough
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
References: <20200619103115.254127-1-anthony.perard@citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac75572a-6568-f5fd-16f0-f43c951e7e86@redhat.com>
Date: Fri, 19 Jun 2020 14:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200619103115.254127-1-anthony.perard@citrix.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/20 12:31, Anthony PERARD wrote:
> Fix typo.
> 
> Fixes: acd0c9416d48 ("xen: fix build without pci passthrough")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  hw/xen/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
> index 3fc715e5954d..502b32d877a0 100644
> --- a/hw/xen/Makefile.objs
> +++ b/hw/xen/Makefile.objs
> @@ -4,4 +4,4 @@ common-obj-y += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-b
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt_load_rom.o
> -obj-$(call $(lnot, $(CONFIG_XEN_PCI_PASSTHROUGH))) += xen_pt_stub.o
> +obj-$(call lnot,$(CONFIG_XEN_PCI_PASSTHROUGH)) += xen_pt_stub.o
> 

Queued, thanks and sorry about that.

Paolo


