Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668ECC2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314B52072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGOEv1LO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314B52072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLpIg-0003nd-CI
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLpFt-0000lY-ED
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLpFs-0001fd-7V
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:31:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLpFs-0001fO-3i
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586269867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uddvtKct4m3HROTxekVZMeJkAMH7ZlM1yUwuoZX7PK4=;
 b=NGOEv1LOk4KyeaZzJhcmnjaeyvPwjZTiwpHUKr+2epZoy6CuQd4IqDCVOR7Pfbffa7Itn7
 GHe491n5/aGzohPNUL7EWWM6uHXOJYkZYIFhPHzdb4nlHtv+WCw7wJaxHeax2gJVVCGptb
 50SSWwt+oKUs3eEQrAP4+QUMk8yJ5TE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-XiwZPBgHNdyONdRHNdLCjw-1; Tue, 07 Apr 2020 10:31:05 -0400
X-MC-Unique: XiwZPBgHNdyONdRHNdLCjw-1
Received: by mail-wm1-f71.google.com with SMTP id f9so937019wme.7
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 07:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uddvtKct4m3HROTxekVZMeJkAMH7ZlM1yUwuoZX7PK4=;
 b=HuapSxqjUT05GLWRz3a9qaZEUR64HLq+9f7AHvOfdQbnBNpNaKwvuWK5xhkZHjYeiH
 roDpvyQoGWas6KBlNAENZnIUvHH/d8VFK60FROOm/FBkkhpVkRX5uSdRY29JR8hj4SaU
 dVOEL8uCLnnGHRX79Ij2fRZRsA8L0JTFe0Nl0u+iMVoOsmLefT1Rf4kfcz4OHZFzbJOZ
 KXAaqUiHZym23amFexXA4EnzfLy6m8N7zy8Kx1alcE2C0AqKLfV+xqSy0rz0vIZHRsU0
 l5Qcj4fYXt6zFwpIFnsGj+4RJdZGszjMh8vP1ay7F90nuUiGAX35/S7sJKAHJ1q0LnfC
 O2Sg==
X-Gm-Message-State: AGi0PuYm8HoHa4urwG8hd73bAPi8LxuXKxYKdKf3DUrw31Gq7GpUmwB8
 T2zuG03lXXQFeU3sIlJkXQxMF3JkXZk52DkdTZyZmzZAR5zZDBf9zVypPWHtHmFgu8Q+owhnisf
 RRIfiFB0lySDKK3Q=
X-Received: by 2002:adf:a448:: with SMTP id e8mr2903517wra.238.1586269864264; 
 Tue, 07 Apr 2020 07:31:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypJRVmJnPRITFpnjlyFs3eWSGGBtnAU0JxJw+CTjtPjZsbFs1GCdQb7NXI941Nd/aYEuiUhCpA==
X-Received: by 2002:adf:a448:: with SMTP id e8mr2903492wra.238.1586269864005; 
 Tue, 07 Apr 2020 07:31:04 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id a15sm2558878wme.17.2020.04.07.07.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 07:31:03 -0700 (PDT)
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Joao Martins <joao.m.martins@oracle.com>, Jingqi Liu <jingqi.liu@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b15709c2-bea7-2717-6833-ac4616b88660@redhat.com>
Date: Tue, 7 Apr 2020 16:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Dan Williams <dan.j.williams@intel.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/04/20 12:59, Joao Martins wrote:
> Perhaps, you meant instead:
> 
> 	/sys/dev/char/%d:%d/align
> 
>  ?
> 

So it works with that change?

Paolo


