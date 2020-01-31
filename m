Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B6CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6FB20663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIBF00t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6FB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZ5D-0006IK-Ru
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ixZ4Q-0005Ae-7L
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ixZ4N-0000ab-P0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:23:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ixZ4N-0000Xw-GR
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580487777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZFpBhCvZISJe+C475dKAGLib+knausHF5/M5i22qww=;
 b=UIBF00t5UWJ9gKRWJCI+CsSdLFs4nUBJ92ROA7oSfPntgUAfrEqXfvvKAN9YBXciZ7Om/n
 ldvYmwh0/05xqs9ZEfvCFgur5v8PoUCQh9n5bPke8gMNoR53GOgETYfAbrMqOuMrR4fvnL
 5F2qEnecKWBl3cVIC85V2BP/nOkZZW8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-vhXr8FcYNn6CX50oqsnelw-1; Fri, 31 Jan 2020 11:22:51 -0500
Received: by mail-wr1-f72.google.com with SMTP id j4so3579541wrs.13
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 08:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DZFpBhCvZISJe+C475dKAGLib+knausHF5/M5i22qww=;
 b=PRcbreIfMH8ZJjHuIFbY1j2zQUWZifcPByD82GfrMizIA0xgPKzjMqqB0Zud75Pgu3
 YdY1cq8BhwC2l1ugD74OdQjQOAWsLlcZf3qkrxAYbfzcM9IsaRh5ij72p0W/+F9yTZ0L
 GgdYeUelg7oeSBXSORfsA7M6a7W4TmWyQ8u1azIzTYqhKLuPHDgCc+6ccYtflK+6xcbs
 Zt8NMECYTC+NCJ4MiGAyJ1vNZuRao5qhjiltchBD8yZMMJPn8nN1n7M2cq4xDNvPPUcm
 QFVh7VKViRrsnn5AH/umeJsA60XWxyVJ1Gf2ix3jIE2ofEpGSaHh07T/kUQ9hEJHV4U6
 yn7Q==
X-Gm-Message-State: APjAAAU6kZnww9RXvwYTjKQWNGNvzqWYDtIgwMzimPKJHQ1nttuYapQx
 CO6LWP1I8nyhTJMcT8lxWXAExuHNkOxl+oht4cdexfBKodkNagpG7q0WJ4V86RwcT18UG577euf
 G75jjr3kFFDbJVN8=
X-Received: by 2002:a5d:568a:: with SMTP id f10mr12714849wrv.180.1580487770343; 
 Fri, 31 Jan 2020 08:22:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNG+7+Y6XVtGf+FYXBXKJY+N+O8FwGAzvc3NaUiBh8cNjJL2itT5oIvNmVgnLMnmIRfPWqKg==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr12714832wrv.180.1580487770072; 
 Fri, 31 Jan 2020 08:22:50 -0800 (PST)
Received: from [192.168.42.35] (93-36-46-135.ip58.fastwebnet.it.
 [93.36.46.135])
 by smtp.gmail.com with ESMTPSA id b10sm4759858wrw.61.2020.01.31.08.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 08:22:49 -0800 (PST)
Subject: Re: [PATCH] virtio: add the queue number check
To: Yang Zhong <yang.zhong@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20191223082813.28930-1-yang.zhong@intel.com>
 <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
 <20191223091856.GA8433@yangzhon-Virtual>
 <e13a5fcc-b861-1847-58a8-e3d6445f84b0@redhat.com>
 <20191223092508-mutt-send-email-mst@kernel.org>
 <187f02d9-1677-d232-a44a-ed7b1e5f6ee5@redhat.com>
 <20200103150145.GA24552@yangzhon-Virtual>
 <CABgObfZWq_d-R_j456yxipPnbcLzCOJwd=9mCBMiwHDOckaXYg@mail.gmail.com>
 <20200110061051.GA1626@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be72c787-50f8-4b63-59bc-d9ac802541b6@redhat.com>
Date: Fri, 31 Jan 2020 17:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200110061051.GA1626@yangzhon-Virtual>
Content-Language: en-US
X-MC-Unique: vhXr8FcYNn6CX50oqsnelw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have just found this email... sorry for the delay.

On 10/01/20 07:10, Yang Zhong wrote:
>> No. If virtio-blk works, the bug is in vhost-user-blk; if virtio-blk needs
>> no check in cpu count, vhost-user-blk also doesn't.
>>
>> You need to check first if the bug is in QEMU or the vhost-user-blk server.
>
>   (1). Seabios issue
>   In init_virtio_blk() function, which set VIRTIO_CONFIG_S_DRIVER_OK
>   status to qemu vhost-user-blk device.
> 
>   // the related code
>   ......
>   status |= VIRTIO_CONFIG_S_DRIVER_OK;
>   vp_set_status(&vdrive->vp, status);
>   ......
> 
>   I think there is no need for seabios to set VIRTIO_CONFIG_S_DRIVER_OK
>   status to qemu vhost-user-blk device.

It does so because it cannot know how it will be used.  It could be used
by the guest boot loader to load a kernel, for example.  SeaBIOS sets
DRIVER_OK because it has loaded a driver for the disk; that's exactly
what DRIVER_OK signals.


>     In fact, this time vhost_user_blk_start almost do nothing because
>     the real guest virtio-blk driver still not started yet. This time,
>     there is only one vq can be used(this vq should be inited in seabios).
> 
>     When the guest virtio-blk driver really start and complet the
>     probe(), the guest virtio-blk driver will set
>     VIRTIO_CONFIG_S_DRIVER_OK to vhost-user-blk device again. This
>     time, this driver will allocate RIGHT queue num according to
>     MIN(vcpu, num_vqs).

Doesn't it first reset the status to 0?

>     (2). DPDK issue
>      DPDK does not know the real queue number used by guest virtio-blk
>      driver and it only know the queue number from vhost-user-blk
>      commond line. Once the guest virtio-blk driver change the queue
>      number according to MIN(vcpu, num_vqs), DPDK still use previous
>      queue number and it think virtio is never ready by
>      virtio_is_ready() function.

What is virtio_is_ready()?  The virtio device should not wait for all
the queues to be set.  A device is ready when it sets DRIVER_OK, and
that's it.

>      or DPDK can get the real queue number by checking if the vring.desc
>      is NON-NULL.

Note that there is no requirement that the driver initializes a
consecutive number of virtqueues.  It is acceptable for it to initialize
virtqueues 0, 1 and 57.  It seems like the bug is in DPDK, possibly more
than one...

Paolo

>      By the way, vhost SCSI device has the same issue with
>      vhost-user-blk device. 
> 
>      Yang
> 
>> Paolo
> 


