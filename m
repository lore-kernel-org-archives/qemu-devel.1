Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F2BC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266E7206CA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHOhs1AJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266E7206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjMp-000385-8L
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGjKF-0008Fc-GY
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGjKD-0002zu-LW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599831768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DnWo3tP97vNmACKVOm1qSM4jaSAbbaFGgmzo6QA9lU=;
 b=iHOhs1AJ7BRBWrT4iMkL72xg6T9kvsOqwx/z06vDXCFOyiYlRUWtqhJHRa67RZmpvBeqrQ
 Sgz2tcimy0RiieXkHRrR3jxbxnOWMV5OJJAX8AeMAy6X7+5wLOtMV3rgDeC1X5chflcmjp
 CepxUM1vSS3xrQITmmWAd2ZHDQq9b+w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-0LMF9aRqNmGfrEFkx4Q-oA-1; Fri, 11 Sep 2020 09:42:32 -0400
X-MC-Unique: 0LMF9aRqNmGfrEFkx4Q-oA-1
Received: by mail-ed1-f69.google.com with SMTP id g16so4314366edy.22
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 06:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4DnWo3tP97vNmACKVOm1qSM4jaSAbbaFGgmzo6QA9lU=;
 b=oYEcA3RnoMJoFNGGX1DoI/EOhn1RCnc5FdjqcO7lFJLJao7oxSMpfzSnDsmYUhwZDG
 +G5401al2sgCUYKpQNvwWjEOzR1qs7DE2W2RHy5oDQzrTDSIg2RZ6v3n7DdvhGhkPinn
 9ATdYZvD4cCRSIp27hKekB8tE64U03a4yUgN30oo+41rlcbCkiT8pH/5cDCRV6Lej+kn
 pLYn1yEXPWOvroMkgAISwJXYtPsfUbvhz/txvjnQBtGRzb/SmaenGuY2/cEpMoNsHHH0
 5V/ai3Ih8tIy7a7iG0tZlRjYpyqEVTB61B51w/p52Xpk88898eMdY0w2XWjOxHFovrEO
 3qsw==
X-Gm-Message-State: AOAM531g/PSme/R8UUsG46luHLotXS/bADR+pk3y/EoZYSoMNXBi1vDN
 VwWwsJHDc97Hc8nbnI+3yOIrmVzCbV9VAB5ebKEgr9UlqvhApkq9P06GWIcM21hRCOPKLlh5Kgk
 oBG9NvAxArtvYAiA=
X-Received: by 2002:a17:906:17c6:: with SMTP id
 u6mr2169172eje.95.1599831750716; 
 Fri, 11 Sep 2020 06:42:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGOlvo/Aemig2M3UiBpVbkiu0x+j/WXIGE9mYVPpjZ6ZzkBh10jMDTE62GXpgMFsg7J/70+g==
X-Received: by 2002:a17:906:17c6:: with SMTP id
 u6mr2169156eje.95.1599831750485; 
 Fri, 11 Sep 2020 06:42:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5568:7f99:4893:a5b6?
 ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id lr14sm1628747ejb.0.2020.09.11.06.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 06:42:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] meson: error out if qemu_suffix starts with /
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20200911124248.1088614-1-marcandre.lureau@redhat.com>
 <20200911124248.1088614-2-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <feedecfd-87c9-480b-9440-4280f8d1a567@redhat.com>
Date: Fri, 11 Sep 2020 15:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911124248.1088614-2-marcandre.lureau@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 08:18:51
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

On 11/09/20 14:42, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Since the variable is used for path concatenation, the result would
> ignore the prefix directory altogether.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  meson.build | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 5421eca66a..cbe1cb51b3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -17,6 +17,11 @@ config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
>  enable_modules = 'CONFIG_MODULES' in config_host
>  enable_static = 'CONFIG_STATIC' in config_host
>  build_docs = 'BUILD_DOCS' in config_host
> +
> +if get_option('qemu_suffix').startswith('/')
> +  error('qemu_suffix cannot start with a /')
> +endif
> +
>  qemu_datadir = get_option('datadir') / get_option('qemu_suffix')
>  qemu_docdir = get_option('docdir') / get_option('qemu_suffix')
>  config_host_data = configuration_data()
> 

Queued both, thanks.

Paolo


