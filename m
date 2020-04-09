Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B815C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B0720678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOFklPmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B0720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMaav-0006Fz-Bt
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jMaZt-0005oQ-Nf
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jMaZs-0001MQ-T4
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:02:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jMaZs-0001MH-Oj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586451776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrKuTxczS2b37pgtLprmXLZbEZ5k/a3ZfMeZc68ABhI=;
 b=UOFklPmSxRIUXgiy1pgLursCnByQQ5lpTdRGC/KQx+5EViSpQ9YVv935vIXuLiMTRvVUUe
 4TgI5H1BZecfmDaIqCKuCWbY8jVrdi94yhkffSgLJdTFek0/VmkZkLRHVQIns4oDN4o8aH
 +Qgv6cBEvynkLuK0vXpKRS53dp9F04Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-xPnbZwptNgeRzyRboJLxUQ-1; Thu, 09 Apr 2020 13:02:54 -0400
X-MC-Unique: xPnbZwptNgeRzyRboJLxUQ-1
Received: by mail-wm1-f69.google.com with SMTP id y1so333884wmj.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 10:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KrKuTxczS2b37pgtLprmXLZbEZ5k/a3ZfMeZc68ABhI=;
 b=sSqMvr6tT9v501B1Fm/WJQf0fTIKK8AL2jz6P6aUAauCXfii6kzESkCvvFjHjpV5ZC
 0z8avbG/ovOSqJmRVL9QiyJ9gvAB7mVhDtB8EGP2efGD29dEGAAgy7RIQQxAOaBHs5cO
 PbqwGjA68ByO/8V19FLnpMvEhK1LX/RHhXDW3+7KRJh75GTxhAL/O++DS4LjDsp+ggnx
 eEQZyvDdTPSo7AnZab5LKzCIoqN72O6uKpkXRQXCxB91HeSFQSmJxH1OhCn2p67/9cr0
 PSawANorPiDLCEvkeYMTLQeylmVssxs/byYsNRGhow1FtY15nMxJXXx0h7eFsg0Th8pq
 IuVw==
X-Gm-Message-State: AGi0PubfDZJeM+CJbpFEMrf3ZFJjT5mdYkmQ6XHVoZURBiZsG5dU76cg
 Ua7assI4oyOdzzKyPtLj+uVW42WOD8/8n/wc8rU6YG/R2YzloyDTeItPG7NF+JidnkImKHubR4e
 kYJNXcmwuKDNdKF4=
X-Received: by 2002:a1c:e302:: with SMTP id a2mr809088wmh.96.1586451773313;
 Thu, 09 Apr 2020 10:02:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHuFXayLK9xE0GYXIM0WNNmHcJcbXp1IThvHZWEncQfvT+sPkWRBPId95kND+LEH+k1QIwpw==
X-Received: by 2002:a1c:e302:: with SMTP id a2mr809052wmh.96.1586451772785;
 Thu, 09 Apr 2020 10:02:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e8a3:73c:c711:b995?
 ([2001:b07:6468:f312:e8a3:73c:c711:b995])
 by smtp.gmail.com with ESMTPSA id c6sm4042195wrs.57.2020.04.09.10.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 10:02:52 -0700 (PDT)
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Dan Williams <dan.j.williams@intel.com>,
 "Liu, Jingqi" <jingqi.liu@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <CAPcyv4igr9-DJx2ehoHj7sXk5g5GmgmivCqM3VpmJV7J4QM+kA@mail.gmail.com>
 <3873cb30-608c-6a27-c19f-f6446898796f@oracle.com>
 <9959e648-94f6-3be3-2271-3d2b855e7e48@intel.com>
 <6c12c748-6ee6-7132-f54b-bf0f90ae84c2@oracle.com>
 <2e2ba0c4-88ed-dc37-c642-a1cc7ae98f05@intel.com>
 <CAPcyv4hpA1Lc8+-3sDLBkG=sqMXbcxwQzNHYEcJevu8NypQcFQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe4668ad-c0ae-6e69-1511-ff8330046008@redhat.com>
Date: Thu, 9 Apr 2020 19:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hpA1Lc8+-3sDLBkG=sqMXbcxwQzNHYEcJevu8NypQcFQ@mail.gmail.com>
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
Cc: Joao Martins <joao.m.martins@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/04/20 18:46, Dan Williams wrote:
> Alternatively maybe you can use libdaxctl that automatically handles
> the ABI differences between compat-dax-class and dax-bus layouts? I
> didn't recommend it before because I was not sure about qemu's policy
> about taking on new library dependencies

In this case I think the new dependency is more than justified, thanks!

Paolo


