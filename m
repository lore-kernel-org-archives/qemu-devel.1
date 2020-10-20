Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B05BC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6751222253
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9PQgXgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6751222253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoZ3-0006Yl-61
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUoXN-0004Yx-Br
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUoXL-0007hz-6v
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603188393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZsNdwegAsSsK5SvAMc7L3pFHjvMUHfLCLtiBtqc7VA=;
 b=E9PQgXgRDHai4fvRGlNQtJ/9gwTcFFJyxFXH/YasRoWc7LNun6SjDXHEnWXJ8tdoFLRs2m
 LztvykZ+LX7dYyK6PnmNRfG38VGxNgroqW+w2Hld2TaVCbg5iAJZB/nRxPF/PobbVS1lSS
 cMgD/JAiOjrmD+eQ8mOhMCtX3Oac8Qw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-OQDCvR-xPc6A6w0DfeyF3Q-1; Tue, 20 Oct 2020 06:06:31 -0400
X-MC-Unique: OQDCvR-xPc6A6w0DfeyF3Q-1
Received: by mail-wm1-f71.google.com with SMTP id c204so276471wmd.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 03:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fZsNdwegAsSsK5SvAMc7L3pFHjvMUHfLCLtiBtqc7VA=;
 b=Ch25OfttGKu6nzJj6CxbNYDEWUzwb/M9KtzLsvC3lr36ux5hjPL4NXnEf1RyxPFR/G
 s9l7dvYcomFkgSZ37O0f3dLtptshmszDZ0gDHs+XhumNsXilQWYOfh0c+F1bcJS00p2W
 w6Oi71WGreZ0OEAlK8HgfLr2sHyevsPWW1pBA8eidO/CyYzvs2EebeCAcus2ODgkC0vl
 0L6JEixZsqcglQZssGNP6IalsGrU5AqEROUTbcnYClLFEfAH3i9zft/oyg9M8G4q6pFs
 ty5/4x89c7sgNzDMkgC76lm4sDBo4bZRmUjSkAAMLDvz+zQyD9Mt4x3Lx7rfm3f8JSGx
 e4pA==
X-Gm-Message-State: AOAM533nq3wQwnTNs/HNLhcgWPhBY0p7HuA2yN8QZABPecDj8J85rsnE
 AMMIkgmCZkDeX5jYGkLvCEt6Zxwrb0Q0rgACk+chqy7kgoAd0UWfXQ8d9A384DMYinQYw5O49tM
 OtzoMIDw/1zfKI4E=
X-Received: by 2002:adf:8462:: with SMTP id 89mr2542855wrf.389.1603188390123; 
 Tue, 20 Oct 2020 03:06:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfEyA9S+CO9YXoYBSrhQ8LWbrwdiIhPetPuDYzKol2MQPtzdrXlUVFwq3QgS/4FZpQFkKweQ==
X-Received: by 2002:adf:8462:: with SMTP id 89mr2542842wrf.389.1603188389919; 
 Tue, 20 Oct 2020 03:06:29 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v4sm1831640wmg.35.2020.10.20.03.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 03:06:29 -0700 (PDT)
Subject: Re: [PATCH] scripts/tracetool: silence SystemTap dtrace(1) long long
 warnings
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20201020094043.159935-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <43806e3a-05c3-2d93-bf9b-52c83ec525cd@redhat.com>
Date: Tue, 20 Oct 2020 12:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020094043.159935-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Daniel Berrange <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 11:40 AM, Stefan Hajnoczi wrote:
> SystemTap's dtrace(1) prints the following warning when it encounters
> long long arguments:
> 
>    Warning: /usr/bin/dtrace:trace/trace-dtrace-hw_virtio.dtrace:76: syntax error near:
>    probe vhost_vdpa_dev_start
> 
>    Warning: Proceeding as if --no-pyparsing was given.
> 
> Use the uint64_t and int64_t types, respectively. This works with all
> host CPU 32- and 64-bit data models (ILP32, LP64, and LLP64) that QEMU
> supports.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   scripts/tracetool/format/d.py | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
> index 353722f89c..ebfb714200 100644
> --- a/scripts/tracetool/format/d.py
> +++ b/scripts/tracetool/format/d.py
> @@ -57,6 +57,12 @@ def generate(events, backend, group):
>                   # Avoid it by changing probe type to signed char * beforehand.
>                   if type_ == 'int8_t *':
>                       type_ = 'signed char *'
> +
> +            # SystemTap dtrace(1) emits a warning when long long is used
> +            type_ = type_.replace('unsigned long long', 'uint64_t')
> +            type_ = type_.replace('signed long long', 'int64_t')
> +            type_ = type_.replace('long long', 'int64_t')
> +
>               if name in RESERVED_WORDS:
>                   name += '_'
>               args.append(type_ + ' ' + name)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


