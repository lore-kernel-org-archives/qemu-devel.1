Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB08C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326D520786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7eZSDLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326D520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBBA2-0006oH-Ey
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 02:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kBB9B-00060J-DL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:12:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28420
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kBB98-0005M8-L2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598508745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/rlhBOVazI3yJbEIvNcqi9aYG1HHyOm095VFtPDuwk=;
 b=M7eZSDLilwQO4FnzWnsQUyZXXhvB3g5XUARMZCH287HN2Hu6GIZSbQvGyiU2PMHSd6hZQs
 UAZJgXXgjvp6KrtimTSV3oQLaAFbOYwUjvqKdq+yzZ4vb4tvbyl3WWKeVzH9Pzs4UHNqRn
 yl6UoIuXfLMZUPMG6+m3VeT5tponm70=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-2upgn0F6P4a3vQr5ShKDNg-1; Thu, 27 Aug 2020 02:12:23 -0400
X-MC-Unique: 2upgn0F6P4a3vQr5ShKDNg-1
Received: by mail-qv1-f70.google.com with SMTP id d9so3544871qvl.10
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 23:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3/rlhBOVazI3yJbEIvNcqi9aYG1HHyOm095VFtPDuwk=;
 b=dgkv+ituAKDj8PbiXS/7Oi2pRnT2/r5BK5N1JPfV25+XZcv8iiTozTuELfjWzm4M0u
 Xbn5CzJXNwdaeUbHdjSslEQZiPIPXk25/VfUuazhc8Ke6CiNl7RgL/bmV5x8q7PU9RKc
 5rXNW+vdiaDM87Aa7D4zywkeGjlc0mt5N0doAvUwMXXuDlt0/oxnOnXhN2RzghuSAwcn
 cuBkHwECKvI3pWxsZzVogMDIV0YA9VTMMh9V4ITDymEsb7UIhrdCHLP73/JRqI5lgGSU
 +VPWkLAIEb3uVnuQxdzjCKCpvpBsoLZ46YhUckjKySoAXUDu1/qIVMtWvlchAAt2OUnd
 ZpVg==
X-Gm-Message-State: AOAM532nhftdDCBc7SYaU/nDUZ//k/gC8ELK/9oYrLmlKTqtkq+v2mAC
 RJM/SyR2TFL7O5eYpyNkPe9SkAmxmphrKK0iIQxLS/3imaPSAAAE3ZOtShEk+bRy/+738XreUdU
 7p6vRk3WnejXHFo40o07DG1nbFeAa8Yg=
X-Received: by 2002:a37:3d4:: with SMTP id 203mr6952860qkd.497.1598508743249; 
 Wed, 26 Aug 2020 23:12:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7dXk9pvlaN/Ydpe5m2DPG5nhLbbdHM3RJQPNWzUbVFv9X1SJANP6Jz40C0rSV1v+DkAib1A/zSPYUbkGe+Vc=
X-Received: by 2002:a37:3d4:: with SMTP id 203mr6952843qkd.497.1598508742982; 
 Wed, 26 Aug 2020 23:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
 <20200826143651.7915-3-eperezma@redhat.com> <20200826154215.GE8235@xz-x1>
In-Reply-To: <20200826154215.GE8235@xz-x1>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 27 Aug 2020 08:11:47 +0200
Message-ID: <CAJaqyWeRzV9k_PS0=1uuK5--5RZB6XcVf6ZmxG-R5cF+ydXgaw@mail.gmail.com>
Subject: Re: [RFC v6 02/13] memory: Add IOMMUTLBNotificationType to
 IOMMUTLBEntry
To: Peter Xu <peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:42:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 5:42 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 26, 2020 at 04:36:40PM +0200, Eugenio P=C3=A9rez wrote:
> > This way we can tell between MAPs and UNMAP, and potentially avoid to
> > send them to a notifier that does not require them.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  include/exec/memory.h | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 22c5f564d1..f6d91c54aa 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -59,6 +59,12 @@ struct ReservedRegion {
> >
> >  typedef struct IOMMUTLBEntry IOMMUTLBEntry;
> >
> > +typedef enum {
> > +    IOMMU_IOTLB_NONE  =3D 0,
> > +    IOMMU_IOTLB_UNMAP =3D 1,
> > +    IOMMU_IOTLB_MAP   =3D 2,
> > +} IOMMUTLBNotificationType;
>
> Can we directly use IOMMUNotifierFlag as the type rather than introducing=
 a
> similar enumeration?  Thanks,
>

Right, I think it's simpler your way.

Thanks!

> --
> Peter Xu
>


