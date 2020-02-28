Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA10C3F2D3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D80B24677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7agFL6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D80B24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7m0f-00059B-B4
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 15:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7lzK-0003uX-3W
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7lzJ-00057u-4f
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:11:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7lzI-00057k-Vh
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582920716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=han508/FxdHhtDXvppDX3aTxKnat/L4Vu13AHT3vgxg=;
 b=L7agFL6lmJESxiX/eWosrjteYMWX/ROOmLu9QN1XNbpXg3znLJ96w9ZE263243gT2KXhZp
 mg68aR1FAfFOGeyjDReVlmgSZZvL/xq7QscQPvmUk390BMJLiLZoFp7OuFcKcGyRoMEsUL
 aIcD07sz6Bztf+uT1fM+RZ+Zt/fZ1hg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-bUuslc3WNI23e3P5cvX4TA-1; Fri, 28 Feb 2020 15:11:54 -0500
X-MC-Unique: bUuslc3WNI23e3P5cvX4TA-1
Received: by mail-qk1-f197.google.com with SMTP id n130so3834318qke.19
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 12:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J+1nhwq+qDDbfhAuc95fcFCk8/yKkQVs/lAYRUCEV2k=;
 b=fkdBV942K13LDHxGesWGyaK5K0NU9XOFxwi4RfosvNEnQ1sMG0yanjHWdHBgluXsec
 pSk4WSFar5JviVpoKn9F4ekHa4ATToWLElA0aT6RM2xMzES8ZsLHkP47HWEhLiG5yxcp
 4+Hr2+s0ql+Evirah6e37n3EC5e6eKvSHFyJ+0boUBZcfObOgt6kW5pW8JSdtdgJpjIf
 p7ZEAdDX9KKWh+vl/TXEOP7W8E3UXRPq15/K+ZkKL1NXn/AMYEy7HR9ZV+ONdPp7Tmwh
 VlMztfDSLdw8R/fqkD9Dd4tOewXxqnVG1pHtANzg6Tx0bma3Zm0P9iwVrwwGqSVOUJ1P
 Yv0Q==
X-Gm-Message-State: APjAAAWEhslu1jrSA3Z9g9/N5U8p4BAaHs8d9fKC6T1jR6H+HHck3z5p
 GPcXQ5iE7N7X0U3FXjO23yzfJpRBRAraIXiQwRGhz2zBm6Q3LhklCA9HSZnZ+foIvcKq0xhYcA+
 yNVO5EkP0L4eajhw=
X-Received: by 2002:a37:6843:: with SMTP id d64mr6082289qkc.207.1582920714328; 
 Fri, 28 Feb 2020 12:11:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwgyJ5on7+uSkR2fMj0bjb3o9g7U8WXomonr6hfcXht6gM7b6VBDcSJ6GFdtIHYTj79QZvk5w==
X-Received: by 2002:a37:6843:: with SMTP id d64mr6082269qkc.207.1582920714132; 
 Fri, 28 Feb 2020 12:11:54 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k16sm5593798qkh.55.2020.02.28.12.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 12:11:53 -0800 (PST)
Date: Fri, 28 Feb 2020 15:11:47 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 14/15] numa: Introduce
 ram_block_notifiers_support_resize()
Message-ID: <20200228201147.GA180973@xz-x1>
References: <20200227101205.5616-1-david@redhat.com>
 <20200227101205.5616-15-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227101205.5616-15-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 11:12:04AM +0100, David Hildenbrand wrote:
> We want to actually use resizeable allocations in resizeable ram blocks
> (IOW, make everything between used_length and max_length inaccessible) -
> however, not all ram block notifiers can support that.
>=20
> Introduce a way to detect if any registered notifier does not
> support resizes - ram_block_notifiers_support_resize() - which we can lat=
er
> use to fallback to legacy handling if a registered notifier (esp., SEV an=
d
> HAX) does not support actual resizes.
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


