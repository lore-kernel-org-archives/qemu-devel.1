Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66389C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359562072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRhca+rG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359562072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSAJ-0006Ql-4o
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isS9I-0005a5-By
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isS9H-0004eI-FW
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:58:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isS9H-0004dt-BY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579269534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l18SNX+nE9Vm2Eui15pFKarn3ipS0jHpsdjrlI840bY=;
 b=ZRhca+rGXPv7r10iz7NKahOiI5PJXY+jF+Am5LaqnNxgKV1rY5Xa9YDTdgSqB/IKA8aV0c
 V+1Hs7CV+5a2G3vFldaln4zmdgtC72T6XOqfiDOGNXfpRf8HKW4bjeWTrI2eW1GpNq/X1K
 RqBlSPuR+M2OmyGMilcOrJcWZ1Zdgtc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-u0q8OQGsPa--rlUg9numFw-1; Fri, 17 Jan 2020 08:58:53 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so10486317wrm.23
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l18SNX+nE9Vm2Eui15pFKarn3ipS0jHpsdjrlI840bY=;
 b=rA3nK+vfv2q0jMJRZb7IBoI+QkuilV+1q9US7mTbNlRRzqGSlgIpUubpIQYoOExjrc
 wMQD6mjKeuTcbbYxh4y44LW0Zpnyj2+Y8S+ffrLyhSmauXGQ2uLqE5Xzs1vDEvg3ozxa
 NAzcYggmFO0mPrWM2DbTpApZjftdClw86S8vfV2xIch3j7w3Nvh/aKnhdUiEbAuIS4V0
 T/SsWPJhVMNKiPC89106jsWVEoxVGw9+ZSBs4A/vkbbFmhT2IZij2KevNS11Bu+k6ysU
 ER0IZt4EFADC6za79PyB6twzE1N1TqbBT0koTFbO1a+r2cV/UPzUFSDF8txHMk7qqiWQ
 SDnA==
X-Gm-Message-State: APjAAAWSIXy2+8pLt151tmj6P5g94feV7N0h0rFY7KQlBILrdWVV7W3p
 HFpaOO3rZVB/yhqjN6oRqVZri1ExqOW4e79vLASzHYuuvp+2Zxn8XLs0qXpDsT2/3hUjF07J6dU
 QA1CFSnMB9VD8wy0=
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr3171133wru.173.1579269532475; 
 Fri, 17 Jan 2020 05:58:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4W2I3UvDoceg12So9Un3E7ZM7Ft71pVk7GEe/y1OvP9UDE+uGka/KSdQsixmK0S005LaAUQ==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr3171101wru.173.1579269532195; 
 Fri, 17 Jan 2020 05:58:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id x14sm984268wmj.42.2020.01.17.05.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 05:58:51 -0800 (PST)
Subject: Re: [PATCH v3 2/2] vhost: Only align sections for vhost-user
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200116202414.157959-1-dgilbert@redhat.com>
 <20200116202414.157959-3-dgilbert@redhat.com>
 <4bf72509-3e60-0d78-c2ba-665a71a978e1@redhat.com>
 <20200117083232-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca54fc82-828b-158b-fadb-07abfbb9418f@redhat.com>
Date: Fri, 17 Jan 2020 14:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200117083232-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-MC-Unique: u0q8OQGsPa--rlUg9numFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: jasowang@redhat.com, vkuznets@redhat.com,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/01/20 14:40, Michael S. Tsirkin wrote:
> We don't really need v2 just to add a field. Compatibility is maintained
> using feature bits. Adding that is a subject for another patch.
> But I'm not sure I understand why does remote need to know about alignment.
> This patch seems to handle it locally ...

Because the remote vhost here will not be able to use the synic regions.
 If it did, it would have the same overlap problem as vhost-kernel.

The alignment is needed because, even if you are mapping only [768k,1M)
of a 2M hugepage, you need to mmap [0,2M).  You can then discard the
rest, but IIUC if you only mmap [768k,1M) then the kernel will fail the
mmap.

Paolo


