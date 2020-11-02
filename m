Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7115EC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A462227F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgbJCar4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A462227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaCi-0005jh-OS
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZa9p-00045I-5O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZa9k-0000jr-QR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604324754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcpD+FyJZ0K6yNbiD32CW6i3e40xFnd3rE7BM2MiplM=;
 b=LgbJCar4u+yGFfFMXrjqPi+bCh67WCtjlTIyu3r2Vb2CirA7Ui+n9dgoK5RRPINHYaSRkS
 V304T0vNd73qhkWqDniMnF930/ukzco9G9lL+oVdSW57LG1bQJ2t/7W6SZAAGO5DvYa/YK
 147oHp0umDM9qpuZbybGHlAdK0sLKak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-5Cqz-aCJMtaDE3x1dtZq3g-1; Mon, 02 Nov 2020 08:45:52 -0500
X-MC-Unique: 5Cqz-aCJMtaDE3x1dtZq3g-1
Received: by mail-wr1-f72.google.com with SMTP id m20so6457199wrb.21
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 05:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BcpD+FyJZ0K6yNbiD32CW6i3e40xFnd3rE7BM2MiplM=;
 b=bBB+nLLAauMlAJ4Cb0cE/93oaaJKoXA5YJFhzo5A4ZAWK9uqWLKGildsRqcnSCStks
 gO0f2iVqty1m6+FtYxGPtip+PPNrx6F6+IFvC4r6aa4jXCjEbV+Wwak7gtLyY4Ar3tT2
 gZfADiP8NCDlgI2MWMg37AqmB2yfXvIWObBwX52TXds17ZPuCYb7GABZ9H86AdfoInxI
 fsz0ZHYWzfptoG9+hD6NjECPCdII49LRNdAhmOLBPn6jmnozuGNUJeIIz62SwPc/3OyQ
 Cy0lmevZRsqAsEBf0hhc8tMrmhct/v5LhwIkmtHobQhFfBoRVHJIvnBPfBxEoMNBoRZC
 4Iug==
X-Gm-Message-State: AOAM530H4osN1I++x8GO2OnO7nEBMVJXReaHx1Sg+xJWbE0uNg9d6N45
 U+hR5XO2BN5hwThOubhlrF7vBuA7stIXzQa8KjhgJW6aNuVtsQLwp7qyCxrEzZ9E3OFdk6vaTKg
 McUW2lav/ybZCbrs=
X-Received: by 2002:adf:f841:: with SMTP id d1mr20565939wrq.297.1604324750653; 
 Mon, 02 Nov 2020 05:45:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLYuFnQHXM+4W1Lx1H9nPmSzT7EJT9zFFm4ENKPzvAAnyt1N1RTJyyCpey3wnHZhnHzVH+XA==
X-Received: by 2002:adf:f841:: with SMTP id d1mr20565913wrq.297.1604324750437; 
 Mon, 02 Nov 2020 05:45:50 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u5sm5171880wml.13.2020.11.02.05.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 05:45:49 -0800 (PST)
Subject: Re: [PATCH 0/4] Publish docs as GitLab Pages
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201102130926.161183-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5009122b-134a-9364-d3a2-3d9d85ea8981@redhat.com>
Date: Mon, 2 Nov 2020 14:45:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102130926.161183-1-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:09 PM, Daniel P. Berrangé wrote:
> This publishes the various docs as GitLab Pages, allowing users to
> browse the docs generated in CI before sending patch series to the
> mailing list. It also introduces a sidebar link to the original page
> source to show readers what file to modify if they want to contribute to
> the docs.
> 
> Daniel P. Berrangé (4):
>   gitlab: publish the docs built during CI
>   gitlab: force enable docs build in Fedora, Ubuntu, Debian
>   docs: show stdout/stderr when meson fails build test
>   docs: add "page source" link to sphinx documentation

FYI (as commented in the first patch) this series result can
be looked in Daniel's page:
https://berrange.gitlab.io/qemu/


