Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC176C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EBD2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czJpgMQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EBD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7feM-00022U-N2
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7fdd-0001bd-6M
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7fdb-0000uf-1e
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597672641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzvgKtnZwE0jSyG7+ObBR6XdWBnX2EOQuwSfHX6V5jI=;
 b=czJpgMQC+aLmtU+I6hYqNJf53sFHJp/3kpKB/3Kx/ZUS+CY161M4AofUyYqSDBJhM70cRb
 OnpwZAF0pn4GdyYCgonmff5yhsWVHNFyXEBgjvAkWtJbxFE/v4P+pJe0HLrJdaAN/cxcBl
 tlFRsadvXt5n45D9RvD2/CqjyeJRcGQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-mMSJxlvQMmuo14fDa-Y4TA-1; Mon, 17 Aug 2020 09:57:19 -0400
X-MC-Unique: mMSJxlvQMmuo14fDa-Y4TA-1
Received: by mail-wm1-f72.google.com with SMTP id z10so6047418wmi.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 06:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HzvgKtnZwE0jSyG7+ObBR6XdWBnX2EOQuwSfHX6V5jI=;
 b=XpufYcsteh6ouZ0P65yRLGomOePXG5W8lIwsB2escbU4n1T9EFnaF686xYLDGkOexR
 KmAvKtQR+VrI3MoMKfH2FZliHV99uQzGf+hE6+YIVoqVd3zfyr2EeuRc4q3iN43fkqlF
 SrcBP/1zHurSpSAYLDkYqqQV7wqckbpYdjvrrO9CVRB8mUv1/4hD/ngI3wWahFqv5aJd
 gRVx6QDXGOEz/cns+cE+MIJYFuEkuqLDgmkhvjeYhCMQf07TETrSifBQqxzymF1sFlRM
 dMqSR1B789Mf1pF8QCQ45B7hdES0LZZqyXk/utVtqoO28H5uO+0pN8FmOkkDorfgO75y
 nefA==
X-Gm-Message-State: AOAM53295kQPy2C4dh1Qo0ZQspJW5K8AVveUAgyqRP57asBbCP/AzAxC
 O2qvbJMnAh1TC89YZVrhi62TtOlc5c9+kQuZslAUkgOwrdh1lb9dazM63bPCu1QlbtFwU9gAzP0
 ZmlLmNETPdgXFbsA=
X-Received: by 2002:a05:6000:12c1:: with SMTP id
 l1mr14839064wrx.270.1597672638196; 
 Mon, 17 Aug 2020 06:57:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRX8itsX18njR8k8oL0o24RH4YpBZ2WyfLFKh8oC/LN3CwLlXFT5S/f84utVzSF0XDNOP6EQ==
X-Received: by 2002:a05:6000:12c1:: with SMTP id
 l1mr14839050wrx.270.1597672637946; 
 Mon, 17 Aug 2020 06:57:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977?
 ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id k15sm30813922wrp.43.2020.08.17.06.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 06:57:17 -0700 (PDT)
Subject: Re: [PATCH v2 000/150] Meson integration for 5.2
To: Cornelia Huck <cohuck@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
 <20200817142617.0ab2b9f3.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b77c48c-108f-c603-33cf-f8d0f6b1b2b5@redhat.com>
Date: Mon, 17 Aug 2020 15:57:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200817142617.0ab2b9f3.cohuck@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/08/20 14:26, Cornelia Huck wrote:
> 
> The bad news: The build on the s390x system with Fedora 30 (yes, I
> know) seems to be lacking various devices. The output of
> 'qemu-system-s390x -device ?' misses all of the
> -transitional/-non-transitional varieties for virtio-pci devices, as
> well as some of the vhost-user devices, and, rather bizarrely, the
> gen15* and some of the z14 cpu models (this is on a z12, so it's not
> that all 'newer' models are missing, and I don't think the system we
> build on should influence the generation of models, even with an older
> compiler). I checked the output from 'qemu-system-x86_64 -device ?',
> and it is missing the -transitional/-non-transitional virtio-pci
> devices as well (did not check if anything else is missing as well).

Whoa, that's weird.  I'll take a look, thanks.

Paolo

> The builds on the F31 (x86) and F32 (s390x, with -Werror disabled)
> systems are fine.


