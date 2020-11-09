Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFECC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4E420674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H072VuzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4E420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc86A-0002z9-Fr
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc808-0004CA-6t
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:18:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc806-0005Pe-Fr
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604931509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DrIfufRSDmeR48LvWf2e4Ep0BL0HRv1Z+8owN/mXZqM=;
 b=H072VuzPWEZCQK4q1X9ktJ3ElrehahWPsHMLakF4oDmFmu1I1xclWU2tUC9V5rL9/pkMLb
 rTNeEZT0/N+1YRSbrdEUGy6pJvJUDG54hiq8+49N2YB2uphWmF6Pmh0JgNud1gmr+sZEpv
 uIbxak/QErS5pfpkS5OXlMIV5UAGPdE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-949z_TukO6K0XxEijJAZTQ-1; Mon, 09 Nov 2020 09:18:27 -0500
X-MC-Unique: 949z_TukO6K0XxEijJAZTQ-1
Received: by mail-wm1-f69.google.com with SMTP id 3so2024892wms.9
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DrIfufRSDmeR48LvWf2e4Ep0BL0HRv1Z+8owN/mXZqM=;
 b=dcS7jKAvhe8pFDgsKFEdAhj2fbGgDhFd76YQw1WGMPwU+X3+2zO1xpFPqamiVazDQ7
 iWUzQhTqGiQrb4twPLIXIxyq25Us22lu4Rs4aocxYlkBt7ey6aIGOYDQRjv2pajzPhsZ
 XzNiKRBCWS+vvdA8BogHHKCNAxbd6M/Ftga4jRKOzDCnca1XIHBeNcPdimZWnm/i2QmX
 xLays656lOK0qGt1Gsa6bLxnmPvFD9xAv8LW85JZIcQpRpUe0OQzNWo1W2qT6R/Ss9M5
 8WM8q3XHSMO+HW/OgDquR+DvHW45CzMEXgln4B1xMWNasAGNIxwpGptC9YKucLzD7evb
 wRZw==
X-Gm-Message-State: AOAM533T22xM/1ONfQMuJCEmrgr1dxn9Ne0KKMIMjiyA6yYhsGK/JGMz
 DfdAa8c8KMpjzoQTw3BkgorX1v2K4p5pITXwT7GMBX3a1nDNNhG2gmndzTM2C5OoUc+a23V/3ro
 f7yJ3rbPLAc5cFDA=
X-Received: by 2002:a5d:6550:: with SMTP id z16mr17904779wrv.266.1604931505986; 
 Mon, 09 Nov 2020 06:18:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvqXyel2inDp1qyzz1spYUGM1gsiqiF/eZo3xeTQMvWNrIa5SRtN037k/eR7yzYe0Es/hhkA==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr17904767wrv.266.1604931505859; 
 Mon, 09 Nov 2020 06:18:25 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x18sm14594880wrg.4.2020.11.09.06.18.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:18:25 -0800 (PST)
Subject: Re: [PATCH] physmem: improve ram size error messages
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org
References: <20201022111302.8105-1-pankaj.gupta.linux@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f6740858-3e35-f0fb-787f-6f6c1510f4be@redhat.com>
Date: Mon, 9 Nov 2020 15:18:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022111302.8105-1-pankaj.gupta.linux@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: pbonzini@redhat.com, pankaj.gupta@cloud.ionos.com,
 Li Zhang <li.zhang@cloud.ionos.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 1:13 PM, Pankaj Gupta wrote:
>  Ram size mismatch condition logs below message. 
> 
>    "Length mismatch: pc.ram: 0x80000000 in != 0x180000000: Invalid argument"
> 
>  This patch improves the readability of error messages. 
>  Removed the superflous "in" and changed "Length" to "Size".
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Reported-by: Li Zhang <li.zhang@cloud.ionos.com>
> ---
>  softmmu/physmem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


