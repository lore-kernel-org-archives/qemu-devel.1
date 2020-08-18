Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16EDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E70C20658
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj7kjXQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E70C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k85ON-0001Sb-MH
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 13:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k85NQ-0000Cv-Hr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:26:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k85NM-0005ds-RU
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597771579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GqwaRX7PujwR5THL045bNdAKHmtacB6pSUOf6RFjkz8=;
 b=hj7kjXQKKIQk/b2sZedrGv0pw8QvLkw99q9xuHDMwNEpg9PuWDq9Wpwc0exyiZRLZRX/jv
 15hLOiRKt3kjX5ofRpd7F87b6YMvU8kKxlbh6RKvj7NvaxRbKtb9/qA0wPER6yXYh9wf1y
 3qJWxpQ6zP9tdQd+88K0JU6nju0BMhc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-iG2xfsGZPKm0Modc8NtSTQ-1; Tue, 18 Aug 2020 13:26:18 -0400
X-MC-Unique: iG2xfsGZPKm0Modc8NtSTQ-1
Received: by mail-wm1-f69.google.com with SMTP id h6so6360739wml.8
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 10:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GqwaRX7PujwR5THL045bNdAKHmtacB6pSUOf6RFjkz8=;
 b=sqnB1viMQz2RqtnjRGy0RJXA0vz8Aqe7FSkd2c/8llPhx0AQ73LIURt/kVMZt9C8sc
 bdursjfckb38Lwzj7BQ70BZIUEum7o2AbguSIuRnZ858lzQcP3+iaWxqIl3vrDaj9g/j
 mlj+Uqdx2cDPlwrlLqqnn7Ni6Y4qxiYoIoW3iMbw9fWwuiVV0qfpJLShQuyPotyaUapu
 bQwauvnZX27/cmCK4Nq/OfccRQmhyFrSRXA7elPo6gciM8T9mSfqM+fwl6LQbKB04bQN
 vnBd2qygro+0bIJCgUeSg6LIehmDeurmGhxtXwIWigWjeXxVelHUoLYFyIK14GExGTXU
 UoTg==
X-Gm-Message-State: AOAM530ydMm5ez2wRuEkIY7rl2xECvRueHdqLPRdwbBOlHibURaiUe3P
 sExrb2qTdJEdJBs95a19NnoJwOt9mMqaqBL7AEDyj6xmLw8Mx2Ig+W9bo/+/rs1yZaOZAR7ycjm
 W4RPQpWvuZhaiDdw=
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr21135965wrn.80.1597771577004; 
 Tue, 18 Aug 2020 10:26:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvg8WETzrjiC+H/96Mj0hWXRLP9KIALIJdDUw7OczzG6lorqX4H4BUDp8DB2jmhns1H2jymg==
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr21135944wrn.80.1597771576790; 
 Tue, 18 Aug 2020 10:26:16 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p6sm33934727wru.33.2020.08.18.10.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 10:26:15 -0700 (PDT)
Subject: Re: [RFC PATCH v3 2/5] util/vfio-helpers: Report error on unsupported
 host architectures
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200818164509.736367-1-philmd@redhat.com>
 <20200818164509.736367-3-philmd@redhat.com> <20200818111239.2f9b510c@x1.home>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <44c63656-8ef0-e179-78a3-f2607f02bd55@redhat.com>
Date: Tue, 18 Aug 2020 19:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818111239.2f9b510c@x1.home>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Drew Jones <drjones@redhat.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 7:12 PM, Alex Williamson wrote:
> On Tue, 18 Aug 2020 18:45:06 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> The vfio-helpers implementation expects a TYPEv1 IOMMU, see
>> qemu_vfio_init_pci:
>>
>>   263     if (!ioctl(s->container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
>>   264         error_setg_errno(errp, errno, "VFIO IOMMU check failed");
>>
>> Thus POWER SPAPR IOMMU is obviously not supported.
>>
>> The implementation only cares about host page size alignment
>> (usually 4KB on X86), not the IOMMU one, which is be problematic
>> on Aarch64, when 64MB page size is used. So Aarch64 is not
>> supported neither.
>>
>> Report an error when the host architecture is different than X86:
>>
>>  $ qemu-system-aarch64 \
>>     -drive file=nvme://0001:01:00.0/1,if=none,id=drive0 \
>>     -device virtio-blk-pci,drive=drive0
>>   qemu-system-aarch64: -drive file=nvme://0001:01:00.0/1,if=none,id=drive0: QEMU VFIO utility is not supported on this architecture
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Drew Jones <drjones@redhat.com>
>> Cc: Laurent Vivier <lvivier@redhat.com>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  util/vfio-helpers.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>> index e399e330e26..60017936e3e 100644
>> --- a/util/vfio-helpers.c
>> +++ b/util/vfio-helpers.c
>> @@ -420,14 +420,38 @@ static void qemu_vfio_open_common(QEMUVFIOState *s)
>>      qemu_ram_foreach_block(qemu_vfio_init_ramblock, s);
>>  }
>>  
>> +/**
>> + * Return if the host architecture is supported.
>> + *
>> + * aarch64: IOMMU page alignment not respected
>> + * ppc64:   SPAPR IOMMU window not configured
>> + * x86-64:  Only architecture validated
>> + * other:   Untested
>> + */
>> +static bool qemu_vfio_arch_supported(void)
>> +{
>> +    bool supported = false;
>> +
>> +#if defined(HOST_X86_64)
>> +    supported = true;
>> +#endif
>> +
>> +    return supported;
>> +}
> 
> Why does this need to be hard coded to specific architectures rather
> than probing for type1 IOMMU support and looking at the iova_pgsizes
> from VFIO_IOMMU_GET_INFO to see if there's a compatible size?  It
> requires us to get a bit deeper into the device initialization, but we
> should still be able to unwind out of the device realize.  Otherwise
> we're throwing out aarch64 running of 4KB for no reason, right?  Thanks,

Ah yes, much clever! Thanks Alex :)

> 
> Alex
> 
> 
>>  /**
>>   * Open a PCI device, e.g. "0000:00:01.0".
>>   */
>>  QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp)
>>  {
>>      int r;
>> -    QEMUVFIOState *s = g_new0(QEMUVFIOState, 1);
>> +    QEMUVFIOState *s;
>>  
>> +    if (!qemu_vfio_arch_supported()) {
>> +        error_setg(errp,
>> +                   "QEMU VFIO utility is not supported on this architecture");
>> +        return NULL;
>> +    }
>> +    s = g_new0(QEMUVFIOState, 1);
>>      r = qemu_vfio_init_pci(s, device, errp);
>>      if (r) {
>>          g_free(s);
> 


