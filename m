Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD73C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46161208B6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhYtH7zG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46161208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuBT-0001YP-Ty
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuAu-00017F-Mw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuAr-0008Mi-Fb
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604401704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmFoDvDxGzq4o2haZ3bo/6fk2so4trGq3ZGmd2FNyPI=;
 b=LhYtH7zG0L4wuqNj43lsq3BPW0CQG9oKfaQYOY2rsAXYl1JefwkYOlcpvIXMeNv7CQ5HXd
 odezUiOeeX3a3j36L2HJtXsq0RR0QYnKRKdVFSM7zUerRMoUvaBbUHhhRxsqbOVKDKOS/w
 aGRGxnfL91NY3tPOr6eO97SB/p9Y5y4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-xTS5tZX7Mpyn9kncu3cdJg-1; Tue, 03 Nov 2020 06:08:23 -0500
X-MC-Unique: xTS5tZX7Mpyn9kncu3cdJg-1
Received: by mail-wm1-f72.google.com with SMTP id o81so1461870wma.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cmFoDvDxGzq4o2haZ3bo/6fk2so4trGq3ZGmd2FNyPI=;
 b=b+zJEY2zBNjwDnTnLHrO6r/Kehycn//CBxXNtV5RX+vjD728OQuzuplffxGiVOthzP
 SzQGdZ2BUhASlJUicdzj9M7fZW98mLRcilbGwC4gUJhZ6gMg5NWkoglurKq2QpSqX9uy
 +TP1yobyFGlre4k8kDuS+gz97gjrIerjdmjOv4tTLJjXrg/OIw6//APAX6YRXq9F6gaH
 fWgOEKVlkfbtDN/zuRHztoQ+P4KsWQ1TrUrsw6uLXw5uuzIutNYqzU6JZvu/tuVWg2OH
 fRnBfj/6HOQpqa6d4dSBVUc4tsl+Nz7p6Zr7+Vit9Rohf7ad7LXVRH9bvULunU/Cr+Ii
 rIhw==
X-Gm-Message-State: AOAM5325pePUfxHJc7ORPmuRWxwSJNxw9nGQpr2rEUE+DAsUMxdQRQeJ
 ppGY0FZoX1e3WPY0fImvq8g1N0l3sOwbmYmm+f5Ocqze4+j/ysexyxI6QgB3/TiIY85chr8koBT
 GyB/JbF1273f1A7A=
X-Received: by 2002:adf:e942:: with SMTP id m2mr25245099wrn.123.1604401701988; 
 Tue, 03 Nov 2020 03:08:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4LrON9dKjEyiOujNZZrpiIYVpH7p/RQqoq4qae2ht+xwYXzy8CCFqcPcUS2aiRtuG/6F6JQ==
X-Received: by 2002:adf:e942:: with SMTP id m2mr25245078wrn.123.1604401701806; 
 Tue, 03 Nov 2020 03:08:21 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m8sm25258174wrw.17.2020.11.03.03.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 03:08:21 -0800 (PST)
Subject: Re: [PULL v3 23/32] s390x/pci: Add routine to get the vfio dma
 available count
To: Cornelia Huck <cohuck@redhat.com>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
 <160426454077.24886.1574050205264167707.stgit@gimli.home>
 <85a0a8e1-1081-12c8-c37b-4a7e919b421a@redhat.com>
 <20201103114513.6909502c.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d6befc5-0516-5ff0-7498-0f4deca92738@redhat.com>
Date: Tue, 3 Nov 2020 12:08:20 +0100
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

With your change:

hw/s390x/s390-pci-bus.c:1079: undefined reference to
`s390_pci_end_dma_count'
hw/s390x/s390-pci-bus.c:1019: undefined reference to
`s390_pci_start_dma_count'
hw/s390x/s390-pci-bus.c:1021: undefined reference to `s390_pci_get_clp_info'

Do we need stubs instead?


