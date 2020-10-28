Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6802CC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8612C24687
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiD0q9uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8612C24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXhqG-0006HZ-6W
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXhoa-0005e8-LL
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXhoO-0003oT-MP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603877524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljumxpNRHeGD0AfZgvVMJXqAW673luWfatV4gKXIIaE=;
 b=JiD0q9uuVaQZ5E5BFcnDsEu5OgOCAn6wQ+fnBU3f6NuInVSNTsgJIjVmi7b93JRt/bSHMR
 9jU6imqAu0Lz419zwhk9+oipXDIoOB9OWe+Lxzd4B5x6gnmDRzYvnGZdJqKSB57/f9rGlh
 pwYctfwNTbPtUNZY6b8xDZIHMza4y0o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-RF1Jn6TlOLuiWuedOnpHEQ-1; Wed, 28 Oct 2020 05:32:03 -0400
X-MC-Unique: RF1Jn6TlOLuiWuedOnpHEQ-1
Received: by mail-ed1-f72.google.com with SMTP id cb27so1856663edb.11
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 02:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ljumxpNRHeGD0AfZgvVMJXqAW673luWfatV4gKXIIaE=;
 b=e9XXnBSQRq7TJ/xONaTjOQGPmcChcncojzlnNx0fEEdGh0yqbChEHnilfKoKjAIkK/
 IjWk9snRD3EQR88YZlGRDwmDZ4PvVq/6Yqpu42GT+bVec0dK8vpTKmuFfkgA767wkkBC
 GsLzrGrPczeOD+B4anHtGwZQzTzZBNloQLmWTP/q/9CBPFAa+VieFyq/AbNGtYTq+tV5
 MuzKA5+5rlJxovXqgNNrGZE8ZB0PNoH0Kx6kP12MM4sd6GdEi9AjoYeMhyjESDb8BNfi
 bOFrGkXGnn2IaXQ+CVDJAgOXbE6Th2cb1mpaHU34dKQayBWJbvp49etW/IO7KFi+X58W
 L4TQ==
X-Gm-Message-State: AOAM530EIxxSOLFkTUl1JJFVr0ZhXpFEgU6BIwDIux6xCze8mdrjXy1q
 rK6UDnZS4B3B1a3BPb47WdBAcmZ4vZw9DUfmEzVJHDJT/0aOWGC52aLLX0HcYs7pPdXNQ3OusJE
 FtZu2HcSt7LXpjrs=
X-Received: by 2002:a17:906:240d:: with SMTP id
 z13mr6690716eja.267.1603877521311; 
 Wed, 28 Oct 2020 02:32:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjhPliO0VaTQDnZkatAy+iEc8W/uRKh0K8WZqsqWIDPu3n63l9T2lnnR7meydbiXtmKpCQvw==
X-Received: by 2002:a17:906:240d:: with SMTP id
 z13mr6690704eja.267.1603877521107; 
 Wed, 28 Oct 2020 02:32:01 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h15sm2555743ejf.50.2020.10.28.02.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 02:32:00 -0700 (PDT)
Subject: Re: [PATCH 3/3] iotests: Use Python 3 style super()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20201027163806.290960-1-kwolf@redhat.com>
 <20201027163806.290960-4-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eaca727a-6eed-a65f-bd19-417f00a7d87e@redhat.com>
Date: Wed, 28 Oct 2020 10:31:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027163806.290960-4-kwolf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 5:38 PM, Kevin Wolf wrote:
> pylint complains about the use of super with the current class and
> instance as arguments in VM.__init__():
> 
> iotests.py:546:8: R1725: Consider using Python 3 style super() without arguments (super-with-arguments)
> 
> No reason not to follow the advice and make it happy, so let's do this.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


