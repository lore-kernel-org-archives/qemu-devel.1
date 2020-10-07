Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EB0C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FC72076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxxT8DaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FC72076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4iV-0005bo-QF
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ4f6-00027v-Mo
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ4f4-00082X-Hn
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602058736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vk+UbotGnWkQH7iWaY0/ec/+yIu08MozIyBU1LrOP2M=;
 b=dxxT8DaCy595TNQ9rIbECUlyOW1eVYZOtpd683WAHgCeNx2Es28BgWzlyUq7rbItxE1Mgd
 NHMQSt7eWFY+BppV5x4FSDBJsYdvihqDdZt299TZzGnHTH06HpRCIlyXil61M6CyHQ1EAv
 Go9eeFHYlsQ/XQiM2hQKm3Jb0xTBSLs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-kFluVlUFMWKhjz3I0UwLBQ-1; Wed, 07 Oct 2020 04:18:52 -0400
X-MC-Unique: kFluVlUFMWKhjz3I0UwLBQ-1
Received: by mail-wm1-f71.google.com with SMTP id 13so259603wmf.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 01:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vk+UbotGnWkQH7iWaY0/ec/+yIu08MozIyBU1LrOP2M=;
 b=qF+F8STK+UkxFJ6XNlL3cKX2qQehrVZIMYbSqVfWTxbMFJOqMa4YMIs3amymIbu5rv
 8t1yMRhNYss85tFXSCraM0OlkGNH5wJUiKdcKFhPYSQyqYyIQAugrmlrkz3BDgnI3M38
 I8QGL7cBFtrRn1gUGYp/Bad4bvv851Hqdifoh9WtFfo6bnydV1NeqZ+a0jyt/kQoJJkX
 HwYZHdCJZeHGttGmDKeTJ+OMcpxXjtYx2sCd5H5OuK3429uShadbJn2Fd3zWU3tBkGYz
 nMDnJlT898PuC8DkwxK7N26WTDQUX5oWlIofdHSgW/mimE/XRedk+24ZwtQfeuQ54/Ja
 3Evw==
X-Gm-Message-State: AOAM533hwIUZElrMcqeFy23Vuub2Gr+lANfdiU1j/aMTHRJa5otQlk+m
 CjED0MDUzjx7sKFr0bMzLR1tdeA6ve7XIBpStnWZgYftNJrjbFHPsS2K6c3EXU2MNmesie970Lj
 Hl+0/8nwpbwfor14=
X-Received: by 2002:adf:dd89:: with SMTP id x9mr2298255wrl.25.1602058730672;
 Wed, 07 Oct 2020 01:18:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAzm7GOjPLHXQtFYM1EpisscyAxwyCgpTUPj0oHAseRN6DVr5ieQ86b5BESbYM4c2cYfmvUg==
X-Received: by 2002:adf:dd89:: with SMTP id x9mr2298221wrl.25.1602058730297;
 Wed, 07 Oct 2020 01:18:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff?
 ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
 by smtp.gmail.com with ESMTPSA id b189sm1588827wmb.37.2020.10.07.01.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 01:18:49 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] cirrus: Fixing and speedup the msys2/mingw CI
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20201007035154.109-1-luoyonggang@gmail.com>
 <20201007035154.109-3-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b4528dc-918d-ebf4-db27-cbd67fa96c11@redhat.com>
Date: Wed, 7 Oct 2020 10:18:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007035154.109-3-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/20 05:51, Yonggang Luo wrote:
> Using a prepared https://github.com/lygstate/qemu/releases/download/v5.1.0/msys2-x86_64.tar.xz
> for speed up the msys2/mingw prepare speed on the cirrus CI.
> This file are generated by the msys2.docker

The speedup is nice, but we need to be able to regenerate the tarball
without access to a Windows machine.  Otherwise whoever adds a new
dependency cannot test it himself with CI.

Ideally, the tarball would be generated by the containers job in the
Gitlab CI, but I'm not sure if that's possible.

On top of this, whoever commits this needs to replace the URL with
something under download.qemu.org, but that's the easy part.

Paolo


