Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F49FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BD220787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="av1aD4ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BD220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaae3-0003ix-Aq
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 03:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaadF-0002mr-QJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:56:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaadE-0005fs-N9
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589788576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30sJb6XvL+VUIj7MLhqbvtpw7ik1DUXGLc8LLLbVcrY=;
 b=av1aD4ecIt9wVpcy1qw2SybbPl1Fv2HPhGGHa24CX+sctPf91bhyXZpeGnKnhS3Ek2iuoG
 +OBVfCnPJvJRgu+/Y5EwvnyM7VX1YcBL2sp/BwQdTOs9e6U2ygdTFkrTaStM7qhJxzvfHT
 l11eCdISuQEKbF7k2UNynz0akCfIOWs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-iTlJn_iuOqSfgHwPYOwhHw-1; Mon, 18 May 2020 03:56:13 -0400
X-MC-Unique: iTlJn_iuOqSfgHwPYOwhHw-1
Received: by mail-wr1-f69.google.com with SMTP id z8so5221537wrp.7
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 00:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=30sJb6XvL+VUIj7MLhqbvtpw7ik1DUXGLc8LLLbVcrY=;
 b=I8wIeUtxGiYAXNi2t2rQgsd7E2UfkKGI6RuH7OE6388QA+R6gcmWGERs8dqdOfFwRT
 tRi1sW20a8lPGLD+sL0PbOmKPlka157VTFEY+yABnZMGoIpEEZC8/wdKAqU8VwC3G3go
 UZHIsknfHzFTLyk9m4XDQbZQd6nLjKZIJRn9PSIXRw06vX6CKQySNgciYInefkbzLtmS
 enqjQHRuRLTm4z0RQaGwnaIypRq/LFoTVsi8ZlmoNgalx1AXPEbMMKVwBEAjtP1XINXq
 71yW1qgGnx4GTIa63aFnnD6Zzo0EDAOFiT2qXxsw021MQizI5oYU5xrd9hgr10fYkV8A
 +Pjg==
X-Gm-Message-State: AOAM533b0GUNDSVsjzUE+7fPUyXivlfUMiy1oFytxFQpNn94Xllx8JsM
 1LglztElx/a0At40D745FjhoLSHlyF4jQxiEU4IZV3KTzXz7u3hiwz5RvoyZzJWL0/+nFz8hP1g
 YUyuRVd05faxq3O4=
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr18503660wma.170.1589788572651; 
 Mon, 18 May 2020 00:56:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBRFK+M62G8A1k+bSBH3qz5uy11UEAhm+n2ooKiDEXfKFrNpoyybH2X6yv+M4xfWn1aCDV/A==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr18503643wma.170.1589788572460; 
 Mon, 18 May 2020 00:56:12 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c143sm13962443wmd.43.2020.05.18.00.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 00:56:11 -0700 (PDT)
Subject: Re: [PATCH] net: Do not include a newline in the id of -nic devices
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
References: <20200518074352.23125-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1dfc3a44-8528-beb1-7c02-63274b6ccd20@redhat.com>
Date: Mon, 18 May 2020 09:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518074352.23125-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 5/18/20 9:43 AM, Thomas Huth wrote:
> The '\n' sneaked in by accident here, an "id" string should really
> not contain a newline character at the end.
> 
> Fixes: 78cd6f7bf6b ('net: Add a new convenience option "--nic" ...')
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   net/net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/net.c b/net/net.c
> index 38778e831d..cbeeeadff8 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1506,7 +1506,7 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
>       /* Create an ID if the user did not specify one */
>       nd_id = g_strdup(qemu_opts_id(opts));
>       if (!nd_id) {
> -        nd_id = g_strdup_printf("__org.qemu.nic%i\n", idx);
> +        nd_id = g_strdup_printf("__org.qemu.nic%i", idx);
>           qemu_opts_set_id(opts, nd_id);
>       }
>   
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


