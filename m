Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE29C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5675251E3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaJGpLoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5675251E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvmi-0003ei-63
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvl4-0001wF-3G
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:31:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvl2-0002rV-25
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593444703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWB+WzN7FPVMUr/ErnrDPYrYsgkM8JiZrAbY2nx3DiE=;
 b=WaJGpLoKb1O108RpESk8ZbEdZLbpLO2Hyb01IaeubPOTd1NhcD+ieasjmPx5VQZnen1DNI
 zs0wgwIplwYp6i7Rs2bBbPhmfl89/gWY5AWtPb1AOf0ucydrlg+xIQ1HQs7lZCEb1qUTR6
 Z9Kj09JNxZ9YwQKVAtbjHu0x99rfuZ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-byOzSyInMHijD4ub_F3wOw-1; Mon, 29 Jun 2020 11:31:41 -0400
X-MC-Unique: byOzSyInMHijD4ub_F3wOw-1
Received: by mail-wr1-f71.google.com with SMTP id f5so16594572wrv.22
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gWB+WzN7FPVMUr/ErnrDPYrYsgkM8JiZrAbY2nx3DiE=;
 b=U5DKZKNHD/rAT+WpZ2TYiikJ+VJeEbFA6xN+tj/CkMqzAVUt3xKdFTFS0HEmoHNjEe
 wG38azmSLPjt0l1PV6cVwdRZhH5rT5+h6w1s7mDZUZb/Pz7aX1vDWccoQWs0fY3ygBF9
 z0GdT5FSLVUxMM74p9xJTc64HPGfroSMuNODfcF0XZKPF4KumyXqaKFhFwtM+LqaS281
 gj6qzgK6txGwWDfS8ltWdRIM/i6FzGNkRBmB8eY15JMVY1u3eHPMdAxq+W/jnFjYecoa
 9ZxajkhLKViqRqUzTPa8e0wiwRhBfD17x1ot37ewWleNnppGGOsVHeAD0n0UQbhBLhf5
 lLZQ==
X-Gm-Message-State: AOAM533+Stfh0igqehVinx6Y6u3W6nkY6wZDQgpagHMy6GS/DRdnQUfw
 PuJrFnjBHlVpNdeuQy4uXWrA/KXpiBMt/7lTYZM03G6FiRHULW0pbjTCCySvi1LIvtUZVyQImTr
 91kmlEqVSbEgvVOc=
X-Received: by 2002:adf:a491:: with SMTP id g17mr18526198wrb.132.1593444700438; 
 Mon, 29 Jun 2020 08:31:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtdkS4yh3fA9vf0AcZ/YRjRlCAjRfesR2XneMRwMlUgG5O1meUbpEMoabLiEE96F6pKhrcCQ==
X-Received: by 2002:adf:a491:: with SMTP id g17mr18526175wrb.132.1593444700253; 
 Mon, 29 Jun 2020 08:31:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id l18sm63639wrt.59.2020.06.29.08.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 08:31:39 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] nvram: add nrf51_soc flash read method
To: Li Qiang <liq3ea@gmail.com>, P J P <ppandit@redhat.com>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-6-ppandit@redhat.com>
 <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d190ab9f-fa80-bc3d-450f-80d05e6a1231@redhat.com>
Date: Mon, 29 Jun 2020 17:31:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 13:17, Li Qiang wrote:
> The 'flash_ops' is for ROM, though I don't see where it calls
> 'memory_region_rom_device_set_romd'
> to ROMD, so this MR is in MMIO mode and it needs a read callback.
> 
> However as the origin code doesn't provide a read callback. So why
> here we return something?
> 
> I prefer here just 'qemu_log_mask(LOG_UNIMP, "%s not implemented\n",
> __func__);' as other
> patches does.

Even abort() would do (with a comment).

Paolo


