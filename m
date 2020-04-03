Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840D8C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F08206E9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlHSNGPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F08206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKMk5-0002ti-F7
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 09:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jKMjT-0002TO-LH
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jKMjS-0006VU-KT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:51:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29509
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jKMjS-0006Ud-Go
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585921897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FufJO7H3iKFQdE3PX6xzrJD+35QATA+lfmcCp+V7Ng=;
 b=FlHSNGPXOPs92pG/ud49ibXTrTKAwUs2/71PstBTiZ4giw9fYtwccvCSQYHcz8Z/MrFWT5
 m7zM9P0Ut4avjx+ZniNE5VZRnz+TVX/ffO8diohDW27ZfBuE5+Or7G0IiNRYdhfSjNx6tb
 y99BpSAVc5pUcvCzQxmqemtYX+5jzbI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Bgk5dqpfOMyWygGqwaZfSg-1; Fri, 03 Apr 2020 09:51:33 -0400
X-MC-Unique: Bgk5dqpfOMyWygGqwaZfSg-1
Received: by mail-wm1-f69.google.com with SMTP id v8so2793306wml.8
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6FufJO7H3iKFQdE3PX6xzrJD+35QATA+lfmcCp+V7Ng=;
 b=saSqxGCGJM36dPvIFZuMBof9DUL1gd6zLvPPSy6Dwu9R7kIypgeyOVpvFKFijF7LFB
 WlMW3Urx2PqFTf7keW8uooEa23DWCXKLcE9e7QCIePxnvHaih35ZRol6aqbm+LYNqt3a
 7GPIp5gYcijUKVmoygJwDNcdKT7CtLJ6IApUHTuRZ7Q7votAfV7C39sR83R1uIgSrVeh
 H4JxE3fby5QT6Qc2zesyhfCEDa2P5Ee0S9fwGuzBftpdjCEiEqwcGWBG3xWoj7yZ+Z7X
 5f5zbiNJSjtGzO9nP1NZgm5gmSQzKVi1tXLucn5siiPCTgpUZM3cyMK9r4PFnCxRgxjl
 B1og==
X-Gm-Message-State: AGi0PuaYlsTmLyp2sMDln3mnxiiqRoYYGE/hg5xIHvA6yiCUZQVN8cxh
 dLf22q7b/oxqsfmy4rxAAWjE+tUJtkIBLxixKR3m89Ad6g6MU4c0FkWSJimr0QNFTI0HhDo7c+F
 OSSKTzVxrXJ5UcVY=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr8646121wmh.72.1585921892107; 
 Fri, 03 Apr 2020 06:51:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypIzzeO2UdA4rTkMctd+t6/DM4wVPIt70u9WT5cNXhPpt13cBHsbVR7/pxBxn+B7kju+ryy3Nw==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr8646106wmh.72.1585921891877; 
 Fri, 03 Apr 2020 06:51:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e440:194e:3aea:d661?
 ([2001:b07:6468:f312:e440:194e:3aea:d661])
 by smtp.gmail.com with ESMTPSA id 61sm12869470wrn.82.2020.04.03.06.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 06:51:31 -0700 (PDT)
Subject: Re: Question about scsi device hotplug (e.g scsi-hd)
To: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <7302c0b9f2327b9b61b4adb465f166e339e46ac1.camel@redhat.com>
 <20200401150944.GA4500@stefanha-x1.localdomain>
 <4bc42bf2-939f-f6c4-ea45-0d08eb42fc2b@redhat.com>
 <ffa77fc719232b8dc0e6e78bd3781fd77c5adcf8.camel@redhat.com>
 <20200403124145.GC146016@stefanha-x1.localdomain>
 <87a73s4r92.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d62678b-dbf8-62d8-4b73-5f50b8ff75db@redhat.com>
Date: Fri, 3 Apr 2020 15:51:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87a73s4r92.fsf@dusky.pond.sub.org>
Content-Language: en-US
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
Cc: qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/04/20 15:45, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
> 
> [...]
>> It would be nice to have a general solution in qdev core that makes
>> thread-safe hotplug easy for all devices.
> Excuse my ignorance / confusion...
> 
> The "realize" concept exists to enable
> 
>     create device
>     configure / wire up step by step without impact on the guest
>     realize, device becomes "real" atomically
> 
> How and why does this break down with threads?

After more discussions with Maxim, it's a bug in the SCSI layer.  It
looks for devices without checking that they have been realized.

Paolo


