Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB63AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5965C24804
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJ8hKIxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5965C24804
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLAt-0004Xz-5D
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSL9Y-0003cH-QN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSL9V-0008B7-Cz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602598783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOv27z5xhdK4/eY0BmPUYbYYvfCTu8eURB6iPyPgwCo=;
 b=IJ8hKIxezZ1VXAelJ9FFMbrn9jzvPDgJx56+y5uR1tsjkPWeDYPcQwT8vADxGK0d6MyGXW
 ZZtHJD5VZ20lObMmi777/mvb9f+YAykehKiFxtpvvXryNOe7TjBqa29AY606uxgGUuN45G
 A3tS8HurpJ6+nh6FAZjHSkP1NlzokDg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-QEdk0op3O9-qT7qRPOUAZg-1; Tue, 13 Oct 2020 10:19:41 -0400
X-MC-Unique: QEdk0op3O9-qT7qRPOUAZg-1
Received: by mail-wm1-f71.google.com with SMTP id z7so42560wmi.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WOv27z5xhdK4/eY0BmPUYbYYvfCTu8eURB6iPyPgwCo=;
 b=DXRX0A6aNs0xr5pSP5gZN9eXlV6w51atyt1Y6wO5+WqUUbjFQlkiR1biJzE9XDS0fQ
 A3X/9cc0i6JrouggiERuAoGLXwhIQiutJiIuANFjv8AZuM8kVFkFTodzUgtlDzlLxN8S
 xrzu4ImJmvwWSVUBBdqmk69PqP3DqjcZR9Ri3lS+8EUMk2wpdBo5tMdQf/Gfnb0MMBW8
 Qad0PBDgoZKah8IM1S2/cJdmJD8O52KsVbYuDTYSDqQQlYzguCXbZJ5oJfyOG7/BX033
 mYFhTlc6o0DOgH6dMzLxPDvtDS6CMXjJKBXtooaYMxAswWcoyVA3vCw8WD9zJojrWUdq
 vSDw==
X-Gm-Message-State: AOAM532t6HRxOBj/G/K8jKkv3qeTjtQI2CUX75O54zDft632PG3p7Xe/
 dF221hGztE5SxRXj96NDsr04RPjXc39hwT5btbuvnn+YTsR2HvijE2TfC0aXP7pU2MhtyvAbO0B
 iXz2U3KKXn/9kIc4=
X-Received: by 2002:a7b:c085:: with SMTP id r5mr67468wmh.17.1602598780380;
 Tue, 13 Oct 2020 07:19:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwo5/56Ij4h9ohtF/0X5tYD7oS0nXWeIZfP9rItx4BzKzGPSeg/6fNkM1p5jU2GKPuklOHgnQ==
X-Received: by 2002:a7b:c085:: with SMTP id r5mr67452wmh.17.1602598780209;
 Tue, 13 Oct 2020 07:19:40 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t12sm19759134wrm.25.2020.10.13.07.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 07:19:39 -0700 (PDT)
Subject: Re: [PATCH] qmp-shell: Sort by key when pretty-printing
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201013141414.18398-1-david.edmondson@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71a27e2a-3883-fc4f-647f-594b49f62816@redhat.com>
Date: Tue, 13 Oct 2020 16:19:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013141414.18398-1-david.edmondson@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 4:14 PM, David Edmondson wrote:
> If the user selects pretty-printing (-p) the contents of any
> dictionaries in the output are sorted by key.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   scripts/qmp/qmp-shell | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index c5eef06f3f..b4d06096ab 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -260,7 +260,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>           indent = None
>           if self._pretty:
>               indent = 4
> -        jsobj = json.dumps(qmp, indent=indent)
> +        jsobj = json.dumps(qmp, indent=indent, sort_keys=self._pretty)
>           print(str(jsobj))
>   
>       def _execute_cmd(self, cmdline):
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


