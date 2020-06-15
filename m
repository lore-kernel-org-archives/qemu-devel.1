Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8192BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1E620707
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2eqv9Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1E620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjKN-00015l-AG
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jkjJZ-0000Ts-SR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:13:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40193
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jkjJY-0002a9-HA
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592205232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcE1sJcTgxf9JcZw+/HYUXG5c649gABbFGq3WamqEQY=;
 b=U2eqv9Dxt/KDP1KP4ywxEwSU8Z/NVsY3V7Kal/egcTp2ZWtQo0QWiDJggnFTlfj3coyg/S
 1Z/zdNGW59Mu8bqNLofrtGPoZPWxMgQyW52LcXKFGMjr5zKb+ddAoNnEH0bBP0aDhP9h8g
 qbqxK7ySqBSz6r28IdEJWsMa01gr9VM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-hiaTONJ4PPKF1mt8osTYIQ-1; Mon, 15 Jun 2020 03:13:45 -0400
X-MC-Unique: hiaTONJ4PPKF1mt8osTYIQ-1
Received: by mail-wr1-f72.google.com with SMTP id a4so6654620wrp.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 00:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bcE1sJcTgxf9JcZw+/HYUXG5c649gABbFGq3WamqEQY=;
 b=tbaa+NHv4v0uCJB2mhLTgDhSJEZCm7Y7IzbMZ5u231wfT2Nzxu+nUeQbS0jwrkUO6R
 sWMRLc6l1Qe1fI4aXU9x50zWXfEnEwBxpeKraT1ph4kiZeksYVByKpOTv5DsiQs51aSw
 RSQrrpmmUp7Ux0Wz+Ib8x8IjHp2C9jj81yUftVh55Ame3bBR8EasJ42J/eYLM5f4MtGe
 RUNMPfzX+a9whdy4cCE9vFa3Yj0//j4q3pllWtic85kwcx+Jnx0qQRgRus/zNFR4bRJP
 y5tvXj8XvX1p2XiMmsPDfDLoI4/9Bdo5g/VMjX1J2r92K/mXej7oonkQ6tMDvi7YCXAv
 2clg==
X-Gm-Message-State: AOAM531HrU+lrDFY24n0epgvVdQx/OY9epNzLMicfqG2Qyb2sI2rxrM6
 U7wBFsY3lQ7fzrkqZkRi18C/0SKDF7y3b7kANxtl75CsxR02JUZ/AQ6o20eZ3fsCaCFgM6p1RV9
 zFrTxhlPTFt1B5zo=
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr11530444wme.98.1592205224500; 
 Mon, 15 Jun 2020 00:13:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1BgpIeEbSqzCTvIAhQqiQo2Zpw/YuqSsjDVndF85x31itNXadmtv6fqOnF0LAAwXVK8S2kw==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr11530423wme.98.1592205224250; 
 Mon, 15 Jun 2020 00:13:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c461:afc9:1:2046?
 ([2001:b07:6468:f312:c461:afc9:1:2046])
 by smtp.gmail.com with ESMTPSA id k21sm24148236wrd.24.2020.06.15.00.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 00:13:43 -0700 (PDT)
Subject: Re: [PATCH v2] Makefile: Remove generated files when doing
 'distclean' (and 'clean')
To: Thomas Huth <thuth@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191008082815.8267-1-thuth@redhat.com>
 <CAL1e-=gYkhM99Ee0LxZJ5dCjeEdC08G4_Tm3WCZpCSWvJ=b26Q@mail.gmail.com>
 <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
 <CAFEAcA_+V7SNsxPSgsd04s8f7PnP3qdyXMp6NvS2inHjE08pJw@mail.gmail.com>
 <CAL1e-=ijjbTG19NHnsDrcJdb7kajBdcndMT8JXymqC6UViiitQ@mail.gmail.com>
 <770c89b9-44d1-0982-34ff-1830911ac413@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89c5b73f-2294-b58a-85e0-5ed64926fb0c@redhat.com>
Date: Mon, 15 Jun 2020 09:13:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <770c89b9-44d1-0982-34ff-1830911ac413@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/20 07:17, Thomas Huth wrote:
> That depends ... Marc-André, Paolo, what's the status of the meson patch
> series? Do you think it will be merged for the next release already? If
> so, it does not make much sense to respin my distclean patch. Otherwise
> I could do another iteration...

I prefer to aim for 5.2, making it the very first series merged there
and forcing everyone else to rebase.

Paolo


