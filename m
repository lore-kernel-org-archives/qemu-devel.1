Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EBFC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 16:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DB62073C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 16:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djDDcmb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DB62073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibSVW-0007q1-BB
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 11:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dsahern@gmail.com>) id 1ibSUi-0007NW-CX
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dsahern@gmail.com>) id 1ibSUh-0003SR-DM
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:54:48 -0500
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:35864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dsahern@gmail.com>) id 1ibSUh-0003Rv-93
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:54:47 -0500
Received: by mail-io1-xd36.google.com with SMTP id l17so11355811ioj.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 08:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2rtYPKXu0wUef3OhDol+BP9kZOGI7cYX1kVkgWIxDkA=;
 b=djDDcmb07Y7ohpmWUHxZKhWxBBNA92ZcXK6LhlPIl0GLkibJY5GsSTHutNLFtsxdjU
 fcIaXrtuTJf+D2N2xK4a/duYUaR8hbcGCgsE8DjHomULTUQTgBlArPUkyHr94Dg78qiD
 CqDvk7XbEdlUBHFFBhGDDSgIfnbdyDGM42kFWiXVVn2F/3egkJycyyhv+k5QeeoM9yIL
 3gEYRX8/6hiN1+R0NCWxrCwDx118fYgBfSNyMvda+JdLSdnbNnbOGdADh6r+1VcCi/CF
 R7VwAiCl81M4/NU6D/XBHfAcayCNtTGYJsoNXOw7VitOEFUu3IU/lJVnXtFfa3uqJrcM
 UkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2rtYPKXu0wUef3OhDol+BP9kZOGI7cYX1kVkgWIxDkA=;
 b=tOtYUZsM4sLx5zmFd4YJ7kPKfF5sNKWMN8JfCPsswdADbW+0x8bpcir6FigrcqRSnH
 zlVAZ3ACziVynvlIlw3rrxIWkY8eViKErZejWyhymFTKbdFMgfv11BPbmxVK42jKfY6w
 GMJmjnmf4omnoh0AhhVChRHI7mIL/P/Qo8uFTmayztzcXiRO6BL3TYO0ZfCRnBQLB7f6
 0/PFDEYX0SjlV8O97B0AeNtHcBAWdIsBLSreUsduO7Gar+F/BDMjt0BSZ8dkcin4RebY
 zID6s5VWK3p1c1Fgi87veRJ+Zybz//s0nRQ4Ss55FdNNEkvlI+Z2PBk+cpr/1xzSU3U/
 LhGw==
X-Gm-Message-State: APjAAAX/5Hz5z7s6x0RsplzSwew7rzKQ3TRtZe/t8sHZD3jgStLO/sss
 4CLIKKNL6XtQRfBOfRt7wPU=
X-Google-Smtp-Source: APXvYqy1H3L0+0XKonVV1/vbmEUW8a220uqNNPbGk+oPe4TuLdAUDVUKK7r/sjoMDX1ZeQeq2PGW2Q==
X-Received: by 2002:a6b:8b44:: with SMTP id n65mr49370974iod.19.1575219286530; 
 Sun, 01 Dec 2019 08:54:46 -0800 (PST)
Received: from dahern-DO-MB.local ([2601:282:800:fd80:fd6b:fde:b20f:61ed])
 by smtp.googlemail.com with ESMTPSA id k199sm8870660ilk.20.2019.12.01.08.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 08:54:45 -0800 (PST)
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
To: Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126123514.3bdf6d6f@cakuba.netronome.com>
 <20191128033255.r66d4zedmhudeaa6@ast-mbp.dhcp.thefacebook.com>
 <c6c6ca98-8793-5510-ad24-583e25403e35@redhat.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <0aa6a69a-0bbe-e0fc-1e18-2114adb18c51@gmail.com>
Date: Sun, 1 Dec 2019 09:54:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c6c6ca98-8793-5510-ad24-583e25403e35@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d36
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
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 qemu-devel@nongnu.org, Alexei Starovoitov <ast@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 10:18 PM, Jason Wang wrote:
> We try to follow what NFP did by starting from a fraction of the whole
> eBPF features. It would be very hard to have all eBPF features
> implemented from the start.  It would be helpful to clarify what's the
> minimal set of features that you want to have from the start.

Offloading guest programs needs to prevent a guest XDP program from
running bpf helpers that access host kernel data. e.g., bpf_fib_lookup

