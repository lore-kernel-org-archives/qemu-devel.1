Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474D2C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCAD20829
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElE/pTUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCAD20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKI4-0003hD-62
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 03:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTKHP-00035d-VE
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTKHM-0008GG-W0
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602833755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTiPuN+95HM+7zA+r6m1GyU1S5sxebjFTd9YBnXXjWI=;
 b=ElE/pTUL7vTQe8Myw8r0mKTmBqke9Kktr6sJDyqqb4NlqX1bj0rlLvfjEwlrvKvRTjG2rr
 p+wfscYkw3XpikrFD0pfXmvow3X/7mBGF1XsLao/bHKMMuMMBtWoG1nLz3+/xibMsaOZu9
 Qxy1eZtvjLKkgaj/vhUi5RrZTro9HHg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-HDXTIDEpP7y_VitG8SjnNQ-1; Fri, 16 Oct 2020 03:35:53 -0400
X-MC-Unique: HDXTIDEpP7y_VitG8SjnNQ-1
Received: by mail-wm1-f69.google.com with SMTP id z7so308480wmi.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 00:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NTiPuN+95HM+7zA+r6m1GyU1S5sxebjFTd9YBnXXjWI=;
 b=MsKFptEF1sp0+ML8/gWAbFFFhfM5Q4LQsmd6ikOn4qg+y4sM0LVq4KpNkQMHMVcZmv
 g8Tufnrp5+zDtVGumBLv6arBuf/gKrbKuluiDO26nZN5s2B+YVV2v0VrFOFYAfUAxeZl
 rmu4lK7mCkA3yvf3j2lZAM0mO/+IRivSNrALF80owM5LNedmJomhKlxHt9mMr2np6cpX
 pNld9AwRYOkcLwnGsnskrVhHyIIpbaAwu+g/kDRNkkX4Z+0Ea9i9PLdvpgNN4nIbeJs/
 8hricp5fQImvO8aBYlTBlyj9FkBxPfwR6S3pYB3SnlYDoOmUE/mMba4Q07oV/NI0heFL
 TtmQ==
X-Gm-Message-State: AOAM532LebZgUwWru8kwZbFvZbjZeOm30r0Z0Py8a5N95Aow1ftg5jYc
 dFi0m1VU8uwU2+lEkXXAxD2ZaA60tk9it8bfcAyjL35h/q4rB80vaoN9HaRFBVizs8JArzA1yWF
 8Nwcq++SRmozRzgY=
X-Received: by 2002:adf:ef06:: with SMTP id e6mr2265520wro.397.1602833752819; 
 Fri, 16 Oct 2020 00:35:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7Wff4f34eYCzSV4Hwmi1ofSL/xqJXhlvpAI5fjQUTSlM08C+DY+V4T84r5mKM9EepvoHyfg==
X-Received: by 2002:adf:ef06:: with SMTP id e6mr2265502wro.397.1602833752593; 
 Fri, 16 Oct 2020 00:35:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3?
 ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
 by smtp.gmail.com with ESMTPSA id t124sm1717423wmg.31.2020.10.16.00.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 00:35:52 -0700 (PDT)
Subject: Re: [PATCH] meson: Only install icons and qemu.desktop if have_system
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
References: <20201015201840.282956-1-brogers@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f1fa79a-3e58-2061-661e-5198d60430bc@redhat.com>
Date: Fri, 16 Oct 2020 09:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015201840.282956-1-brogers@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: berrange@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/20 22:18, Bruce Rogers wrote:
> These files are not needed for a linux-user only install.
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  ui/meson.build | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/ui/meson.build b/ui/meson.build
> index 78ad792ffb..fb36d305ca 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -113,8 +113,11 @@ if have_system or xkbcommon.found()
>  endif
>  
>  subdir('shader')
> -subdir('icons')
>  
> -install_data('qemu.desktop', install_dir: config_host['qemu_desktopdir'])
> +if have_system
> +  subdir('icons')
> +
> +  install_data('qemu.desktop', install_dir: config_host['qemu_desktopdir'])
> +endif
>  
>  modules += {'ui': ui_modules}
> 

Queued, thanks.

Paolo


