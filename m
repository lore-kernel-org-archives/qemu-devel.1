Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4369AC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 00:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22C920637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 00:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSJaBm2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22C920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie6tO-0007af-6m
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 19:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1ie6rl-0006cq-S5
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 19:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1ie6rk-0006qp-SL
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 19:25:33 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1ie6rk-0006on-MD
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 19:25:32 -0500
Received: by mail-pg1-x544.google.com with SMTP id q127so6211642pga.4
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 16:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=54pMROPZSZfXX7jRTCLEYndLEfmz7nGR8IgouL3KZTc=;
 b=BSJaBm2ePbXg4/8QJEoez2M+93ZFU9CFwMm/wY/y3fH5J2FICxXg8f4R5L+w9xefYo
 PTGQ5sPuVVu1AV7xJKYeCg6mPH6PVz6KvEF8AbZ9eS+0NQxwvSeZoSJ0gsdnjh5e3mZd
 4OV2ibZ7dlTjDdmWZs9VKt9th1QoncUz5eCiV15AFzTuuUzDIycxQz83ZjnnSyOHTLvG
 gNhSKdu3VCuezUFhphqXSBBClXUtu5jz8Eox0dKJp7rCb00Jjm9tpLfrC1ESWJfUKiB3
 fcljUfI7jtssvTxptrRqIjOtU4i3FJLBvy518UbNZPY3iY5ZWRC+AEUvH9qqTosHGlXb
 ywvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=54pMROPZSZfXX7jRTCLEYndLEfmz7nGR8IgouL3KZTc=;
 b=VeL89uLcqM0Hclm+wUM/bqLKjt8MCzILiwteuB9ZxMDJDAiY5xri9GU+qVQ7nnQLeq
 4aOy2njebQxAwg1q7wpTVMzbnkPdrHqXiDvYB8HuQWUqsteMpuclUvwAhsdkq2JmdvNX
 nOtTBL6CJ/0H6kgz3Gj+ntiBUUvd/M9KFm3sZlMdy0KhsqwlMuQM/9VT0TLN951PyyTB
 hQD0uYU3zPRqbC4/FoWLcXnXg+m6J+30fF3COeQ+bXcxeeFYYQplZbwDXFGG+ke7CI6v
 zOgMosxrEOdfdSN/rbBFeQA7888eiecOVjGanBDkkhRQo9Z2PNrpysd5AXf4rXX8rQqN
 UQtQ==
X-Gm-Message-State: APjAAAVJ/qCkSR/XkMSL6Pch8G1wTLNXdeRLr51I/+WVrVSPlIAr9YN5
 elf2wXfCYnlX9RV2bk/kM94=
X-Google-Smtp-Source: APXvYqyLOx/NbgYchmoB1mb0Ueb/tUuLtaKFry8cwej7RBw1g78+6E329FnE4TSyZJDGD6IMKOF7vQ==
X-Received: by 2002:a62:6381:: with SMTP id x123mr26519913pfb.75.1575851131060; 
 Sun, 08 Dec 2019 16:25:31 -0800 (PST)
Received: from [172.20.20.156] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id o3sm9802750pju.13.2019.12.08.16.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2019 16:25:30 -0800 (PST)
Subject: Re: [RFC net-next 07/18] tun: set offloaded xdp program
To: Jason Wang <jasowang@redhat.com>, David Ahern <dsahern@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <jakub.kicinski@netronome.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126100744.5083-8-prashantbhole.linux@gmail.com>
 <3ff23a11-c979-32ed-b55d-9213c2c64bc4@gmail.com>
 <8d575940-ba31-8780-ae4d-6edbe1b2b15a@redhat.com>
From: Prashant Bhole <prashantbhole.linux@gmail.com>
Message-ID: <ba0c0d5f-fbb4-ff92-c7d8-403dbb757758@gmail.com>
Date: Mon, 9 Dec 2019 09:24:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8d575940-ba31-8780-ae4d-6edbe1b2b15a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/2/19 11:47 AM, Jason Wang wrote:
> 
> On 2019/12/2 上午12:45, David Ahern wrote:
>> On 11/26/19 4:07 AM, Prashant Bhole wrote:
>>> From: Jason Wang <jasowang@redhat.com>
>>>
>>> This patch introduces an ioctl way to set an offloaded XDP program
>>> to tun driver. This ioctl will be used by qemu to offload XDP program
>>> from virtio_net in the guest.
>>>
>> Seems like you need to set / reset the SOCK_XDP flag on tfile->sk since
>> this is an XDP program.
>>
>> Also, why not add this program using netlink instead of ioctl? e.g., as
>> part of a generic XDP in the egress path like I am looking into for the
>> host side.
> 
> 
> Maybe both, otherwise, qemu may need netlink as a dependency.
> 
> Thanks
> 

Thank you all for reviewing. We will continue to improve this set.

If we split this work, Tx path XDP is one of the necessary part
which can be developed first. As suggested by David Ahern it will be
a netlink way but we will still need ioctl way for tap. I will try
to come up with Tx path XDP set next time.

Thanks.

