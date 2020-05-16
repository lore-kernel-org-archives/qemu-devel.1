Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A90C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 11:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEF820727
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 11:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMsxw1SU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEF820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZv7H-00043W-8p
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 07:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZv6i-0003co-T3
 for qemu-devel@nongnu.org; Sat, 16 May 2020 07:35:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52706
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZv6h-0000Ni-4Y
 for qemu-devel@nongnu.org; Sat, 16 May 2020 07:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589628953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plmK8ueeCWkXMqQ0pT6IqDFxat4X5UP9C+XAPIkIjoE=;
 b=hMsxw1SUmzIGbjG8SFrp0JwpGuICkATIqVIW2yr6+HRfB1jh276/4uTXaDqNNjDG94svTm
 UH/k8pkpdtbZEsrmsOBXIkbHnCjnnRahHCXxl6lgY3Su/mglMVF7OxvcUVbAdnrLRC8A+1
 3pJnoHnSjE2Ww3iWYIisB97abNzPShI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-OYLyfj4CNcWCRHcA_AWRpA-1; Sat, 16 May 2020 07:35:47 -0400
X-MC-Unique: OYLyfj4CNcWCRHcA_AWRpA-1
Received: by mail-wm1-f72.google.com with SMTP id 23so2554177wma.8
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 04:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=plmK8ueeCWkXMqQ0pT6IqDFxat4X5UP9C+XAPIkIjoE=;
 b=YO1bQA7DBLsqIAy0iVeL2dPe7SVM6nUfHkYcnIQS7o8j1kclzeE5aA47Qdj+8cChIS
 1WkqIYLxP1lDGZbYSaY4oJIciZj5rDhEcgdxiZwa1U+OY77JXmPAvuqDM7aXrR9PVjbx
 fq8GdDXkV7vilIeQObQz6uwK2xj6VPvXZ3ZOVpmrqO0rWO1pdNACKLOLT6P4rNvBKTUF
 rbEyFElpYThwkxpzaknlYfcyklUyPNw3+9t2lL2exLWlT2BQ5TvHu/70WJ/GInp1lGzg
 X9S90nCUW9HmycbLqVbCUPQv3SFFj52oOchnnCtF7GULvshrSqHZCNZd64fG/yEDtE5K
 80+g==
X-Gm-Message-State: AOAM532t34QO8ckv672vL2Hda+Jc7hP3dECo+QXtbmGuVoOlNTZQsRWs
 KdwAQiGeLBMEzypQcutD1Eq6bR0k0de7X5De8TeNr7r7yvbzKJs851BL9EDxfUDykFpT7dxAXAh
 OLx7a2AuiVwCSDdp0SjxyU7Ptl7sCbK4=
X-Received: by 2002:a1c:81d0:: with SMTP id c199mr8605609wmd.125.1589628946197; 
 Sat, 16 May 2020 04:35:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Ftvv/FMX7WaNAtrqa19DBv6GNm8FwmIkNw8V4jG2jwKyIb4EUznEMdGIO9AXvBRyPYM6CGbGb6+Vn3e6Bu8=
X-Received: by 2002:a1c:81d0:: with SMTP id c199mr8605579wmd.125.1589628945712; 
 Sat, 16 May 2020 04:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200511044121.eihns2tdimdzgi4i@mozz.bu.edu>
In-Reply-To: <20200511044121.eihns2tdimdzgi4i@mozz.bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Sat, 16 May 2020 13:35:34 +0200
Message-ID: <CAP+75-WyjYTDcERsxYG3YyN4mWH3aRi-OYyQcPAWEa10htv6Lw@mail.gmail.com>
Subject: Re: Null-pointer dereference through virtio-balloon
To: Alexander Bulekov <alxndr@bu.edu>, David Hildenbrand <david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 05:35:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+David (virtio-balloon maintainer)

On Mon, May 11, 2020 at 6:42 AM Alexander Bulekov <alxndr@bu.edu> wrote:
>
> Hello,
> While fuzzing, I found an input that triggers a null-ptr dereference in
> aio_bh_enqueue, through virtio-balloon. Based on the stacktrace below,
> I am not positive that this is specific to virtio-balloon, however
> I have not encountered the same issue for any of the other virtio
> devices I am fuzzing.
>
> AddressSanitizer: SEGV on unknown address 0x000000000000
>
> #0 0x55ee5b93eb28 in aio_bh_enqueue util/async.c:69:27
> #1 0x55ee5b93eb28 in qemu_bh_schedule util/async.c:181:5
> #2 0x55ee5ae71465 in virtio_queue_notify hw/virtio/virtio.c:2364:9
> #3 0x55ee5b51142d in virtio_mmio_write hw/virtio/virtio-mmio.c:369:13
> #4 0x55ee5ad0d2d6 in memory_region_write_accessor memory.c:483:5
> #5 0x55ee5ad0cc7f in access_with_adjusted_size memory.c:544:18
> #6 0x55ee5ad0cc7f in memory_region_dispatch_write memory.c:1476:16
> #7 0x55ee5ac221d3 in flatview_write_continue exec.c:3137:23
> #8 0x55ee5ac1ab97 in flatview_write exec.c:3177:14
> #9 0x55ee5ac1ab97 in address_space_write exec.c:3268:18
>
> I can reproduce it in a qemu 5.0 build using:
> cat << EOF | qemu-system-i386 -M pc-q35-5.0 -M microvm,x-option-roms=3Dof=
f,pit=3Doff,pic=3Doff,isa-serial=3Doff,rtc=3Doff -nographic -device virtio-=
balloon-device,free-page-hint=3Dtrue,deflate-on-oom=3Dtrue -nographic -moni=
tor none -display none -serial none -qtest stdio
> write 0xc0000e30 0x24 0x0300000003000000030000000300000003000000030000000=
30000000300000003000000
> EOF

If you start QEMU this way, you get a warning:

qemu-system-i386: -device
virtio-balloon-device,free-page-hint=3Dtrue,deflate-on-oom=3Dtrue:
iothread is missing

        if (s->iothread) {
            s->free_page_bh =3D
aio_bh_new(iothread_get_aio_context(s->iothread), ...
            ...
        } else {
            ...
           virtio_error(vdev, "iothread is missing");
        }

Shouldn't we call error_setg(errp, "iothread is missing") and return instea=
d?

>
>
> I also uploaded the above trace, in case the formatting is broken:
>
> curl https://paste.debian.net/plain/1146094 | qemu-system-i386 -M pc-q35-=
5.0 -M microvm,x-option-roms=3Doff,pit=3Doff,pic=3Doff,isa-serial=3Doff,rtc=
=3Doff -nographic -device virtio-balloon-device,free-page-hint=3Dtrue,defla=
te-on-oom=3Dtrue -nographic -monitor none -display none -serial none -qtest=
 stdio
>
> Please let me know if I can provide any further info.
> -Alex
>


