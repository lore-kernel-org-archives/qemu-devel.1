Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23641C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDFDE2075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIU4yoHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFDE2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXT6-0005Ii-1t
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1ipXQ2-0002yY-3C
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1ipXPx-0001KN-Kw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:00:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36957
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ipXPx-0001Ee-8Q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578574804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfWnWan7BT3e62QOwgAkCvYs8KTTIrzZOd+qDCNBHO4=;
 b=KIU4yoHW6RMf/V7+fv5e5DbtNqo58nfoAaXpTMI0KKgpnm/a3JmGZbNikJvihh6dn4fHhw
 dfSV95+vKJEvd+z4G5Bx2RGO6uXd3COIVC5ymq3IXAQd3EQaj0n86puG6UiQZOiA1JwKrS
 1bkHl2+C351tCb1VljKVK9XZ83dUUzw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-XsTpxWrYN52oM2Wvg6CEGg-1; Thu, 09 Jan 2020 08:00:03 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so2841478wrq.12
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 05:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=NNBWZCiiWiw2ggAlD0hwfJwk6zKvpyiPpHzkdIP6wDI=;
 b=fUVM0rP4Y+xsX+OqbpA2q/0jau5kvcsLcB31P1DecigXFKbeU3fbGWs+kflLlXacEo
 4Bj2He7XZ7OG7Hhts5hCZKQuFlNLxtEAQ6iqfMRJseQ/yzpPv1LXretueA/Jc17aFg+7
 V9mNIx2fpCiN4drhiQEpYQVolI7SAKYWwh1Br5dFQMNU23kxFcd9RNlvGkIMsoeUN45H
 9Dwf1KWz8zMN9THfDj4sluLOn/cmeWTeCNOsfsLb/7FM+cpdvnWeY4caAZX0wLt/vpc7
 pIEtL5xtORyRIkBRHwD4gQ6366DwYHSN9RbS1uUKfPee6oPbAlmyaTb6NhUq1o85S8xO
 +s3A==
X-Gm-Message-State: APjAAAVtglqKK9H3DWsjNUQuMWhBx27GSnqEWQwuzoiHE0JQVefbTf68
 0BzeB86jM6Qz0oRPc8yvQiG5/fdTCg4BuOymiyF3DiOhUDpIp/ezqmzGY6z8AezAEsR5CYUF1ed
 qXzPDtSWDjBWGBVk=
X-Received: by 2002:adf:9427:: with SMTP id 36mr10861597wrq.166.1578574802025; 
 Thu, 09 Jan 2020 05:00:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhoAcnFbHzXo0sLVYaywMXas9E8PL2ZjkWXnmDQpKZjLYnxFA2klMDv8qem3/wnlqEEVPBXg==
X-Received: by 2002:adf:9427:: with SMTP id 36mr10861588wrq.166.1578574801833; 
 Thu, 09 Jan 2020 05:00:01 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id 2sm7915978wrq.31.2020.01.09.05.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 05:00:01 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
In-Reply-To: <20200109122237.GD6795@work-vm>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
Date: Thu, 09 Jan 2020 14:00:00 +0100
Message-ID: <87r208rdin.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: XsTpxWrYN52oM2Wvg6CEGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> And I think vhost-user will fail if you have too many sections - and
> the 16 sections from synic I think will blow the slots available.
>

SynIC is percpu, it will allocate two 4k pages for every vCPU the guest
has so we're potentially looking at hundreds of such regions.

--=20
Vitaly


