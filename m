Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC0C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8657922275
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DB3/nrOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8657922275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZVFp-0005zW-Bc
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 03:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZVF0-0005Vw-OX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZVEx-0002i8-Ma
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604305857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgByJND0II4RGxxdGnPLF9mWiZItu9WEOonFJBwGs4Y=;
 b=DB3/nrOHn8gdk0dI08mfCwhD79Mc9H5VvN/7u7ALmidlXfBXRh06x42ozEnDvYtgLJAmBy
 nUTL+uDxgWUizIXOV5Colb1+pgw6zyUatcWRfKzCrilATVyBC86xm5p1fovXynR16Hc88j
 ZpPUGlUf7O8zPpKS9fS/Xl5XC6epV8c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-SMeI8f6qOeWaHOqeZfcmWQ-1; Mon, 02 Nov 2020 03:30:54 -0500
X-MC-Unique: SMeI8f6qOeWaHOqeZfcmWQ-1
Received: by mail-wr1-f70.google.com with SMTP id h8so6149891wrt.9
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 00:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TgByJND0II4RGxxdGnPLF9mWiZItu9WEOonFJBwGs4Y=;
 b=Pnnrw7y46FgVodCVox5aFLjOOX2Y4ioK0OwAE9Y8lg3vpII2P62U9MMFOSZ2/oV9eg
 Ztho1KjMgX9YVpCO/9I5fScIU2YSbSU30RYLnlCRLglbcyJWJZcWO4b6y/z6RtPJXR18
 sGgFXt2tBek7b7QH1/tfs/+UVNg6LzN5FRJRilIfxaT8iPuDo1bs+GvRjyHZB5NOQrXQ
 jmxuxEfSes+Svv2QsRVjF4HoSXmSxKv39eFSgBcmd6z+vQ84lnGpKc37TkfZxIypwPsU
 gQO2XNZchl/KTeEYMVJEL525hhAUQh0INwMUfXuzW/ERnZgdfyCIudUWXehGgQ25IxxT
 GMKg==
X-Gm-Message-State: AOAM533UW4ayRW1NyvB8QoHxWCDP05teT8yN39Dfq+azCAboYQaoZ17N
 eDrh5LnLOvys1TTbRwEttQ3IaLlE0YfVZDcBmAXKU+QDs+jzWjLUJZrGfbpN8GGPOpajrsmHRQn
 QlDOhZPA5d5TNJw0=
X-Received: by 2002:adf:ef92:: with SMTP id d18mr18506784wro.420.1604305853292; 
 Mon, 02 Nov 2020 00:30:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsNEVopzt9s6MK45JIs+jNjUmx4KtuYpcvlI8xU8KBfDhyzuZNDo7R5MbOGE/aoN+MfCkRlw==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr18506774wro.420.1604305853121; 
 Mon, 02 Nov 2020 00:30:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id b63sm15327080wme.9.2020.11.02.00.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 00:30:52 -0800 (PST)
Subject: Re: [PATCH-for-5.2] scripts/oss-fuzz: rename bin/qemu-fuzz-i386
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201101212245.185819-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0caf1656-e66b-22d4-8183-e53b0829a3e7@redhat.com>
Date: Mon, 2 Nov 2020 09:30:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201101212245.185819-1-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: darren.kenny@oracle.com, thuth@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/11/20 22:22, Alexander Bulekov wrote:
> OSS-Fuzz changed the way it scans for fuzzers in $DEST_DIR. The new code
> also scans subdirectories for fuzzers. This means that OSS-Fuzz is
> considering bin/qemu-fuzz-i386 as an independent fuzzer (it is not - it
> requires a --fuzz-target argument). This has led to coverage-build
> failures and false crash reports. To work around this, we take advantage
> of OSS-Fuzz' filename extension check - OSS-Fuzz will not run anything
> that has an extension that is not ".exe":
> https://github.com/google/oss-fuzz/blob/master/infra/utils.py#L115
> 
> Reported-by: OSS-Fuzz (Issue 26725)
> Reported-by: OSS-Fuzz (Issue 26679)
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
> 
> Also, for context:
> https://github.com/google/oss-fuzz/issues/4575
> 
>  scripts/oss-fuzz/build.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index fcae4a0c26..3b1c82b63d 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -91,7 +91,7 @@ make "-j$(nproc)" qemu-fuzz-i386 V=1
>  # Copy over the datadir
>  cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
>  
> -cp "./qemu-fuzz-i386" "$DEST_DIR/bin/"
> +cp "./qemu-fuzz-i386" "$DEST_DIR/bin/qemu-fuzz-i386.base"
>  
>  # Run the fuzzer with no arguments, to print the help-string and get the list
>  # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
> @@ -104,7 +104,7 @@ do
>      # that are thin wrappers around this target that set the required
>      # environment variables according to predefined configs.
>      if [ "$target" != "generic-fuzz" ]; then
> -        ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
> +        ln  "$DEST_DIR/bin/qemu-fuzz-i386.base" \
>              "$DEST_DIR/qemu-fuzz-i386-target-$target"
>      fi
>  done
> 

Queued, thanks.

Paolo


