Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B76C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5374823EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR7FVXz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5374823EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvT5-00007G-Jt
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvSM-00086m-JQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:12:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvSK-0008At-CL
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593443543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WjQkAFIVzz5cNrGfPal06T/It3VohRB4RddCxMrMiI=;
 b=NR7FVXz5UGqgt8PGDl4yeffihzgi+LuUq96eEx/3RfhDIZA6RPdM44tit35yJrb1n/iSAV
 ViO3d1CQzSDde7BiQMEIt6/X4Y4kTp2qTm0NYDE1x27SR6Kg+6W6LY8QHXGRGThxir8jgt
 b9R4qEFp79kXeqGuSkIeVQZ31oEdwJ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-rY2K3JPDNUeFJOok4Iaqmw-1; Mon, 29 Jun 2020 11:12:04 -0400
X-MC-Unique: rY2K3JPDNUeFJOok4Iaqmw-1
Received: by mail-wr1-f71.google.com with SMTP id f5so16574969wrv.22
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5WjQkAFIVzz5cNrGfPal06T/It3VohRB4RddCxMrMiI=;
 b=EGx9MCV2cg9i4DvwJcrigF3EeoPyD0kd5EjMrgZAIRAqhkoQY/fY14m2XoF88n50MM
 6zp5Rw0ffcdy8MlQHELL4Nm+eFsU4IpZtS4L0u7I/U+N3XM3romTnzYx2DWnCnDrPAIb
 rE02A8VbngSav+VYgtSuj6wyji4ZR2eKFEICGwqTYlxh27zg8oKdptMraN+w05KRS0cS
 jW+Ju9uRDweJJif5uROuyY7ROeBuQrJsR9bbyJr5PSVjs9WUVWzC1UvQVs3KloAwNVPV
 t/kfzLO6RiaKtUGoaV0JgwDdEWTSsW9CDo/lBk8PGqWTlwC7LjyJhctssmcxPzbXrC4d
 Oa/A==
X-Gm-Message-State: AOAM533LfkoLiWLZMxzv7n6D87SWdVQdGhzrimEXLjLC+GHK4VQhLhe4
 w8iL8TAsfDurJdxvJgYqDbR2A7E01FOJ99VswpS/2+jRhVu7lK3UKYWUSC2cjRZlPnm+OLfYzjw
 f0WCrzBja+dFsR9w=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr17006775wrv.162.1593443523116; 
 Mon, 29 Jun 2020 08:12:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Rv7qBFkwYrvwn03C3UHV82d2n1/yKwEH8lVS3hrpR4FtPfl7X7fV0snT5D87mPqe8ux/yQ==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr17006746wrv.162.1593443522865; 
 Mon, 29 Jun 2020 08:12:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id r67sm129813wmr.9.2020.06.29.08.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 08:12:02 -0700 (PDT)
Subject: Re: [PATCH] tcg/svm: use host cr4 during NPT page table walk
To: Alexander Boettcher <alexander.boettcher@genode-labs.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
References: <c9ba7c23-581e-86d8-8174-37d2beeab768@genode-labs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e0f1409-c92b-560d-ca43-82b51cd88d41@redhat.com>
Date: Mon, 29 Jun 2020 17:12:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c9ba7c23-581e-86d8-8174-37d2beeab768@genode-labs.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On 29/06/20 15:25, Alexander Boettcher wrote:
> Hello,
> 
> during a page table walk of TCG+SVM the code in target/i386/excp_helper.c get_hphys() uses the cr4 register of the guest instead of the hypervisor to check for the PSE bit. In the test case we have, the guest have not enabled (yet) the PSE bit and so the page table walk results in a wrong host physical address resolution and wrong content read by the guest.
> 
> Attached patch is against 4.2.1, but works also on 3.1.0. It fixes the issue for our automated testcase, which is a 32bit hypervisor w/o PAE support running a guest VM with tcg+svm.
> The test worked beforehand up to qemu 2.12, started to fail with qemu 3.0 and later. The added TCG/SVM NPT commit seems to introduce the regression.
> 
> In case someone want to try to reproduce it, the iso is at [0], the good case is [1] and the failing case is [2]. The used commandline is:
> 
> qemu-system-i386 -no-kvm -nographic -cpu phenom -m 512 -machine q35 -cdrom seoul-vmm-test.iso
> 
> [0] https://depot.genode.org/alex-ab/images/seoul-vmm-test.iso
> [1] https://depot.genode.org/alex-ab/images/seoul-vmm-good.txt
> [2] https://depot.genode.org/alex-ab/images/seoul-vmm-bad.txt
> 

Queued, thanks.

Paolo


