Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C16C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 07:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D358207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 07:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRbAhTe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D358207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jivEM-00063z-HZ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 03:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jivDK-0005NE-8T
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 03:31:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jivDJ-0001YQ-2F
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 03:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591774315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ufr9OvMKHx6dilbenCBf6oJ7zVnHo90LqSeQBs4wcOw=;
 b=TRbAhTe9MPzRZL4p4r5azQKP+TMti2KhAHTaSTQ0T+ndC5Ot6oVLAmpqGqFk4+AfgIU1JY
 MHKEMbwE6gaxaqbwTBUzKFj5ZkYotx/3Qz5SA64PNJa2AACeuk1+rQxNJrTW4STq3Gnyvq
 MHil2Ya+UcboqdvWh5ls0HqX/HFJ/cY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-wCxTOC4hNz6OhHJ0CywtqQ-1; Wed, 10 Jun 2020 03:31:52 -0400
X-MC-Unique: wCxTOC4hNz6OhHJ0CywtqQ-1
Received: by mail-wm1-f72.google.com with SMTP id b65so204948wmb.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 00:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ufr9OvMKHx6dilbenCBf6oJ7zVnHo90LqSeQBs4wcOw=;
 b=CzIVwX/WtLJcX+KuWeFrsBdm/rcIVBrgFH5BlNWSpWjL6LaS2yIjrYkm9WxPdgfpkd
 yPCoKM3Rrakqbmd55IxrOwv608uYytOXnhR65yQyStpk5/reMwb2Db6takzOd6phcQlz
 PaRTyx5vbUAZeh078j6Cospyfb5s0AdChKg9e+GE/6vvP5h6aVCZYQkBsa5237rKjDC0
 ZKzsEP32J7HQVoSgeSwpadCNN23brq0v9ANG4FlhlGOrE9PIDcI55Rmlh7wm5HoYDSZT
 49AxeuyoV4T6JjwyWNVClm0Lb0mCPKb0l6cHovAR/zTbBMb4bMkgneymBFLAzJ1Atoev
 guTQ==
X-Gm-Message-State: AOAM533QUVEQfOJmqQ9LdlglplFt4tIIJAe4lh8ZekMXh0nFyH13Hrd+
 3hoVoQM8pbKcG6souzHyid0m/eTnj6D304bOhYCm0jgVChYTnkjkMLbqYbwV3ZS7SG1hMrxkcYk
 MhV9R8vQaoNfW4ew=
X-Received: by 2002:a05:6000:1202:: with SMTP id
 e2mr1948930wrx.231.1591774310493; 
 Wed, 10 Jun 2020 00:31:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2hQgSrh3avXiojSm08oGCfW0D+2HM4aHlqJJ1ZerzJXa+R7WkDZVuEL2AgaxN1HiwOdqThA==
X-Received: by 2002:a05:6000:1202:: with SMTP id
 e2mr1948901wrx.231.1591774310106; 
 Wed, 10 Jun 2020 00:31:50 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id i10sm6650106wrw.51.2020.06.10.00.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 00:31:49 -0700 (PDT)
Subject: Re: [PATCH] hw/vfio/pci-quirks: Fix broken legacy IGD passthrough
To: Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20200610035102.20192-1-thuth@redhat.com>
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
Message-ID: <706060db-46c4-2dee-d746-eba24e6b137d@redhat.com>
Date: Wed, 10 Jun 2020 09:31:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200610035102.20192-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 5:51 AM, Thomas Huth wrote:
> The #ifdef CONFIG_VFIO_IGD in pci-quirks.c is not working since the
> required header config-devices.h is not included, so that the legacy
> IGD passthrough is currently broken. Let's include the right header
> to fix this issue.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1882784
> Fixes: 29d62771c81d8fd244a67c14a1d968c268d3fb19
>        ("hw/vfio: Move the IGD quirk code to a separate file")

What about shorter tag?

Fixes: 29d62771c81 ("vfio: Move the IGD quirk code to a separate file")

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/vfio/pci-quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index f2155ddb1d..3158390db1 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "config-devices.h"

I've been wondering how we can avoid that mistake in the
future, but can find anything beside human review.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  #include "exec/memop.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> 


