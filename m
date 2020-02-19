Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A00FC34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D94E207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxYLb/I2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D94E207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4WIF-0002iu-Aq
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 15:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4WGu-0000uk-Dt
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4WGs-0008Bt-23
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:48:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39737
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4WGr-0008BL-Tx
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582145317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WHU3ZqTfeswbEWOmBD3PXUmmGojZ0coXnYJ1AJvfDg=;
 b=PxYLb/I2ZszEroouw9Phrt3TZQpcoNLkqhBk6MoP5V7E0GQnl7PYT/JmFguvxQ4TppE7CU
 7z6KKkip7hXjkMkULLXhf4r1NiQGzsr7MOMF6wS/8IVpIKkmv5mAauXL0mTy42UsloQAxd
 1p5LZsP/qhMERiZXqQV+fTVZ+XtAcSA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-Z03qydyTMpKnHQO0ogUbMA-1; Wed, 19 Feb 2020 15:48:30 -0500
Received: by mail-qv1-f72.google.com with SMTP id g9so1053820qvy.20
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 12:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DFsSD9HJ/VzhserxGeD2UDYUVDfb0+EQA4Py2kAmj1s=;
 b=K7oC2mW4+96bVtPs3QVw/vgmmzma5BLSVK0WDyIzWjqZS0uX3ZN+GjHHoHUsD51t78
 y26RbmKGhb9Rv1eXgeHs2FlwbVBg9Swb+fWs56Qurczv7vc/lqH8eIU5bhJfmfZVnIrq
 ZTxtooEQqhKiOxI2QljheY/wZVPhEpUCueEMiwZzyZAUblc8Mxb4n7mjZ06aiq1UWNlJ
 A8qhzIArSKvN2YpwjpIX9lFcNZFLqs1W01clg5iWu5S4deomdHrtwDjUYrUHKY3ADsbf
 Fqh9yL8RFdrHkqXQmRhSwNqRg3BBnPj6J71GAmnxO7+wyq97GbgXFg6QdTxYS91MizRn
 Chzg==
X-Gm-Message-State: APjAAAV7DTyY76NAQqea9+A8A1OIxp8woddt3G8gCrzMO/HEc8tH28mw
 EgnjzM68Nyr44q2vQZ4rvUZborusaKN8y759l+aJ1HXz3mgf5v/LbLS9av5MzC6dLO4gxv1SrTh
 QtaCqFV/GRx5qmm4=
X-Received: by 2002:a05:620a:47:: with SMTP id
 t7mr23921832qkt.432.1582145310525; 
 Wed, 19 Feb 2020 12:48:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzuUyLMGBJXkaoXDpcxwFI/fWoaAHipOVhiRXcbOC+CrEiuUNXAuSR9Ptlfu68FXwB9ErTtVA==
X-Received: by 2002:a05:620a:47:: with SMTP id
 t7mr23921814qkt.432.1582145310304; 
 Wed, 19 Feb 2020 12:48:30 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id h34sm634837qtc.62.2020.02.19.12.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 12:48:29 -0800 (PST)
Date: Wed, 19 Feb 2020 15:48:28 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 01/13] util: vfio-helpers: Factor out and fix
 processing of existing ram blocks
Message-ID: <20200219204828.GC37550@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-2-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200219161725.115218-2-david@redhat.com>
X-MC-Unique: Z03qydyTMpKnHQO0ogUbMA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 05:17:13PM +0100, David Hildenbrand wrote:
> Factor it out into common code when a new notifier is registered, just
> as done with the memory region notifier. This allows us to have the
> logic about how to process existing ram blocks at a central place (which
> will be extended soon).
>=20
> Just like when adding a new ram block, we have to register the max_length
> for now. We don't have a way to get notified about resizes yet, and some
> memory would not be mapped when growing the ram block.
>=20
> Note: Currently, ram blocks are only "fake resized". All memory
> (max_length) is accessible.
>=20
> We can get rid of a bunch of functions in stubs/ram-block.c . Print the
> warning from inside qemu_vfio_ram_block_added().
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


