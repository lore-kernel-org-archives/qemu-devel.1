Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B51C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E87C206F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SR+mGGAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E87C206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHCyD-0007Sf-6g
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 16:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHCxH-0006ul-60
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHCxF-00007C-SY
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:48:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58265)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHCxF-00006Q-Ou
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585169328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfF6X0A1UT51x+rN+uVi9TiFzDPB2HbDOJoLKpWeJr4=;
 b=SR+mGGABT5EKOHVWHWsgIikjt91rBN2dAZ+A+20uWcNJOW2FWRmHc2XsjdIkLnvTzpPwWN
 IRFKSmFQEDn1X3WSWu0pbsca8bnZmBR43edDrXZbzOrHck+HGT0SRXNZokU/3O77Fbmw6G
 vimBqCSxlo6qYDKMkQUYFM6S78A8uis=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-WB3OCf1MONOAU2hTMR5SSw-1; Wed, 25 Mar 2020 16:48:47 -0400
X-MC-Unique: WB3OCf1MONOAU2hTMR5SSw-1
Received: by mail-wm1-f69.google.com with SMTP id w9so1260183wmi.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 13:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i4w8kqKfEalp/D3Tq89wNjeHoYUoCBGqkQD7W+kubXo=;
 b=rPo+dHjtACUcQnUjIFwBqppEbU+/sVAMQNoAsQr8d1LmgowEIRH4BEcTMF7IFIpRTx
 Vx7j7/CSik2vDJNdXU4Mhdmef1bdpVhydGc56JHDdyqTSbiMUB9MJUg89DDDL75A6sIn
 +nFh4n68hXVDo1sibrJ08pr2V1+5atZiygZme+TKjS4E34XrgTQQI90FkGqA3Xrz2vfE
 gZYHxaJufutWoVjKGgYkWKWEL+vRRJirEhLhN124GxkjSirQtimuDxeMY1MZV5ILiJzq
 u4ssb/wPDy8JK8eJJi8hkmt03diTNZQgI6jJqoLy09QGVZQle43lx/rjNljqbLJTgkyc
 r+2g==
X-Gm-Message-State: ANhLgQ32WRDLsrXIFwuxy+P3nGcQRkbQ1grnOejrTq6PqS6rEBYShDkw
 EaXBZ/97krtwpYaEAgAWrY5J6RhItXUysQFilyAkB9zZI3V/64pEH441l+JfjEAWJnzM9FHUEfe
 odwecClKFEHvlu9c=
X-Received: by 2002:adf:80af:: with SMTP id 44mr5520197wrl.241.1585169326017; 
 Wed, 25 Mar 2020 13:48:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsFNw2kQ75Hl7UvRgWlrWhY0zH7+AtmYR9Q84/8rLux1zWk9WeRPLDAs+FCSejKKBor3N3MgA==
X-Received: by 2002:adf:80af:: with SMTP id 44mr5520178wrl.241.1585169325733; 
 Wed, 25 Mar 2020 13:48:45 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id b15sm206839wru.70.2020.03.25.13.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 13:48:45 -0700 (PDT)
Date: Wed, 25 Mar 2020 16:48:42 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 8/9] KVM: Add dirty-ring-size property
Message-ID: <20200325204842.GE404034@xz-x1>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-9-peterx@redhat.com>
 <20200325201403.GH2635@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200325201403.GH2635@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 08:14:03PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Add a parameter for size of dirty ring.  If zero, dirty ring is
> > disabled.  Otherwise dirty ring will be enabled with the per-vcpu size
> > as specified.  If dirty ring cannot be enabled due to unsupported
> > kernel, it'll fallback to dirty logging.  By default, dirty ring is
> > not enabled (dirty-ring-size=3D=3D0).
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
>=20
> <snip>
>=20
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 224a8e8712..140bd38726 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -119,6 +119,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
> >      "                kernel-irqchip=3Don|off|split controls accelerate=
d irqchip support (default=3Don)\n"
> >      "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\=
n"
> >      "                tb-size=3Dn (TCG translation block cache size)\n"
> > +    "                dirty-ring-size=3Dn (KVM dirty ring size in Bytes=
)\n"
> >      "                thread=3Dsingle|multi (enable multi-threaded TCG)=
\n", QEMU_ARCH_ALL)
> >  STEXI
> >  @item -accel @var{name}[,prop=3D@var{value}[,...]]
> > @@ -140,6 +141,8 @@ irqchip completely is not recommended except for de=
bugging purposes.
> >  Defines the size of the KVM shadow MMU.
> >  @item tb-size=3D@var{n}
> >  Controls the size (in MiB) of the TCG translation block cache.
> > +@item dirty-ring-size=3D@val{n}
> > +Controls the size (in Bytes) of KVM dirty ring (<=3D0 to disable).
>=20
> I think that needs to say 'per vcpu'

Right, fixed.

--=20
Peter Xu


