Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61026C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB5F24654
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCnXwRt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB5F24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ifq-0004Pe-D7
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4ier-0003iv-2E
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4ien-0004nA-HS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:02:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4ien-0004ln-BD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582192928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYpmB5HQZhvCads7nBvD0cMe979MOlsgiXHY2npHwyA=;
 b=gCnXwRt7x9H3hYE8ln+2aIRP04hBc3U9+ABRtO9NHCWm0F8BOO4Drwoe5JNsiNgKeVlHDR
 lLfOm2/NHNabaR1o/KIWqv9X3ciq7qs/4cRk29OT1e8yjCPmEnzfrYzjLmW/sFhBOlfqDr
 MB6RxUsNPnUMz3j9jFihPaoCoMzSf24=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-w22wdLj_PUiDMJk8y0qrLg-1; Thu, 20 Feb 2020 05:02:02 -0500
X-MC-Unique: w22wdLj_PUiDMJk8y0qrLg-1
Received: by mail-wr1-f69.google.com with SMTP id z15so1526848wrw.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 02:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xYpmB5HQZhvCads7nBvD0cMe979MOlsgiXHY2npHwyA=;
 b=mAUT+hmZzd91OetcYMQtMss1IXqTSkRVRyDgM+Km7/21DCsWgHTp+A0tPEOGcuokyM
 05JxSya7K3frxT/Rl2y2TznbYeORXlcyqRrZgGkOopZOqqZIn0wsKD7LM0qtu3xGXxrk
 LkwCgc7TR7t1blsKw6NqT2pAWE6Oozwx/+6BR8UCXtkl5+50FVeVvj1XHL7n9ocKBjwH
 FnNMzuX32HIuRo7roQu97ryBbkD4FWNs8VzNLnDN8Tc0RXsFZw8WmXepzhj904+jWuyG
 6aOqhU4Jx/h5Av95TCJ7wvYm20ssB0YyyK01H5yHAngKEq+t9WQRw8i/z3n2Ufcg+kDn
 RiMw==
X-Gm-Message-State: APjAAAWYcp119BwtsoOXzfQ7eA1ceHyiZNrJ5aQuM3LCYP7+9OFvE/3Y
 amKwWnx9lwvkm7JMwB5o5y7PhNbGujKmlkLCxETiP7HBjiR+29sDQuIWQnqbWwWsAkB77uTCCw6
 sS3fA1I0A8U6p1Qc=
X-Received: by 2002:adf:db48:: with SMTP id f8mr39184113wrj.146.1582192921579; 
 Thu, 20 Feb 2020 02:02:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHwr5NI9I2q8GIXqxYh92zeGK3VSeuGVMgF9sTK/oZRsCI10Txon1NSSmBPk/5x33GTJUYpQ==
X-Received: by 2002:adf:db48:: with SMTP id f8mr39184073wrj.146.1582192921206; 
 Thu, 20 Feb 2020 02:02:01 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id a16sm3573679wrx.87.2020.02.20.02.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 02:02:00 -0800 (PST)
Subject: Re: [PATCH qemu v7 0/5] spapr: Kill SLOF
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20200220061622.15064-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db675fc6-9d07-1780-134d-6a9279328b29@redhat.com>
Date: Thu, 20 Feb 2020 11:01:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200220061622.15064-1-aik@ozlabs.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/02/20 07:16, Alexey Kardashevskiy wrote:
> This is another attempt to implement minimalistic
> Open Firmware Client Interface in QEMU.
> 
> With this thing, I can boot unmodified Ubuntu 18.04 and Fedora 30
> directly from the disk without SLOF.
> 
> A useful discussion happened esrlier:
> https://lore.kernel.org/qemu-devel/f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru/
> 
> 5/5 is kind of controvertial though. This respin does not include
> networking.
> 
> This is based on sha1
> 015fb0ead60d Chen Qun "hw/ppc/virtex_ml507:fix leak of fdevice tree blob".

I would like to play with this.  Can you provide a disk image that just
reads the first sector of the disk using an OpenFirmware read command,
and dumps it to stdout?  (Also, I lost the pointer to your super-minimal
pSeries firmware).

Thanks,

Paolo


