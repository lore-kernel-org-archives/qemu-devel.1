Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F8C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 02:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CBF215A4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 02:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRH3uQm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CBF215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia9xl-0004ef-B7
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 21:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1ia9wz-0004F9-CK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 21:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1ia9wy-0006gT-4N
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 21:54:37 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1ia9wx-0006f5-UP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 21:54:36 -0500
Received: by mail-pj1-x1044.google.com with SMTP id v93so7914832pjb.6
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 18:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QVjDMSx5+CBlZfoasvUKpNpCEQRNUdLJKpLr0vW0iOg=;
 b=BRH3uQm1T+yc8VQ4P+eIBX1WdUJFLuB3ohcUxgwuFqzGYKDReyi0lshQsuePqD7ZGM
 09Wi7AhPzU9ZO8hfI62na4Plu6dO7+9B86PzDj1+3dCjEzZ3lo4uAgNTqKqMbaQ9Isvg
 TfWZwv5zQtAbHjms3qTgkj6w/4pHIKen9v3+rxQJc9/NBzBK/gZ043UEk60sF9IDbhhH
 Ih4CSwgX1m7oRIEjFE7c2aBQX3XgsWwvB/W7YLK0NQSBPH6wVvhy+zWKPW3P7lli1hDJ
 QrUI0X/BPqN/JkMp+gDl34rPQsz/NEkPCoAQFyPJ3cvJmL/ILTz1WjW9qva6cRJh8mHq
 bO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QVjDMSx5+CBlZfoasvUKpNpCEQRNUdLJKpLr0vW0iOg=;
 b=bHCu2rIh+i4y9Lb9eoofgC4xtzvPc3/E7SsEpFzDnBOrX7PiV9JplvECDsqfEN2BwF
 1RbxvsuRtnBPbagO7Oc/bDAg5FW1aMpHX238TXKCJ/xA784jrQ8+pwXCpOS5ayVKmfEG
 JlynkVrCiaEJ7Hbz9zWNMbL45PhribwFbRK0N39p8wOQ9n3Zk2mc/3YnawWQJCKE1nsJ
 4oxO0X+lPqEmfdqfg2d71oCr3IoBFqgXTBwQHy/XIHFs9JZ85uc6pW3vNE9SymnhDOCZ
 ajahQTbB76S3Sf/c2jH9CE/MDSHy4kINue6tl4eNdjUx9YzzcBqjFOZQ8uhR8bCd7s27
 oKkA==
X-Gm-Message-State: APjAAAXI3HeMPHn6wdOZs35fQutmUNwqIyxRi3GX/0LTG8fTz69jG8Ja
 hK0NlEBUEeRKPhVBtcZUOZs=
X-Google-Smtp-Source: APXvYqwM+rGj3t9fvCM8AlSg+hRLmzqTozOSfjXYhfAemzMrUo7KZkLxbiymcoSxUbgSSjErtrU+mw==
X-Received: by 2002:a17:902:be16:: with SMTP id
 r22mr7508188pls.2.1574909674528; 
 Wed, 27 Nov 2019 18:54:34 -0800 (PST)
Received: from [172.20.20.156] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id j23sm17761332pfe.95.2019.11.27.18.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 18:54:34 -0800 (PST)
Subject: Re: [RFC net-next 15/18] virtio_net: implement XDP prog offload
 functionality
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126100744.5083-16-prashantbhole.linux@gmail.com>
 <20191127153253-mutt-send-email-mst@kernel.org>
From: Prashant Bhole <prashantbhole.linux@gmail.com>
Message-ID: <73323055-3f8a-802d-87da-e8f61ef5cfb7@gmail.com>
Date: Thu, 28 Nov 2019 11:53:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191127153253-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
 Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org,
 netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/28/19 5:42 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 26, 2019 at 07:07:41PM +0900, Prashant Bhole wrote:
>> From: Jason Wang <jasowang@redhat.com>
>>
>> This patch implements bpf_prog_offload_ops callbacks and adds handling
>> for XDP_SETUP_PROG_HW. Handling of XDP_SETUP_PROG_HW involves setting
>> up struct virtio_net_ctrl_ebpf_prog and appending program instructions
>> to it. This control buffer is sent to Qemu with class
>> VIRTIO_NET_CTRL_EBPF and command VIRTIO_NET_BPF_CMD_SET_OFFLOAD.
>> The expected behavior from Qemu is that it should try to load the
>> program in host os and report the status.
> 
> That's not great e.g. for migration: different hosts might have
> a different idea about what's allowed.
> Device capabilities should be preferably exported through
> feature bits or config space such that it's easy to
> intercept and limit these as needed.

These things are mentioned in the TODO section of cover letter.
Having offload feature enabled should be a migration blocker.
A feature bit in virtio for offloading capability needs to be added.

> 
> Also, how are we going to handle e.g. endian-ness here?

For now I feel we should block offloading in case of cross endian
virtualization. Further to support cross endian-ness, the requests for 
offloading a map or program should include metadata such as BTF info.
Qemu needs to handle the conversion.

> 
>>
>> It also adds restriction to have either driver or offloaded program
>> at a time.
> 
> I'm not sure I understand what does the above say.
> virtnet_xdp_offload_check?
> Please add code comments so we remember what to do and when.
> 
>> This restriction can be removed later after proper testing.
> 
> What kind of testing is missing here?

This restriction mentioned above is about having multiple programs
attached to the same device. It can be possible to have a program
attached in driver mode and other in offload mode, but in current code
only one mode at a time is supported because I wasn't aware whether
bpf tooling supports the case. I will add a comment or remove the
restriction in the next revision.

> 
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> Co-developed-by: Prashant Bhole <prashantbhole.linux@gmail.com>
>> Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
> 
> Any UAPI changes need to be copied to virtio-dev@lists.oasis-open.org
> (subscriber only) list please.

Sure.

Thanks.

