Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F5C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7AF24655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WghMFRmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7AF24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdzt-0002Jk-7b
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBdyl-0001fv-Hn
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBdyk-000496-5h
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:27:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBdyj-00043Z-R0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583843241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEWBm7c9j10Sxtu/tisotHrVDe1+OXzhJCghP/u4mmg=;
 b=WghMFRmQH1HI5yWlvk0U/fxfoLabonF32ask7Q5rz8KMCdDhEs64WEnKtDhAKvwmnIISgs
 SyKH8vf+yh8+H3mBM9tIbVTPUXwq1qiMkRJ/H3MWbI5u6n4GwiKaDAbvPPie7vtO4YsTl7
 XoqYGqHAhsZC5Rj0SMcKRLgU7TJN/bU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-fY8632HWOI2jufpCHUsn4g-1; Tue, 10 Mar 2020 08:27:17 -0400
X-MC-Unique: fY8632HWOI2jufpCHUsn4g-1
Received: by mail-qk1-f198.google.com with SMTP id w2so9578937qka.4
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=L/fc0tjaGRxVSgKEiKUII0LB9scZp2X6AysaWaSjqqI=;
 b=RLEpTJDZM0/ebRp6/Hvxb0P7V9f0i2uXDFvOCBjmEDaKaKflq49Puode/lMVHn5/dk
 7SBojhIU/Mx+haixgUKHWXxqDaGdp2ipp2TOoujO2UaPCCmlZtQ/LzYjS6GfA7F14MHV
 ruOfD9uHKzPGsenTnKFg7okIKf8n5Xn/n521uT0sN1BFyhzzoLP9hdZG5rdUe7GIovBf
 iOMOHDD2Uq0TDtpl9iyNvTWn5nS/wrNQLHLT/3XfvhjlcBuk5TwlLxOdqQsxqR7XncPL
 mXngLTudSyob1cVMfnvOxMBrBvVTFJeFVUm+zQpUBMbTSDJvpoeAXGclfr6peb9w/PrF
 jRNQ==
X-Gm-Message-State: ANhLgQ0Dp0E3JjYBTcj0HyPzhk7uHiFYyzg/udKCIJwVlgtu4oR2HO4X
 CvDVBkk4Khkyo45y1sOIYdLqng9Twn08Rzj+WREivESibMncyaTxA21ROm1E04NGc/c7pMNNxgq
 55nxZ8Fiz+cUmB4Q=
X-Received: by 2002:a37:a551:: with SMTP id o78mr6039719qke.453.1583843236919; 
 Tue, 10 Mar 2020 05:27:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vujdmvHEt9rKQjaYMaR1jxuVhQrFueKFeAp1+N+wxOnj1DRFryeFOt661ArZplQV5WPWIg8ow==
X-Received: by 2002:a37:a551:: with SMTP id o78mr6039699qke.453.1583843236680; 
 Tue, 10 Mar 2020 05:27:16 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id 127sm17400275qkj.97.2020.03.10.05.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 05:27:15 -0700 (PDT)
Date: Tue, 10 Mar 2020 08:27:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 12/14] i386/cpu: Store LAPIC bus frequency in CPU structure
Message-ID: <20200310082542-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-13-liran.alon@oracle.com>
 <20200310052900-mutt-send-email-mst@kernel.org>
 <7d511194-6af1-efe6-1170-623144bdcc20@oracle.com>
MIME-Version: 1.0
In-Reply-To: <7d511194-6af1-efe6-1170-623144bdcc20@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 12:53:28PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 11:29, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:54:09AM +0200, Liran Alon wrote:
> > > No functional change.
> > > This information will be used by following patches.
> > >=20
> > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > ---
> > >   linux-headers/asm-x86/kvm.h | 4 ++++
> > >   target/i386/cpu.h           | 1 +
> > >   target/i386/kvm.c           | 6 +++---
> > >   3 files changed, 8 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.=
h
> > > index 503d3f42da16..99eeaaf2f0b4 100644
> > > --- a/linux-headers/asm-x86/kvm.h
> > > +++ b/linux-headers/asm-x86/kvm.h
> > > @@ -446,4 +446,8 @@ struct kvm_pmu_event_filter {
> > >   #define KVM_PMU_EVENT_ALLOW 0
> > >   #define KVM_PMU_EVENT_DENY 1
> > > +/* From arch/x86/kvm/lapic.h */
> > > +#define KVM_APIC_BUS_CYCLE_NS       1
> > > +#define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CY=
CLE_NS)
> > > +
> > >   #endif /* _ASM_X86_KVM_H */
> >=20
> > This header is auto-generated from UAPI - you can't add
> > your own stuff here.
> Oh I didn't notice that. OK, I will move definitions to somewhere else.
> Is it fine by you if I will just put them then in target/i386/kvm.c
> directly?
> Or do you prefer I will put them in target/i386/kvm_i386.h
>=20
> -Liran
>=20

That's Paolo's area. Myself, I don't really know what this is doing,
nor how is this supposed to work e.g. on TCG.

--=20
MST


