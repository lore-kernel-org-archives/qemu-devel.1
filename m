Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431D8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2A12076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9kGBv/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2A12076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRrvT-0002K4-Bc
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRrqS-00081r-2g
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 03:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRrqO-0005ny-Gt
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 03:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602486122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gkl7xq1ebWd672+Its+mjpxdmuftldwQyXpTP5QjCeA=;
 b=R9kGBv/pVApdDTj9w0JWnzvOtULeOHEI4hLVUKWUQ1QHklXulyyou7KTfCyqXX751ELoDt
 602DWuPaady9jw0WE46iLdEjYGvEFkEeBzZNLnfKN6yRVfKBZMN3lx6hmXsc5d5t3dqHwL
 lWyOaEe2Pe/sSI70se5HPDyCStxyP9k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-7qNaUq7xNX6U6_ggmJBzvw-1; Mon, 12 Oct 2020 03:02:00 -0400
X-MC-Unique: 7qNaUq7xNX6U6_ggmJBzvw-1
Received: by mail-wr1-f71.google.com with SMTP id x16so8480248wrg.7
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 00:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gkl7xq1ebWd672+Its+mjpxdmuftldwQyXpTP5QjCeA=;
 b=aT7IwUr6NNfD26RNZMgKLc3UGYY0veUj0ik67wbah2iU68fVrehk+RiKGZdDXDkxv5
 CgRwtm8CZYeFuX8zTIIuFqbzhhIX1yYkIuYm5tpwH+MxNpdhLGfvfbEv4u35dHOAcYQt
 SRsnReeA+TptNpyAyQUtDQFxLE/YmbdMJEa6ZibAVg3zNKG12yqD8Yx8q67wv3hBkLGS
 r6wQXIg5lwKZyRGQtU8G0yf3E0VSjpccNrFWSeq0TxTQC49fKinBpljSNaPRdcNyZDtO
 sWCZbTD1Ma4tNzp9HtykCOdd56wFT0JGhJzwT28OW4TqE67ry40fNENw5+psOyhJcvdl
 /4GA==
X-Gm-Message-State: AOAM531H7giSyQrDPZkUU6tFG73Y2nf+nNiKY5xvuET6nFYDZRIPJvFM
 VA3ZtYdKf+BrHIedu/dYf0eNXCJ0HqYh0uoesgEPGd1FVXPpca9+K0eFuGty5oXPhe6TkkXHd57
 ZI1MSHfdOCiyRkxA=
X-Received: by 2002:adf:dd89:: with SMTP id x9mr8530993wrl.284.1602486119338; 
 Mon, 12 Oct 2020 00:01:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQNHcPqA+wZ6r/JgkyyHY4JuB14anRHNNmroJeLdaZCMsk7jURudP8i3MzV55RdyhpmXbboA==
X-Received: by 2002:adf:dd89:: with SMTP id x9mr8530967wrl.284.1602486119095; 
 Mon, 12 Oct 2020 00:01:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7ffb:1107:73ba:dbcf?
 ([2001:b07:6468:f312:7ffb:1107:73ba:dbcf])
 by smtp.gmail.com with ESMTPSA id e7sm24517410wrm.6.2020.10.12.00.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 00:01:58 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] fuzz: Add general virtual-device fuzzer
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-3-alxndr@bu.edu>
 <63ca7622-557b-4217-f15e-ee9b024fbd77@redhat.com>
 <20200921143405.3taiymgzwvscxsry@mozz.bu.edu>
 <74511624-33ed-ff5d-62c2-f9b2b632b39a@redhat.com>
 <20201011153522.oyad5n47p4hphgfm@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <244cc05c-e063-9d25-3833-96bda5cfc2e2@redhat.com>
Date: Mon, 12 Oct 2020 09:02:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201011153522.oyad5n47p4hphgfm@mozz.bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/10/20 17:35, Alexander Bulekov wrote:
>> Instead of always looking for a separator, can you:
>>
>> 1) skip over it if you find it naturally at the end of a command (that
>> is, "FUZZ" is like a comment command)
>>
>> 2) actively search for it only if you stumble upon an unrecognized command?
>>
> What is the end goal? Is it to be able to use the "FUZZ" bytes to fuzz
> devices?

Yes, possibly, and perhaps also using a shorter separator that is easier
to learn.  But if the dictionary is enough to work around the learning
time and it's unlikely that crossover produces inputs like that, I guess
it's okay to have the separator.

Paolo


