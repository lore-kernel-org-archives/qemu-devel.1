Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB398C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DF02084C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJQNYxV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DF02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqw2l-0007Mw-23
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqw1p-0006vZ-Pw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:01:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21220
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqw1m-0000Pe-MW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593684069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pr9hVWv5ziQvcirq4ZAgXVDjCNoAWKQ3lAebrqE/IZY=;
 b=SJQNYxV8zC5m5TiGUaJC5wJNBBCYp0jLQLY3DnixsOoZAN22WI2ykYIVcODIsBfhTIJbsW
 SvITpDJVV0SmRZEYSlsj5tKfbsO2Y0SVtofApsi7tRIZhyOmhS75ouSappvZ1ePZ5EbR6O
 7Y3PEzPyaa8RyLfrIMuGbqYOBBXmlZ0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-DrAOg9DtMD6JXHZOwVaSYQ-1; Thu, 02 Jul 2020 06:01:08 -0400
X-MC-Unique: DrAOg9DtMD6JXHZOwVaSYQ-1
Received: by mail-wr1-f72.google.com with SMTP id y16so24565058wrr.20
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 03:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AqubhPEqZ48yj0CLxXE/+4mQsbV7lOpPVYY7vTX++IY=;
 b=Wy1QMhsjOMKzuvC8ymxeWiv6UUnlIIM7nV3mjDIwLQ49iJRIuSEeulhczBiKE9fYu/
 NXG3LtwzQCRqSCTNf3zVLma3UDZBk3U/TK3Ucr/Nu7WbfDfdsYvWM3OBQudqMrLjiVxG
 JCTQSPIHBszroAR+0EAegOZ0EUnmgApPzHxWABWhWZLSnQH3TPfoH4NFARlJlSRE2sF+
 AVcT8GeDsiQHLRGkMwzWqO5N58pGXbc3OSUn3z1G7Ewe+H8kIKwuJNNMDmYTBL/J6c6q
 U0NSbe7Ji2+e4LInVDpWm0Bbc94uUIPDgs8JoQSPJUV62pBw4S7du/DyKe78XIFISZbI
 SdIA==
X-Gm-Message-State: AOAM533vXHYMBBKfnzIxPE9MAMfaUXPhvjDAuZh2VKqNVkGcymPbr3UQ
 ROkA7mMc0feD2SLrMGGNj7FSG9g8PifxqKalse+IYleaDqSvlZBGGUctiktHR76cVlW1BjE9/CJ
 IN4U2HaCXI1VBDAw=
X-Received: by 2002:adf:e647:: with SMTP id b7mr32827157wrn.170.1593684067138; 
 Thu, 02 Jul 2020 03:01:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI6kPrTOrJcM8RVocW304vX+PlPwIcCU4bgemigQ9fprBzfTmsk+OdrVVBDaJylkvPgjDXPw==
X-Received: by 2002:adf:e647:: with SMTP id b7mr32827120wrn.170.1593684066827; 
 Thu, 02 Jul 2020 03:01:06 -0700 (PDT)
Received: from redhat.com ([93.157.82.4])
 by smtp.gmail.com with ESMTPSA id 138sm4732384wmb.1.2020.07.02.03.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 03:01:05 -0700 (PDT)
Date: Thu, 2 Jul 2020 06:01:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 0/4] Enable virtio-fs on s390x
Message-ID: <20200702060008-mutt-send-email-mst@kernel.org>
References: <20200625100430.22407-1-mhartmay@linux.ibm.com>
 <20200629125305.GH31392@stefanha-x1.localdomain>
 <20200629130716.GQ1298906@redhat.com>
 <20200630090451.GE81930@stefanha-x1.localdomain>
 <20200630113932.484b3fde.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630113932.484b3fde.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 11:39:32AM +0200, Cornelia Huck wrote:
> On Tue, 30 Jun 2020 10:04:51 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> 
> > On Mon, Jun 29, 2020 at 02:07:16PM +0100, Daniel P. Berrangé wrote:
> > > On Mon, Jun 29, 2020 at 01:53:05PM +0100, Stefan Hajnoczi wrote:  
> > > > On Thu, Jun 25, 2020 at 12:04:26PM +0200, Marc Hartmayer wrote:  
> > > > > This RFC is about enabling virtio-fs on s390x. For that we need
> > > > >  + some shim code (first patch), and we need
> > > > >  + libvhost-user to deal with virtio endiannes as mandated by the spec.
> > > > >  
> > > > > The second part is trickier, because unlike QEMU we are not certain
> > > > > about the guest's native endianness, which is needed to handle the
> > > > > legacy-interface appropriately. In fact, this is the reason why just
> > > > > RFC.
> > > > > 
> > > > > One of the open questions is whether to build separate versions, one
> > > > > for guest little endian and one for guest big endian, or do we want
> > > > > something like a command line option? (Digression on the libvirt
> > > > > modeling)
> > > > > 
> > > > > A third option would be to refuse legacy altogether.  
> > > > 
> > > > I suggest the following:
> > > > 
> > > > 1. Combinations that worked with libvhost-user in the past must not break.
> > > > 
> > > > 2. New combinations should only support VIRTIO 1.0 and later.
> > > > 
> > > > This means continue to allow Legacy mode devices where they already run
> > > > today but don't add new code for the cases that didn't work.  
> > > 
> > > What I'm missing here is what PCI product ID was being used when the
> > > current impl is in legacy/transitional mode ?
> > > 
> > > Normally legacy and transitional mode devices need an explicit PCI ID
> > > reserved, where as modern-only devices have a PCI ID derived from their
> > > VirtIO ID + a fixed offset.
> > > 
> > > Was this mistakenly using a VirtIO ID + fixed offset for the legacy
> > > mode too ?  
> > 
> > vhost-user-fs-pci does not support Legacy or Transitional mode. See
> > hw/virtio/vhost-user-fs-pci.c:
> > 
> >   static const VirtioPCIDeviceTypeInfo vhost_user_fs_pci_info = {
> >       .base_name             = TYPE_VHOST_USER_FS_PCI,
> >       .non_transitional_name = "vhost-user-fs-pci",
> >       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >       .instance_size = sizeof(VHostUserFSPCI),
> >       .instance_init = vhost_user_fs_pci_instance_init,
> >       .class_init    = vhost_user_fs_pci_class_init,
> >   };
> 
> This makes it very unlikely that someone accidentally configures
> non-modern, but does not prevent it AFAICS. See
> <20200630113527.7b27f34f.cohuck@redhat.com>, which I just sent.
> 
> (I may be off, because that is all very confusing...)

Right. We'll block legacy for modern only devices going forward.
Going back to the patchset in question, virtio-fs is modern
only, legacy will not be supported.

-- 
MST


