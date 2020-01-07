Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A403CC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3033420678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftCZjPzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3033420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolxT-0000AW-3X
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iolsl-000274-SS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iolsk-0007sp-MY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:14:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iolsk-0007sc-JT
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578392078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrQ+gMo4zbJaq4NpNdTnusPx/z0A5WLMSHm5zLXuAUs=;
 b=ftCZjPzLXMSkRar5yQD7+XmB0zXFr4mCj8aYPTZjL9oGz6bZKNybXulFyhGtXR+s02NdXt
 MF3KZfnjga8p3/fMaBDG18cuPEENU70IuoiMMMJsZuGRogxvsj+lR3M8kgLJ6G4tfBNr7Q
 4zpJmkzMJ3Io0Cf3YnpseHCSwbdcIzk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-w7KZHwXmOW2W_TcJBx6IWQ-1; Tue, 07 Jan 2020 05:14:35 -0500
Received: by mail-wm1-f69.google.com with SMTP id h130so3904900wme.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rrQ+gMo4zbJaq4NpNdTnusPx/z0A5WLMSHm5zLXuAUs=;
 b=bsq8vFhAe2Q/OuDsnLYTIGXNuYohTuHCEq6OxtDDJFjky35SbmNglF8clPqIAE1itw
 oMjmqxNv8uNo2hkxSubxgf4znoDymfHqq6ALkJCO17l8W0akRnwuOLIDGR6KrI/L7rR6
 KpKxTpNWPfafsfJ5Iz0FRBYZ2rntE4U+ovvqxf/DUxgCf/7ldvMa/jJxw6lyfmvrkEap
 WRiVeP9Sa/bbuO+yw4Y9GQqDl13kifWz+253qsHC4lnY1O2MTJ/fuiVXfltdrrVNu946
 w2TNh5MnFkpHZ6XburA3uIWgLzGklH1mBkiPlm1X+zcn1zZojgZsj1kevmcgZYWbFjTG
 ja7w==
X-Gm-Message-State: APjAAAX1QITdC7lWCqTjuFY7xhFuhLAuwmXH7ju1gCT+cd9ccxHWLWfF
 A7aRo82J7iMDjU578JqPR/FOeZ8By/aVzbh9bNXwE9gCXhAwDuY9w2+9Wz+c/16ZilBcVQaD7ki
 t4M8tJA2bJpx0iqQ=
X-Received: by 2002:a5d:6151:: with SMTP id y17mr57987518wrt.110.1578392074184; 
 Tue, 07 Jan 2020 02:14:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzlaiRtwCEJ58zUK8aaZ7bShCA/KUKMaq5G5bQ1xpFxTm8R9i/lcV1KHg20mRuaFYfHooSaMQ==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr57987489wrt.110.1578392073974; 
 Tue, 07 Jan 2020 02:14:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id p5sm77111081wrt.79.2020.01.07.02.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:14:33 -0800 (PST)
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
Date: Tue, 7 Jan 2020 11:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
Content-Language: en-US
X-MC-Unique: w7KZHwXmOW2W_TcJBx6IWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/20 11:03, Thomas Huth wrote:
>>  
>>  vm = QEMUMachine(iotests.qemu_prog)
>> -vm.add_args('-machine', 'accel=kvm:tcg')
>> +vm.add_args('-accel', 'kvm', '-accel', 'tcg')
> Looking at this, I wonder whether we really want the "-accel" option to
> prioritize the accelerators in the order of appearance? A lot of other
> CLI tools give the highest priority to the last parameter instead, e.g.
> "gcc -O3 -O1" compiles with -O1, and not with -O3.
> 
> Also I think it might be quite common that there are shell scripts which
> call "qemu-system-xxx -accel xyz $*" ... and if we don't invert the
> priorities of -accel, it will be impossible to override -accel in that
> case...

Hmm, it does match "-machine accel=kvm:tcg" and in general I think it's
more self-explanatory.  However, it is indeed less friendly to scripts.
 On one hand those could be changed to place "-accel xyz" after $* (or
better "$@"), on the other hand we could also add a priority option to
"-accel".  What do you think?

Paolo


