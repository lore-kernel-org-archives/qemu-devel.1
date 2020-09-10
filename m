Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42148C07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1572087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M44aQBwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1572087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOY3-0007J3-Q2
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOW1-0005Sy-Fv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:29:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOVz-0000Ny-3I
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599751772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MwlAn70AQVtVSioTjfjmSDS2U0/7ENDnKe27+112gjw=;
 b=M44aQBwagSP2Ef6prKxD05O4D1auaHXYIw/AC8T3QfpZpGH7GqWfrwk4nRMphxEURRbL94
 GxENfhCyrBNMj3Ks5q6ktckBkXX30mgsTXtDWD6B6/IeW0ImtELoIGrKdZ5ft9emqB+lho
 GRVwSblFjqSRwFDpOSyRrdYj9ovJCfQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-hWjEyMrmNCyIFBfLSVEX5Q-1; Thu, 10 Sep 2020 11:29:28 -0400
X-MC-Unique: hWjEyMrmNCyIFBfLSVEX5Q-1
Received: by mail-wr1-f69.google.com with SMTP id v12so2387790wrm.9
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QTEzDGyA/qThFrA3Z2TsOFnNne8sRv45PPaHlrlTdYQ=;
 b=dU2p72gAg5AzjZ43bwr3mporpyTNSFpLao1W8uTbokYP+s+Yn7qcY1LI3bbiWMjTRu
 Hr480IITqA+i3ShXC9dNtVSnaIRfWmhQMdUQq2JkL6oodO6wQnc8w6epmqfitxttaHSn
 glYjZlkIhZwHkWgpUCndACDKokhm8vH23aD8qejfI2qdxAwAmDvnAxb8ETQaC5KZFEBa
 l2WJxoVJPRgSN3aY2hvCcqcp6tLbPUOtCn3r/2iGN5VJP9NaoaK6EDQAS1Igsy+ralPO
 Vi2zn9QaBo9u/uBttiAPPyuQdiZBM/pB69r+j5QXCU8gQmyWEWopMm9YuO5WUKqS+ewU
 6/NA==
X-Gm-Message-State: AOAM530YHveg7USua5VSOpbQ8ecBmsxjxGc8aXyDlneBgKddR7JILHhV
 9DNtJgOf/kO8QIVrp5NX2d8igLs8E8zqXDm0aK8jCZjOq3qiPf2j06rvUkRL8NwwKdg9BJHJfE+
 uQl29LkUfTanxFFs=
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr9523451wrw.348.1599751767327; 
 Thu, 10 Sep 2020 08:29:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs8UCz/lSW68XpV86c3iPqdKNJ3VQCPgRYH1pPoS/wer0nvRJ8jjdObyuCWnfbVVe4YCIqNg==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr9523419wrw.348.1599751767102; 
 Thu, 10 Sep 2020 08:29:27 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id p18sm9278524wrx.47.2020.09.10.08.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 08:29:26 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20200909142354.334859-1-philmd@redhat.com>
 <20200909142354.334859-4-philmd@redhat.com>
 <20200910104435.GA45048@stefanha-x1.localdomain>
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
Message-ID: <4df84b90-68f6-7d69-024a-30ab2af5cc7e@redhat.com>
Date: Thu, 10 Sep 2020 17:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910104435.GA45048@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan, Alex.

On 9/10/20 12:44 PM, Stefan Hajnoczi wrote:
> On Wed, Sep 09, 2020 at 04:23:53PM +0200, Philippe Mathieu-Daudé wrote:
>> +/**
>> + * Initialize device MSIX IRQs and register event notifiers.
>> + * @irq_count: pointer to number of MSIX IRQs to initialize
>> + * @notifier: Array of @irq_count notifiers (each corresponding to a MSIX IRQ)
>> +
>> + * If the number of IRQs requested exceeds the available on the device,
>> + * store the number of available IRQs in @irq_count and return -EOVERFLOW.
>> + */
>> +int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *notifier,
>> +                                 unsigned *irq_count, Error **errp)
>> +{
>> +    int r;
>> +    size_t irq_set_size;
>> +    struct vfio_irq_set *irq_set;
>> +    struct vfio_irq_info irq_info = {
>> +        .argsz = sizeof(irq_info),
>> +        .index = VFIO_PCI_MSIX_IRQ_INDEX
>> +    };
>> +
>> +    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
>> +        error_setg_errno(errp, errno, "Failed to get device interrupt info");
>> +        return -errno;
>> +    }
>> +    if (irq_info.count < *irq_count) {
>> +        error_setg(errp, "Not enough device interrupts available");
>> +        *irq_count = irq_info.count;
>> +        return -EOVERFLOW;
>> +    }
>> +    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
>> +        error_setg(errp, "Device interrupt doesn't support eventfd");
>> +        return -EINVAL;
>> +    }
>> +
>> +    irq_set_size = sizeof(*irq_set) + *irq_count * sizeof(int32_t);
>> +    irq_set = g_malloc0(irq_set_size);
>> +
>> +    /* Get to a known IRQ state */
>> +    *irq_set = (struct vfio_irq_set) {
>> +        .argsz = irq_set_size,
>> +        .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
>> +        .index = irq_info.index,
>> +        .start = 0,
>> +        .count = *irq_count,
>> +    };
>> +
>> +    for (unsigned i = 0; i < *irq_count; i++) {
>> +        ((int32_t *)&irq_set->data)[i] = event_notifier_get_fd(&notifier[i]);
>> +    }
>> +    r = ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
>> +    g_free(irq_set);
>> +    if (r <= 0) {
>> +        error_setg_errno(errp, errno, "Failed to setup device interrupts");
>> +        return -errno;
>> +    } else if (r < *irq_count) {
>> +        error_setg(errp, "Not enough device interrupts available");
>> +        *irq_count = r;
>> +        return -EOVERFLOW;
>> +    }
> 
> EOVERFLOW can occur in two cases: VFIO_DEVICE_GET_IRQ_INFO and
> VFIO_DEVICE_SET_IRQS.

Yes.

> 
> If it happens in the second case the notifier[] array has been
> registered successfully.

No, I don't think so:

vfio_pci_set_msi_trigger() register the notifier only if
vfio_msi_enable() succeeded (returned 0). If vfio_msi_enable()
failed it returns the number of vectors available but do
not register the notifiers.

Alex, do you confirm?

> 
> The caller has no way of distinguishing the two cases. Therefore the
> caller doesn't know if the eventfds will be used by the kernel after
> EOVERFLOW.
> 
> If the second case can ever happen then this function should probably
> call VFIO_DEVICE_SET_IRQS again with VFIO_IRQ_SET_DATA_NONE to
> unregister the eventfds before returning EOVERFLOW.
> 
> STefan
> 


