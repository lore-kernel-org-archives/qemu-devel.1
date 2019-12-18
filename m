Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490DBC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E9B21835
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/sn0auo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E9B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihMmk-0007jV-7U
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 19:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihMm2-0007IN-V1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihMlz-0003EQ-E1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:01:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihMlz-0003Ch-0A
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576627261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jf4iRcfMDCG5a9aQ5+EVrTRK5Ru2ljpbZo8uDAnU+iM=;
 b=V/sn0auovcVs+YaewDOYNyvSrxnOTUCpGiQiPdtcvbErd2YpIxVdxhLXk1+L8FTvEd1bDQ
 WnMGAXf0mdZjgbmaKsTFLlct/RBUOstiF+cOsKIai2eNVzjcuPfqmLqKhbCSeWF6xIa0qM
 O0cKbSE4jgQwpj95sV3rhuQZJrxbIpE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-Dpl4NmS0MrCWqNXUpdOUTg-1; Tue, 17 Dec 2019 19:00:57 -0500
Received: by mail-wm1-f69.google.com with SMTP id w205so105821wmb.5
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 16:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jf4iRcfMDCG5a9aQ5+EVrTRK5Ru2ljpbZo8uDAnU+iM=;
 b=PPHQ21YVrUxUmN8w90TOcsmsVd6Wwi7ALYpe8Nxk/tIXx0KLx0fTvUIV85Oc6oNc0B
 pooZyJBrp0VYnHS6C2LeUkJn59wSZOI3TEo+j9GVuoolct9QV3XDy1B+KvyH4EGOYiIQ
 0CPhoQ6kMBLlcS2CtdaFZOjboNz6cYK82as0x9Xaa7TuUDetb4k3VTD/pJ3k9YCNBbND
 nLLSfdk85EZz4aAtB0689HgB/qcKYxLDvyU6zpZEYEhEPZXRux4jb/ie572oXzuYwOae
 SNTqVpTv+6cbLAaqu4vEmZRFn3RinVbDDqdcQ9t/GaV9T/1ensxYzm67HEyUx69YEpPk
 q8jQ==
X-Gm-Message-State: APjAAAXrncFnhetjKKQsiEiYRLeEiLwcukYuHOnvEzPdQxMnv2kx5NBu
 OsZnkBZtY6cdly99HkPdr7F/pwP1e14C2TfGBg5pWyptMtlDmCPFQDz0xUf6RGEad2hBYAc24cd
 PlKS4QHVZNCzwCWU=
X-Received: by 2002:a1c:5401:: with SMTP id i1mr295596wmb.99.1576627256061;
 Tue, 17 Dec 2019 16:00:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPrCsaG1O2kwQ4ui9sNK89Y5K8mqI8Z8TxhD9xtu+vNqC9IdmyPzEytmE3apoAFbjy19zqVw==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr295557wmb.99.1576627255824;
 Tue, 17 Dec 2019 16:00:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:cde8:2463:95a9:1d81?
 ([2001:b07:6468:f312:cde8:2463:95a9:1d81])
 by smtp.gmail.com with ESMTPSA id i5sm497310wrv.34.2019.12.17.16.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 16:00:55 -0800 (PST)
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
To: Felipe Franciosi <felipe@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a302c6d-e2c8-0c3e-43d2-946e1fafea5d@redhat.com>
Date: Wed, 18 Dec 2019 01:00:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
Content-Language: en-US
X-MC-Unique: Dpl4NmS0MrCWqNXUpdOUTg-1
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 23:57, Felipe Franciosi wrote:
> Doing it in userspace was the flow we proposed back in last year's KVM
> Forum (Edinburgh), but it got turned down.

I think the time since then has shown that essentially the cat is out of
the bag.  I didn't really like the idea of devices outside QEMU---and I
still don't---but if something like "VFIO over AF_UNIX" turns out to be
the cleanest way to implement multi-process QEMU device models, I am not
going to pull an RMS and block that from happening.  Assuming I could
even do so!

Paolo


