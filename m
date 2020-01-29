Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7106C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64235206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGfxVLgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64235206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpbo-0004Lx-C2
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwpb0-0003t3-00
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwpav-0000A1-Ms
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:49:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27413
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwpav-00008R-JH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580312972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BuS436/+EwLVentl33YO0hXsAGWTcwkIW0tLrCrBQaw=;
 b=WGfxVLgQadXuhTHPdSNwk5XfLdzhok0HL6v8gs1Tg3kBoRR34LNvEY8ADQqCWYZg/AMcZy
 Ha24ZGAhZ+7CrRGMAvN6hV+inh/CvQV87pVT60q6AYPtI2e5Nq4rjZq18yNhgE3CsJ02ed
 DvfKfxdNq30frEP25SoH2ykwCgg7J7M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-nrVExUyyMbSffQD6cKxQkw-1; Wed, 29 Jan 2020 10:49:30 -0500
Received: by mail-wr1-f72.google.com with SMTP id f10so8461wro.14
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5fTEHl1xax71sJ9e+W6+JevkbtdD40pu043c/0UOeg8=;
 b=WnOFbWjbRDOuM/Ak20k0qBoMEIzDM/lzFen/VtDXiSCdoWrJmwsWI5k+RKlUzhooCu
 GwBrCICpfagF3PTLCgmLZ2ybaow9+86VKNQePaKNtTuRawJuR3YwK3li65xCgg9gXpSQ
 Rsh6JtDeAGWwsX4uxCQkJ+zg1ZNVpBIi8TMQ8FlUToROGAW15XBsOw4QpH7T9HWZnt7s
 p9GEFRCZ/k69DWo28g5Q+GZzc734Pn0AVLqCDno3HH2ieYpmR1F7TgiN8tbR0o1QS9kJ
 D9ae/bofs9SxWyJfYPYaMgVJZdNx8A/FVBzqs7JKD0aCXTbs1XrJpU9SAeO1XEKrMUuT
 nD8A==
X-Gm-Message-State: APjAAAXS1Yrl7YVMugcbRTdVtXY74pPd/LWv8KBLYvVokqILd18KQB6B
 puv//36lGJZFv/+iMVylqPzWiJEVpsjd3out806Qp/R8d9UpQwzO+LWCQ7rPtljGFdOHgXMFNUE
 SJriD3uzQyttC/+8=
X-Received: by 2002:a1c:5419:: with SMTP id i25mr12386377wmb.150.1580312969331; 
 Wed, 29 Jan 2020 07:49:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9HPwUE2ua6bMNhxLNdT9aWl/yrn+Ou4WqZTkvueheSjISqAeNP3/fMuvOtgzx4TVD+Nw5xg==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr12386359wmb.150.1580312969115; 
 Wed, 29 Jan 2020 07:49:29 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d16sm3567162wrg.27.2020.01.29.07.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 07:49:28 -0800 (PST)
Subject: Re: [PATCH] seqlock: fix seqlock_write_unlock_impl function
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200129144948.2161551-1-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b2cd7d52-dde6-fd4c-0066-9c5e66d9a340@redhat.com>
Date: Wed, 29 Jan 2020 16:49:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129144948.2161551-1-luc.michel@greensocs.com>
Content-Language: en-US
X-MC-Unique: nrVExUyyMbSffQD6cKxQkw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 3:49 PM, Luc Michel wrote:
> The seqlock write unlock function was incorrectly calling
> seqlock_write_begin() instead of seqlock_write_end(), and was releasing
> the lock before incrementing the sequence. This could lead to a race
> condition and a corrupted sequence number becoming odd even though the
> lock is not held.

I'm surprised it took 18 months to figure this out.

Fixes: 988fcafc730
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>   include/qemu/seqlock.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qemu/seqlock.h b/include/qemu/seqlock.h
> index fd408b7ec5..8b6b4ee4bb 100644
> --- a/include/qemu/seqlock.h
> +++ b/include/qemu/seqlock.h
> @@ -53,15 +53,15 @@ static inline void seqlock_write_lock_impl(QemuSeqLoc=
k *sl, QemuLockable *lock)
>       seqlock_write_begin(sl);
>   }
>   #define seqlock_write_lock(sl, lock) \
>       seqlock_write_lock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
>  =20
> -/* Lock out other writers and update the count.  */
> +/* Update the count and release the lock.  */
>   static inline void seqlock_write_unlock_impl(QemuSeqLock *sl, QemuLocka=
ble *lock)
>   {
> +    seqlock_write_end(sl);
>       qemu_lockable_unlock(lock);
> -    seqlock_write_begin(sl);
>   }
>   #define seqlock_write_unlock(sl, lock) \
>       seqlock_write_unlock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
>  =20
>  =20
>=20


