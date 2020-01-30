Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C40C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E772082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zsydqoi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E772082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixELK-0003Wx-Pf
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 13:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ixEKd-000385-HA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:14:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ixEKb-000644-7c
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:14:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ixEKa-00062l-V3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580408060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lD90yEVMHskUxxLkry2sTdl+XTod4UvmKZ4w0FtFIac=;
 b=Zsydqoi+KBGPtfFtrXbvQd02PUSP9OGCyfmkx2GySD69W4id2+P+igrubXsTO+c4FLNkvI
 XkLVXymkMqoz7I8ERSehnAlhyGiIhu/yob2KPnzT4TKk0DRqb1nP7W2D+6sq6snuPllr7f
 MK4wjXAW6VjvUO057Y/OBF0FMesC6vM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-fNCAENWwO5uf6glMFJLVqg-1; Thu, 30 Jan 2020 13:14:18 -0500
Received: by mail-wr1-f71.google.com with SMTP id i9so2105102wru.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 10:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lD90yEVMHskUxxLkry2sTdl+XTod4UvmKZ4w0FtFIac=;
 b=FRGhmMRASjJ1BNmJLubaBgJVgsJx8NrmpxAmCg7YZDiuEF7UFHUiUPRzQse2s/dOKF
 oIlHmA4UBE1mM+E0hZxEPFzNoi0zD160dSKC1xQ02NlDv6pxub0lGxC1e2OA6uG9+KYR
 FmeRlQkm8O5Caa68dPHswe86XU2yRQxDQqGE2InGseNxbcBWiPBzR8uKpHA6scf/7yDv
 ZoedzAgDSTeZH5To97dFHOXlu/9S9eWFEYq7nNWRmN3GTLFbG/Ecv5NVoIGDZ8vgnVLa
 2y+AQJUvSEKr/RUCDpT/RxhIKTJe5HqbdYaZqEBpuK6MvnfVfK4qNUQUDiuAIfBWA5m1
 85vQ==
X-Gm-Message-State: APjAAAUxn0QsnU4lIPbuZu0VsElwwGjDpXgThFbfkBQGbcscFcafVoce
 nKRbJEUv/nA99t4VP/MPzhy+mw8azK0zaEe1pcEUEDkzLYwwwb1K0f3FnDz/k5kE41rIw8twjC5
 A9hsdjZa62+/iPWk=
X-Received: by 2002:adf:90e1:: with SMTP id i88mr7156150wri.95.1580408056904; 
 Thu, 30 Jan 2020 10:14:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzsl+JGo9cirs68hR6jw9hyL07ROVRrJbZTYcNIlPBikHCy/H5UtjczLo9TIQUcHjG/mIgzpQ==
X-Received: by 2002:adf:90e1:: with SMTP id i88mr7156133wri.95.1580408056622; 
 Thu, 30 Jan 2020 10:14:16 -0800 (PST)
Received: from [10.200.153.153] ([213.175.37.12])
 by smtp.gmail.com with ESMTPSA id d204sm7266285wmd.30.2020.01.30.10.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 10:14:16 -0800 (PST)
Subject: Re: [PATCH v8 13/21] main: keep rcu_atfork callback enabled for qtest
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-14-alxndr@bu.edu>
 <20200130144224.GC180311@stefanha-x1.localdomain>
 <4bc49889-081e-6016-b8d5-a5d1fd615830@redhat.com>
 <20200130174246.fd4dcs7gntoyzx5i@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a374881f-b3af-eb51-9fc8-ee4d43dd7b15@redhat.com>
Date: Thu, 30 Jan 2020 19:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200130174246.fd4dcs7gntoyzx5i@mozz.bu.edu>
Content-Language: en-US
X-MC-Unique: fNCAENWwO5uf6glMFJLVqg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/20 18:42, Alexander Bulekov wrote:
> With QTest, is this still a concern, since there are no CPU instructions
> involved? Sometimes the fork-server starts after some I/O has already
> occured (eg mapping BARs and setting up VQs for virtio-net). I know we
> briefly talked about threads at some point, and it seems that iothreads
> may be a concern, if any are started before fork. Other than that, since
> there is no TCG/CPU thread, are there any other threads that could be
> a concern?
> -Alex

There is a CPU thread, it just does not do MMIO.  However, it may still
execute code via run_on_cpu.  It's quite unlikely to have the deadlock,
but if it were possible to force an early start of the fork server (at
the point of os_daemonize() would be ideal) it would be cleaner and it
would allow reverting this patch.

This is not a NACK, just some extra info.

Paolo


