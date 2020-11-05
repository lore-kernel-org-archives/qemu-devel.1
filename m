Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891EEC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E275820715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWM9IDo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E275820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafjW-0004If-Lg
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kafhh-0002yQ-CD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kafhf-0007z2-1f
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604584405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NS/7EbhAgUiSrlkSSDm68n75kdNUig11iX7y/60DmfA=;
 b=fWM9IDo/mLB9ekxludRe4XO/tg/wHE88iBfkL5sAoUoJx4eumhOhg+8mMO0Ix4pP9dd4rL
 qhUagGeqMvX8VmVGOMyHpV2Zgct/OB2ZoQP/8KLaZ3sJVUA4ln0PH+n7siRrJ2DSmVNQRk
 LsV9LpDyk5GSvcZF/lXlNjWoeGQc1JU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-Ggo8Gs8POpy41bQiEeEQFw-1; Thu, 05 Nov 2020 08:53:20 -0500
X-MC-Unique: Ggo8Gs8POpy41bQiEeEQFw-1
Received: by mail-wr1-f71.google.com with SMTP id r16so721618wrw.22
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 05:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NS/7EbhAgUiSrlkSSDm68n75kdNUig11iX7y/60DmfA=;
 b=SdzHLvitid4vC4DEn0HkhzeN6EgotBHuGuT+dDwkUdG/d5Cq0hxB0PJpyDdd1+sZW7
 7n6uR1dtdBEXmEoBpTomNIukZm/QunTf9SO7pmM3hEtlRrILjY/mt2xDzkz1JE1cD5PL
 r38nq4+3Fr5nR5/2XjA5y/4ZOm1/p/r/w0QycEz4CdtquUy9INr/lgDho1mx29VMoc2U
 w8f30G1PqrCQYMSc6uDRD8PCPPlIGgPJiFoHfd9LurppnS8bTHnVlQvApfzkySbfECPf
 nuxOjjR7XV5jXso4y1kQbEFqsG6JVFPtvQG41ykZG/M9wHT2UAkXw5hXYX2pzL5E9Bhm
 f6iQ==
X-Gm-Message-State: AOAM530T1xakYetdDdA8eh93xmklqZPZ1A9geUjKh1IvEoawmKJbTUDx
 ViElDw3XSJTdzMBfhIlbB1ZoPR7cmUSwXNzuJ2JG1D9y1dneOgOkevKMeJ0OqoDO8D3T+Lfe064
 L+lQa6OgA/d/VVZY=
X-Received: by 2002:adf:e351:: with SMTP id n17mr3168788wrj.308.1604584399570; 
 Thu, 05 Nov 2020 05:53:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXADJ/MAAkE6SQIIha1SyyISYhFvYK91OT+byHI9QFyCu6YuPVOnyPW9Utafp3I7+ACa85MQ==
X-Received: by 2002:adf:e351:: with SMTP id n17mr3168738wrj.308.1604584399197; 
 Thu, 05 Nov 2020 05:53:19 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b1sm2954583wmd.43.2020.11.05.05.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 05:53:18 -0800 (PST)
Subject: Re: [PATCH-for-6.0 1/3] hw/virtio: Add configure switch to disable
 legacy VIRTIO
To: Cornelia Huck <cohuck@redhat.com>
References: <20201105124353.3680057-1-philmd@redhat.com>
 <20201105124353.3680057-2-philmd@redhat.com>
 <20201105140652.6c975b9e.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <142c7112-a24f-5349-8969-20c84aee013e@redhat.com>
Date: Thu, 5 Nov 2020 14:53:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105140652.6c975b9e.cohuck@redhat.com>
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 2:06 PM, Cornelia Huck wrote:
> On Thu,  5 Nov 2020 13:43:51 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Per [1] (Terminology):
>>
>>   Legacy interfaces are not required; ie. don’t implement them
>>   unless you have a need for backwards compatibility!
>>
>> [2] (Version 1.0):
>>
>>   The device configuration space uses the little-endian format
>>   for multi-byte fields.
>>
>> and [3] (Legacy Interface):
>>
>>   for legacy interfaces, device configuration space is generally
>>   the guest’s native endian, rather than PCI’s little-endian.
>>   The correct endian-ness is documented for each device.
>>
>> Add the --disable-virtio-legacy configure flag to produce builds
>> with VIRTIO 1.0 only, and the --enable-virtio-legacy to include
>> legacy VIRTIO support (supporting legacy VIRTIO is the default).
> 
> This is only dealing with endianess issues; there are other differences
> on the control plane as well.
> 
> Currently, virtio-pci has the option to make devices non-transitional,
> but virtio-ccw has not (only for device types). For virtio-mmio, you
> need to select one of legacy or non-transitional, IIRC.
> 
>>
>> [1] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-60001
>> [2] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-170003
>> [3] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-200003
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  configure                         | 10 ++++++++++
>>  meson.build                       |  1 +
>>  include/hw/virtio/virtio-access.h | 19 +++++--------------
>>  hw/virtio/virtio-legacy.c         | 29 +++++++++++++++++++++++++++++
>>  hw/virtio/meson.build             |  1 +
>>  5 files changed, 46 insertions(+), 14 deletions(-)
>>  create mode 100644 hw/virtio/virtio-legacy.c
> 
> (...)
> 
>> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
>> index 6818a23a2d3..b6c060f8cc6 100644
>> --- a/include/hw/virtio/virtio-access.h
>> +++ b/include/hw/virtio/virtio-access.h
>> @@ -20,24 +20,15 @@
>>  #include "hw/virtio/virtio.h"
>>  #include "hw/virtio/virtio-bus.h"
>>  
>> -#if defined(TARGET_PPC64) || defined(TARGET_ARM)
>> -#define LEGACY_VIRTIO_IS_BIENDIAN 1
>> -#endif
>> -
>> +#ifdef CONFIG_VIRTIO_LEGACY
>> +bool virtio_access_is_big_endian(VirtIODevice *vdev);
>> +#else
>>  static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>>  {
>> -#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
>> -    return virtio_is_big_endian(vdev);
>> -#elif defined(TARGET_WORDS_BIGENDIAN)
>> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>> -        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>> -        return false;
>> -    }
>> -    return true;
>> -#else
>> +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>>      return false;
> 
> This will make migration from a QEMU that has devices for which 1.0 has
> not been negotiated fail.

Oh good point... Not as easy as I thought then :/
Now I'm seeing plenty of possible problems.

Commits 9b3a35ec823 & d55f518248f help a bit:
("virtio: verify that legacy support is not accidentally on")
("virtio: skip legacy support check on machine types less than 5.1")

Thanks for warning :)

> 
>> -#endif
>>  }
>> +#endif
>>  
>>  static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
>>  {
> 


