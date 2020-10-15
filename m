Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFDBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D4D206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0NdH8QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D4D206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9Hn-0006YX-Vk
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT9H9-0005tV-BM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT9H5-0007aI-Ne
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602791454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=or/Sgac7zDovAQ5/8oeN0LrMcskb50LWmXBGUlzfBcI=;
 b=f0NdH8QAQwX7OJpJuSBKb3yQuE+FSq3zJpCq7vxayOZT4tvZR5Mol9+wGSpDBmkde7upp/
 efO1lB3J//ER9ZPvasPInzoe+CX0AZuN957My87jvpnB0xG/v28JCLEM/ZBO3FjCpe/T9b
 XLipOVX8Oi+/O696Q8v29v6jKwhcf2w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-tQAXy0xiP_-J6YOvWF69vw-1; Thu, 15 Oct 2020 15:50:52 -0400
X-MC-Unique: tQAXy0xiP_-J6YOvWF69vw-1
Received: by mail-wm1-f69.google.com with SMTP id c204so207295wmd.5
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 12:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=or/Sgac7zDovAQ5/8oeN0LrMcskb50LWmXBGUlzfBcI=;
 b=GRO2UFHBg8VB2gpBiBtRDnDTSj/aplLiuOEzqpeJ/VkhU9i41B7r57oIeymme6oHWm
 Swx/PiYUk7we0WYtozKaH7l+jV1X932beXNR7l2GIevIS1pbFYTv+USOKRYMnOMZOwLY
 L9lnc169auzmLa+4fnm/8XCPRNxYFlYmt48DGlVtOH//gF2VxCTcaJAE7iQ4whbpidep
 YQgxAapfDeGKD0TIkkYl02Sf0Clal59tXhyFNgdoJNyacbmu2mNxLXLA2Hbf06j0hUJq
 VVFiIN7Zd/JdoFhp9xG/FgT8BPkRngY8MLV/y0Gg6SuqhjGN+XDjb5R4nefXmUT0GJf7
 NpLg==
X-Gm-Message-State: AOAM5325U7VJraltwaUEu1JLLy/bj9tW2dkzkflUGlOsvsGVHjUviDOr
 hUhynp/txMb0hWRnArW76m3otvKCX+rrjBQGjn8Ra+23WWR/Qkhr14HbbkMAjgweaJfUij3tE10
 C0Ib1mjtjmtU6Syw=
X-Received: by 2002:a1c:a983:: with SMTP id s125mr307619wme.50.1602791450848; 
 Thu, 15 Oct 2020 12:50:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKwY5+zQ+Y2uva2hcpfX0Te+qzJ/O/JkNNl6/MMZMai8uJMX0vGrNtP4enoS5YEYExn+Gumw==
X-Received: by 2002:a1c:a983:: with SMTP id s125mr307608wme.50.1602791450673; 
 Thu, 15 Oct 2020 12:50:50 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j13sm444469wru.86.2020.10.15.12.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 12:50:50 -0700 (PDT)
Subject: Re: [PATCH] configure: fix handling of --docdir parameter
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
References: <20201015190742.270629-1-brogers@suse.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1ca04ef1-7c34-cb2a-e246-b7c085707db6@redhat.com>
Date: Thu, 15 Oct 2020 21:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015190742.270629-1-brogers@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
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
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 9:07 PM, Bruce Rogers wrote:
> Commit ca8c0909f01 changed qemu_docdir to be docdir, then later uses the
> qemu_docdir name in the final assignment. Unfortunately, one instance of
> qemu_docdir was missed: the one which comes from the --docdir parameter.
> This patch restores the proper handling of the --docdir parameter.
> 
> Fixes: ca8c0909f01 ("configure: build docdir like other suffixed
> directories")
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


