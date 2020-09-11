Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEE6C2D0E1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D423D221E5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9FluRDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D423D221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmrh-0007Rm-Pb
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGmrA-0006z5-Ex
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGmr8-0000gr-Si
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599845341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZaGwkwG6PUjHaOnwE1qnf+WINn2GkygNKrwnMK8Uz8=;
 b=B9FluRDzrkxTRULp/AVRGvHS61sWvX540ms7zQrWO2fTszVyQ04CPo3FE5+ZL+Xu3r7S4Z
 1tZC/sx3aUK+ixNE0s4ttyERpeRhZrIFCiQtPPkkHE26vnkVUR3dZ85nfC62YRbky6jB7U
 EKqqMIeUvKLZw/Pc8+hdT1lJYisjU/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-_BQi10UOOnWV4cjykrLZdg-1; Fri, 11 Sep 2020 13:28:59 -0400
X-MC-Unique: _BQi10UOOnWV4cjykrLZdg-1
Received: by mail-wm1-f72.google.com with SMTP id u5so1190296wme.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 10:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ZaGwkwG6PUjHaOnwE1qnf+WINn2GkygNKrwnMK8Uz8=;
 b=E0wCIHjXu4GpEQ+sf60sFJsbM+R+xfOkq9WL0knAbfEbtHCGRgiPLvjz+dnJ5bU1Ar
 eds2iz2UadYOCEXZVsDKFaiI1n/EUNMaKIluI9ZBpzKceWJlk1yn+xEPpQdIwFQGBoBO
 oMgiVsU9aKkFWWXucenGtS+mOAN/DeFb44zT4z0QVHbJcqi8Rv5RGk6cJpRwQZcVp1BS
 t14gSKsALhME3GDqBZNBLl/oPnPTjU9CzUMQ8eiUOyR+sAJqAnM8gPVjoYqb0oIHdT64
 c556+kompS32LjMAZXmR2S3HOCGxCU/9ojMEMQpIuJTzqR9gKISSf0xFDsg8CyWdXat5
 zhBA==
X-Gm-Message-State: AOAM533Cx/VB0vUqBlrvVIvy+ltej3Ob2f2DyudDIFCnUNTChg4hIgLk
 cWDYZDAe+vkq81j2qxWS9CQygZxS39LK/6xw+O1h5Gh7ePjDoDrT7nPIS2NGY+qAUECmV5crouk
 e6pngttKkYg334mg=
X-Received: by 2002:a1c:9654:: with SMTP id y81mr3207358wmd.9.1599845338422;
 Fri, 11 Sep 2020 10:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKyiNf/2Qe1TK3hx71lCXX7z5wyW8DPlrWVCDR4tfLY6AMddzxVSOyLp2wwtn2l2VtrN44Gg==
X-Received: by 2002:a1c:9654:: with SMTP id y81mr3207349wmd.9.1599845338190;
 Fri, 11 Sep 2020 10:28:58 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id 9sm5537537wmf.7.2020.09.11.10.28.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 10:28:57 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: add Paolo Bonzini as RCU maintainer
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200909090851.14458-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2e1ba30-74db-e6db-5acc-5cfda38bc101@redhat.com>
Date: Fri, 11 Sep 2020 19:28:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909090851.14458-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 11:08, Stefan Hajnoczi wrote:
> The RCU code that Paolo maintains is missing a MAINTAINERS file entry.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d0a5e91e4..50296caac4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2291,6 +2291,14 @@ F: softmmu/cpus.c
>  F: softmmu/cpu-throttle.c
>  F: qapi/run-state.json
>  
> +Read, Copy, Update (RCU)
> +M: Paolo Bonzini <pbonzini@redhat.com>
> +S: Maintained
> +F: include/qemu/rcu*.h
> +F: tests/rcutorture.c
> +F: tests/test-rcu-*.c
> +F: util/rcu.c
> +
>  Human Monitor (HMP)
>  M: Dr. David Alan Gilbert <dgilbert@redhat.com>
>  S: Maintained
> 

Queued, thanks.

Paolo


