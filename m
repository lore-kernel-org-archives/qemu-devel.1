Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C19C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FED520659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiLF7XnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FED520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLtb-0006OK-Pz
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgLse-0004ZD-Ie
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:24:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27801
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgLsd-0001m2-Q0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591161838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQ89nUx/A4Yn4sJkuQa1py42AZcp+oQ819iaS+e2vAg=;
 b=FiLF7XnRQsrRvr1TMOKkdYjuozpoqNBaLV7luSco9Rn+bXI/Waapv22wWpZyQc1EedNAiH
 Bv7IOr3kwuaHdOyXed/UxRnev0IckjNLUv1JKmYNradckuPwWkAfS9i0AumSOZG9NmR2Qy
 fLZWNECuqWEQ7T/+Zfv4kGPefwDrc3o=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-SAINBWy-PqaOWLGZswuu6A-1; Wed, 03 Jun 2020 01:23:57 -0400
X-MC-Unique: SAINBWy-PqaOWLGZswuu6A-1
Received: by mail-pf1-f198.google.com with SMTP id w1so923189pfw.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 22:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cQ89nUx/A4Yn4sJkuQa1py42AZcp+oQ819iaS+e2vAg=;
 b=AYXeVkbpYo+PySGSq4/fwZf4G6ymOoKYFoxK10e1NlOa0R+/o2f1vKH6bTBIl/L0kb
 Cafw1WYmWc+mBivrPVD2DZyeKMwY5+0MO1FvlNJSiofZwtMKznxx4m06Mzy1ClqiSq/s
 0DbULwusD/j184gw9uKkwtdYV/0o8zzw/h6mqkveaM1bQF4JYeiyqxc67UCjaw6wlMQD
 D6kIxLXw3K8cgEnDUd8LYRGohJAohIiyc24vrJZ2jg/2LR60jN5UO8HJMaSfMjMW4XRO
 hbC+pqd4DSqz++ZGAbF/TTUAKbBcw5Uguv2R5MTOHxUOotD/QbjCRNDqQAOZCT436cx8
 jUrw==
X-Gm-Message-State: AOAM531Hd0I6HZN47M9iLRTRAXFiF0O5ImWMH/NtX+FfucfxV5RyB705
 c2il00R2TgFTGE4sZCohIF4JvA+Dqi8J+5c7RaCA93WGFiP7IbWyVFlAL6DO2LO/cCknvGFyqNg
 11ENeYdTNlZ7+eGaa8hJByL4Y7ytRfi8=
X-Received: by 2002:a63:1323:: with SMTP id i35mr27621212pgl.311.1591161835799; 
 Tue, 02 Jun 2020 22:23:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgrUQv7TADsGn1UTl8ZV0/zkRF+d68ZLaHKNp9dOHxLiynS2fYj+zoPATFn/C4iKvCBimKfQ3Gsc/JUDn6Q54=
X-Received: by 2002:a63:1323:: with SMTP id i35mr27621181pgl.311.1591161835569; 
 Tue, 02 Jun 2020 22:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-8-lulu@redhat.com>
 <9a74b3d6-7b04-5918-1c23-8d1dadaabd2e@redhat.com>
In-Reply-To: <9a74b3d6-7b04-5918-1c23-8d1dadaabd2e@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 3 Jun 2020 13:23:44 +0800
Message-ID: <CACLfguV6Mbybrq2xBxeEQE+3TKj+EQ6XHtC1_r2uXxbNQTOEeg@mail.gmail.com>
Subject: Re: [RFC v3 7/8] vhost-vdpa: introduce vhost-vdpa backend
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 3, 2020 at 10:54 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/29 =E4=B8=8B=E5=8D=8810:06, Cindy Lu wrote:
> > From: Tiwei Bie<tiwei.bie@intel.com>
>
>
> Consider the significant modification based on the original patch.
>
> I think you may change the other to yourslef and keep the sobs for both
> Tiwei and Lingshan.
>
> Thanks
>
>
Sure, Will change this
> >
> > Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> > vhost-user. The above patch provides a generic device for vDPA purpose,
> > this vDPA device exposes to user space a non-vendor-specific configurat=
ion
> > interface for setting up a vhost HW accelerator, this patch set introdu=
ces
> > a third vhost backend called vhost-vdpa based on the vDPA interface.
> >
> > Vhost-vdpa usage:
> >
> >    qemu-system-x86_64 -cpu host -enable-kvm \
> >      ......
> >    -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost-v=
dpa0 \
> >    -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \
> >
> > Co-Authored-By: Lingshan zhu<lingshan.zhu@intel.com>
> > Signed-off-by: Cindy Lu<lulu@redhat.com>
>


