Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E637FC388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 14:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A6D2068D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOKSq01A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A6D2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYrxn-0002rj-5y
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 10:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYrx2-0002Rt-Hy
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 10:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYrwz-00025C-Cd
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 10:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604154827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXqFmbfOPVOhXOdRVT0vixM4uQXKFnbFGiYk1nyPnzU=;
 b=XOKSq01A2a89ovN6vnYsZ0As4GBj9ohZjrthGl+aHcjtxg5gzcfhH4uB7r72FtVVLaUy7S
 JEkkdzkwGFlo9+MMSuMUvqaqIk+NnBnMJh50ik9eB1CC5fdME/vOtCnGzjPCg3sgaLU5ov
 FyrVjGEbzvL6BMxVnRouImQyQRS5pPw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-9Q4sHa_HNxuAuY_6Gfqf5A-1; Sat, 31 Oct 2020 10:33:45 -0400
X-MC-Unique: 9Q4sHa_HNxuAuY_6Gfqf5A-1
Received: by mail-wr1-f71.google.com with SMTP id h8so4081865wrt.9
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 07:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bXqFmbfOPVOhXOdRVT0vixM4uQXKFnbFGiYk1nyPnzU=;
 b=SK5hO06n5a5rVfV19Jvit6hnkmCus2KWNdcPQYSRPFxJqq8taFiNRqs3pBeHDYMUVd
 KCyfNdlCCq87OBncWn2xvPxa1Lok8OwMqubPZyOPJIAvi6Un/EysaI/roKaXAQT13K0Q
 MVc9PJGetxiA1lD+G6mqRZQKfdXuszcYPDAOA6/aLDoHoxw5AYfzSyrbrBgi4NrGNqKx
 SDKYBFzL/oonWk7Vu9tuBkKQl1HP6CRCXCZ7hOoNOngRSth86URj7sehhX9kvlzFO3ll
 nShxoW0J00p4VbzOf67ItCT5lFi4we/sQUHIEKU/yVpmxHaACsGSnKwbSMXryQgk+Yx1
 gd2Q==
X-Gm-Message-State: AOAM530YKi2Q+XAVHkFIsfQGXqhecG6ZTAOqst/wz85LAzb9L+uol/v8
 uiO2H87aoJnQosKHB17urQ3nRQvFpAb/cfugJKMDjHPAalEUTXf6c6lc5UO7wsRJRmD8e09w3Qd
 HSjXkYnbqQLcCvxo=
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr8100005wmd.1.1604154824422; 
 Sat, 31 Oct 2020 07:33:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyme+NWs4UW32x5CxU+CKUsQiDfm4fJH13wsvs1vAgDnki2KciLze4eNQ0ezzt0tpSg1MLidA==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr8099991wmd.1.1604154824251; 
 Sat, 31 Oct 2020 07:33:44 -0700 (PDT)
Received: from [192.168.178.64] ([151.20.250.56])
 by smtp.gmail.com with ESMTPSA id b7sm14070395wrp.16.2020.10.31.07.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2020 07:33:43 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: Introduce ioeventfd read support
To: Amey Narkhede <ameynarkhede03@gmail.com>, qemu-devel@nongnu.org
References: <20201020170056.433528-1-ameynarkhede03@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8014bc56-78fd-47f5-e62c-b8f6444f45bc@redhat.com>
Date: Sat, 31 Oct 2020 15:33:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020170056.433528-1-ameynarkhede03@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 08:00:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.257, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/10/20 19:00, Amey Narkhede wrote:
> The first patch updates linux headers to
> add ioeventfd read support while the
> second patch can be used to test the
> ioeventfd read feature with kvm-unit-test
> which reads from specified guest addres.
> Make sure the address provided in
> kvm_set_ioeventfd_read matches with address
> in x86/ioeventfd_read test in kvm-unit-tests.
> 
> Amey Narkhede (2):
>   linux-headers: Add support for reads in ioeventfd
>   kvm: Add ioeventfd read test code
> 
>  accel/kvm/kvm-all.c       | 55 +++++++++++++++++++++++++++++++++++++++
>  linux-headers/linux/kvm.h |  5 +++-
>  2 files changed, 59 insertions(+), 1 deletion(-)
> 

Hi,

in what occasions is this useful?

Paolo


