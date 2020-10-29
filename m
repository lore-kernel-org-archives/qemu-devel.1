Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F37820719
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uirx+Moi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F37820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY52G-000378-5R
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kY51h-0002gH-A6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kY51f-0005nF-4E
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603966761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHoW9RjzaoUXCFCgRE3Mb6Gc+4+BEBOkgFkgoznpLRs=;
 b=Uirx+MoiloxMD9UCPXJ6YbzAdFzBk0Zinwi26W8oozbF4Gvvdax0HQ+00q0OhxY5v7htNg
 IkcYJsl2BsulM1A5IvmPNnzg1csqlCAcy8JYb2a68WHm6NpPdMI+DvQ5SHyIzCCG6AIBcR
 t3uw8ULQSAEC/zr5OSak4G5lgaCX5tc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-vgZCZqvyMoiu22KuFu7LAQ-1; Thu, 29 Oct 2020 06:19:20 -0400
X-MC-Unique: vgZCZqvyMoiu22KuFu7LAQ-1
Received: by mail-wr1-f69.google.com with SMTP id b11so1091032wrm.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 03:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zHoW9RjzaoUXCFCgRE3Mb6Gc+4+BEBOkgFkgoznpLRs=;
 b=bCi0rGkXBVd62UJBrnoiANCKM19o9JMc7fGK76KGOJpesqpDZUOMN53M65OFBNuBNd
 wxKrgKcrOckTDxPo7BB2i4xrdU6/bTlkXigCMoSiXeCKHDbV1xP7+Y5nw1SZ+j8O8naB
 +jtyvzVFhex3nxpLVjcswgEEoVTJOm14XKSHr6hw7PmUOyszsZGAae/yVI99b9YVr4iG
 Bu0DNd8pdNBa0bUArELUOT1OAlreMcjDqJC9LXjHX5JWyInJIPZYgB+nns3DIaqeLmvY
 kkh+YOocPwyQjmbPQhe2xWGuQfSKomwRLjJDbFCtQVt8A6ZDFZuiw5vsAp8bemGnswlQ
 0Uew==
X-Gm-Message-State: AOAM533HmMbMwC6hDRqnUqgEH5bvfvrhK5UoHiOcUh0ANOG/nrPkcF7i
 8E7t8tJ1Wv+3nZrOwyVxDFVtw2aVls4Y3+WKYJhwvMgqZ8EViECa8RxkJTNxPdAQrM516bmXVjL
 /VsMaOc91c1Bu8fA=
X-Received: by 2002:a1c:6788:: with SMTP id b130mr3763078wmc.91.1603966758741; 
 Thu, 29 Oct 2020 03:19:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+EwFu8wMuPJTqt7Nh754yBqfn0DbeK7HFc04AcWitOAd9iXFfb0EJ8Txb4dM6gFmCrHdgrQ==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr3763063wmc.91.1603966758566; 
 Thu, 29 Oct 2020 03:19:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id x10sm4020653wrp.62.2020.10.29.03.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 03:19:17 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] configure: add option to enable LTO
To: Daniele Buono <dbuono@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
 <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
 <20201026155006.GE496050@redhat.com>
 <756e6060-394f-fe4a-47f2-2601b6e54a45@linux.vnet.ibm.com>
 <20201027151744.GF529052@redhat.com>
 <606b3283-25e5-329a-7d02-4d3d39383c73@linux.vnet.ibm.com>
 <0b7e524f-59f5-a7b3-7e4f-608042f0bd4f@redhat.com>
 <718a0446-09f5-9e45-5f64-e22a72708e67@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bf8c015-3b44-4fae-1920-f02b856be2f1@redhat.com>
Date: Thu, 29 Oct 2020 11:19:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <718a0446-09f5-9e45-5f64-e22a72708e67@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/10/20 19:22, Daniele Buono wrote:
> If LTO is enabled with the wrong linker/ar:
> - with the checks, it will exit at configure with an error. I can change
> this in a warning and disabling LTO if preferred.
> - without the checks compilation will fail
> 
> If LTO is enabled with the wrong compiler (e.g. old gcc), you may get a
> bunch of warnings at compile time, and a binary that won't pass some of
> the tests in make check.

I think both of these count as user error or compiler bug, which we
generally don't protect against.

There is one exception.  We check if the C++ compiler driver can link
object files produced by the C compiler driver; this issue arises if the
driver used for compilation (C) is GCC and the driver used for linking
(C++) is clang, because GCC and clang's sanitizer libraries are not
compatible with each other.

I think however that in this case the problem is not one of
compatibility, but just a broken install, so I think we can just ignore
and just forward b_lto.

Paolo


