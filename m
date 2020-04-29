Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9218C83009
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9347720B80
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJk1Y3O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9347720B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTo0k-0004BK-3r
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTnzs-0003YD-Io
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTnzr-0003TO-FA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:47:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27951
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jTnzq-0003T8-TR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588171654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lEtLDyp7iFnZjul8Zm0DuDY7EJzkmLrU8teGYAr/28=;
 b=FJk1Y3O8TpoTh5JaDWKyaQNKT49P40BR2d3e7iUgkHC77E2FsaeLduAA9vvYyMV8BTIlUP
 0qssUZ96sDDQi8LAXDH/3TqrfCFg67UqU06/h/WoUNEcl1RvUzMMzK7Bvu3K4R8gwhsKfJ
 xtSHMqB6Ub4yyCL9iQqwy8WP+2b0YSc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-msrCTe9xNdy3h_wZ9Oi42Q-1; Wed, 29 Apr 2020 10:47:32 -0400
X-MC-Unique: msrCTe9xNdy3h_wZ9Oi42Q-1
Received: by mail-qk1-f198.google.com with SMTP id 198so2901122qkf.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yPAsUBIs03h4yunxvaD+gRFwr2wU1gJ1iuNONBVz6TQ=;
 b=SUQeBoZ9YvmmXE5trW9yBZl16/eluT7jsMI/VAAT2vN3YovbQKfZ4aN5TPdU5VL9D/
 5DFZ8X5O27kE0vMLIuS91GaOh+veoyW6UY1Lh+TkbyVPNtZRldmMsH6zsDXrlAJNgzgf
 JeYsAPO1e8MbQK6TSro2gRfgc7qhCYV8GLgjW/5OusUCpkk/gKjHQhFKKlmQXo2CUVsd
 Tzi/hGOPakmgTnebjD9OP95s721uHPFJgGRmEY11R411YzI8mMoiAByG77MHioudVYu0
 ntAute0vnFeibmvwY4Q9dIhOFXYmAu1bRv/h0ztQ9NtNg5R29UQSbI1glrTkcWPy0HHi
 oJNg==
X-Gm-Message-State: AGi0PuaXNroUW+lQAMIq8X1z+qjnQeuJUqGSyuoo/YQ2R5X83aann281
 jQZ7zy94I4+dlq0UVcVML83ytUxR5QDrGDe7l0vBpVDbo2hHB3ZHhJN9kjjaFcLSxuzVZHebiu4
 Qwcif2bKOACaEsfF0cBD3ZsFn17+I6gk=
X-Received: by 2002:a37:a102:: with SMTP id k2mr12358313qke.199.1588171652138; 
 Wed, 29 Apr 2020 07:47:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypLuAAW+UNJEJ418Ix6qNVbDQZb5IiKtpEyGiY9UPaEhGj3h/Uzql0N3iWGJ7qa1+9l52/IXZknWigVmD43Rg1U=
X-Received: by 2002:a37:a102:: with SMTP id k2mr12358296qke.199.1588171651937; 
 Wed, 29 Apr 2020 07:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200429124733.22488-1-mszeredi@redhat.com>
 <20200429143600.GE231284@redhat.com>
In-Reply-To: <20200429143600.GE231284@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 29 Apr 2020 16:47:19 +0200
Message-ID: <CAOssrKcOgP7eLo+uQdv==HssuqU3qpBKibvYAXypU88QXvypKw@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: jail lo->proc_self_fd
To: Vivek Goyal <vgoyal@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 4:36 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Apr 29, 2020 at 02:47:33PM +0200, Miklos Szeredi wrote:
> > While it's not possible to escape the proc filesystem through
> > lo->proc_self_fd, it is possible to escape to the root of the proc
> > filesystem itself through "../..".
>
> Hi Miklos,
>
> So this attack will work with some form of *at(lo->proc_self_fd, "../..")
> call?

Right.

>
> >
> > Use a temporary mount for opening lo->proc_self_fd, that has it's root =
at
> > /proc/self/fd/, preventing access to the ancestor directories.
>
> Does this mean that now similar attack can happen using "../.." on tmpdir
> fd instead and be able to look at peers of tmpdir. Or it is blocked
> due to mount point or something else.

No, because tmpdir is detached, the root of that tree will be the
directory pointed to by the fd.  ".." will just lead to the same
directory.

Thanks,
Miklos


