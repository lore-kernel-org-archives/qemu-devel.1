Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E5C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60ECF2074D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f69i6aaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ECF2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHAaC-0002MB-GW
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 14:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHAZO-0001vE-30
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHAZL-0004g9-QC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:16:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHAZJ-0004a4-Ej
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585160150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0q30Q3+vXFuRYLssXRtjeQaM7yOSGwdKNdarkd9+oc=;
 b=f69i6aaWZd3w3Os0VDV9h151V7ifu58LckqLeSjr9Q+k3tFkatjNF4LjR52XWhvnr/L9qZ
 WRSwHdidpiIJ+Qc40zOXZwc8LwkyPQDB3SOzfjNw/0oLTKrfOEZAtZnKGfWsKN7TXklxL8
 w/ork0PF4HoL/m/mXTG27Td5z8PokHo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-_X3NBYbnNhGc1QYm4_dI7g-1; Wed, 25 Mar 2020 14:15:48 -0400
X-MC-Unique: _X3NBYbnNhGc1QYm4_dI7g-1
Received: by mail-wr1-f69.google.com with SMTP id d1so1517190wru.15
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DflHpgEprK9pfAKqsvE8f/A6K3V5qBcFlBDVPsJ7x/k=;
 b=Go+roTpdnUH6HWBKFQw70OsvdSmrIHF/AeUDKguKrxTdH+ewyUukD+2gtdOZolRJad
 72mUp6X5fgiABQefwGAmmr0XOdnqm+M+Ld1K7I8re7nJ2VVg69w5nj9EEUVFfaJ2U2vZ
 +YQLMvdyd0BrkWqQCjqSkKUWhd8opqYNpcyepuAEAJAThQc/f9fhXiX0+f3eZKQt6lXv
 nxWkLxXmPlGAERBcurRURTESk+P5QikDpq/0T51EkpR7ZDvv5WrhTqUIy4jAKp6XFFe1
 tYj0R2J68hGQB8pBnWY1vqMMaRi9GCpbLrPHJHEKEU372bPEWDKe2Gx/fgmrs3i9BgdG
 izEQ==
X-Gm-Message-State: ANhLgQ0AqWPcSqxNvx8PHttqnXAQVDjydsd9pxwdaA4ABJNSEVtWwZtR
 tIVwKqe1tEB1Za6gZYOG7Sj2gCKuUIzHu0TbYfykgtDBNQopZdJ5myn01N+WmyKITsdxn/l7r6u
 8HODPaAvUK7KThM4=
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr4619010wmh.175.1585160147285; 
 Wed, 25 Mar 2020 11:15:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvBQeStysTQfaJx075L8v3k7dhNmLIT7JsyWJj+GnG1IGDjgnNE0u4Uig+zV7/Sil9ZY3FPrw==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr4618992wmh.175.1585160147054; 
 Wed, 25 Mar 2020 11:15:47 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id r16sm24328682wrv.33.2020.03.25.11.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 11:15:46 -0700 (PDT)
Date: Wed, 25 Mar 2020 14:15:43 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 5/9] KVM: Provide helper to get kvm dirty log
Message-ID: <20200325181543.GA404034@xz-x1>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-6-peterx@redhat.com>
 <20200325175220.GD2635@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200325175220.GD2635@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Wed, Mar 25, 2020 at 05:52:20PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Provide a helper kvm_slot_get_dirty_log() to make the function
> > kvm_physical_sync_dirty_bitmap() clearer.  We can even cache the as_id
> > into KVMSlot when it is created, so that we don't even need to pass it
> > down every time.
> >=20
> > Since at it, remove return value of kvm_physical_sync_dirty_bitmap()
> > because it should never fail.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  accel/kvm/kvm-all.c      | 39 +++++++++++++++++++--------------------
> >  include/sysemu/kvm_int.h |  2 ++
> >  2 files changed, 21 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index bb635c775f..608216fd53 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -553,6 +553,18 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *me=
m)
> >      mem->dirty_bmap =3D g_malloc0(bitmap_size);
> >  }
> > =20
> > +/* Sync dirty bitmap from kernel to KVMSlot.dirty_bmap */
> > +static void kvm_slot_get_dirty_log(KVMState *s, KVMSlot *slot)
> > +{
> > +    struct kvm_dirty_log d =3D {};
> > +    int ret;
> > +
> > +    d.dirty_bitmap =3D slot->dirty_bmap;
> > +    d.slot =3D slot->slot | (slot->as_id << 16);
> > +    ret =3D kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d);
> > +    assert(ret !=3D -1);
>=20
> As discussed on irc, that -1 check seems odd given your previous check
> but there seems to be some history as to why it was still there.  Hmm.
>=20
> It also seems very trusting that it can never possibly fail!

Yeah I agree.  I've asked the question under patch 1.

Before we know the answer, I'll remove the assertion to print an error
if it triggers; check against -1 (-EPERM) explicitly does look odd...

Thanks,

--=20
Peter Xu


