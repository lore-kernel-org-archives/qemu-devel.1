Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EBFC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37E420797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="er6IfXhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37E420797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQB8Q-0003W6-LL
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQB7J-0002wy-Id
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQB7G-0001e6-5l
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602083548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGAeFSlDQMyCs7edayZGzepLWoyhQTBGcNgC23QgIUE=;
 b=er6IfXhj3LAdCnmz/6rJNJcL4J3QrNJ8e+L9EsaRZk3ZQqTglIyKpIQI5Ft1/DgIqXKvx3
 hTfpZ0BalFYbGoxNDIqGQEBe5517YVqp8wWPLrj+SdBdJKc/2l5Ui16eTnfLYJP0PzRDTS
 XaRmLLKz/1eX3zM7KTDhOXTycfliSzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573--NKYqwYoPc67-FehzCLNmw-1; Wed, 07 Oct 2020 11:12:26 -0400
X-MC-Unique: -NKYqwYoPc67-FehzCLNmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E334D84E246;
 Wed,  7 Oct 2020 15:12:24 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 747605D9DD;
 Wed,  7 Oct 2020 15:12:23 +0000 (UTC)
Subject: Re: [PATCH v5 1/2] cirrus: Fixing and speedup the msys2/mingw CI
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20201007145300.1197-1-luoyonggang@gmail.com>
 <20201007145300.1197-2-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <11e4e784-3ce9-a385-bf81-8c7e1034f42d@redhat.com>
Date: Wed, 7 Oct 2020 17:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201007145300.1197-2-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/2020 16.52, Yonggang Luo wrote:
> Use cache of cirrus caching msys2
> The install of msys2 are refer to https://github.com/msys2/setup-msys2
> The first time install msys2 would be time consuming, so increase timeout_in to 90m
> according to https://cirrus-ci.org/faq/#instance-timed-out
> 
> Apply patch of https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  .cirrus.yml | 110 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 66 insertions(+), 44 deletions(-)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index d58782ce67..a1145d0366 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -46,64 +46,86 @@ macos_xcode_task:
>      - gmake check
>  
>  windows_msys2_task:
> +  timeout_in: 90m
>    windows_container:
> -    image: cirrusci/windowsservercore:cmake
> +    image: cirrusci/windowsservercore:2019
>      os_version: 2019
>      cpu: 8
>      memory: 8G
>    env:
> +    CIRRUS_SHELL: powershell
>      MSYS: winsymlinks:nativestrict
>      MSYSTEM: MINGW64
>      CHERE_INVOKING: 1
>    printenv_script:
> -    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
> +    - choco install -y --no-progress 7zip

Since you've now removed the 'printenv' line, I think the section should
maybe not be called "printenv_script" anymore, should it?

 Thomas


