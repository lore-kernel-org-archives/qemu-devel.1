Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26246C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E357E215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCOEKa3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E357E215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9WGY-0003QP-16
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j9WFo-0002m3-SO
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j9WFn-000625-1K
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:48:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j9WFm-0005zU-Qh
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583336889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1wAumeVH//i6CL9ZvptMZook4kdqW8REYVEX4qMcsM=;
 b=CCOEKa3qCA8vI/ON3U0OIH+MSm5WHwH66070JvG4YQ32FrsdYKBZ8/2J+adT1MMGqRjEJv
 Fyjix3JM2yxMlhnRqXyrgCgMNhDU9uCWgMshhdILUqY5aqCPoiw4B/ujt3Eqxx0KJroWvg
 ryh5z3ddAuysc/HvfWHvLzVSn673Yeo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-KK4cCnUSOMKPS0bTQ0O3qw-1; Wed, 04 Mar 2020 10:48:08 -0500
X-MC-Unique: KK4cCnUSOMKPS0bTQ0O3qw-1
Received: by mail-qk1-f198.google.com with SMTP id 22so1591457qkc.7
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G05ODUMwGaZtTydQIga3NfVZQOwHv7Y4Bw0+tGX480w=;
 b=TGXQWJ6ocO84zd0lEwQ/ORgziZgP8eFZIOyHg1b6TiK9+ZzwOCAyGPzTmnbXhgUpg4
 AGljVheknGJYNwOo0n90j6VQLwIxwGvAvSbtEmBpYA2MGWItwtQQndaQcviK2C0FyiGQ
 hQ5oZgZpKGzvgTXujrOlQ8GnKRVsdgJGyURuPvrFvGed5mnIiCNSkvM/1uJsApey2GmO
 z86zsrEyNWqPoG85f97jg+TxBVkBVRxq+smCcF/neFDslC9KEimkAO5J7hHNPzP3c/0T
 azzFKRJcwrVKBUJ2Wtb70NdJGmtFwtNBh2q6jldX55YR5AUveCmtk9OjMBZBQAJF0iup
 6DpA==
X-Gm-Message-State: ANhLgQ1bFAtWAR8KS0QwgS4o6yogxGVP66He745Ol4Q59R2zv9wWuxwj
 UZw8pac9YlvqYPoelUFsm/WLgdxB9rJ+oFRIHPkarqyTXuTUm4IP2NToAwC+98acoteArCyW75+
 fU6tHblFRaADIV78=
X-Received: by 2002:ac8:344f:: with SMTP id v15mr2949275qtb.58.1583336887626; 
 Wed, 04 Mar 2020 07:48:07 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs9S0eYXlfqZXtPUdipXSfLtn/EG8NyXkF23m7/jaeOXsDnXYsxmHRqgNzn6iJLCPWk1rgB8g==
X-Received: by 2002:ac8:344f:: with SMTP id v15mr2949250qtb.58.1583336887323; 
 Wed, 04 Mar 2020 07:48:07 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id v6sm5639721qkg.102.2020.03.04.07.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:48:06 -0800 (PST)
Date: Wed, 4 Mar 2020 10:48:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Jay Zhou <jianjay.zhou@huawei.com>
Subject: Re: [PATCH] kvm: support to get/set dirty log initial-all-set
 capability
Message-ID: <20200304154805.GC7146@xz-x1>
References: <20200304025554.2159-1-jianjay.zhou@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200304025554.2159-1-jianjay.zhou@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: liu.jinsong@huawei.com, weidong.huang@huawei.com, kvm@vger.kernel.org,
 mst@redhat.com, wangxinxin.wang@huawei.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 04, 2020 at 10:55:54AM +0800, Jay Zhou wrote:
> Since the new capability KVM_DIRTY_LOG_INITIALLY_SET of
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 has been introduced in the
> kernel, tweak the userspace side to detect and enable this
> capability.
>=20
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
>  accel/kvm/kvm-all.c       | 21 ++++++++++++++-------
>  linux-headers/linux/kvm.h |  3 +++
>  2 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 439a4efe52..45ab25be63 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -100,7 +100,7 @@ struct KVMState
>      bool kernel_irqchip_required;
>      OnOffAuto kernel_irqchip_split;
>      bool sync_mmu;
> -    bool manual_dirty_log_protect;
> +    uint64_t manual_dirty_log_protect;
>      /* The man page (and posix) say ioctl numbers are signed int, but
>       * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
>       * unsigned, and treating them as signed here can break things */
> @@ -1882,6 +1882,7 @@ static int kvm_init(MachineState *ms)
>      int ret;
>      int type =3D 0;
>      const char *kvm_type;
> +    uint64_t dirty_log_manual_caps;
> =20
>      s =3D KVM_STATE(ms->accelerator);
> =20
> @@ -2007,14 +2008,20 @@ static int kvm_init(MachineState *ms)
>      s->coalesced_pio =3D s->coalesced_mmio &&
>                         kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
> =20
> -    s->manual_dirty_log_protect =3D
> +    dirty_log_manual_caps =3D
>          kvm_check_extension(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> -    if (s->manual_dirty_log_protect) {
> -        ret =3D kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, =
0, 1);
> +    dirty_log_manual_caps &=3D (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
> +                              KVM_DIRTY_LOG_INITIALLY_SET);
> +    s->manual_dirty_log_protect =3D dirty_log_manual_caps;
> +    if (dirty_log_manual_caps) {
> +        ret =3D kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, =
0,
> +                                   dirty_log_manual_caps);
>          if (ret) {
> -            warn_report("Trying to enable KVM_CAP_MANUAL_DIRTY_LOG_PROTE=
CT2 "
> -                        "but failed.  Falling back to the legacy mode. "=
);
> -            s->manual_dirty_log_protect =3D false;
> +            warn_report("Trying to enable capability %"PRIu64" of "
> +                        "KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 but failed. "
> +                        "Falling back to the legacy mode. ",
> +                        dirty_log_manual_caps);
> +            s->manual_dirty_log_protect =3D 0;
>          }
>      }
> =20
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 265099100e..3cb71c2b19 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -1628,4 +1628,7 @@ struct kvm_hyperv_eventfd {
>  #define KVM_HYPERV_CONN_ID_MASK=09=090x00ffffff
>  #define KVM_HYPERV_EVENTFD_DEASSIGN=09(1 << 0)
> =20
> +#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
> +#define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
> +

The patch looks ok, though ideally I think we need to wait until the
kernel patch got pushed then we'll be sure these macros won't be
overwrite by other ./scripts/update-linux-headers.sh updates (or
another patch to call the update script to fetch the macros...).

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

--=20
Peter Xu


