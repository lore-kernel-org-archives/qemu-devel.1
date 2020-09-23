Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCFDC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438A423119
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWa9o3Cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438A423119
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL206-0000lv-A5
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1yU-0007wh-9f
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1yK-0004ul-O7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600856755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fyxj1WNzaJ2yaVpoGWvLTvrDc8l86IlZSVcaCb1DgEA=;
 b=hWa9o3Cw1h1vXvXS+oD0LYI/5Vx+9tLDtXln75OTIyNoy21f4fwKl4UU8kc6Z4N48Gc5rp
 ajr40umI8KzHEUg6u7W9G7WaCrIjAjo+SgFk3I3vO0tY90y0+uSgZ+da2R4TWQjsMlUJd8
 Aedx4wmgzblwEcCfAcGK77rEBmdpTnM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-tByIhuB9O8avOU3WeSfdsw-1; Wed, 23 Sep 2020 06:25:51 -0400
X-MC-Unique: tByIhuB9O8avOU3WeSfdsw-1
Received: by mail-wm1-f71.google.com with SMTP id b14so1203304wmj.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fyxj1WNzaJ2yaVpoGWvLTvrDc8l86IlZSVcaCb1DgEA=;
 b=fPkQhQHv0eheK5hGppgaK/ryRsDURYMddB6N1AaDrWMOjWXwu+uXDM+fAVkiJpsZdF
 T2DmD2Ta6NdFSTJkCMOBKLjiWvziER/KV0fjEe37R3tK5gRyxPQs8j2o5uBZQ8x4MBVo
 aeD+SCaraN8NVBnfumJhOJryFbH4hpgsBW6mM85MFEtbe1zvA/hBsnipYenqBZOoGatw
 vJdw/B1xtByaRjbeiNhxLP7cobtbN5ruJSujsuQqvRzCJuOt6R8j+IZKZJmFQl9FMzRj
 1czrJ//XNIaPvxgPU5x3d3Qr0NbnzwkDQrtIgfZKi8rHeDF70rDYM3Tmufde09V41eLj
 FWPw==
X-Gm-Message-State: AOAM532k5il5c2epyzFP1DkCkEDR3JKB5tpaQnBkyVI1T08205GjjH1F
 T8B0iEZ2a3l6TM7YA8L1mypgZUmcThG21rpIlnXDi/5lXAtxMstSfFGCGKaDF8Q0t1yNXRHDnh2
 75z5VwbNmGB+fBos=
X-Received: by 2002:adf:df87:: with SMTP id z7mr10620254wrl.239.1600856750264; 
 Wed, 23 Sep 2020 03:25:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3BiOrwMNMN4tkbWGPAwRh6lp9KWyYUBXLKmxZHGWLdqwor70as5nwfyHmSG6bmCve+dCP9w==
X-Received: by 2002:adf:df87:: with SMTP id z7mr10620230wrl.239.1600856750016; 
 Wed, 23 Sep 2020 03:25:50 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k4sm30888991wrx.51.2020.09.23.03.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 03:25:48 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] block: deprecate the sheepdog block driver
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200922161611.2049616-1-berrange@redhat.com>
 <20200922161611.2049616-3-berrange@redhat.com>
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
Message-ID: <1d391aab-db3d-a134-9657-d81c7c2d9130@redhat.com>
Date: Wed, 23 Sep 2020 12:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922161611.2049616-3-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 6:16 PM, Daniel P. Berrangé wrote:
> This thread from a little over a year ago:
> 
>   http://lists.wpkg.org/pipermail/sheepdog/2019-March/thread.html
> 
> states that sheepdog is no longer actively developed. The only mentioned
> users are some companies who are said to have it for legacy reasons with
> plans to replace it by Ceph. There is talk about cutting out existing
> features to turn it into a simple demo of how to write a distributed
> block service. There is no evidence of anyone working on that idea:
> 
>   https://github.com/sheepdog/sheepdog/commits/master
> 
> No real commits to git since Jan 2018, and before then just some minor
> technical debt cleanup..
> 
> There is essentially no activity on the mailing list aside from
> patches to QEMU that get CC'd due to our MAINTAINERS entry.
> 
> Fedora packages for sheepdog failed to build from upstream source
> because of the more strict linker that no longer merges duplicate
> global symbols. Fedora patches it to add the missing "extern"
> annotations and presumably other distros do to, but upstream source
> remains broken.
> 
> There is only basic compile testing, no functional testing of the
> driver.
> 
> Since there are no build pre-requisites the sheepdog driver is currently
> enabled unconditionally. This would result in configure issuing a
> deprecation warning by default for all users. Thus the configure default
> is changed to disable it, requiring users to pass --enable-sheepdog to
> build the driver.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  block/sheepdog.c           | 15 +++++++++++++++
>  configure                  |  5 +++--
>  docs/system/deprecated.rst |  9 +++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index cbbebc1aaf..7f68bd6a1a 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -242,6 +242,17 @@ typedef struct SheepdogInode {
>   */
>  #define FNV1A_64_INIT ((uint64_t)0xcbf29ce484222325ULL)
>  
> +static void deprecation_warning(void)
> +{
> +    static bool warned = false;

Checkpatch warns there is no need to initialize static bool to false,
otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
> +    if (!warned) {
> +        warn_report("the sheepdog block driver is deprecated and will be "
> +                    "removed in a future release");
> +        warned = true;
> +    }
> +}
[...]


