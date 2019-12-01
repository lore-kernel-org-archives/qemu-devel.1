Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06A3C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 16:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8619820718
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3B9CJAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8619820718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibSMr-0004LG-N4
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 11:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dsahern@gmail.com>) id 1ibSM2-0003k8-9P
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dsahern@gmail.com>) id 1ibSM1-00071D-BG
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:45:50 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:44320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dsahern@gmail.com>) id 1ibSM1-00070G-5y
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:45:49 -0500
Received: by mail-il1-x142.google.com with SMTP id z12so21637192iln.11
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5PiLHcJSPrRzekdCH8FxUdbB33YPjM+w/haI6Mc/7K0=;
 b=H3B9CJAMvF39dG9jba2KaW6vAmuzrXQ3PXh+V4jw2su6sfjsnh7aze0miemyZwB0AJ
 gdfW6awNfgrnRExN4kIwJ7J+A8F2JieY8l3ccgURz5K+/K6Pl/brPyqmbbzhDZ7KUc51
 VVJ5XZCTS2Fq+F8bzv9mcOrFiao9K5ubJVXEDelrYhCWfu5VUp5rbQgAQIDBJ4Anc41D
 wxo1+s13Wa2V7sIN4oeWncBPLqhyMIoQnx1r8fqjvvqOwnkAEfBbovQZhVzLZarDe/Xp
 pkg4JuvdXs6zkvmLaV9kAq6wN6yAUsYaLrWj5EnGDXQsAnl8BQKKUBRbhkG+lMEGCqe5
 WAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5PiLHcJSPrRzekdCH8FxUdbB33YPjM+w/haI6Mc/7K0=;
 b=PFq5419ZnDD7wa49t5OHyOdT2NZOKiPEXR+1IN/siB7ZFVFE/RjSngW5XGauq5fB8u
 DYpkeKIWjtlxuKetqrBsUAi/6PM3MVi7+HXFA9K3yq+ykKiC2TyWcPdtwbMNmltX8pcO
 cTcN2IEZ4GPToz1yho9SA0XMmGkBBZy9sAjUakDDlxbkCoU+Lb6LhBd6ENPVDvt2UbIZ
 wmFZMPDOrfgQWTIDP/XjlsWkveRvA76XiMEb19u/NsWEmZyo27DMzs6rx+2fbzVtqG44
 SEAqLWQKPALDMvIUQBIykYgIeDjycegfIxFHiEk0BYkU9Fqe2zk7cx2X7qrZMqI2d1ka
 MS+g==
X-Gm-Message-State: APjAAAUQ8PqdgbWYtOWMsKVHRYMZjHfd1Zb1QU9MuxESyTrCR3yVdjC3
 9R15yGLxENibJ6UuTaPKIig=
X-Google-Smtp-Source: APXvYqzJ++V1IzVJ3BpcLuNfGspGbhWYTRszgvqw22CsV9Df5CjZ8uXk7CNjwTVdTrxJdHggwnzy+Q==
X-Received: by 2002:a92:3a88:: with SMTP id i8mr63854697ilf.254.1575218748467; 
 Sun, 01 Dec 2019 08:45:48 -0800 (PST)
Received: from dahern-DO-MB.local ([2601:282:800:fd80:fd6b:fde:b20f:61ed])
 by smtp.googlemail.com with ESMTPSA id s8sm5116156ilq.14.2019.12.01.08.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 08:45:47 -0800 (PST)
Subject: Re: [RFC net-next 07/18] tun: set offloaded xdp program
To: Prashant Bhole <prashantbhole.linux@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126100744.5083-8-prashantbhole.linux@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <3ff23a11-c979-32ed-b55d-9213c2c64bc4@gmail.com>
Date: Sun, 1 Dec 2019 09:45:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126100744.5083-8-prashantbhole.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/26/19 4:07 AM, Prashant Bhole wrote:
> From: Jason Wang <jasowang@redhat.com>
> 
> This patch introduces an ioctl way to set an offloaded XDP program
> to tun driver. This ioctl will be used by qemu to offload XDP program
> from virtio_net in the guest.
> 

Seems like you need to set / reset the SOCK_XDP flag on tfile->sk since
this is an XDP program.

Also, why not add this program using netlink instead of ioctl? e.g., as
part of a generic XDP in the egress path like I am looking into for the
host side.

