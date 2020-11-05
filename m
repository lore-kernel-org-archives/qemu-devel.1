Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B372C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F59D2080D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7TQjuPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F59D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaiJv-0006lC-8w
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kai9g-00076T-0s
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kai9e-0005Pv-38
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604593827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFnVVEtETQZI4lcdwV65DHKv7tHnVxRx8o72VcBYh/8=;
 b=E7TQjuPSkLnRXQF81IqMNh4qEGKnjWiIEnikhD8B/KtVtr6j0ExUH30yN3v+k1V7PdUKSW
 UbEyGhaAcXOqX4c4FvdNOZkqz9nl/jQJQcxLlR0X4+gWdMR/yp5I0EcdDvAb8zspZmLjRa
 g3yKExX0C6tXXOBed0XczGgZoct7haw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-yin5GYHNOve8FhQ9-gW57A-1; Thu, 05 Nov 2020 11:30:24 -0500
X-MC-Unique: yin5GYHNOve8FhQ9-gW57A-1
Received: by mail-wr1-f72.google.com with SMTP id v5so954907wrr.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 08:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YFnVVEtETQZI4lcdwV65DHKv7tHnVxRx8o72VcBYh/8=;
 b=V6Rfftl0a8nbWcA4cR5XzsLoOunrZA194JReBWG7oGT+NVzFMHLk4PdKmJaqN3C6kd
 T4ZdPksTLsRfwiGqOuTKLfgTtvsOgspqetGjYvwFYCQB5RckvnEtW/IqMA/zo1pxc1rj
 8nUBxxWYZvbC46ZhuhGYX1F3w6hAiFo4HiKuuVdU+uQddXj4eylBnBWnEYo8wcZ07T8j
 biPJJ21O/aw0B45+jQnlIYkd2QRDtQdmbzFNRa5rWmHk9406jTLmjUcLU+HpS5wKkuYg
 n2txK8AJxyvT19khZb6ZMiSGY/p1PYDhqaHpE/0WV4xSXoPl+lWe7fy51BR7mXqS90to
 ytMA==
X-Gm-Message-State: AOAM53264vXHbsqkeueTUhtuKPLLyvfrF5Y02mu9XYBfodq7hY0tqo8M
 eOV6ZX9anB8v2Lx3gJjWtK2NHjFumaYgFsfXNfa96RICvbpYzwo1VVR4TpOHjfBhQVplXwZNbNB
 Nl6uMPWDbTGiuv34=
X-Received: by 2002:a5d:51d0:: with SMTP id n16mr3836556wrv.43.1604593823507; 
 Thu, 05 Nov 2020 08:30:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz49CfOm64R3Eq/LLn6Arrq1aHda18bAYop++xu7MBusEJMFhczMvhcJ4eO3CmefCDdU0rGuw==
X-Received: by 2002:a5d:51d0:: with SMTP id n16mr3836538wrv.43.1604593823356; 
 Thu, 05 Nov 2020 08:30:23 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id r3sm3206100wrm.51.2020.11.05.08.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 08:30:22 -0800 (PST)
Subject: Re: [PATCH for-5.2? 2/2] Makefile: No echoing for 'make help V=1'
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <160459121308.462591.11794514422987547665.stgit@bahia.lan>
 <160459122012.462591.8467906402712875729.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <93271510-f1c3-1d67-d47d-427441ead645@redhat.com>
Date: Thu, 5 Nov 2020 17:30:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160459122012.462591.8467906402712875729.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 4:47 PM, Greg Kurz wrote:
> It doesn't bring much to have echoing with "make help". Suppress it
> unconditionally.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

'make help' is not as helpful as it used to be. Still:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>



