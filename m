Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA30C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F37B20777
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAz2LxYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F37B20777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHA4M-0005QO-JV
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHA3c-0004To-Fq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHA3b-0001On-DM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:43:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHA3b-0001OX-9Y
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585158190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npq6in6QIhRC2Vf/wwQDgFyiMQzVNAEh8CyukAjaTMo=;
 b=NAz2LxYtkIF5zeKGHHP9B73xdGS/L7lvgE2CWPjdUFP1uO1DiIAfJOJEytGhfRI7lSKpDe
 W+7AvueXcduAEvvo1SEGNp5xvaB9dB4MmPEjGpmwaEaRXZzEjB/9nMpn7kEMzbp5MkKmF6
 WiNzLoGXnwBK/ZiS8dCK2/RfPEOpC0M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-FjGLWdE4PjmEya-KRuCIIQ-1; Wed, 25 Mar 2020 13:43:08 -0400
X-MC-Unique: FjGLWdE4PjmEya-KRuCIIQ-1
Received: by mail-wm1-f72.google.com with SMTP id m4so2761352wme.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 10:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EOCoqUjf8CUS3+fsPCv7fqtKWLfg28PneudeeOMjZA8=;
 b=Kk1gav2ZtdDvhX+DKB3jUJi8CiXkLidlcrPbxzw5bqKODu+rTjtl+B2H0RUnA/xJf5
 CjKddGqDgPLhL8198EEqInYTTSYrHjqZU29pWwolf3lkogvSUO4363McnEH9RimTVTGn
 thioFY0znryD1Ov/yQIWqagCWlttCdG89Lwakci/OVSBxEn0xNkkRQrR3xaR7Jn9imVW
 PTcnB+ms0tYrf4o3bTVL1GEclvdsHCWmCS2YZuybMUfdT6R5rzhXtI99yx51SgPJupDZ
 n+hVR5M3dFD8EIybVLmlF/CRJQuFxTgpRmBuOBhhx2fZL8/Bw8ILy+HWlEGXFgNeP33V
 zEUw==
X-Gm-Message-State: ANhLgQ39AWAaO6F5wWDs3ew27U947gAAzGpTUxFNOeVmjyXlmZptGKy2
 eGPK5qtA4ma57H/5gIVUR6SsWLLPuQEpRDKS0GrlALL6djz2El6I/IX5NLqxOhlTF7pXCShRGot
 gN5Xgx222c6gmQGo=
X-Received: by 2002:a1c:4c0e:: with SMTP id z14mr30904wmf.0.1585158187365;
 Wed, 25 Mar 2020 10:43:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vssqFB2I8kqzhRWvvj0byjaBttrQn1GglvbPvcBb798yRTs9B0YcfUzpAHmvtVz1KSIRtJxZA==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14mr30894wmf.0.1585158186865;
 Wed, 25 Mar 2020 10:43:06 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id b15sm34290676wru.70.2020.03.25.10.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 10:43:06 -0700 (PDT)
Date: Wed, 25 Mar 2020 13:43:02 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 1/9] KVM: Fixup kvm_log_clear_one_slot() ioctl return
 check
Message-ID: <20200325174302.GH354390@xz-x1>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-2-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-2-peterx@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 09:17:41AM -0500, Peter Xu wrote:
> kvm_vm_ioctl() handles the errno trick already for ioctl() on
> returning -1 for errors.  Fix this.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c111312dfd..4be3cd2352 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -688,14 +688,13 @@ static int kvm_log_clear_one_slot(KVMSlot *mem, int=
 as_id, uint64_t start,
>      d.num_pages =3D bmap_npages;
>      d.slot =3D mem->slot | (as_id << 16);
> =20
> -    if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) =3D=3D -1) {
> -        ret =3D -errno;
> +    ret =3D kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d);

Dave raised a question offlist when comparing with KVM_GET_DIRTY_LOG,
regarding 50212d6346 ("Revert "fix return check for KVM_GET_DIRTY_LOG
ioctl"", 2014-04-14) where we wanted to allow KVM_GET_DIRTY_LOG to
fail for some cases.  I didn't find any context of that, and from the
first glance I don't understand why and when we'll get -ENOENT during
sync dirty log (we should have BQL held, so I don't know why a memslot
can be gone underneath).  Anyone knows more?

CCing Peter Maydell and Michael Tokarev too.

> +    if (ret) {
>          error_report("%s: KVM_CLEAR_DIRTY_LOG failed, slot=3D%d, "
>                       "start=3D0x%"PRIx64", size=3D0x%"PRIx32", errno=3D%=
d",
>                       __func__, d.slot, (uint64_t)d.first_page,
>                       (uint32_t)d.num_pages, ret);
>      } else {
> -        ret =3D 0;
>          trace_kvm_clear_dirty_log(d.slot, d.first_page, d.num_pages);
>      }
> =20
> --=20
> 2.24.1
>=20

--=20
Peter Xu


