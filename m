Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF9FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12E92236F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuxAMYho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12E92236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGy6-0002QG-F8
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaGxN-0001es-Aa
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaGxL-0001mT-OE
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604489278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lalScLFIO8oj7wPwMGuu3i31sDP/fLpN35bkKRc5rK0=;
 b=HuxAMYhoKbTFKtLHGv0lkHdx2LhHiVa1uthNt/vJrnqPLAIjG8xAh2svHbT8+ENUvJ/vLC
 MJ5/UuRLomwTC2i97E5KTIJYYtOaaXZndem9KaCGvKuDz49SBf52ZfwoG7e9ivMK0QoYdG
 jCYuxFdcfscmCeGwHl3O1Khl6IHPKFw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-kI1_XEJBMIK2O4lAzXSQSQ-1; Wed, 04 Nov 2020 06:27:57 -0500
X-MC-Unique: kI1_XEJBMIK2O4lAzXSQSQ-1
Received: by mail-wr1-f69.google.com with SMTP id t11so9166122wrv.10
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lalScLFIO8oj7wPwMGuu3i31sDP/fLpN35bkKRc5rK0=;
 b=prwiDeLO8mRB2K9AsnDwgAyrMLrIK4O5IzrwZqnmF8yPMTgtfrrS0+5EBR7erswf3+
 TDe65Kt5FsHrkKcnrNM47rJFQxannxQeNx0WBLdo0+OPXfusKL3SHs0Zju/olkc+mZYd
 L/CNDYrifTK1G+LQU0ovtZhfiAdzbkxkgsk3/zO1f9i7t+POIgyjWRdjIlLEtEQPEMeW
 WRaU1flWlT7S2o27BFAy7iDYLFRiLTjTLDiCOS4+6RUmXOFTNTmF0Q+JVCb7VlzmdhNh
 QO/81K24eQx/ukpdFPm0jejNP3G5tMtjnhQVVIa0lHQbGm8TWpFbEu7HXYA4ruhgNr0h
 icSA==
X-Gm-Message-State: AOAM532Hj9qYAmn4yrZ8LG3jdP1XTboFPdSNWkTkFJR9nKg1vu/Yiola
 d2AmNm46ctUcNnb+3TB9HWUQIJPzAv9A5VLR3+baS8J6kfVKTCF6PtPjguqTtWsc6mRhuz7SfRm
 o+HAwf5jz9m+xlS0=
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr4058889wme.0.1604489275758; 
 Wed, 04 Nov 2020 03:27:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwg15wfrgT+BshmOIwYfW74zEUfdWPrZdp2kXjj06rz+9QjqdURBX/mJbdLlVqTsjM/n0UQOg==
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr4058876wme.0.1604489275593; 
 Wed, 04 Nov 2020 03:27:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id l16sm2008678wrr.83.2020.11.04.03.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 03:27:54 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v2 2/4] hw/9pfs: Fix Kconfig dependency problem
 between 9pfs and Xen
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201104084327.3010593-1-philmd@redhat.com>
 <20201104084327.3010593-3-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7049dab1-5b94-6011-6501-609f32414edf@redhat.com>
Date: Wed, 4 Nov 2020 12:27:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104084327.3010593-3-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/20 09:43, Philippe Mathieu-Daudé wrote:
> Fixes './configure --without-default-devices --enable-xen' build:
> 
>    /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function `xen_be_register_common':
>    hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
>    /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to `local_ops'
>    /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference to `synth_ops'
>    /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference to `proxy_ops'
>    collect2: error: ld returned 1 exit status
> 
> Fixes: b2c00bce54c ("meson: convert hw/9pfs, cleanup")
> Suggested-by: Paolo Bonzini<pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@redhat.com>
> ---
> I'm not sure b2c00bce54c is the real culprit

I think it is, probably a wrong conflict resolution.

Paolo


