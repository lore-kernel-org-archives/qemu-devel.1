Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6559C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0167246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXalFZAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0167246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7m9k-0003rz-Rj
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 15:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7m95-0003Fr-9m
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7m94-00020g-BA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:22:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7m94-00020H-76
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582921321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V48eB0sYTW4bGi4KgJbJGdVYGJqatl5bT9d8nVbpgko=;
 b=PXalFZAtdKiC9dJSbJQNdcSNsdteujDSUc8mGbKHUnQtSpg/V2Ide46aOp6VuO9HVbXpWC
 FAOFE19dJdl0nV+/aivPc79nv+W95F0shhy2dDSg7gvbpPXqRT4CQKPIU6G8vEVwNqO9GT
 AQ4ENHijJyUKS56lFJDpZ5B94u/7jzY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-RQ2kLGo6OeG5h9PDa0s11g-1; Fri, 28 Feb 2020 15:21:57 -0500
X-MC-Unique: RQ2kLGo6OeG5h9PDa0s11g-1
Received: by mail-qt1-f199.google.com with SMTP id c22so3845803qtn.23
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 12:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3m+xEEMlhX9H8vmwBA/LI7eyJunic3nSez3kyrIDSQs=;
 b=coqIBOftJZwxwZ0iGgNUckMQvJrYk3RFx67KFwinXbK7aEDcJtytsqBvXqQimvKOk7
 WqaIdv+5ZRDL8ys+DWWf5IOf4aW/le23vPJ8x4pYqeLXaE4DRNh/eRUVS9l+AkImm7GW
 n/gF82qNOHcN9foviPrHHxX681+nBtqdIxOVJJ4Sfe8f9phgd+ky+29ZicdnAtyXpEhs
 1nxoo7E4nyFlnE384NJO//06QtyGEjXA9azlGLj2V/AHcMewlm7l0+WIHRCJulJwhyPD
 c+ZD4QB8c86ueGK5y3KZtB8k+qEWbKfIs8mWJ10TxFKZCZdwyVbJWezBBfQqiR5BuGXP
 5hyA==
X-Gm-Message-State: APjAAAW0WmGTMjECXJguk0xKI7HfDOUT5X6ZhJEUUFv4mJGz6wOOJC6G
 BOHNQDkj34vri173lEm1UDWNWhnV5YWzU2AI8gT0UgqlQltMPu+zTVxmXFhreHa6s9Bgmcnfzb6
 Px7jYEDYVzRRi6mw=
X-Received: by 2002:ac8:4711:: with SMTP id f17mr5746189qtp.160.1582921317186; 
 Fri, 28 Feb 2020 12:21:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJNvraVzkLKPr9n4ofkxwFjFTWS3C765A3x62X9y6H5HGDNeRdh0DjEaXGGNQqU7DQ/7PrRQ==
X-Received: by 2002:ac8:4711:: with SMTP id f17mr5746168qtp.160.1582921316963; 
 Fri, 28 Feb 2020 12:21:56 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k11sm5657197qti.68.2020.02.28.12.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 12:21:56 -0800 (PST)
Date: Fri, 28 Feb 2020 15:21:54 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 15/15] exec: Ram blocks with resizeable anonymous
 allocations under POSIX
Message-ID: <20200228202154.GB180973@xz-x1>
References: <20200227101205.5616-1-david@redhat.com>
 <20200227101205.5616-16-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227101205.5616-16-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 11:12:05AM +0100, David Hildenbrand wrote:

[...]

> +static void ram_block_alloc_ram(RAMBlock *rb)
> +{
> +    const bool shared =3D qemu_ram_is_shared(rb);
> +
> +    /*
> +     * If we can, try to allocate actually resizeable ram. Will also fai=
l
> +     * if qemu_anon_ram_alloc_resizeable() is not implemented.
> +     */
> +    if (phys_mem_alloc =3D=3D qemu_anon_ram_alloc &&
> +        qemu_ram_is_resizeable(rb) &&
> +        ram_block_notifiers_support_resize()) {
> +        rb->host =3D qemu_anon_ram_alloc_resizeable(rb->used_length,
> +                                                  rb->max_length,
> +                                                  &rb->mr->align, shared=
);
> +        if (rb->host) {
> +            rb->flags |=3D RAM_RESIZEABLE_ALLOC;

A trivial nit: If it should only be set automatically by the memory
code, shall we mark it our somewhere just in case someone passed this
in flag explicitly (which, iiuc, is a misuse)?  Maybe:

  assert(!(rb->flags | RAM_RESIZEABLE_ALLOC));

At the entry of this function?  Other than that it looks sane to me:

Reviewed-by: Peter Xu <peterx@redhat.com>

> +            return;
> +        }
> +    }
> +    rb->host =3D phys_mem_alloc(rb->max_length, &rb->mr->align, shared);
> +}

Thanks,

--=20
Peter Xu


