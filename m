Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63427C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC76922282
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDjv+lLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC76922282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyAk-00086H-DZ
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQyA8-0007fI-Aa
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQyA5-0002XS-QU
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9TK4xS63NFarUGyMpcAtuvAAVTvbaoURjQKxmQr1rc=;
 b=KDjv+lLeEioo9g0eh8lWpJFaaDGt4jV+oEI3s2jPUlRbelM7IirDis1xOcTCSZAhosO4+D
 Jpgns3xhBUpYmZPY9pJmVhj1tUZtCSrbalCHFtFanqjkwS43X9RG3ZL+Siaxz92mng1ZoG
 Z8FCgiqoP/k9hgLEektOdsHEBS3/JlM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-So4MR-faOjaKZzKyMIPFlw-1; Fri, 09 Oct 2020 15:34:37 -0400
X-MC-Unique: So4MR-faOjaKZzKyMIPFlw-1
Received: by mail-wr1-f72.google.com with SMTP id i10so5595269wrq.5
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 12:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j9TK4xS63NFarUGyMpcAtuvAAVTvbaoURjQKxmQr1rc=;
 b=Vb2FLe5UvuSU+KNP5cap6B/QscjvSGoArVfxVlyT+QvUSV6EMl7/E5mBdon3rDsrxJ
 yEQW7xCXHWCiA6XrmXKt+LICqPd68QCUp6HlHj+RV+zK4MkVpKvTk1leTT+Xpia+gjTn
 Vburit+pOCSnWnVJquGzNkjygpkYZYzpnF9dyVieNY8RF9gAlpXD29n6369uLgWhum+H
 i55WveHpiNyUR6rf8BI3Mgd5IwXhAE5FA6Dlw5ag1eMkwlULbq0BTn+OWbftTC3pSq72
 +8TKPKwJ4kwYjQq5o62P9BG62nkt/0XIi6Y+6b+jxaXOtJv0N0dPky7ZwO6KxiHG7IIb
 cKoA==
X-Gm-Message-State: AOAM530r4ExIBaLyLLVF1usubLz2A6PiAouuQ9iA5+ApXyXNj9Jdm7cv
 71bqk4uFYgZiUSvwPcq3t2SV0Rcmq17HQkqJj6P9emWWZJxJpC62dnbc0Q6csv15rMtIPVeLZ5F
 nTIMOOBfeFy2JrAw=
X-Received: by 2002:a05:6000:8e:: with SMTP id
 m14mr16568337wrx.400.1602272076518; 
 Fri, 09 Oct 2020 12:34:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze361k2Zhz87ey5/uT8kqo0U8NLfshDLCBey9nReSiaDCOzIVzJBHIoanc9bZoSPJwW9BAyQ==
X-Received: by 2002:a05:6000:8e:: with SMTP id
 m14mr16568320wrx.400.1602272076328; 
 Fri, 09 Oct 2020 12:34:36 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x81sm13074164wmb.11.2020.10.09.12.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 12:34:35 -0700 (PDT)
Subject: Re: [PATCH 2/3] python/qemu/qmp.py: re-raise OSError when encountered
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201009175123.249009-1-jsnow@redhat.com>
 <20201009175123.249009-3-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <48ab4909-8124-e358-f002-1b3f87d17a3a@redhat.com>
Date: Fri, 9 Oct 2020 21:34:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009175123.249009-3-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 7:51 PM, John Snow wrote:
> Nested if conditions don't change when the exception block fires; we
> need to explicitly re-raise the error if we didn't intend to capture and
> suppress it.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/qmp.py | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


