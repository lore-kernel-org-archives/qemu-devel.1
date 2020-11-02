Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB77C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0D12225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCperk9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0D12225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeyy-0008Iq-Jx
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZex5-0006w6-33
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:53:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZex1-0002Y6-Dj
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604343185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kyuk33HKrKufWRnvVKaCrARIFaVanppwxBO2zcQmIHE=;
 b=hCperk9FcuTz3a0kO2GHtfPHjKKh06FgQDFOwLT11MwbO+XdTJn1BI45bDQsAWblwG81Ip
 lFvyrKTerbKnIlJCT3w1eVqLz5/J/tbM8HDdb84U3mbuT8MNQ4oNfYj5QAJdm+yAnidDFN
 tI0OERw8IfQ3ic0yePS1BdHU8coDfN8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456--cpnOZVFPHyFo6bwIF46hw-1; Mon, 02 Nov 2020 13:53:02 -0500
X-MC-Unique: -cpnOZVFPHyFo6bwIF46hw-1
Received: by mail-ed1-f72.google.com with SMTP id c2so1148129edw.21
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kyuk33HKrKufWRnvVKaCrARIFaVanppwxBO2zcQmIHE=;
 b=EiC5fFQGw/jy0Qc9LdTb9G/B7Ckqqn3X0c178IF9H6EQ7zm+4lmgBaKWyapi4xFSYk
 wD4zCJylaYtFzpEvqX/oddOodkpZ72aUcQMGvqXPJS8T8uITlH4fyGEdTsa57IrfRdUt
 gaj56zKYg3zszhSj0v49o36vSh9AXhN67kPZEaB6YrNxCdiTUXBLoDbc9hTO9XDqBUrI
 eTKi+tJl8BiPqwOegaQXs8K1HL0SfUWzPqiWDD6/9iIaaZAYcKoKqsjzW6/JJsqzX6y0
 qYjqJxHXp/AC9Btw7xVC/S1s5x5isfKro3DAQYiMaTlMShf43KdisPPQdk0Tgrg8Eax1
 F5hQ==
X-Gm-Message-State: AOAM533qWxr0EEMZLgVEhB5hzCcT0aAMwjVI6qmdWc+gtcUOmQDUTSR0
 hk0aot858550+uLukKveaRZSUaTqYrRR15u4z8GeWPObDiat9BPxN8tIuZ5fq0cPF8X5fNUGBbV
 A+C3LKy3x1YusfjU=
X-Received: by 2002:a17:907:1102:: with SMTP id
 qu2mr16702730ejb.300.1604343180912; 
 Mon, 02 Nov 2020 10:53:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWJ/uqR2OKFXK9ElCg9/yKD2C6E3xvYSg41fvBdzoyAZ5hU62Z13DnQTCKfal6yuvFAM47Nw==
X-Received: by 2002:a17:907:1102:: with SMTP id
 qu2mr16702719ejb.300.1604343180733; 
 Mon, 02 Nov 2020 10:53:00 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g18sm9905282eje.12.2020.11.02.10.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 10:53:00 -0800 (PST)
Subject: Re: [PATCH-for-5.2] hw/virtio/vhost-vdpa: Fix Coverity CID 1432864
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201028154004.776760-1-philmd@redhat.com>
 <CAFEAcA_URCc2LjdrR8GbK-uu+isTVPH39qSce4yWqNV39RkbWg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff6f31c1-c3f3-f2b1-aaad-843c317c903f@redhat.com>
Date: Mon, 2 Nov 2020 19:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_URCc2LjdrR8GbK-uu+isTVPH39qSce4yWqNV39RkbWg@mail.gmail.com>
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 6:31 PM, Peter Maydell wrote:
> On Wed, 28 Oct 2020 at 15:45, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Fix uninitialized value issues reported by Coverity:
>>
>>   Field 'msg.reserved' is uninitialized when calling write().
>>
>> Fixes: a5bd05800f8 ("vhost-vdpa: batch updating IOTLB mappings")
>> Reported-by: Coverity (CID 1432864: UNINIT)
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Hi Philippe; thanks for this patch. I don't suppose you
> could also write a patch that fixes the same problem in
> vhost_kernel_send_device_iotlb_msg() (CID 1432871) ?

Oh I hadn't noticed it, sure, no problem!


