Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFCEC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8414C20729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNXbjRvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8414C20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaeCG-00071s-Gg
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaeBW-0006b8-8W
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:16:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaeBU-00005d-Lx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604578567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9ICR1yXh3FG7V16PL+z404rlhj3Yi3iLJ9NPtGdMTA=;
 b=HNXbjRvBm2PZQUoTJbpCl/j6XtM1CDquYN77cHfp7O9Gg8p3e6yQlTVxv+G1BULyheZs3u
 Cj8HPtqVLevgGJY8u968ZMXAcCTnJOPlGaI35QmZESS1+JJq+tAcBX28E82WmTjdTcbqwA
 MAYrVKctFEQhWgDflM2uBd2j8RSLHHg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-yZLlIu-GMvOGnSRt1-DN1g-1; Thu, 05 Nov 2020 07:16:04 -0500
X-MC-Unique: yZLlIu-GMvOGnSRt1-DN1g-1
Received: by mail-wm1-f72.google.com with SMTP id u207so547230wmu.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M9ICR1yXh3FG7V16PL+z404rlhj3Yi3iLJ9NPtGdMTA=;
 b=e51MjDUW/CLBUz3cKXVHWuSTxFG8L0NtkLArXrDTFMgdmLKYoYUjt7f4dxeyh8jal+
 1WLOTFr5qGFjP2jADBM59XAAG8rqpwSBSpCk+FFqboOaJLRTDwjZdHRTkcuCtVI2jH3z
 FWAx7p+pW5DyadzudRlHl+1tN2KqHFqkyeYMtmSazEsfP2tYgCSG5DD+CLFmEm9Y8K7Y
 9zJv2UEbIOWzDqIdkqpXa8WuQozh1s7bA/lBfMnqYMH/UiUlLeTscSJWassWsY1DBqYA
 DhqWpN4GYKClF34C3WcG3aAb91e/8adrQUXp5cnBLcOg/lm6ijAndNbz+YLJGfhe4WTb
 aBlQ==
X-Gm-Message-State: AOAM530TkM84j0KqtdnGwODG6+3konn+oibRwBMGIbTjpvPmNsyjPriG
 PwvTEKWuad6JrW8mtC/o8htoz3PoqjVkOCd7sVu2bZpzG0O25lhwlpylVQMju2MwvG+mllFQVea
 gWQ53m7ATK7BoQxI=
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr2406933wmj.101.1604578563126; 
 Thu, 05 Nov 2020 04:16:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUna/uTT3GoKmJffb5+QYG325EJWzeGaJI9YrtAx/wl8yEiUHnt1PCFQCITOvfdErMIV251g==
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr2406887wmj.101.1604578562777; 
 Thu, 05 Nov 2020 04:16:02 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 89sm2413628wrp.58.2020.11.05.04.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 04:16:01 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v3 2/4] hw/9pfs: Fix Kconfig dependency problem
 between 9pfs and Xen
To: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <20201104115706.3101190-1-philmd@redhat.com>
 <20201104115706.3101190-3-philmd@redhat.com> <8965407.pN9RvXrJQ9@silver>
 <20201104185439.41e9ddb3@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <17370310-d69c-91ff-763d-52a1355ad605@redhat.com>
Date: Thu, 5 Nov 2020 13:15:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104185439.41e9ddb3@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 6:54 PM, Greg Kurz wrote:
> On Wed, 04 Nov 2020 13:18:09 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
>> On Mittwoch, 4. November 2020 12:57:04 CET Philippe Mathieu-Daudé wrote:
>>> Commit b2c00bce54c ("meson: convert hw/9pfs, cleanup") introduced
>>> CONFIG_9PFS (probably a wrong conflict resolution). This config is
>>> not used anywhere. Backends depend on CONFIG_FSDEV_9P which itself
>>> depends on CONFIG_VIRTFS.
>>>
>>> Remove the invalid CONFIG_9PFS and use CONFIG_FSDEV_9P instead, to
>>> fix the './configure --without-default-devices --enable-xen' build:
>>>
>>>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function
>>> `xen_be_register_common': hw/xen/xen-legacy-backend.c:754: undefined
>>> reference to `xen_9pfs_ops' /usr/bin/ld:
>>> libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to
>>> `local_ops' /usr/bin/ld:
>>> libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference
>>> to `synth_ops' /usr/bin/ld:
>>> libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference
>>> to `proxy_ops' collect2: error: ld returned 1 exit status
>>>
>>> Fixes: b2c00bce54c ("meson: convert hw/9pfs, cleanup")
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Acked-by: Greg Kurz <groug@kaod.org>
>>> Tested-by: Greg Kurz <groug@kaod.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>
> 
> Phil,
> 
> Same questioning as Connie. Do you intend to get this merged or should
> Christian or I take care of that ?

Same answer too =) If you are preparing a pull request, please go ahead!

Thanks,

Phil.


