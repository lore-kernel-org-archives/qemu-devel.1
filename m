Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2029C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF7320787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OheRfsUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF7320787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThjz-0002GN-Q2
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jThgN-0004ze-Hg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jThdK-0002Ju-6x
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:03:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30937
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jThdJ-0002Jl-PE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588147192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slkTxr4aAjAq40yrag2UiNVbydADFCBElOueerHLyhM=;
 b=OheRfsUsBU+00upur4C9qh0HOojP165lh63Ad9kPu1q6vxRTIH2LVRZ8Jqe4IbGq7UNeXJ
 9N5eemMptULNBbZPmghs6DWeaAwq/neTjBhxP4lUg9vUoYDP07CbqyUD/IeHdRfCEZdiX3
 aH1T+uVQdghQ/f4ShA8Z9pYrOrB59/4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-HkI_HzZnMyOLFo5cDOsqFQ-1; Wed, 29 Apr 2020 03:59:50 -0400
X-MC-Unique: HkI_HzZnMyOLFo5cDOsqFQ-1
Received: by mail-qv1-f72.google.com with SMTP id cr5so1710368qvb.14
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 00:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=slkTxr4aAjAq40yrag2UiNVbydADFCBElOueerHLyhM=;
 b=CFmQ4++UiukWqsx2H+2Od/16Y7hbcVYd9IQ9F/gspUNT2FvFF2E1x+uxK0W05ufxFs
 fkT3UoLpu2C0HUJxdUO0Hbol9bIVr3N5JVKv9V0hTb3P6xAAbJDL3d2LqewCFeGe2XFy
 k/NYFtMqcxCokWSAqsfCkBzl0yUtPoJxwp1SNG4fMduKngVPIkhUfXq6qgxNGNkp+BlA
 j6yllNZPs289cgCN596GCIxRGLguJEbuxmgYMreoOpgc+r0fM+wwlENoGqDwNjLBLqM/
 1IiqWlBrLgYOSqUwM1uOiPigwki693xLj8u0qD5tJtZ40O/oa68uqDQq20EasAzrzatS
 LoCw==
X-Gm-Message-State: AGi0PuYw/V0XTzK7QfzRF9+zx/VDRY/HqK8L/DrRuJ8QEQWv+CuptDQk
 NV6Qj0KUaKWIPDkA+WD9fFG/W7IyILZNjqNJTzECe3pxrFW5yoBpuFJ6eS0WDI+zlrWyboct79W
 U31AiF+fpOy7J8WY4tmoFO76uEv2wN3g=
X-Received: by 2002:aed:2e83:: with SMTP id k3mr33373047qtd.2.1588147190129;
 Wed, 29 Apr 2020 00:59:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypJTWi0pdVdHLnuS+xa6cQqFh2tFMwkwfuzHcfvbnO+pYwBTGa+Wqv+qIQzOmetvEoIt2TwKaomTnO0fQ5QUdoA=
X-Received: by 2002:aed:2e83:: with SMTP id k3mr33373034qtd.2.1588147189882;
 Wed, 29 Apr 2020 00:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
 <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
 <20200428191523.GU2794@work-vm>
In-Reply-To: <20200428191523.GU2794@work-vm>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 29 Apr 2020 09:59:38 +0200
Message-ID: <CAOssrKcsVvMok6i+vAm1KJaq07Ep9JLcMiB1nWhsNU2n1m-Fmw@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Show submounts
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 9:15 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:

> So our current sequence is:
>
>    (new namespace)
>  1)    if (mount(NULL, "/", NULL, MS_REC | MS_SLAVE, NULL) < 0) {
>  2)   if (mount("proc", "/proc", "proc",
>            ....
>  3)   if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
>  4)  (chdir newroot, pivot, chdir oldroot)
>  5)   if (mount("", ".", "", MS_SLAVE | MS_REC, NULL) < 0) {
>  6)   if (umount2(".", MNT_DETACH) < 0) {
>
> So are you saying we need a:
>        if (mount(NULL, "/", NULL, MS_REC | MS_SHARED, NULL) < 0) {
>
>   and can this go straight after (1) ?

Or right before (3).   Important thing is that that new mount will
only receive propagation if the type of the mount at source (before
(3) is performed) is shared.

Thanks,
Miklos


