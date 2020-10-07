Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257A5C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510C0206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNN1GqXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510C0206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ403-0005Or-3x
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 03:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ3z5-0004da-Dg
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ3z1-0002uF-SW
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602056129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ca/p2ZhO8Ysd4U+qHMxJRMC1tWokUm/TueisztofumM=;
 b=fNN1GqXIJrG5Gt0KTWG/WzWuoGuESE/Z5Xbj8SYxrSRARcKPDwM53OUtOMPlqilVsd0qCH
 f7KZ1sMdrjwNUL4cbB+NVBL2FNtRPak1RAamJSVhfR0Ky4g16gqWXah5Rm6vQbzwdS3ISH
 74XYCchbmZk2t9nyq7IsBWrNKaBIkKE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-_vWxryNDMcSQ9bgnL2Bkuw-1; Wed, 07 Oct 2020 03:35:28 -0400
X-MC-Unique: _vWxryNDMcSQ9bgnL2Bkuw-1
Received: by mail-wm1-f72.google.com with SMTP id 13so220934wmf.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 00:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ca/p2ZhO8Ysd4U+qHMxJRMC1tWokUm/TueisztofumM=;
 b=DU4YRTz7sz0uJYfjzKikCXQy8rH4uKHM6lfllyXCbbVUf3jjMT8zfOIzK5X736/nVK
 ZCEOKUAcSOHs+NY0+TRWARadNqoWRmhWzKpE++Ak7n3rhoYaRPfTzD2I4ZjF5skEKK7K
 LVMW58lgWfsi77RcdatSXjwgsHncb5nQGAWd0LwOn1yvmOFdn2H9nNhjZn7O6KXmrW9o
 ij5XrTtXOYo2D7bPQRtWxmuT6XyyNoVoKkHDk5iJBsw2ewqj7lcbAJwuau0RywFcJtMJ
 o9d3S0MZuTyEDzsaQp20u+W7DE7t9NGIUH11XDIbJiU0JfSrm1hAcMr7yE2Dv2383+jM
 QwOw==
X-Gm-Message-State: AOAM530cz3t3pPLXf6edxV2RBsKcD7e3nIfAirr/AAlYUSJKuBB4vn/z
 DwI8O0B7Kf+m/PGJUmb37VLT32Xedc6VxEsh9mKo2lHMzUak7D9QQEi0cPqPXpEsf9kFVX+xy3d
 XJUPWh6WtZS70Pcg=
X-Received: by 2002:a1c:152:: with SMTP id 79mr1780781wmb.90.1602056127107;
 Wed, 07 Oct 2020 00:35:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyav6MjH305d11GWO15adQpuSkcTWmJgU+kPXFFIxX6xnjHwRnw+7hSyu74oyLQK72jnLidJA==
X-Received: by 2002:a1c:152:: with SMTP id 79mr1780758wmb.90.1602056126828;
 Wed, 07 Oct 2020 00:35:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff?
 ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
 by smtp.gmail.com with ESMTPSA id o186sm1495383wmb.12.2020.10.07.00.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 00:35:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] s390x/pci: Move header files to include/hw/s390x
To: Richard Henderson <rth@twiddle.net>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <1601669191-6731-1-git-send-email-mjrosato@linux.ibm.com>
 <1601669191-6731-2-git-send-email-mjrosato@linux.ibm.com>
 <20201006173259.1ec36597.cohuck@redhat.com>
 <e9f6c3e1-9341-b0d0-9fb2-b34ebd19bcba@linux.ibm.com>
 <1c118c1d-8c9b-9b7b-d1ec-2080aaa1c1a3@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e5c775d-76e1-dee4-56ee-8e8ebee1676f@redhat.com>
Date: Wed, 7 Oct 2020 09:35:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1c118c1d-8c9b-9b7b-d1ec-2080aaa1c1a3@twiddle.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 19:33, Richard Henderson wrote:
> On 10/6/20 11:43 AM, Matthew Rosato wrote:
>>> Looks good, but...
>>>
>>> <meta>Is there any way to coax out a more reviewable version of this
>>> via git mv?</meta>
>>>
>>
>> I tried git mv, but a diff between the old patch and the new patch looks the
>> same (other than the fact that I squashed the MAINTAINERS hit in)
> 
> git format-patch --find-renames[=<pct>]
> 
> Though I'm surprised it's not doing that by default.

Yeah, diff.renames should default to true.  But you can try

git config --global diff.renames true

and if it fails

git config diff.renames true

Paolo


