Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1666C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3AC2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkDa50g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3AC2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5tb6-0006tg-ND
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5taV-0006SF-NT
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5taS-0002A1-TH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597249608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XpRlUkQFf6AHIug+gP70NucqP83ene4yqqQ+ezAfHLM=;
 b=IkDa50g+XR3GBoE3/q4ix2JVTmvmWStI8Sqz48zj5GH0C5vkcSApMG6xsdrDSxmlZEreJE
 /eG1xMcag3d7CukY9+cU8gJFJWKr1QpNFfVSoIx3GD/fLM+nHurBAj0BmherW9y4e7Uv77
 qE6go97wdIl4Ha/xX5Rv6e/Cc8e0FxQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-xoEQs_PEMqmITVw465TGLg-1; Wed, 12 Aug 2020 12:26:42 -0400
X-MC-Unique: xoEQs_PEMqmITVw465TGLg-1
Received: by mail-wm1-f71.google.com with SMTP id v8so870191wma.6
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 09:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XpRlUkQFf6AHIug+gP70NucqP83ene4yqqQ+ezAfHLM=;
 b=JJ2nDJRk1BMmNb5War5IGftwHSflZvqHbP6CLZ+kjQYk9Bj+d0yUrIKfhU62uJa0nO
 hw8IlGUxx8bPGw6gUYVvaysv+BaMdsZbKwfLU/64BJvJkTA5tXw+fMlNUlL1C3eRZ6/O
 zs0G62hRBafQYm6zqOmDRkk/34Y2tlhbZ7BtI2xq1/tdR61brPlqiHmXioyG7KPPfzAV
 6qivPJlmEn1tm4TrGtDWLrBBNtYM0PZmJsFyEnutom8Xcz+k8ESSNTPYW4OZAQjcnDcP
 +n3jmTfh2NPXr6kjRNVuUvcLuZQC8Zx1nSbfNvRGFznuVmuhzeae8iaCjVq2okezoPu5
 l3Gw==
X-Gm-Message-State: AOAM530G8j3k6KYaU5EMsQLszdnVsWzMaS5wRnRPtQ2wTFhSjcWCwyo1
 qGTQdPpQgP660rXn3mWHSvXrjZ6Nk5oDaeC0BxBwiF5K7hj/fLlymcTAmUyCXaV36kVshOGFxp9
 YtqHC3skfvMSWXuc=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr34511wrn.65.1597249600951;
 Wed, 12 Aug 2020 09:26:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcjaSv7dCidP1+iRkgHfd9C0vVJdYFMtazrraHQSiZkOiLy937x1GYO+GS8WyOYJktRYYkyw==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr34491wrn.65.1597249600677;
 Wed, 12 Aug 2020 09:26:40 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y145sm4773770wmd.48.2020.08.12.09.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 09:26:39 -0700 (PDT)
Subject: Re: [PULL 3/3] configure: Allow to build tools without pixman
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200724164258.24886-1-kraxel@redhat.com>
 <20200724164258.24886-4-kraxel@redhat.com>
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
Message-ID: <f1fbe9b9-575e-b55f-8596-754a82654b5c@redhat.com>
Date: Wed, 12 Aug 2020 18:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200724164258.24886-4-kraxel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 12:26:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 7/24/20 6:42 PM, Gerd Hoffmann wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> If pixman is not installed, it is currently not possible to run:
> 
>  .../configure  --disable-system --enable-tools
> 
> Seems like there was a dependency from one of the required source
> files to pixman in the past, but since commit 1ac0206b2ae1ffaeec56
> ("qemu-timer.c: Trim list of included headers"), this dependency
> should be gone. Thus allow to compile the tools without pixman now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-id: 20200723141123.14765-1-thuth@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 4bd80ed507aa..2acc4d1465f8 100755
> --- a/configure
> +++ b/configure
> @@ -4065,7 +4065,7 @@ fi
>  ##########################################
>  # pixman support probe
>  
> -if test "$want_tools" = "no" && test "$softmmu" = "no"; then
> +if test "$softmmu" = "no"; then
>    pixman_cflags=
>    pixman_libs=
>  elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
> 

This commit broke my '--disable-system --disable-user --enable-tools' build:

$ make vhost-user-gpu
...
  LINK    vhost-user-gpu
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`vg_resource_create_2d':
contrib/vhost-user-gpu/vhost-user-gpu.c:322: undefined reference to
`pixman_image_create_bits'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`vg_resource_destroy':
contrib/vhost-user-gpu/vhost-user-gpu.c:381: undefined reference to
`pixman_image_unref'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`vg_transfer_to_host_2d':
contrib/vhost-user-gpu/vhost-user-gpu.c:538: undefined reference to
`pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:540: undefined
reference to `pixman_image_get_stride'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:543: undefined
reference to `pixman_image_get_width'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:544: undefined
reference to `pixman_image_get_data'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:556: undefined
reference to `pixman_image_get_stride'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:557: undefined
reference to `pixman_image_get_height'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:555: undefined
reference to `pixman_image_get_data'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`vg_resource_flush':
contrib/vhost-user-gpu/vhost-user-gpu.c:693: undefined reference to
`pixman_region_init_rect'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:705: undefined
reference to `pixman_region_init'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:706: undefined
reference to `pixman_region_init_rect'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:709: undefined
reference to `pixman_region_intersect'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:711: undefined
reference to `pixman_region_extents'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:731: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:731: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:747: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:747: undefined
reference to `pixman_image_create_bits'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:753: undefined
reference to `pixman_image_composite'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:758: undefined
reference to `pixman_image_unref'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:762: undefined
reference to `pixman_region_fini'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:763: undefined
reference to `pixman_region_fini'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:765: undefined
reference to `pixman_region_fini'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`update_cursor_data_simple':
contrib/vhost-user-gpu/vhost-user-gpu.c:863: undefined reference to
`pixman_image_get_width'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:864: undefined
reference to `pixman_image_get_height'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:865: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:865: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:868: undefined
reference to `pixman_image_get_data'
collect2: error: ld returned 1 exit status
make: *** [Makefile:730: vhost-user-gpu] Error 1

Thanks,

Phil.


