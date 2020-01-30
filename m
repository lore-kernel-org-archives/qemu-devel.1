Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D432BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DAB7206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbkyKb2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAB7206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxgj-0002Fj-Ce
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iwxg2-0001q0-Dq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 19:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iwxg0-000669-2G
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 19:27:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27842
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iwxfz-00064B-Ui
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 19:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580344038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/PQsF/oROczdcK8m7w5nKbXVN9HKW2hoUw3TuMQc2E=;
 b=TbkyKb2u9zg4NtgqOo7nC7OyGWCptzxqrowMyeG77NVRQXu6Q5xheUohc6gq2ILuhrvtQt
 rN7H87tquHbH0mxcuuuLgEhPT0jO1GlH1/reJCtbmLjJ9SqpZxkDJhwkk+lzt+vmwoWCux
 EeZzmFJEqjUNAn3SCak3Fa7OdVa++KI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-WmlbH06WOBCrJt3jla45kA-1; Wed, 29 Jan 2020 19:27:17 -0500
Received: by mail-wr1-f69.google.com with SMTP id c17so859251wrp.10
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 16:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j/PQsF/oROczdcK8m7w5nKbXVN9HKW2hoUw3TuMQc2E=;
 b=dAvTqunVJf6X6YyP4zcm/jnbsxQZUuIc5f0CMcFwznXOY6TVyXZNvjfom8GDjmf6mr
 Mu9Jt/w3lA/FmKacbWG2wG7Ew5QV4p9K/qzAvROf26EuNs6+8QO5zRSOub7lHAjyENaB
 iLXqZcJK1TsTCGUdFfXv0t4FpW4e53H8XRRe3DLRd6CguYJqaFqc4DeCdbI4rzxmOqTh
 LAFEFygAebTfRzPk0+wlYbDZSLR3Rp9FX9ptqEH99Cl8lrRM6ZP99sioVsxJuyBGKA57
 b1pQXX3dYs2ATypeMoO1EPHT3KZ0Qkcng4pgP4Ea00SaudsAWifYwcW2BoNE2ZXJx7Ms
 nJFg==
X-Gm-Message-State: APjAAAUnStrrZewnpYcXCVVpbmO/LeN10xxzJ1ACcoWJHMHhuEPer2P0
 Ej/s50EO2JpGhxgP+o5z/GjVgjjmasndSuC2F5ljnOmZQrivB9pvXkejp6gfSxnRDQOJOfPImRc
 DqqoyRY5zHAy4ehg=
X-Received: by 2002:adf:e686:: with SMTP id r6mr1570655wrm.177.1580344035677; 
 Wed, 29 Jan 2020 16:27:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8tq/+TuB40OdRWKnY2W934BNpbg33IQGF3MZB7n6LdNmnvQfTUYOZhMrDut/QRYd/hPLqwQ==
X-Received: by 2002:adf:e686:: with SMTP id r6mr1570624wrm.177.1580344035315; 
 Wed, 29 Jan 2020 16:27:15 -0800 (PST)
Received: from [10.1.251.141] ([80.188.125.198])
 by smtp.gmail.com with ESMTPSA id s22sm4065964wmh.4.2020.01.29.16.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 16:27:14 -0800 (PST)
Subject: Re: [PATCH] seqlock: fix seqlock_write_unlock_impl function
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
References: <20200129144948.2161551-1-luc.michel@greensocs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1ce57c0-7947-e569-cbcb-f47e5b5b3aff@redhat.com>
Date: Thu, 30 Jan 2020 01:27:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200129144948.2161551-1-luc.michel@greensocs.com>
Content-Language: en-US
X-MC-Unique: WmlbH06WOBCrJt3jla45kA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/20 15:49, Luc Michel wrote:
> The seqlock write unlock function was incorrectly calling
> seqlock_write_begin() instead of seqlock_write_end(), and was releasing
> the lock before incrementing the sequence. This could lead to a race
> condition and a corrupted sequence number becoming odd even though the
> lock is not held.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  include/qemu/seqlock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/seqlock.h b/include/qemu/seqlock.h
> index fd408b7ec5..8b6b4ee4bb 100644
> --- a/include/qemu/seqlock.h
> +++ b/include/qemu/seqlock.h
> @@ -53,15 +53,15 @@ static inline void seqlock_write_lock_impl(QemuSeqLock *sl, QemuLockable *lock)
>      seqlock_write_begin(sl);
>  }
>  #define seqlock_write_lock(sl, lock) \
>      seqlock_write_lock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
>  
> -/* Lock out other writers and update the count.  */
> +/* Update the count and release the lock.  */
>  static inline void seqlock_write_unlock_impl(QemuSeqLock *sl, QemuLockable *lock)
>  {
> +    seqlock_write_end(sl);
>      qemu_lockable_unlock(lock);
> -    seqlock_write_begin(sl);
>  }
>  #define seqlock_write_unlock(sl, lock) \
>      seqlock_write_unlock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
>  
>  
> 

Queued, thanks very much.

Paolo


