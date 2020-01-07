Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E7C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F432208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlKKAmFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F432208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopbW-00049D-6Y
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iooux-00061G-CI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ioouv-00044h-TP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:29:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ioouv-00043I-QI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578403745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBM0R32glpMVuot9fSWTjQ1+QD7ILwo94E2L+NFbt3k=;
 b=ZlKKAmFjMPYSS9hwdI7jk5hwXVss1xE7CxHfUM+mnr7p3ljkmKDAkZrsA30LGT11Nwx1MY
 xHoNAB8o49aH2tfxbZPhmNA1NoDMqE/BPU2zBSL+c9jbfl/uoHQTpcqMpntH/wGgzIWT4d
 5+kZ2NYsOzr3J8nrYddteZH9i869I3I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-mzYvX5BVMGqA1StgLZzemA-1; Tue, 07 Jan 2020 08:29:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id u18so28581443wrn.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SBM0R32glpMVuot9fSWTjQ1+QD7ILwo94E2L+NFbt3k=;
 b=Fhv1KMR7XHCZgIe2h7e7WtKdZJPPPhKAiSJ5x0QP+J90ni4x/HuMFo2mpHAzkHVQWx
 xw/Q275LpI2eCwgq7k/bLec0OnI/H6bwDCWMfudbc4xkIXUGMyhpzVdNHEp5aPtZ9Pcs
 QKxeLPP3zQfQtFIev8SCJciS0YP3aGOsGTPZGCh0G9bpShkSsMwOk21/JcHQ2Aik5a1P
 MK71RytNwd/tLIiAEbA2F/Yvel2JPDB/QNDatXCAN0y36mkvS9RvNhdwe+UC9gPDgCYx
 yls253f1n+CyPT96ol4JhEdh4rGlE7BvWUNPGc70jnHZM2OLZRibAGYH8l3HJJIxaYgC
 YQRg==
X-Gm-Message-State: APjAAAW2s5ek8nPawt/OMu51bGolIoyf4eTOLv1U/Y9jnqhfyP7hcOr9
 wUtY/xcaxZ1m6iQ4kNkjNmQG4hm+IoH6Tm8MfNigRaIeGAQCQgcc8Miyi9K6hb4okP1MUQuNmUW
 thFqsTOj6lt31bjU=
X-Received: by 2002:a1c:f210:: with SMTP id s16mr38901854wmc.57.1578403742912; 
 Tue, 07 Jan 2020 05:29:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjXVv7ouLDbitXju/95vWo7+UF9DVG8hZVlNxGRslqnI5/Cgk19r7pCe8P91E0lioe/Pv6OQ==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr38901832wmc.57.1578403742639; 
 Tue, 07 Jan 2020 05:29:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id p18sm26735668wmb.8.2020.01.07.05.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 05:29:01 -0800 (PST)
Subject: Re: [PATCH v4] target/i386: Fix handling of k_gs_base register in
 32-bit mode in gdbstub
To: "Marek Dolata - mkdolata@us.ibm.com" <mkdolata@us.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <4afa19236529458282794f682dfac556@us.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f942e38-d3bf-0d12-89fe-0ccf72f763d0@redhat.com>
Date: Tue, 7 Jan 2020 14:29:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4afa19236529458282794f682dfac556@us.ibm.com>
Content-Language: en-US
X-MC-Unique: mzYvX5BVMGqA1StgLZzemA-1
X-Mimecast-Spam-Score: 0
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Doug Gale <doug16k@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/12/19 03:48, Marek Dolata - mkdolata@us.ibm.com wrote:
> Fixes: corrects clobbering of registers appearing after k_gs_base
> Buglink: https://bugs.launchpad.net/qemu/+bug/1857640
> 
> Signed-off-by: Marek Dolata <mkdolata@us.ibm.com>

Queued.  Note that I had to apply the patch by hand since you probably did
some cut-and-paste job.  I also added a meaningful commit message:

    gdb-xml/i386-32bit.xml includes the k_gs_base register too, so we have to
    handle it even if TARGET_X86_64 is not defined.  This is already done in
    x86_cpu_gdb_read_register, but not in x86_cpu_gdb_write_register where the
    incorrect return value causes all registers after it to be clobbered.
    
    Fixes https://bugs.launchpad.net/qemu/+bug/1857640.

Thanks,

Paolo


