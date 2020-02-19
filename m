Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB5DC3404D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8B62067D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjbT14ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8B62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4NJ7-0000Az-Nc
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 06:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4NIY-0008D1-7k
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4NIX-0002xn-A4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:13:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45799
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4NIX-0002xX-6E
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582110824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weR0/ZsuL4TlGeVZmbkhffYf+Eg/J+PCFj/gEsOTr78=;
 b=IjbT14epHOclrxVWr4QZqWIu5saSecHfPpowwItBEPl+YJwqo9YQnV050mn8AZW6/klhVf
 /wJpqcyd9YVgNDxYlHlH3IyIRVX1MJEEmw4q4uimmJ8jawsUjRRE4ja3/joBgIEU0/Y8F9
 2UfvjNou6FgXlWGg1qnF1lKy4KzzwTU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-x1ODAeGBPluCGcd-wL8J-A-1; Wed, 19 Feb 2020 06:13:43 -0500
Received: by mail-wr1-f72.google.com with SMTP id m15so12323289wrs.22
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 03:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=weR0/ZsuL4TlGeVZmbkhffYf+Eg/J+PCFj/gEsOTr78=;
 b=Fd3qnOMdg13wgTF80Ff6nFtsDP8ia/Xjz7ES1MhlL8SMabMuwxK1YZ66vKKXsrsSLZ
 /k7paa3RspX6AHy0I2asNTcbPdSNsQ0kqv1PV9zy8YorTEE+cmy2tAiLzXCIEGNVTi4l
 oF/pCp8f7fuUcNcSOPojdSZHGIRQXIxuVhEfRXBoMcadJokf6ue/Vxv0PS2nh9Pa3Alu
 1lb7XG4vg3/n4X/wM4oZWYcmzEqQ+47okjQpwiHcN8aqrMnI5Op+Rbbnex/XsMplA4H0
 gUiCVCEzXSnAaLPxTQ0rIxhbjpMHj/rWONGjSqUBzqmsoFzrw4X8pv68lYrXrMPOZLVT
 TBVA==
X-Gm-Message-State: APjAAAWCZp/teVF3++ktcwJu8fbTqfWK9bBs62V8T2AmcGhIV1UCZ9r/
 LaYFiVWI8CYO4T//+ZFNIzNe1giH7eDoLt0+fO8lnhfwyneLje+1es4+SkO8hYo754pq1sjxJl/
 x4TUprqKnuE1zJfc=
X-Received: by 2002:a7b:c851:: with SMTP id c17mr9252737wml.71.1582110821939; 
 Wed, 19 Feb 2020 03:13:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxO2lpsDcoVycMwOAnMdNBQtplV79Jlx0Vzhj5MmsNn4jZu1mTmagRhg/7ZMc0Nb9GkW5COcA==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr9252698wml.71.1582110821668; 
 Wed, 19 Feb 2020 03:13:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51?
 ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
 by smtp.gmail.com with ESMTPSA id 5sm2566913wrc.75.2020.02.19.03.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 03:13:41 -0800 (PST)
Subject: Re: [PATCH 5/5] aio-posix: make AioHandler dispatch O(1) with epoll
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-6-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38c8e61b-377b-07bd-f55b-a1a773b72701@redhat.com>
Date: Wed, 19 Feb 2020 12:13:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200214171712.541358-6-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: x1ODAeGBPluCGcd-wL8J-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/02/20 18:17, Stefan Hajnoczi wrote:
> +    while ((node = QLIST_FIRST(ready_list))) {
> +        QLIST_SAFE_REMOVE(node, node_ready);

Why does this need safe remove?

Paolo

> +        progress = aio_dispatch_handler(ctx, node) || progress;
> +    }


