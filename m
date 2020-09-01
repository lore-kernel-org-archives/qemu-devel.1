Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F2C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68AA2078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+IC/Vmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68AA2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDK2-0002RR-PD
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 16:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDJ6-0001VF-Bh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 16:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDJ3-00081I-0K
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 16:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598993703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HwMBq4L31jb9hDXnrjyPO3sxiRNCcOtXm+rN5EL9+Vo=;
 b=Q+IC/VmrJ8xVa8zuiOBTbYTfYcHhxKOl7hsLZ8pgploWa5vk2Q05kCmDQkmwpBXdymKC4o
 pg4IHR6JR31yRazJ0aNyAF7RFRMyac6JrnCQqeZ0WjJz9EXPAIWNHZxzwvj8TS173evli7
 nrFheJf9w8iHGUQLTfAP2KNDgoAw5ZM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-FzOCGsl0NHGpTCMragAJJg-1; Tue, 01 Sep 2020 16:55:01 -0400
X-MC-Unique: FzOCGsl0NHGpTCMragAJJg-1
Received: by mail-qt1-f198.google.com with SMTP id q19so2000514qtp.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 13:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HwMBq4L31jb9hDXnrjyPO3sxiRNCcOtXm+rN5EL9+Vo=;
 b=B7idU4CsLvczFmKPm6AuISqqPAHMqMfGZFaNOxcXxh6xju1FGmxzEh+QQXNNW/MLB0
 hba1xrWvtnoSxyROwTsy+xD1P5ejCmB2CtGVRQa9xCDlewj6aONPigxFYwl6JitW/3SM
 9WFjKdNV7Mt17ZKqEuTaz4VsKsDsuX44TTIHaVA148Xt0gYv+r2LsWVM3WFp/+yjp5BR
 c6UcW/iUBol1/AxrQntEq/MlAawrH0bLSguuJxhLJNDI5+3ce71RqQyTvHoFraT/WQ1w
 yemFt81IHxkPH05Qo7JW1yuxRWcDmYdkFPbrSNbhnfyV+wTGBRAQQdc1xyXEDMCakfGD
 fxPA==
X-Gm-Message-State: AOAM5331RBcEZcAX+dsMXeDs4QHOj0zVW95boPyrC/hdwGW76/me2i+R
 s14OzeTgeTa/n2vI1YDHm1tDGurGloqFB5eMeAHPu3kDuLFvba0CjP7CCAWA4fBrrTwuJNgXNjj
 vFc0u1ywgXVjnlMU=
X-Received: by 2002:a37:87c2:: with SMTP id j185mr3908716qkd.458.1598993701391; 
 Tue, 01 Sep 2020 13:55:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysj2VTjkcnngC0hoPf1XCsScwP4HylPIU/zmsDcNq4ys7bHV/E+jiAV4q+ckNOl+BclVoZcg==
X-Received: by 2002:a37:87c2:: with SMTP id j185mr3908692qkd.458.1598993701166; 
 Tue, 01 Sep 2020 13:55:01 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id h17sm2956296qke.68.2020.09.01.13.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 13:55:00 -0700 (PDT)
Date: Tue, 1 Sep 2020 16:54:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v8 2/5] memory: Add IOMMUTLBEvent
Message-ID: <20200901205458.GD3053@xz-x1>
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200901142608.24481-3-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 16:44:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 04:26:05PM +0200, Eugenio Pérez wrote:
> This way we can tell between regulars IOMMURLBEntries (entry of IOMMU
> hardware) and notifications.

s/regulars IOMMURLBEntries/regular IOMMUTLBEntry/

> 
> In the notifications, we set explicitly if it is a MAPs or an UNMAP,
> instead of trusting in entry permissions to differenciate them.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

[...]

>  struct IOMMUTLBEntry {
> -    AddressSpace    *target_as;
> -    hwaddr           iova;
> -    hwaddr           translated_addr;
> -    hwaddr           addr_mask;  /* 0xfff = 4k translation */
> -    IOMMUAccessFlags perm;
> +    AddressSpace            *target_as;
> +    hwaddr                   iova;
> +    hwaddr                   translated_addr;
> +    hwaddr                   addr_mask;  /* 0xfff = 4k translation */
> +    IOMMUAccessFlags         perm;
>  };

If these lines are identical, then we can avoid touching the spaces.

With above changes, please feel free to add:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


