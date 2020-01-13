Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD06AC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A336207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3BJSaEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A336207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2Xb-0004c7-Gk
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ir2Wc-0003or-8L
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ir2Wb-0000Pk-9f
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:25:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30813
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ir2Wb-0000P7-5B
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578932708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tJeKRarH0GSgKHbReVkjmi9dH+l8TsJfxihOE0pOes=;
 b=f3BJSaEy7Nw9NkXyT7p0Va+kaIazomkjPsnKYyz8nrXUxZS8sFehhnsHIZqqY5zGz7900P
 8ZzQ93DkIlU1Jb3xmV3eCTBh3z95y2TfZ9qBD1Vs6cKqiCo3O6R+1yFiM0n/GdX7vqNBxC
 SyCyqNWGLcnZHoXF1QlroXPiyeYmdKg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-2czXqXKlPLqWM738F8dA6w-1; Mon, 13 Jan 2020 11:25:07 -0500
Received: by mail-wr1-f69.google.com with SMTP id f15so5263951wrr.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 08:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8tJeKRarH0GSgKHbReVkjmi9dH+l8TsJfxihOE0pOes=;
 b=DAqYDokJs6Vw1UXvdShUS68V6C+BM4bE3aFcWSjyonbIEel0ToNg7qMNGaYau3OHnh
 NAvc7zOQIdxoDENEz9KLDNqNohI5vxYtoj/V8kWo062WjrhYR4YJt+Srj7pGLkPo1stW
 GrVF+j8HHIOkwicDfxTMFpi+36WbU49vpSouYFKb39ImPjObnkEEe0PF3Vgr6UvCTKZQ
 Syj6a5jqd6NDn2X0OY4NTDATG18bcvYJx3i/Q35nmhG35MOehC2++k4oyxv0FCLm/gai
 Ku/hNbctKD7dR01lqPOsf9bZvVktWmRhIqr2iguyCXnE2I73LltGc2GN6jER26O7uqp2
 5ioQ==
X-Gm-Message-State: APjAAAVzO9PIikKLFvrA7PdBXqlEQAY+8K/pVQ1TJ168bU+SJsIpBdoh
 4Ct0e23ksmRRUQstlUaD8Ubg7LthPXS+bS6zU0KemgXW+nCozzbImygPjdpZN6JzPk+/BYzYkE6
 cHXi5Rz3KMTNm0T4=
X-Received: by 2002:a5d:5345:: with SMTP id t5mr20359646wrv.0.1578932706005;
 Mon, 13 Jan 2020 08:25:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFeRGj8MQxm2h68HEtaKWB6m0FBGajtklvVGaEdkdUeG3sX4bNd5affyJxFJK9VrWjqbOzIA==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr20359621wrv.0.1578932705773;
 Mon, 13 Jan 2020 08:25:05 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:1475:5c37:e2e2:68ea?
 ([2001:b07:6468:f312:1475:5c37:e2e2:68ea])
 by smtp.gmail.com with ESMTPSA id y7sm320244wmd.1.2020.01.13.08.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 08:25:05 -0800 (PST)
Subject: Re: Priority of -accel
To: Markus Armbruster <armbru@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
 <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
 <87d0bnwct1.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff78d961-9432-c84d-4bba-6df14b1a5a79@redhat.com>
Date: Mon, 13 Jan 2020 17:25:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87d0bnwct1.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: 2czXqXKlPLqWM738F8dA6w-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/01/20 17:17, Markus Armbruster wrote:
> Perfect opportunity to change the default to something more useful.

I am not sure acutally if it's that more useful, now that we have
sanctioned qemu-kvm as the fast alternative.

Particularly it would be confusing for qemu-system-x86_64 to use
hardware virtualization on Linux, but not on other operating systems
where the accelerators are not stable enough.

Paolo


