Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D494C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A292173E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP2x9npc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A292173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDdx-0005Fd-G7
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQDdL-0004kT-O7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQDdI-0003PF-9e
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602093222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mv5O2sMeMIcrCezyZXQjkcGEbEEqvRQap9zqGS+jtJE=;
 b=CP2x9npc5M2Yh2LwxO0nBIxomBQWUBIgTF9xI2DrHGinxqfuvA7exr6FTwqsB1+rAZdjkH
 ZIaA24E2EJmDg49RfFjmtczp6m8iQKOq1N6U0bWaHH/E3N5AqGPjTlPbGxTrnDoqMdp0aM
 udr+4CwkvA7jpk5L4M+RPjCT6xzKua0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-yCAcYhfFPTupv1rYDVnO9g-1; Wed, 07 Oct 2020 13:53:41 -0400
X-MC-Unique: yCAcYhfFPTupv1rYDVnO9g-1
Received: by mail-wm1-f71.google.com with SMTP id g125so1259974wme.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 10:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mv5O2sMeMIcrCezyZXQjkcGEbEEqvRQap9zqGS+jtJE=;
 b=uKxsPu/U2NyqjrOkSi8RktS2gon92XchliqXt77kJhtH/s/Dldd2IToSOIbx4QdE8D
 CDaQjjc5DjKPCNakF6108ZNhTzYCyajj9TdRkmWtIkzJEiWDSaTpYZkM3lQ6sVH5Hv9J
 J045Pa6ex7PLNdw0lS8USkcagZ/BkvD9W1sypRieyXQ7kF2ERr1d84V1yTIH7MkjgHP3
 l108Qxk8QeNVPd/gziEXyGf4d2fxc4r2K3cPu/nMNBfrE9B196cu2GvZLt91zXKXmb5G
 X0Y/yGgYk7BvLRwJiio8drW28cPLnJeFBa4hvWMcoKsP44qfvJ8b0ascOQDR83LHqECs
 DScA==
X-Gm-Message-State: AOAM532okH/qRLbWrkJyNnw6zy1YLPbgR7jXLrbVdSyoym2Ht36OvkB5
 IEugM/h9x80n/d8pNZDokxkq0uqfSfY8ELYnzc78DYSnN1wxjh1hXPnBThw2RCvmlSNyArP2Gpy
 nVCloLyRNtakUTew=
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr5053591wrx.164.1602093219768; 
 Wed, 07 Oct 2020 10:53:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbFHSAOAmxnsaXgCJ9dRpJ5OdJnITKxlp4pFU7kfwtIpnLV8RmSnuOjT5y48f3+hVLcDxQjQ==
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr5053575wrx.164.1602093219546; 
 Wed, 07 Oct 2020 10:53:39 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w5sm3734488wmg.42.2020.10.07.10.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 10:53:38 -0700 (PDT)
Subject: Re: [PATCH v1 03/22] hw/ide: restore replay support of IDE
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201007160038.26953-1-alex.bennee@linaro.org>
 <20201007160038.26953-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <74de465a-7ec8-3fe1-bb81-d6900ba09939@redhat.com>
Date: Wed, 7 Oct 2020 19:53:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007160038.26953-4-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, John Snow <jsnow@redhat.com>,
 "open list:IDE" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 6:00 PM, Alex Bennée wrote:
> A recent change to weak reset handling broke replay due to the use of
> aio_bh_schedule_oneshot instead of the replay aware
> replay_bh_schedule_oneshot_event.
> 
> Fixes: 55adb3c456 ("ide: cancel pending callbacks on SRST")
> Suggested-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  hw/ide/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 0e32abd779..693b352d5e 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2289,8 +2289,8 @@ void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val)
>              s = &bus->ifs[i];
>              s->status |= BUSY_STAT;
>          }
> -        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> -                                ide_bus_perform_srst, bus);
> +        replay_bh_schedule_oneshot_event(qemu_get_aio_context(),
> +                                         ide_bus_perform_srst, bus);

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      }
>  
>      bus->cmd = val;
> 


