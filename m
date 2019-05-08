Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7362AC04AAB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4958D21530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4958D21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKcg-0008Q0-Dk
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:20:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKao-0007Gb-LW
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKan-0004Nf-DM
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:18:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKan-0004N0-5s
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:18:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id v10so1440734wrt.6
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xEKdl6jGihOoYEc/ymEI0k6WtSvqhaB/R5yGrQ99Ykg=;
	b=DKqvgt+OOzjZ9sK1F0xBFA7u9n3gQRgR3QrB57ypyrIjl5J+9FXRnXogpWGaR3ump5
	Y1oV46V01SOR6gtZoVT21n+vvFREHExfUeZe178XN5UpbNHZsGx4eHEAUb1rQ8KW4AsS
	gvR0qIN7zTpqzz7wpzqf1eEQw3zyDoPgv+p9yyEFxLkzKmNQQkps9E1iIH2SEDVr0Q+3
	SJQhdcZOysR364uUYlp3SIKJbAhlUdJpPbfyFlPEk0HXmXZdkEVDlwszWTtsh93+r6iZ
	eCM+8sySRxGBcv8Pf31rvu7iMr8mWCv7KYhwxYCLfOZBGVnTYekATg0bpC8HGRbTK9zX
	JTTg==
X-Gm-Message-State: APjAAAV0B37DKRbxqVrOnPbVAwQHQT54VBD18kJqkqZ+7r3sm8ScKZS+
	wNkgcl7U5ve6Cp9AemCEMYnDFQ==
X-Google-Smtp-Source: APXvYqzPet6W6mi2VS6YAp1QvKKxu0Ti176HnXsVZUAa9zf9DfdxXpK6QUzVHXF+OhfXGzBQYYqKBw==
X-Received: by 2002:a5d:4e4f:: with SMTP id r15mr12204152wrt.157.1557314312261;
	Wed, 08 May 2019 04:18:32 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	g185sm1946153wmf.30.2019.05.08.04.18.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:18:31 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-14-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1119aab7-8d35-a635-9b8f-9a066956079d@redhat.com>
Date: Wed, 8 May 2019 13:18:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-14-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 13/16] hw/microblaze/zynqmp: Use
 object_initialize_child for correct ref. counting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/19 11:34, Philippe Mathieu-Daudé wrote:
> As explained in commit aff39be0ed97:
> 
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
> 
> This patch was generated using the following Coccinelle script
> (then manually modified to use numbered IPI name)
> 
>  @use_sysbus_init_child_obj_missing_parent@
>  expression child_ptr;
>  expression child_type;
>  expression child_size;
>  @@
>  -   object_initialize(child_ptr, child_size, child_type);
>      ...
>  -   qdev_set_parent_bus(DEVICE(child_ptr), sysbus_get_default());
>      ...
>  ?-  object_unref(OBJECT(child_ptr));
>  +   sysbus_init_child_obj(OBJECT(PARENT_OBJ), "CHILD_NAME", child_ptr,
>  +                         child_size, child_type);
> 
> We let the SoC adopt the IPI children.
> 
> While the object_initialize() function doesn't take an
> 'Error *errp' argument, the object_initialize_child() does.
> Since this code is used when a machine is created (and is not
> yet running), we deliberately choose to use the &error_abort
> argument instead of ignoring errors if an object creation failed.
> This choice also matches when using sysbus_init_child_obj(),
> since its code is:
> 
>   void sysbus_init_child_obj(Object *parent,
>                              const char *childname, void *child,
>                              size_t childsize, const char *childtype)
>   {
>       object_initialize_child(parent, childname, child, childsize,
>                               childtype, &error_abort, NULL);
> 
>       qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
>   }
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/microblaze/xlnx-zynqmp-pmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 20e973edf5f..0948b1fd5f2 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -71,9 +71,10 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
>  
>      /* Create the IPI device */
>      for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        object_initialize(&s->ipi[i], sizeof(XlnxZynqMPIPI),
> -                          TYPE_XLNX_ZYNQMP_IPI);
> -        qdev_set_parent_bus(DEVICE(&s->ipi[i]), sysbus_get_default());
> +        char *name = g_strdup_printf("ipi%d", i);
> +        sysbus_init_child_obj(obj, name, &s->ipi[i],
> +                              sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQMP_IPI);
> +        g_free(name);
>      }
>  }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

