Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0300BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3952074A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXONCCJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3952074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBiNw-0003bE-1P
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBiNA-00036l-Un
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:41:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBiN7-0007rW-Nb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598636464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bjp7dIk2c5OlbLUlMoUHyJ0VMurfRTivaLuwFZ1/Acw=;
 b=GXONCCJber2xImeTopxFBOuoXxEIEhEHdbkFbpsPlBa+VkKBRGwNhsKPqT7InjSQpfNGvC
 b+Qfm28ptPFofv1l+BvfZD7cmErqUqCFXtndlpRs1VifYaoQTAUzq0LzP72dMsqhKHXscV
 k167JjlIEuwCmtiI8PDlEXuuwxMs7Yg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-yJD27AJpOWyVzUpby0UbhQ-1; Fri, 28 Aug 2020 13:40:56 -0400
X-MC-Unique: yJD27AJpOWyVzUpby0UbhQ-1
Received: by mail-wm1-f71.google.com with SMTP id p23so68684wmc.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bjp7dIk2c5OlbLUlMoUHyJ0VMurfRTivaLuwFZ1/Acw=;
 b=bRFv4azY3jAJ5o/85NDNl3I3bdlqxRaBBFnsqP/Sanx0NSZB6HnmDTRfazkQP5qLex
 EALokfDqfswoArXaT34etVmRRe7jqUqQdd1nWPb1/lUi6KyYgpvVAY6c+NJ+5LqqbNa4
 Vsyp4YIRY8AbelahiLbiOT6cP9ADP/nRRd1u39NpQ9uyBSFrr1CjlIK74mNBu4NuEkH7
 qO/p6zsfxyBPpKLUQmWxTkn34OzwwkbOVW/elIG748z+2zOH50oTUiycfqO6aQKxr2LB
 fRK+lHh56FDECRNvVWRQmRzfziaIAYNnwBEwHIdytoJZhfTv+J8yJJy1tjuc50+gq7y0
 t79g==
X-Gm-Message-State: AOAM5335ciSgwNHlEaVQ626Ta03FpA4Fhn8IaK+r544emDLJty3Cpacv
 f7am0PqwdUWcOY+m/tQFRhXLh3e0tCibY0lAndWP/XyD1sGfOR4iRBIX/86JO3nLn2GuX1KRQgn
 jEb5ZtdiLcpx9Qf0=
X-Received: by 2002:adf:82f6:: with SMTP id 109mr107167wrc.25.1598636455463;
 Fri, 28 Aug 2020 10:40:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh6hWn5SqKlF5JekJ/clmj8WfWmJ5KN9SXJmucXgu5PqQsJTDSBxBP67tRhWlYWycyJhP+Iw==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr107144wrc.25.1598636455190;
 Fri, 28 Aug 2020 10:40:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c924:73d2:e509:7a3f?
 ([2001:b07:6468:f312:c924:73d2:e509:7a3f])
 by smtp.gmail.com with ESMTPSA id t25sm151159wmj.18.2020.08.28.10.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 10:40:54 -0700 (PDT)
Subject: Re: [PATCH 0/2] Getting qemu building under msys2 properly
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200828162246.423-1-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20cd87f8-d4c7-677e-3992-57ecf3d94964@redhat.com>
Date: Fri, 28 Aug 2020 19:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200828162246.423-1-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 12:33:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 28/08/20 18:22, Yonggang Luo wrote:
> Convert undefsym.sh to undefsym.py and replace $PWD with $build_dir
> 
> Yonggang Luo (2):
>   meson: Convert undefsym.sh to undefsym.py
>   configure: Fix include and linkage issue on msys2
> 
>  configure           | 28 +++++++++++++++-------
>  meson.build         |  2 +-
>  scripts/undefsym.py | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  scripts/undefsym.sh | 20 ----------------
>  4 files changed, 77 insertions(+), 30 deletions(-)
>  create mode 100644 scripts/undefsym.py
>  delete mode 100755 scripts/undefsym.sh
> 

Thanks Yonggang, I'll queue the first patch.

I'll keep an eye on your patch but I prefer to first have the rest of
the build (tests and possibly pc-bios) moved to meson.build.  This way
most of the references to source and build paths from Make (where spaces
are problematic) should go away and it's easier to understand the effect
of the patch.

Paolo


