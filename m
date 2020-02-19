Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B561C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315B324654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuL15iYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315B324654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4WK1-0005O4-DI
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 15:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4WHW-0002Ck-VP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4WHV-00005G-VA
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:49:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4WHV-00004w-RA
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582145357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oicdxW+KQjgq+6hsv3N6RbpUXKl3GH1uCs1DUkzWoIg=;
 b=CuL15iYEsxQfuV+T1fyvGklofA4TsfqCnQ5EmSKGpqOAt1IZY88KodCM2iunmI6Cj+ddYJ
 ofMelQs5/F9mHV38QnBqS2qff+lbDY/B8n12p5jSR6acCOR+N1uE9smITBRY3qV9FXlL91
 IUXzai0EnYF/oES1Q5tBh+i9NVLTFCY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-CjrP7wwuODiNfCR4QEfiwA-1; Wed, 19 Feb 2020 15:49:13 -0500
Received: by mail-qv1-f71.google.com with SMTP id c1so1057950qvw.17
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 12:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3TAiXbtWFFPzTtWbje4hIoh7hZLZlwCaGN9W2jWkAKo=;
 b=VjbFBdCMQiC82VzT4A/ePw4sMJSF/KvQadZsP0Voty/fq9ryqM5bdIUoIJ+i+FLuxb
 4B4uvyexA06OL2xxlol9GzjPj8k/2oPHdlBJWO9FMg+89KZ6FgrN0dIXwFyqzfsx4s95
 r0IfZKpLHCuCwHJmTREdmb6d+iP68n0dXzilXnNLXOWzLtPr6xeg2mEJ/GY1s7xJEeSV
 U1Sy6Kh4/ZEziHSP4FGrOtY2D+YEeC2xfLHyy8LwXOfCABJuYvR8Ez2swCnoISbGPBG0
 PfrCf7l9fXx1U44mmYjbY5p2D63TxzgnDnmD8h2AVfVy+PqaMr+vhjab8n70OlTdWV2m
 Zurg==
X-Gm-Message-State: APjAAAWn3ssXmDx558Rb9cODO4i6o/FVSWUSkGuXzxvZXJcESYqR5XiM
 lyXpmfuFcUWWGsU5dVETXjjJmaNnsLFD+nvekR3CRD4XYNK3agdAycCro7T+qtQQ3Rl9HayV4ze
 tALB/Iinx3pJ/GH4=
X-Received: by 2002:a0c:f910:: with SMTP id v16mr22842232qvn.108.1582145352984; 
 Wed, 19 Feb 2020 12:49:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWdFJ7OiZvqIc6dWPFjRJhIYpZlyqE450b5AICm4HA6tl5Bpyc6cIDC9laCng7/AprTkBTKw==
X-Received: by 2002:a0c:f910:: with SMTP id v16mr22842209qvn.108.1582145352708; 
 Wed, 19 Feb 2020 12:49:12 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id y21sm581116qto.15.2020.02.19.12.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 12:49:12 -0800 (PST)
Date: Wed, 19 Feb 2020 15:49:10 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 04/13] numa: Make all callbacks of ram block notifiers
 optional
Message-ID: <20200219204910.GF37550@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-5-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200219161725.115218-5-david@redhat.com>
X-MC-Unique: CjrP7wwuODiNfCR4QEfiwA-1
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
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 05:17:16PM +0100, David Hildenbrand wrote:
> Let's make add/remove optional. We want to introduce a RAM block
> notifier for RAM migration, that's only interested in resizes.
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


