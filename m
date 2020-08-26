Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1006AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCCF2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXSuTXHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCCF2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxnk-0004pG-5U
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxmw-0004LC-O8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxmv-0002Lq-0R
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598457395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RuDjHXkEZQl+t/LaeifAxTZaSn8tmAlK+kuNk4wR0VE=;
 b=QXSuTXHXbvK95uCPRtCJna4y7VSoiR7DQfdU/w8ftKlmyiKDs55iy0V/kOJ98YPoEXogVg
 0/riqZnvxiBUHx8aezu5nejR8oUSdjBTQNXv6zIFqWkBpwSXN7AqVzMG44Dkh71rCulUv2
 g40+HeRgbrM1geeOkmgxjPF3pBOz4wI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-Bqm2cdZhMjGr9L_4pME86A-1; Wed, 26 Aug 2020 11:56:31 -0400
X-MC-Unique: Bqm2cdZhMjGr9L_4pME86A-1
Received: by mail-ed1-f71.google.com with SMTP id v11so843330edr.13
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RuDjHXkEZQl+t/LaeifAxTZaSn8tmAlK+kuNk4wR0VE=;
 b=gjr2NLYS7LnrWEW7W8DPobYC6r013qHS4jKEENPn4dYRpttEkc4AquX2IK9FIyqBAl
 /NF6dmJeRwO09wHnpsqer4hYVrBEY1bGyFwpGnJkWSm5CjKc2pkB6NMyIn4j732vvLL8
 FZTBYhLZCZEMqZZpcQcJZZVFGM4lPEJSMABHatNkIx+bSYT5I+wSf5GA5wOoUUPojqHP
 Pf/T/Yh4UUq9tdpv6HwWLcNLf1G0ycV+F6JI4IJsACtWKgXMFE4O6bMJwM59XriUBPZo
 Ee4/lYxbr/EtzfN5tRzMErl7sQtuAsq5jHrAf8+L1fktKN3yu9PKo9vY4MZyyG+LMCzx
 5MOA==
X-Gm-Message-State: AOAM530e9sYVHbrGQrrkkUbRJ/QifSHSKLS5CaGNsP6C2PA+S6iMVag/
 Cm2+KDHvtMc1EsUODfr0xdZlI8O1wGWGpVk3naLPtVol1SoNuq0PsYdclipj0gRNX/Qgo1Wwwob
 QxYIGbcP/MPs2/JxMGiBY4H8xEFrZgkE=
X-Received: by 2002:a17:906:d9db:: with SMTP id
 qk27mr15467968ejb.230.1598457389752; 
 Wed, 26 Aug 2020 08:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweyJuV+hEf54z4TIzaOw8UGHkvM1lrliVfgsOypbPM8gSBB9YctG8y8alskZDnsTI/BWAQF2Cm4XHJKgzOIKM=
X-Received: by 2002:a17:906:d9db:: with SMTP id
 qk27mr15467953ejb.230.1598457389574; 
 Wed, 26 Aug 2020 08:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
 <CAE2XoE-JKpqQj7H3wMt0+WNTBR1JS6ZyiLOhqOYkaVj5Zzgp5A@mail.gmail.com>
 <CABgObfYk8zG3TBB3UZhvmZLGqLO+bZF+AmL6hSQkCgiCKKW4ug@mail.gmail.com>
 <CAE2XoE-U6Ls9gMSSDB4Qajn-m0vrBBP-+C0K4tncvzzr3Nwq9w@mail.gmail.com>
 <CABgObfaByaW9jqRZkV3BGONmqFaYwnQDREemYit8s+qYTAeP4g@mail.gmail.com>
 <CAE2XoE8LDYbGkJXQBorg9=R632PNtZ_onawrm=jsJQ_+gAA1rA@mail.gmail.com>
In-Reply-To: <CAE2XoE8LDYbGkJXQBorg9=R632PNtZ_onawrm=jsJQ_+gAA1rA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 17:56:18 +0200
Message-ID: <CABgObfbFJx5uzTPmthJSkUEwRryZgLNTeYdetgBEUtztRa0oiA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes that would be great. We are tracking all CI "holes" that we didn't
catch before committing the Meson transition, and MSYS is certainly
one of them.

You can send a patch and it will be reviewed and included.

Thanks,

Paolo

On Wed, Aug 26, 2020 at 5:48 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com> wrote:
>
> How about enabling github actions to enable MSYS2 builds in CI.
> So we won't break msys2 silently.


