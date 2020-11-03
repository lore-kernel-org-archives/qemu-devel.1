Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E51DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3539E2072C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6RmiUje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3539E2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzK9-0003B2-9S
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZzJH-0002bd-Tz
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:37:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZzJG-0007bI-6Z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604421444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J6YvgHAwlz4iV1ZQgZv2DUJcFbEr6dcFvxuLoxix+ew=;
 b=e6RmiUjeMVKLRmgd7Qu5TfkuRGKUE/H6svn2GwlP5vPje+dOYlBQiF1QsPy3wWDzXM24ir
 eKW/j/TRvn3AiZrrcW/Og6oKjQm/KAY5HN6Yg+seJ42yU+hF8daqUVFOP+ulRu/Nt0iyrl
 H3gW3YlugYXmxA94AAoAndlTQtAwgQM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-JlxMqC6bM8iKMzjjPr6sOw-1; Tue, 03 Nov 2020 11:37:23 -0500
X-MC-Unique: JlxMqC6bM8iKMzjjPr6sOw-1
Received: by mail-qv1-f71.google.com with SMTP id l16so9434303qvt.17
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J6YvgHAwlz4iV1ZQgZv2DUJcFbEr6dcFvxuLoxix+ew=;
 b=raQndyKFfzOXQZo2n9AajQeEThKfTndokPq7ZuDxgLrA/ZZ++ZU4M4pktJO/uPgSCr
 pK+DfKiOjx1d8iXrt1JlAFaTtT2jYVYbz/BGQvqup2nXIO+kk+9ozzJ/q4edIbV9CUSo
 giz/DqydShcJY2ABqMrYYWhBL48owvlOQWrPQrtq3nIqUWBQptpI4dN3/iCM7OPPIdr+
 JZBQTu3NK73LgTJBXpLlvBpDiaNo5kOaBGgLjqQ5zDdW+rwN1HtKvTPvBn0LYUZN3TjK
 yEF0lYUsu5jR0/7IQlCleOHab9Xdz/JqvI9dtN+o1eCQPdCjOWNPsXxATe2Dm0veFuVE
 5rMA==
X-Gm-Message-State: AOAM531m5FMFY12jNzlIBV8iIksr54xbWvRRCV1+vdgNe1SZJPzMvjzX
 GJYm/OJxJAPc9P9I7UPSQ2VfxBvENZTTsj/COybPKb5VqH/2uzZk47ChWg1Z4G1j9N8fxeJP1pQ
 uHX937CcBGGVAsG0=
X-Received: by 2002:a0c:f3c2:: with SMTP id f2mr11281288qvm.24.1604421442426; 
 Tue, 03 Nov 2020 08:37:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2Nhw/TyEkkvpNgTUJ3BNUUoC278hISsfdvr2Aod1HFqRcQrh0iCttpz0Gv3ouBwTWITKqJQ==
X-Received: by 2002:a0c:f3c2:: with SMTP id f2mr11281272qvm.24.1604421442156; 
 Tue, 03 Nov 2020 08:37:22 -0800 (PST)
Received: from xz-x1
 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
 by smtp.gmail.com with ESMTPSA id i18sm10534031qtv.38.2020.11.03.08.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 08:37:21 -0800 (PST)
Date: Tue, 3 Nov 2020 11:37:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
Message-ID: <20201103163718.GH20600@xz-x1>
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <20201102195729.GA20600@xz-x1>
 <87v9emy4g2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87v9emy4g2.fsf@vitty.brq.redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 02:07:09PM +0100, Vitaly Kuznetsov wrote:
> In case it is a normal access from the guest, yes, but AFAIR here
> guest's CR3 is pointing to non existent memory and when KVM detects that
> it injects #PF by itself without a loop through userspace.

I see, thanks Vitaly.  I think this kind of answered my previous confusion on
why we can't just bounce all these to QEMU since I thought QEMU should try to
take the bql if it's mmio access - probably because there're quite a lot of
references to guest memslots in kernel that cannot be naturally treated as
guest MMIO access (especially for nested, maybe?) so that maybe it's very hard
to cover all of them.  Paolo has mentioned quite a few times that he'd prefer a
kernel solution for this; I feel like I understand better on the reason now..

Have any of us tried to collect the requirements on this new kernel interface
(if to be proposed)?  I'm kind of thinking how it would look like to solve all
the pains we have right now.

Firstly, I think we'd likely want to have the capability to handle "holes" in
memslots, either to punch a hole, which iiuc is the problem behind this patch.
Or the reversed operation, which is to fill up a whole that we've just punched.
The other major one could be virtio-mem who would like to extend or shrink an
existing memslot.  However IIUC that's also doable with the "hole" idea in that
we can create the memslot with the maximum supported size, then "punch a hole"
at the end of the memslot just like it shrinked.  When extend, we shrink the
hole instead rather than the memslot.

Then there's the other case where we want to keep the dirty bitmap when
punching a hole on existing ram.  If with the "hole" idea in the kernel, it
seems easy too - when we punch the hole, we drop dirty bitmaps only for the
range covered by the hole.  Then we won't lose the rest bitmaps that where the
RAM still makes sense, since the memslot will use the same bitmap before/after
punching a hole.

So now an simple idea comes to my mind (I think we can have even more better,
or more complicated ideas, e.g., to make kvm memslot a tree? But I'll start
with the simple): maybe we just need to teach each kvm memslot to take "holes"
within itself.  By default, there's no holes with KVM_SET_USER_MEMORY_REGION
configured kvm memslots, then we can configure holes for each memslot using a
new flag (assuming, KVM_MEM_SET_HOLE) of the same ioctl (after LOG_DIRTY_PAGES
and READ_ONLY).  Initially we may add a restriction on how many holes we need,
so the holes can also be an array.

Thoughts?

Thanks,

-- 
Peter Xu


