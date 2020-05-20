Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A23AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 22:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AE220873
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 22:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N65UBNIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AE220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbXWb-0000kV-Cm
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 18:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbXVu-0007wv-4K
 for qemu-devel@nongnu.org; Wed, 20 May 2020 18:48:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbXVs-0005To-Hl
 for qemu-devel@nongnu.org; Wed, 20 May 2020 18:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590014915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjK0wYllS4ibvWJ5TsfjWgCHi6FwX71A6Z8Mc6ItnMQ=;
 b=N65UBNIOmIRKDZQc25cRkVwcWSRTj2ACJ6Uj2ad9YpPytYLmFiC0d/Sj9CtN9tibJvJKkl
 m24+Lg/OHjvmT4HPzmJY7wNW6ZYUMTF+ba79Uprv6EAYP/pAYbSdpwOx+4/N07mBk6Ki6w
 Zc5J0OT2xAQrrsFOWZKNTLzcAnurx/g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-Manu0w7-MPW8mJTdT_Dg0A-1; Wed, 20 May 2020 18:48:33 -0400
X-MC-Unique: Manu0w7-MPW8mJTdT_Dg0A-1
Received: by mail-ed1-f70.google.com with SMTP id w15so1331337edi.11
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 15:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tjK0wYllS4ibvWJ5TsfjWgCHi6FwX71A6Z8Mc6ItnMQ=;
 b=grWP/9BtOF9ibuSO575R0JKFAk4uL/BqBC4uJLJjjYA9cID5n5NHtp987Y65Gn1RWI
 CbWy0GQsUoZdevCXUvbZbHHw85tEw7MI80zQBFKzAl22dB80EbFQYAF2nr0wTPU6g8uI
 kvkOp8FBjyt9Wb9wDQ+xUolbrsab8fjf+4xhTyBTGtoS/Gf37fVq/SzIt4ZW6WEZMbqe
 2ycZ0PxqXWVP9cn0AfDfryz4FLkXwqz8ewyxLabYLX4oQ6gFo5yb2vIibjjZkiJD8TuC
 myk+WAjlCAk9h1njzaK32MepkIaJVNwHNR/OWHbGrBtXvP9J55XGvmjnOd/0FRYWteUE
 1bsQ==
X-Gm-Message-State: AOAM530AzATdcA7WQZzCjYQ5UIpa3bOjf03H/MSAHVjGVvncWzm81m9D
 4lk03IjbCsG1xG7TsMcvuGhaO14gFeJiP1LnKbNWzMXrApxIsWLcohQ6jJTLoHMXt6shWbzLcv6
 LpiY+gsXmRr6SR4s=
X-Received: by 2002:aa7:d399:: with SMTP id x25mr5320967edq.164.1590014912674; 
 Wed, 20 May 2020 15:48:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4F+b0269uBJCZFdMupffPpAAb0/zMB/eLM+MV4zn9HvHZq3j08uBWgRkuoPOLKHGvqxB5ow==
X-Received: by 2002:aa7:d399:: with SMTP id x25mr5320940edq.164.1590014912357; 
 Wed, 20 May 2020 15:48:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1c48:1dd8:fe63:e3da?
 ([2001:b07:6468:f312:1c48:1dd8:fe63:e3da])
 by smtp.gmail.com with ESMTPSA id s18sm3004906edi.45.2020.05.20.15.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 15:48:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] Introduce yank feature
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1590008051.git.lukasstraub2@web.de>
 <20005a15c708fbda983f9be602c55fc0b1979a18.1590008051.git.lukasstraub2@web.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4585d13a-edad-94a8-1c3b-0a0599c930ad@redhat.com>
Date: Thu, 21 May 2020 00:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20005a15c708fbda983f9be602c55fc0b1979a18.1590008051.git.lukasstraub2@web.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 17:39:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/20 23:05, Lukas Straub wrote:
> +
> +void yank_init(void)
> +{
> +    qemu_mutex_init(&lock);
> +}

You can use __constructor__ for this to avoid the call in vl.c.  See
job.c for an example.

Thanks,

Paolo


