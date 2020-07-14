Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA0AC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AC42145D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8SeSsLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AC42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFne-0003oS-AF
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvFmm-000380-0w
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:55:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvFmj-0005BD-G3
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594713328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzH2VvrhXRsNG8azCI3t0Sju5lO1d/8A9XERbQDKyw0=;
 b=J8SeSsLeLAJyo4YaMgMvTgJ4+61QyHnxQGIncoHIRCvhdOp6iYYdAGkeyCmC89Wb2640k5
 rwNaX2ih7uuadEmu8OJo/7Wc7b+2Pd+SVtkqiHSfCjYlO4BzaX49eaf8aibLTcV/hZzuYN
 HGaDordDsl1HXK8IdNes2RBl2CKTpXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-bsh3qauYO7W9t9fXGCAvlw-1; Tue, 14 Jul 2020 03:55:26 -0400
X-MC-Unique: bsh3qauYO7W9t9fXGCAvlw-1
Received: by mail-wm1-f72.google.com with SMTP id z11so2779512wmg.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 00:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mzH2VvrhXRsNG8azCI3t0Sju5lO1d/8A9XERbQDKyw0=;
 b=aaYWnUG+PA+a8eQ/tY4TG75E7I0tnDlPQ90zRahtOHZG1RCfE7eI/t6SJ2hwC4j6qX
 hnNTrBMT/ROWyWAlxIuDvkWv+J+ct609xlPgepQNDx/fzBEAO0zDkDYxkeCe5quLbpo/
 WsTznABe/4GA7rVvapP/qAy7SyobtYjpsL362IvQ6AnFIs4MsLUuIvSrVoZAK7CbjvcQ
 6keHSCxQt9nyS7EHuLTSETWHawzG4YfmcMOR5LKMeLviKUI84UQcdrbOxNj6gBqAvbjT
 tjjpknL0uY5+SZ5XmBoNrFnZj4P5BoUdUaigzch23JuD2rxeHLmgw8DTauRpACSNnt89
 Mp5Q==
X-Gm-Message-State: AOAM532XW0q9ZGd+MLHaq9Kl965E2UjKt98f50LIFh/EJzGemXr3H085
 pqtBi+pAVdM311HpgNI4R9Z8ZI1YiSrwaVKHslL63JCFZz2sXw2Fz2o6L+2ZSPld5hWfPKskmca
 VglUt54jmWZgB5fU=
X-Received: by 2002:a1c:5ac3:: with SMTP id o186mr2993602wmb.39.1594713325000; 
 Tue, 14 Jul 2020 00:55:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvpgAD2uRB9NxCoiAxYIcHANwIo5dkA/mGxcevqj87IrRjjB7fSdFe7YLolxQTJIPYdC+2Xg==
X-Received: by 2002:a1c:5ac3:: with SMTP id o186mr2993581wmb.39.1594713324737; 
 Tue, 14 Jul 2020 00:55:24 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id a22sm2948485wmb.4.2020.07.14.00.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 00:55:23 -0700 (PDT)
Date: Tue, 14 Jul 2020 03:55:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] Allow acpi-tmr size=2
Message-ID: <20200714035300-mutt-send-email-mst@kernel.org>
References: <5f12377f-b640-c4c5-1bcd-858c622c6c31@the-jedi.co.uk>
 <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
 <20200713070946-mutt-send-email-mst@kernel.org>
 <7662bc2c-d958-731a-0882-62c5ab47c7a4@the-jedi.co.uk>
 <20200713081627-mutt-send-email-mst@kernel.org>
 <34d24b3a-75ec-ad94-c61b-2ebe4a0f277a@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <34d24b3a-75ec-ad94-c61b-2ebe4a0f277a@msgid.tls.msk.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Simon John <git@the-jedi.co.uk>, imammedo@redhat.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 05:16:56PM +0300, Michael Tokarev wrote:
> 13.07.2020 15:17, Michael S. Tsirkin пишет:
> > On Mon, Jul 13, 2020 at 12:46:00PM +0100, Simon John wrote:
> >> I don't profess to understand most of this, I am just a user who found
> >> something didn't work and tracked down the cause with help from the people
> >> on the bugtracker.
> >>
> >> the min=1 and max=4 was chosen as it seems to be set that way in most other
> >> places in the source, and 2 fits in that range.
> >>
> >> so as macos seems to require 2 bytes but spec says 4 (32 bits) would it be
> >> better to set min=2 max=4, given that the original revert seems to be a
> >> security fix?
> 
> It's not about the security fix, it's about the piece in qemu code which
> behaved wrongly for several years, which finally started to actually work.
> 
> >> this works equally well:
> >>
> >> static const MemoryRegionOps acpi_pm_tmr_ops = {
> >>     .read = acpi_pm_tmr_read,
> >>     .write = acpi_pm_tmr_write,
> >>     .valid.min_access_size = 2,
> >>     .valid.max_access_size = 4,
> >>     .endianness = DEVICE_LITTLE_ENDIAN,
> >> };
> >>
> >> regards.
> >>
> > 
> > Sounds good. And how about also adding:
> 
> What this call will receive on a real HW? returning the same 4 bytes
> even when asked for 2 smells wrong, no?
> 
> >       .impl.min_access_size = 4,
> 
> What does it mean? :)
> 
> /mjt

This will allow you to return a 4 byte value and will shift it
accordingly.

See: docs/devel/memory.rst :
- .impl.min_access_size, .impl.max_access_size define the access sizes
  (in bytes) supported by the *implementation*; other access sizes will be
  emulated using the ones available.  For example a 4-byte write will be
  emulated using four 1-byte writes, if .impl.max_access_size = 1.


-- 
MST


