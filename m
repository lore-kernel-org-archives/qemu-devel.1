Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB86C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA70223BD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P46BmMVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA70223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZu26-0006U5-GG
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZu0j-0005RN-J9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:57:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZu0h-0004Mr-0s
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604401072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pP8C1ZlSa0KjjTyiEjPGDy4d+tsD9qsIx3Il97IDeo=;
 b=P46BmMVBdC6/bQylt/DghPo3P9EPvlaU+URtBtGWKeCHA3AEKk+Ndp86E16wgGb0KnDceT
 LcsB7pPg6ZZpYEhJELw2al8znDymeFmvlgr8M0BdFxXh3aPB+V9bJgWNsJqipwNHwCnRjz
 kti4TcUldwXmxTNpxO8ejNjpyUajlss=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-ZJtL4Ir7NQSRksTUtV7Pxg-1; Tue, 03 Nov 2020 05:57:51 -0500
X-MC-Unique: ZJtL4Ir7NQSRksTUtV7Pxg-1
Received: by mail-wr1-f72.google.com with SMTP id e11so169505wrw.14
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 02:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7pP8C1ZlSa0KjjTyiEjPGDy4d+tsD9qsIx3Il97IDeo=;
 b=FuETa69rKj8/9tYpjHSTDPRT/m2N2CRdHvx1rvnlMaxgsh/Hp65Puxj5c+aP2NrbJJ
 mNrs+3fLe/Qf3K5N8FiO9EuiB1ObHm7mg3alOqXwPniw7B0kYCS3LShIWCj5yVFUhLLr
 xJ3y8+Am51dfTI7tf1cwvoaKrs1/qAoB3Zg/bkmKzWLAhAIafmitfzqulX312cnQrm/N
 fnCzmaum//24gYnX2VBCcg403/82iXejMrpa8c6Euso5yWgKiNtqbH49keQY3zmRjJXL
 AFy10qIwjCgg0PZ5Jn/nKHjZXwdlRMyFQ7U95FjyFs5omPMYPlmyWQ6ZYp2lAuFd3Tev
 zusg==
X-Gm-Message-State: AOAM533GbOcwbFQELIttSZiVy0DhfSscnIWRvLcWyFKkoc5oh8bU1Uoz
 T7AUCW23BLB9filvdy9nig58/OlKqngEQKucsr0rBpfTLN9oUB87ddickd6PM+ItfIo3hZKyEt7
 o2JKIrlBWmLIZ9GM=
X-Received: by 2002:adf:ce01:: with SMTP id p1mr24044456wrn.33.1604401069963; 
 Tue, 03 Nov 2020 02:57:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOO6Hpm1txRd8af5Dzw2UK2XtKQ6xKYjV9LZH34j5969fZR6XN4QKpLdAdzVfpVMH1voxtPw==
X-Received: by 2002:adf:ce01:: with SMTP id p1mr24044435wrn.33.1604401069725; 
 Tue, 03 Nov 2020 02:57:49 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y20sm2479122wma.15.2020.11.03.02.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 02:57:49 -0800 (PST)
Subject: Re: [PULL v3 23/32] s390x/pci: Add routine to get the vfio dma
 available count
To: Cornelia Huck <cohuck@redhat.com>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
 <160426454077.24886.1574050205264167707.stgit@gimli.home>
 <85a0a8e1-1081-12c8-c37b-4a7e919b421a@redhat.com>
 <20201103114513.6909502c.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a1d7a25e-e1a2-a2c9-49dd-85e49ed28b89@redhat.com>
Date: Tue, 3 Nov 2020 11:57:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103114513.6909502c.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 11:45 AM, Cornelia Huck wrote:
> On Tue, 3 Nov 2020 06:49:13 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Hi Matthew,
>>
>> On 11/1/20 10:02 PM, Alex Williamson wrote:
>>> From: Matthew Rosato <mjrosato@linux.ibm.com>
>>>
>>> Create new files for separating out vfio-specific work for s390
>>> pci. Add the first such routine, which issues VFIO_IOMMU_GET_INFO
>>> ioctl to collect the current dma available count.
>>>
>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> [aw: Fix non-Linux build with CONFIG_LINUX]
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>  hw/s390x/meson.build             |    1 +
>>>  hw/s390x/s390-pci-vfio.c         |   54 ++++++++++++++++++++++++++++++++++++++
>>>  include/hw/s390x/s390-pci-vfio.h |   24 +++++++++++++++++
>>>  3 files changed, 79 insertions(+)
>>>  create mode 100644 hw/s390x/s390-pci-vfio.c
>>>  create mode 100644 include/hw/s390x/s390-pci-vfio.h
>>>
>>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
>>> index 948ceae7a7b3..f4663a835514 100644
>>> --- a/hw/s390x/meson.build
>>> +++ b/hw/s390x/meson.build
>>> @@ -27,6 +27,7 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>>>  ))
>>>  s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
>>>  s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
>>> +s390x_ss.add(when: 'CONFIG_LINUX', if_true: files('s390-pci-vfio.c'))
> 
> I think we need s/CONFIG_LINUX/CONFIG_VFIO/ here.
> 
>>>  
>>>  virtio_ss = ss.source_set()
>>>  virtio_ss.add(files('virtio-ccw.c'))
>>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>>> new file mode 100644
>>> index 000000000000..cb3f4d98adf8
>>> --- /dev/null
>>> +++ b/hw/s390x/s390-pci-vfio.c
>>> @@ -0,0 +1,54 @@
>>> +/*
>>> + * s390 vfio-pci interfaces
>>> + *
>>> + * Copyright 2020 IBM Corp.
>>> + * Author(s): Matthew Rosato <mjrosato@linux.ibm.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>>> + * your option) any later version. See the COPYING file in the top-level
>>> + * directory.
>>> + */
>>> +
>>> +#include <sys/ioctl.h>
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/s390x/s390-pci-vfio.h"
>>> +#include "hw/vfio/vfio-common.h"
>>> +
>>> +/*
>>> + * Get the current DMA available count from vfio.  Returns true if vfio is
>>> + * limiting DMA requests, false otherwise.  The current available count read
>>> + * from vfio is returned in avail.
>>> + */
>>> +bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
>>> +{
>>> +    g_autofree struct vfio_iommu_type1_info *info;
>>> +    uint32_t argsz;
>>> +
>>> +    assert(avail);
>>> +
>>> +    argsz = sizeof(struct vfio_iommu_type1_info);
>>> +    info = g_malloc0(argsz);
>>> +
>>> +    /*
>>> +     * If the specified argsz is not large enough to contain all capabilities
>>> +     * it will be updated upon return from the ioctl.  Retry until we have
>>> +     * a big enough buffer to hold the entire capability chain.
>>> +     */
>>> +retry:
>>> +    info->argsz = argsz;
>>> +
>>> +    if (ioctl(fd, VFIO_IOMMU_GET_INFO, info)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    if (info->argsz > argsz) {
>>> +        argsz = info->argsz;
>>> +        info = g_realloc(info, argsz);
>>> +        goto retry;
>>> +    }
>>> +
>>> +    /* If the capability exists, update with the current value */
>>> +    return vfio_get_info_dma_avail(info, avail);
>>> +}  
>>
>> --without-default-devices configuration is broken, bisected
>> to this commit:
> 
> Hm. Is this run in any of the CI tests? I did not even realize it
> existed :)

Paolo added it to Travis-CI 22 months ago:

commit 20885b5b1697247038018f3a7dfe8a84adf1b8e9
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Jan 31 15:57:53 2019 +0100

    .travis.yml: test that no-default-device builds do not regress

    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index cca57f43148..e942175dd30 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -149,6 +149,12 @@ matrix:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh


+    # We manually include builds which we disable "make check" for
+    - env:
+        - CONFIG="--without-default-devices"
+        - TEST_CMD=""
+
+
     # We manually include builds which we disable "make check" for
     - env:
         - CONFIG="--enable-debug --enable-tcg-interpreter"
---

> 
>>
>> hw/s390x/s390-pci-vfio.c:52: undefined reference to
>> `vfio_get_info_dma_avail'
>>
>> Can you have a look please?
>>
>> Thanks.
>>
> 


