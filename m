Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC97CC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CE4208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cO5U+jYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CE4208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqMy-0001fv-4t
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ioqL5-0000H9-Op
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ioqL0-0007fZ-Sb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:00:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ioqL0-0007dm-MP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtKW3/T5fgdYNj5LeF8SE0b0A9HyEna6BVmtkQchnqY=;
 b=cO5U+jYGevXEolhNMMTma0eqKk/t/KDURUrQNLVPMYUduK+g1LeXgwlkLV2UeSeclyMa3H
 N3jdJztGkx5DYYkaJERuGMSRaNysHr6iba5U6upaOITRCOCmgzMAtJDbVpg9fzfiYRmD+u
 DvQQ5m4N7eIhtdy0EQwotaXsCStVzZc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-6FFZ0VYuODq7_uZvqbf7TA-1; Tue, 07 Jan 2020 10:00:02 -0500
Received: by mail-wr1-f72.google.com with SMTP id r2so49908wrp.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 07:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VtKW3/T5fgdYNj5LeF8SE0b0A9HyEna6BVmtkQchnqY=;
 b=H7hroDlbinlRZw05DI0MJmeFO8SDHVbfKAuok/Bc5jfmQV3NfUG7ntSYqauo5iz+gH
 zcl67md8clc11L/FM1B5kMRSrUw6/sfM5vrIJ42UTEqfORjttZqlQyk3Az+DiTGKONwC
 yyWXCA4nZ/Rx7GkZ3uO40UCZ9S6NoZEPykBAEsk0PH9Iktmqv4228zL7AroifFyUbopr
 FwZgfB3oHMOILLVqQDAgH43XvXfGT7a6qfwCEtiS+2QwQZqsWw5aOID2pL70Q+uoBYbV
 BEALgPkLeg+HNWjZEeEaFiHMpE1CW6igNv+w3i5IaOyIGqoM6WjYEkJlJqnwGd/Ha5qE
 mHEA==
X-Gm-Message-State: APjAAAXRqQjQ8X68j3/XMzuWfco396IQMJcLUAtpkEqcK5U3XC4IcDss
 fdbUBzrn5LMn/jMHmZQczK966wGLm1Dko6foRs69LUhMec5qRE5vtSwDSODsp5CTBUtoGtzkAPe
 o+IXjd+aUrce88eI=
X-Received: by 2002:adf:eb0a:: with SMTP id
 s10mr114983876wrn.320.1578409201785; 
 Tue, 07 Jan 2020 07:00:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwc0BQ+8eGaMfwHq8uqZtmWPJM4iCqXICikk+lTfHIoZEJeuMq+k2RPX7d2cfaYEcu8Tp8eiQ==
X-Received: by 2002:adf:eb0a:: with SMTP id
 s10mr114983862wrn.320.1578409201557; 
 Tue, 07 Jan 2020 07:00:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id a16sm110879wrt.37.2020.01.07.07.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 07:00:01 -0800 (PST)
Subject: Re: kvm_set_user_memory_region() doesn't check ioctl return value
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-Q_qprNny1gy1TX=JSrJm3um=6=dQbtrHVry1ODSCc_A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57d5c7ae-40c2-ddcd-c4a8-60f9fec5d206@redhat.com>
Date: Tue, 7 Jan 2020 16:00:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Q_qprNny1gy1TX=JSrJm3um=6=dQbtrHVry1ODSCc_A@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 6FFZ0VYuODq7_uZvqbf7TA-1
X-Mimecast-Spam-Score: 0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/20 15:52, Peter Maydell wrote:
> Coverity has just pointed out (CID 1412229) that the function
> kvm_set_user_memory_region() in accel/kvm/kvm-all.c calls
> kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, ...) twice, but
> it only checks the ioctl return value for failure in the
> second case. Shouldn't it be checking both calls?

The first ioctl is basically setting up things so that the second can
succeed.  My understanding of the code (and the comment above the first
call especially) is that if the first ioctl fails, it will cause the
second to fail as well.

However, it would indeed by cleaner to check both.

Paolo

> (This code seems to have been in place for years so I guess
> Coverity has only just decided that kvm_vm_ioctl() passes its
> 'needs return value checking' heuristic...)



