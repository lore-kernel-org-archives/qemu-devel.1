Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E936C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FD020772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6LhETog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FD020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyrR-0006M7-6C
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqyof-00044I-RQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:59:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqyoe-00065h-2w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593694787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQhvlrcJJXnukesO8dG0MM5mVFWb8gZBKUiCoMR7cMk=;
 b=O6LhETogC8LbRm2LCz/br2tVatqvD+7s6kWmPIie/q57JFPPZy4p1YfujBdcHTXRhuNuw1
 VU0UcM14xzLzpYCVB6n2KmkfFXauQ7g49cgwpe1TcGiE2dMTLnDq1QAsRgn5L7jXIszCsc
 Fzho9c4mctSiLzF1vfCChRg1LMSfhYE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-eTHt6rNxPNGZqg0njo7FfA-1; Thu, 02 Jul 2020 08:59:45 -0400
X-MC-Unique: eTHt6rNxPNGZqg0njo7FfA-1
Received: by mail-wr1-f70.google.com with SMTP id b8so11650926wro.19
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 05:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HQhvlrcJJXnukesO8dG0MM5mVFWb8gZBKUiCoMR7cMk=;
 b=gtAjxVoNoxm0HODQbhveSVxkLcryA5gJvSL7g3/93DEhOCILhCCqRvNzTkmRuU8dt4
 Uafe3egm8Eh3WeRblYI9P4CBPNzh4mYP0vQR9vxuuawSIazmtyBlD4llm7gOKDropiY6
 4Sme+6Jhj318Vyd2vWdGobjNDNYvcNKlKt4tDPDjxDCqKS3ikPO87Q03qBDHHns1RXo9
 i7J50iYaBCnpxcSUmY2SijR6dB494n9C2pRNHXiKrJIxbaCUKZwgzv1Gvhebrcvnadlc
 mK/XdWqRvhsVAStroR9lOuiox9ltCIOlD8Ax/SOWBpar3wI2fMVdoHqCbjp/vIqNSIlF
 Fh4Q==
X-Gm-Message-State: AOAM5306UUoDRtOTYgWXeK0W6a0te0cocLUhqfn7ESVUxkBSZFn6cZ5W
 jC3TEInkrkJcHrLx5icvY28X/dSVIgUwJLj2mdHiXlgkQoxPNY0r4uNFNtmPESu1ZHtmBzS8bXy
 /tARysj44tGZHhRI=
X-Received: by 2002:a1c:1b0d:: with SMTP id b13mr30628193wmb.169.1593694784626; 
 Thu, 02 Jul 2020 05:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKLkM4ZR8V02E7hyofQylmJ6y+BsOYNqdoeuj4kkB4BD4icC7/kank1ugFlrdG85b7xX6oRA==
X-Received: by 2002:a1c:1b0d:: with SMTP id b13mr30628125wmb.169.1593694783443; 
 Thu, 02 Jul 2020 05:59:43 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id u23sm11547283wru.94.2020.07.02.05.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 05:59:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] configure: add support for Control-Flow Integrity
To: Daniele Buono <dbuono@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
 <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
 <20200702095252.GF1888119@redhat.com>
 <0ed44c55-1f5d-6866-9555-82134ef628fb@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c81befdd-979c-6060-c0a3-15ea1b142d25@redhat.com>
Date: Thu, 2 Jul 2020 14:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0ed44c55-1f5d-6866-9555-82134ef628fb@linux.vnet.ibm.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/20 14:50, Daniele Buono wrote:
> I also wonder if this is something that could be put in the fuzzing
> environment. It would probably also help in finding coding error in
> corner cases quicker.

Yes, fuzzing and tests/docker/test-debug should enable CFI.  Also,
tests/docker/test-clang should enable LTO.

Paolo


