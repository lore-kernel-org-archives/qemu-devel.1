Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D84C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAD4222BA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5SXmcxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAD4222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUUhf-0000C2-TB
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUUh4-0008BV-4V
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUUh0-0000wy-08
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603112111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qceqnx9+o8vceAKlej+q0xmQhZZKxeNLiQ8dDfT+PU=;
 b=C5SXmcxl796S7fyB9dqf02/n46kQ6En07AZ/mgvUjnK/SSwfM0Kfm17ymJJODeLlJIb4GB
 E26Ec0eUHygwqgHeFTJzuGwRDxdbHeaugDYJU1xRVl3/5AFElOohsDkTZ2FxhWLiT5iphR
 41YbWhaLD9Mgma7JiU9/9VxQBWNx1+s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-nQE6CVHxNP-ANB20xgqMYA-1; Mon, 19 Oct 2020 08:55:09 -0400
X-MC-Unique: nQE6CVHxNP-ANB20xgqMYA-1
Received: by mail-wr1-f72.google.com with SMTP id 31so7354661wrg.12
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 05:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4qceqnx9+o8vceAKlej+q0xmQhZZKxeNLiQ8dDfT+PU=;
 b=JJm8APdkS76utDqFHSsdtCGplpFaqS2ZYpFzgR7kDXonKRjjPOKsNk5SC6hDO/jlLE
 lyOcELHLFLR+ZoJmVwNmyXQhkIPhbjZmzhwgl1qkgLnkIKiLE55FkYhqImHES4mp8MfG
 6XdpVybLDIuud7vPA4RcKGiPiH6JBQPZWJmqVz6/zAlbfGr5H7MEQfFDxjGn5VP3Bca3
 YrUtZi8Y/+vrjpIbBVjag6e89byT9gfl91IyiQNeVuZAboDn+Lmd1STF7u1rcUPo3O2y
 8SPgjfsoT6yek0POUnLdcVxAAS8s4pGSWzzFtmgjMBKQREBD56Z6x/q1WU8gFuN8je2Z
 E4Qg==
X-Gm-Message-State: AOAM531kAolPPNkDVjsxhtqhj5rjAfrdQJpXkNZXNFTKm4gmEzDRYbD6
 GxHdBQSVcxbqqYTSFevcYDYBcA06oM32/2mNuhGFtfTpVr45b5ym8ftFO+dsiTRHMMaPYcmwM5F
 ZieqBP/qJbQ97PS0=
X-Received: by 2002:a05:600c:410e:: with SMTP id
 j14mr17240463wmi.15.1603112108373; 
 Mon, 19 Oct 2020 05:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMoh25JpCoWbIYenzWbukEChz9zxm1ZXbhdfg0z+ULvaPx1nTqHJuULbEMoQ8nW6D/y/YOlA==
X-Received: by 2002:a05:600c:410e:: with SMTP id
 j14mr17240441wmi.15.1603112108128; 
 Mon, 19 Oct 2020 05:55:08 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id j9sm18474554wrp.59.2020.10.19.05.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 05:55:07 -0700 (PDT)
Subject: Re: io: Don't use '#' flag of printf format
To: AlexChen <alex.chen@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <5F8D8292.5030302@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <12f75124-7234-9a03-e089-5dc573790042@redhat.com>
Date: Mon, 19 Oct 2020 14:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5F8D8292.5030302@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
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
Cc: zhengchuan@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 2:12 PM, AlexChen wrote:
> Signed-off-by: AlexChen <alex.chen@huawei.com>
> ---
>   io/channel-websock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index 47a0e941d9..e94a1fcf99 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -746,7 +746,7 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
>               opcode != QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE &&
>               opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PING &&
>               opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PONG) {
> -            error_setg(errp, "unsupported opcode: %#04x; only binary, close, "
> +            error_setg(errp, "unsupported opcode: 0x%04x; only binary, close, "
>                          "ping, and pong websocket frames are supported", opcode);
>               qio_channel_websock_write_close(
>                   ioc, QIO_CHANNEL_WEBSOCK_STATUS_INVALID_DATA ,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


