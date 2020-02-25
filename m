Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C599C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 08:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410F021744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 08:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeII3Bcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410F021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Vbi-0002LW-92
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 03:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6Vb7-0001s2-4n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6Vb5-0000Ws-Nb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:29:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23260
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6Vb5-0000WH-JW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582619382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQmsXgNCJs24sOuqkiRXlQLbQzHCPWbzvCSRJ5USzn4=;
 b=YeII3BcgcSTwXtVGvWzlUGyT9teti1yH2dNDZqjPdB1bbf6IPqK/Xhl5u2hHK/3K8LGhM+
 bKmI9KUTXmWnIPvL3pMJXgpKkEDnEWa1ZxcoBiAXl+CgzQeu0h/JOGxXFBvTW3Oahkpsns
 P2yFx+pwu7Qd5HifE3uHh+s/ZiA1A9E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-Wx5gNnAoPS2TWFGDmG6wHQ-1; Tue, 25 Feb 2020 03:29:39 -0500
X-MC-Unique: Wx5gNnAoPS2TWFGDmG6wHQ-1
Received: by mail-wr1-f69.google.com with SMTP id t6so6966748wru.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 00:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XQmsXgNCJs24sOuqkiRXlQLbQzHCPWbzvCSRJ5USzn4=;
 b=M6wlQA4wUu6419q2NVbPFmJoZRpHlq7+dbs+G0OkaL/ebhbx1891BCv8tgK/gzuZ8Z
 D2WaA0VfmryUl0Xo884mDaUovOEc086ebZJUqypXkB0g2biiTQRN8VXu8ig+OxLM33Mr
 1Jv4Ff3I6DzUwfcCZGmp353eNhk1ASznhQw/fEnlIY0AGuY4OaKrXx2IGXc2VVTYTtJr
 xpRSgF3DaIx6aU8m9IBrHMZp4IrdKyy+0qlwOsEYdjTiY9oqxpIPFgphVILH+RjzA91X
 AzYMGbiWaztEqQIlIOUpbFNJa9Rgm/R2nM1uYtAatiY2EzIrFmAd1qdG/xot/KFfeqmz
 uy6Q==
X-Gm-Message-State: APjAAAXfS0ReBpY4YvRpQegzM9PX4ApcB4TjgUTsDgNzjFeX3jH2Tigb
 k5gpECQxFe9GLtU1+y7AJcEtefjmx2BL2aD3iZMqNHCYyhHjYvsSEOLoEX9pbgqbzLbPpMNZ9oF
 8QHz0Sct5jz46hiQ=
X-Received: by 2002:a5d:540f:: with SMTP id g15mr68966716wrv.86.1582619377802; 
 Tue, 25 Feb 2020 00:29:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrNLBkt1Xrt0uE6lWrqREVzjXJfkLU6NkN59Bo5xBox/dsSNZkiXcCF2KV7NsbJ18Rn18Pmw==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr68966694wrv.86.1582619377534; 
 Tue, 25 Feb 2020 00:29:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:60c6:7e02:8eeb:a041?
 ([2001:b07:6468:f312:60c6:7e02:8eeb:a041])
 by smtp.gmail.com with ESMTPSA id v131sm3265403wme.23.2020.02.25.00.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 00:29:37 -0800 (PST)
Subject: Re: [PATCH 2/2] qxl: drop shadow_rom
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200225055920.17261-1-kraxel@redhat.com>
 <20200225055920.17261-3-kraxel@redhat.com>
 <3e1d3937-1f63-3e8a-4e20-532ae34a51ed@redhat.com>
 <20200225082315.xpxryeuxyehv7qhd@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7fa352cf-39cc-569f-7c0b-388c731014fc@redhat.com>
Date: Tue, 25 Feb 2020 09:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225082315.xpxryeuxyehv7qhd@sirius.home.kraxel.org>
Content-Language: en-US
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/02/20 09:23, Gerd Hoffmann wrote:
> On Tue, Feb 25, 2020 at 08:39:12AM +0100, Paolo Bonzini wrote:
>> On 25/02/20 06:59, Gerd Hoffmann wrote:
>>> Now that the rom bar is mapped read-only and the guest can't change
>>> things under our feet we don't need the shadow rom any more.
>>
>> Can't it do so when migrating from an older version?
> 
> Good point, and I think there is no easy way around it.
> So drop 2/2 and merge 1/2 only I guess?

Yes. :(

Paolo


