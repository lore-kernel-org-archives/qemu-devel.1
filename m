Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ECDC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04DC2100A
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umu+bkX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04DC2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJem0-00059S-O9
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 11:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJelR-0004b9-KI
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJelP-0002b7-Lv
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600529218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jb+tUWECdJh1+GTTUYVQtihtN2OTKBKDhiwssIKHfUI=;
 b=Umu+bkX4PnsEtl1BP7Q8xQIbENuOQeWTNEb5/H/pm0NgPzT6EXoBkWzBl4TKDYX1JPlCDO
 B/+CZw+8ZSSvzbJAwEQK47IlFgl3AvkUq5iEJoc6RGsbDD2e43NI+L13nmTn/OpM84l0rE
 zghz+w+Cztpmtb3u8RVsl7Vojx5XdF4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-WkZbDli8N6uwd9BO6L4cBA-1; Sat, 19 Sep 2020 11:26:54 -0400
X-MC-Unique: WkZbDli8N6uwd9BO6L4cBA-1
Received: by mail-wr1-f72.google.com with SMTP id r16so3541141wrm.18
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 08:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jb+tUWECdJh1+GTTUYVQtihtN2OTKBKDhiwssIKHfUI=;
 b=ks/HeLizMC4FL0S+YXaayQ9WfVn/PJ9xRwlthq46uQHqgcV/jHcAbzyQsbmBGm3sJa
 OJIImAUK8C2XIj4klh902hNqB/bBbv7wCkBSXQhCjegN0/f6uvAfMaAKH4cwgB7ZKQit
 hC8j2PoLG1zwBi/kApgq8FIHVjcupHqf3QYOGDEkuiZyXbeOpvACyfmVeKjISqd42ePH
 C0A2yP7ZceYvA3fbz8TadgyTDE8xAfl2DkgbFs93GyGztH0+FExrKae5SQvZ9xsT9/VE
 hc4HTzhBY/tQUaZOqCWhdDjpe6VOwusZO8EvgMn62jHeWT9Bge9+5j/uFnFW2GW3BFYs
 K0hg==
X-Gm-Message-State: AOAM533ZLQPFG3Z+eVjxsZa/g/LJX3JapPY+uforhaCUdKC/VLU6XCTG
 k7mBJcwK0hgRygOp6HnkTkCOAd41vP4bvpI4KMtqOfYsvOUxZ5kgauyLq2k+TEqdw5rlmEjnAd6
 DFOmPqiklhwXQrI8=
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr19978216wmj.112.1600529213205; 
 Sat, 19 Sep 2020 08:26:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWwsvDOcik7LdKnZUv1CZMuDlIUZzGOIoe+o0NQ2DoyYtnBM5pRgbYxknIlqq5dLhwYKkBmA==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr19978203wmj.112.1600529212959; 
 Sat, 19 Sep 2020 08:26:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b20a:b600:521c:512d?
 ([2001:b07:6468:f312:b20a:b600:521c:512d])
 by smtp.gmail.com with ESMTPSA id o4sm11413702wrv.86.2020.09.19.08.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 08:26:52 -0700 (PDT)
Subject: Re: [PATCH 0/6] Convert pc-bios Makefiles to meson
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200918204759.225810-1-marcandre.lureau@redhat.com>
 <0e14e115-797d-b91b-dec5-7a2a26836d92@redhat.com>
 <CAJ+F1C+NDS=M+JDbAyU9itvHkBKvjCS3gtn2P1T2nvYbnn+8JA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02cb4105-8729-3b5b-fa45-b465d4324095@redhat.com>
Date: Sat, 19 Sep 2020 17:26:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+NDS=M+JDbAyU9itvHkBKvjCS3gtn2P1T2nvYbnn+8JA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Qemu-s390x list <qemu-s390x@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/20 17:15, Marc-André Lureau wrote:
> 
> 
>     I don't know, the way pc-bios/ works seems just wrong to me.  pc-bios
>     should IMO be its own build system with support for docker-based cross
>     compilers similar to tests/tcg.
> 
> 
> It could still use meson to build the binaries though (like we did for
> qboot). It's more about setting up the environment for the build to
> compile for the target.

Yes, essentially it would set up the cross file.  However, to some
extent whether or not Meson is used would be of relative importance.

Step 1 would probably be to find a place for the common docker
infrastructure, moving the common parts of tests/docker and tests/tcg to
scripts/docker and de-Make-izing them.

Paolo


