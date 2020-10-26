Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118A4C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811B420719
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX2t6HQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811B420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2lT-0002jk-Cw
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX2kD-0001UE-IU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX2kB-00007I-VS
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603719662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOdPW/FPV+izbQ0JRIQQdrrYT2ZuodXr/PqbrEc8U8E=;
 b=WX2t6HQtN/tvIBtc/TvMVBLzrVeJa81VpSEixyK/mLhstAHg0nG/AMmDIOcIH3lSes7k9H
 qv5tGN7EgDXmBewFVnQNah1rlLQGaOkGRSPl8NvoB0O0W2h5Qia+RRmNUPnKJPaARIZDaD
 q1ANkxqBcUaqeS3MjuyeYXaWkH4sMt4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-2WF6zHLcPQC4XssYN8wzVg-1; Mon, 26 Oct 2020 09:41:00 -0400
X-MC-Unique: 2WF6zHLcPQC4XssYN8wzVg-1
Received: by mail-ej1-f69.google.com with SMTP id gh22so4946301ejb.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 06:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aOdPW/FPV+izbQ0JRIQQdrrYT2ZuodXr/PqbrEc8U8E=;
 b=n/WTtjcnjYpIPLWFDjVQmRPcUGwy+R+KJALP7h0qrdfOiapb1L9yfXgXd36qEG6reG
 fIYMkOs5iu/uD2QcYmC1wfCkb1QZ7bSEZ3wHzF/5Z5lKnOvZ5Ij40mOLnhQHmhYM6huV
 SB/4ZaSXFLc1P7Mfjw4MOQmf0Qn0otLJNavjiPCLaNyP3paCl1uLm+Bhk6sS3NhMb7FR
 0hCZA4KNQA8SYsGLOAPg1hQ0/3C25Yhr4dkznJqd3h1OjsaUOCXI8dYxP5sD8ebcEY9j
 bcIs6YbTPDAlhSMiK1zpY5sKslKXCrYHdEVXn248nyuzFSrOijCh4+vIsFNoTPNKkY+9
 FrFg==
X-Gm-Message-State: AOAM530Uo8gTZAg74Jhu5u71Y1CARb+6kkbSZNGhaKmg071DpyyqIvHe
 JpH9KKDaieJdac98mMtD0IwYwXPp8Cg1NQHT0IxGH8VgLyi855fp8INgn56cFBxWhKYjOvZVA+/
 Cs40+8HuD2ioBPGo=
X-Received: by 2002:a17:906:6d89:: with SMTP id
 h9mr14926262ejt.152.1603719659585; 
 Mon, 26 Oct 2020 06:40:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVUR7SbGQv02sLQy5z5zOHVXxtLsbxGLWGE9NcmKUnaK0SckPLVRVOsCT40dawisoHeBxBCw==
X-Received: by 2002:a17:906:6d89:: with SMTP id
 h9mr14926240ejt.152.1603719659403; 
 Mon, 26 Oct 2020 06:40:59 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d24sm5224070edq.34.2020.10.26.06.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 06:40:58 -0700 (PDT)
Subject: Re: [PATCH] device-crash-test: Check if path is actually an
 executable file
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201026125238.2752882-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a8ffa626-e754-5ac4-1859-16387f5432ed@redhat.com>
Date: Mon, 26 Oct 2020 14:40:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026125238.2752882-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 1:52 PM, Eduardo Habkost wrote:
> After the transition to Meson, the build directory now have
> subdirectories named "qemu-system-*.p", and device-crash-test
> will try to execute them as if they were binaries.  This results
> in errors like:
> 
>    PermissionError: [Errno 13] Permission denied: './qemu-system-or1k.p'
> 
> When generating the default list of binaries to test, check if
> the path is actually a file and if it's executable.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   scripts/device-crash-test | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


