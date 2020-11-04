Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6249C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8F2206DC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtFn8QWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8F2206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRyG-0003KD-W6
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 18:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRxS-0002ck-16
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:12:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRxO-000268-Dp
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604531563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wzp/JQwuWCsLiTg1vw/vn3h0w5HqZ/TGc2ldv9QPD3I=;
 b=JtFn8QWhKMyI3GwhKt0rtM0QGoa8PDWtPhfA9a0x5mregZMuUnaJASFWTZdVXVFD/5taU5
 hCvw1kd5sSU87fTnV3xln+tkanRVOopVD9DRsHi2BzGBUY32bQZppEY/t/hdSmDd2sh1lT
 8EO1pGOHasDdu7jlftTn+6JpG9u+6Ds=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-9VK_E6MGNNSUnG3thC2Qhw-1; Wed, 04 Nov 2020 18:12:42 -0500
X-MC-Unique: 9VK_E6MGNNSUnG3thC2Qhw-1
Received: by mail-lf1-f70.google.com with SMTP id 205so91729lfb.17
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 15:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wzp/JQwuWCsLiTg1vw/vn3h0w5HqZ/TGc2ldv9QPD3I=;
 b=C1TIgBuc/qiBwhnUnnCJ4aqa/8Lxw/COoweaPHPR6ixJAto1xPv/eYpdo89xnJh7gw
 xw9opR/ncrRvJZxisSX2htS54Q1YNAvuJOP8YzwnuA9CsEWLd4IOiI0LFyOQ3sGt1aU5
 8weXl0foB3prSuurIP7k/i8I7L0YswWqWgAVwy7oOZrQAp+Xz7oWsGS7RguSJW5qc2Kz
 ydPZjVfc39GzPdo8d8e2SkacyBONaH2bP2Cl+sZePNOU8aoTSfKe7Qe+U/jnFXL8weP+
 FwePaNxSEggfD7KmOntaIFAhJ/wFgIppxxtB3sGySOFmdcc5BM17QJwdxZPPB9qV3W67
 jGUQ==
X-Gm-Message-State: AOAM530jGF1k/fU7SeA9re/cJd5xHXR11dY2QhxWiBGdae3m872yMIBK
 SfDoOa0OWaqiPAbSquhUrUfAjBEfvRa7CznusCKsPvvofOcbBEmO8LMWvu85KakFLEXDoVZlXMi
 ABIvbqkdNu3S1VWk=
X-Received: by 2002:adf:ef02:: with SMTP id e2mr293506wro.381.1604531559954;
 Wed, 04 Nov 2020 15:12:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuaPImparodBUUgVBw/hn0HnXSYtcFm2/uZl3BiJqIMhgqiPz9GBKED65XV69qi4r0+5e/Lw==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr293487wro.381.1604531559780;
 Wed, 04 Nov 2020 15:12:39 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e6sm4749508wrs.7.2020.11.04.15.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 15:12:39 -0800 (PST)
Subject: Re: [Bug 1879672] Re: QEMU installer with WHPX support
To: Mike Battista <Mike.Battista@microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, John Snow <jsnow@redhat.com>
References: <158996968484.21371.12685815665992748631.malonedeb@wampee.canonical.com>
 <160452011092.12514.8206218482979551684.malone@gac.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e3b4bf14-c460-5777-df0d-89f90aa5e3e3@redhat.com>
Date: Thu, 5 Nov 2020 00:12:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160452011092.12514.8206218482979551684.malone@gac.canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Stefan Weil <sw@weilnetz.de>, Bug 1879672 <1879672@bugs.launchpad.net>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi John,

On 11/4/20 9:01 PM, John Snow wrote:
> Removing 'Opinion' and moving back to 'New'; as 'Opinion' is essentially
> the same as "WONTFIX" but allows discussion to continue. I believe you
> want a Feature Request tag instead.
> 
> If there is still work for us to do, let's move this to
> Confirmed/Triaged and add the feature request tag.

It seems Launchpad didn't Cc'ed the interested parties.

Our contact is Mike Battista (see [*]) but so far he never
made any comment regarding this issue.

Cc'ing Sunil who is the active developer (of WHPX in QEMU)
at Microsoft, and Stefan, who does the Open Source packaging.

Regards,

Phil.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg731227.html


