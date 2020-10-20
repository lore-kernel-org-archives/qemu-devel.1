Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375CFC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E31222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzOmAsy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E31222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmwf-0002Sg-DI
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUmsY-0006DM-Dw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUmsW-0003vq-77
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603182018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TB1qmgxP2KsOVlx2oX6hMEOR6+nbCU24Mmakth29III=;
 b=ZzOmAsy3aT86xgULy033JENAJkX3klFLr8G0SV0qwbxBqkZ30W4UPoBvs1PHZ9MJdQLiXo
 5Ik0DnQ6W4G/LjYVstsrvzxAyrALaQlPMNjQMTSgJiQLLxHlWQ/KDM7DjzC0oqG4qsKBLL
 WSqJwmDjcyUV6cnIIS11CimqvbExteo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-vd6UffLxNlau7j10I4dfUg-1; Tue, 20 Oct 2020 04:20:16 -0400
X-MC-Unique: vd6UffLxNlau7j10I4dfUg-1
Received: by mail-wm1-f71.google.com with SMTP id u207so178719wmu.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 01:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TB1qmgxP2KsOVlx2oX6hMEOR6+nbCU24Mmakth29III=;
 b=FPglAdquEkBqTVJWsDAG1wO4stn8OWqWb2syIR41APLCum3D2Lwcgt28GYjzfAE19j
 MS21eN1LUSLrfo75lSlSn0sXATmAQcVHgYmKkmWqNAzWCNOMgttIN2uaKsDmGco4VDEV
 6IrJwnyXRuCPU0jg5Wi9j2GqPXXL0d9b6An2tGBThW3ELpcBZHL7G7kIV4z3hfnKC2uC
 QtKj5e5fXggfFy5j417+JffG9m+F09+sIpv+56+1l/JkwTtQcnqwMGJzuWM2LJPYWUZw
 Q77dCtrNrkZDCJg+oQpYLNcJUJb3+OYQhfa7gX8JcYm8xUZJPNfjpYv0bWXsBBBcF5gu
 VBNg==
X-Gm-Message-State: AOAM532pbBm5qho9IWa1dcmg7EUZw6XCft2ZnxkfnBDABdESyhPXvpv3
 8z99nNj4RRUCqRXP+JXPsyi80ttEX1vV0dCBJn5ucfybyihz2t/YnvfQuW8aMvw0liIinTHk4Xc
 PyJk0oNw1U2fkUxQ=
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr1966980wrg.335.1603182015236; 
 Tue, 20 Oct 2020 01:20:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMG46NKKs1TfFkDgTCbdVRpMF1CYP0shvwwNqpSXfqHuUkfJVIHnQW1DrTDwPauuBqqXijbg==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr1966955wrg.335.1603182015006; 
 Tue, 20 Oct 2020 01:20:15 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y7sm1495099wmg.40.2020.10.20.01.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 01:20:14 -0700 (PDT)
Subject: Re: [PATCH] net: remove an assert call in eth_get_gso_type
To: P J P <ppandit@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20201020081119.1578251-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <819064ca-8fd2-ebd0-be88-9c5aae111bfb@redhat.com>
Date: Tue, 20 Oct 2020 10:20:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020081119.1578251-1-ppandit@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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
Cc: Gaoning Pan <pgn@zju.edu.cn>, QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 10:11 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> eth_get_gso_type() routine returns segmentation offload type to use
> based on L3 protocol type. It calls g_assert_not_reached if L3
> protocol is unknown, making the following return statement unreachable.
> Remove the g_assert call, as it maybe triggered by a guest user.
> 
> Reported-by: Gaoning Pan <pgn@zju.edu.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   net/eth.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/net/eth.c b/net/eth.c
> index 0c1d413ee2..f36a418077 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -72,9 +72,6 @@ eth_get_gso_type(uint16_t l3_proto, uint8_t *l3_hdr, uint8_t l4proto)
>           }
>       }
>   
> -    /* Unsupported offload */
> -    g_assert_not_reached();

Maybe LOG_UNIMP with useful fields, so when user send bug
report we directly know what has to be implemented.

> -
>       return VIRTIO_NET_HDR_GSO_NONE | ecn_state;
>   }
>   
> 


