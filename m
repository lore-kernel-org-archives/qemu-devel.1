Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7BC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBD82067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCJ+W473"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBD82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipa1O-00078M-Gy
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1ipZvF-0007Xf-Ax
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1ipZvE-0004vr-7y
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54905
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ipZvD-0004rc-VD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578584431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=almwuBSs5NUAlWxDkD+s8wyQnj6bFYwLWMTQE8sZc4s=;
 b=KCJ+W4737xEF8nklIf7iPzs7YrSXB4M59Jn3jyCJDxXdLFtQBZvdic2xDm/6CCAILQISI/
 /pYfA9txAg3IpjKjDVdYDn3KARHMHM5HG3k9o7dRS1ZEdfxRIv7ibw3RsVppSxCBVLWBna
 HAgANLiNA5X0IdTM/vVarCeLOL2A3kY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-DEOeI66mOtOlyaziu9DcPA-1; Thu, 09 Jan 2020 10:40:29 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so3011882wrp.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 07:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=hgtQssvf0G8mTFfKEg0p7TY23ywk4QqxI1U2lpR+eHU=;
 b=XPwAGPdOV285Z5fxxVXPZfctMcwolripRNeCRDwFUqoxjAcYeD6RJSTxTOHgbtI30k
 akI0ORvIp90W6tTm88mhF4PT228wDX0TaFE9wRJzii/cWJnfVVEN5oV/9GeRzExlqlAg
 FDCbh57wyE6HyhNl7IJ5w8F7fZZi25+m0LqRCSzbq8rv+lnPHT0ZOFA0eLynDMWVZLzK
 ZvX1VP3n+U9igNBUIDeu8pmk6dKID9yMO1Pl4Xp6Nzvmjy8lvJfOQGIsuGzIMh+UDBFe
 1gjMy3jiWe851WOsMCOuDnWAkZv7h20KBKG5smuikp9ENW/1DjOqbtFANtWNvvDBptN1
 kVUg==
X-Gm-Message-State: APjAAAWrEbimL0podyecvZyc43NGRXlxKrwSK0uslBItkq82y6hdYHaj
 tneVbv15IuF+PNMev2G3LpjB5oMf+LMTXzElT5KitO92hem/h/kqYCYozL5kyts9rFe1oxO3M5T
 TmuyutIwSFQ0kF7c=
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr5626052wmj.100.1578584428653; 
 Thu, 09 Jan 2020 07:40:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqydvanIy33TRbcfpb7RpcZZbm5G8e3zip8l6xwNUfXOkVt7MwmJZfOHWjMsaNQS80csBXJWiA==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr5626025wmj.100.1578584428470; 
 Thu, 09 Jan 2020 07:40:28 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id k7sm3097434wmi.19.2020.01.09.07.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 07:40:27 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
In-Reply-To: <3162676e-da40-7a3f-1777-2ed4f3efffe1@redhat.com>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
 <20200109080412-mutt-send-email-mst@kernel.org>
 <20200109132242.GF6795@work-vm>
 <3162676e-da40-7a3f-1777-2ed4f3efffe1@redhat.com>
Date: Thu, 09 Jan 2020 16:40:26 +0100
Message-ID: <87h814r639.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: DEOeI66mOtOlyaziu9DcPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, jasowang@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/01/20 14:22, Dr. David Alan Gilbert wrote:
>> * Michael S. Tsirkin (mst@redhat.com) wrote:
>>> On Thu, Jan 09, 2020 at 12:22:37PM +0000, Dr. David Alan Gilbert wrote:
>>>> Do we want a new memory_region_init for that or just to be able to add
>>>> a flag?
>>>>
>>> I think a flag API is preferable since this can apply to any kind of
>>> region. But can go either way, Paolo's the maintainer there.
>>=20
>> (Copying Paolo in)
>> So what exactly does this flag mean; to me it's 'no vhost' - but is it
>> actually more general?
>
> It has two more effects in addition to no vhost:
>
> 1) it is skipped when dumping the guest (is this a good or bad idea for
> SynIC?)

Imagine we have an not yet consumed message sitting in message page, or
a signalled event, do I understand correctly that these are going to get
lost upon migration? This may not work then -- unless we transfer
in-QEMU synic state somehow separately.

--=20
Vitaly


