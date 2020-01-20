Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192E3C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA707207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blyZmM8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA707207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itcDq-0004G4-V4
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 13:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1itcD2-0003pz-VJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1itcCz-0002k2-VB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:55:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1itcCz-0002im-Re
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579546532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7k8lSd7juNIiS4EN6RyQ7+ZxwOODoi4uu0/0R3oFkC0=;
 b=blyZmM8SyLJjaC6HHLPFXL8ZeXkFCZbkdP729/od3JUqHq78xkfACs9gYaXxTlUvD5zoo3
 KQLQFy3nf5wZbQdySXvn47nhct9DZsYh42hanRIHNNATnfe2XlPa/R8k22NArHSDq68oct
 7FN4kZVxki93RgkhuILagHPIEolv6Ew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-nmjOiXyYOhatOWal7vOdQw-1; Mon, 20 Jan 2020 13:55:29 -0500
Received: by mail-wm1-f71.google.com with SMTP id m133so28619wmf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 10:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7k8lSd7juNIiS4EN6RyQ7+ZxwOODoi4uu0/0R3oFkC0=;
 b=s3CJjZ17jGwD0zr3p+kfSfeYTwAWn9kX3p4qXsiCWFCWLilNYS2RJ4igqo07iu7MPj
 sDr6m6TqjwIuuIQ2J5m0Bw9geCB//GttFmfFMtKVyWA7s6zMUyuti1OKPBnCE70g3olH
 6S6UHgluv8CYa+ilYL+Vzn6yq4cmFWoUkKscc/ucAymYVzVFz7dSVzYXV2vOd1A+/AmH
 pQnHwhAz0RoXjNRIN4+q7kC9NMEHoI86QClS0aBpCxURb//RgqORR1oUjEcMn1K1ghOK
 PsxL8hnyopBqJ6Jy38W3EAL511PHPw8InVReddFl6hE6vIoMqNIHWduKKmrkXqX6xzi1
 gJEw==
X-Gm-Message-State: APjAAAUqOd7sH1s9HqtZCsXrSeezfKnp930ceyzfZuU89oRBBJTORtav
 xBtpmo6vPTKFc3BwqP0SYJDFqYn6STlaIFPX3D7OyQIWzNQlSVJP6i8frv+yGbGgYvC6FI5I/n7
 2NUbzLbEHBmy8g5lEWSH4uuDsI48DinE=
X-Received: by 2002:a5d:6191:: with SMTP id j17mr810756wru.427.1579546528061; 
 Mon, 20 Jan 2020 10:55:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzi7teBV4Lph+wQmbM+abgRmiQKjGLwXtpi2g97IQizxgSt7IU0FPykNdC+RvMFK0SWISP6OAqNwBWtqiyly2E=
X-Received: by 2002:a5d:6191:: with SMTP id j17mr810747wru.427.1579546527846; 
 Mon, 20 Jan 2020 10:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20200117133257.16906-1-philmd@redhat.com>
 <20200120185211.GT2827@work-vm>
In-Reply-To: <20200120185211.GT2827@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 20 Jan 2020 19:55:16 +0100
Message-ID: <CAP+75-VpQbjg2sAa+QY4tJooJ1F=igCFHUUXev6_Nm8XUsiEDQ@mail.gmail.com>
Subject: Re: [PATCH 105/104] virtiofsd: Unref old/new inodes with the same
 mutex lock in lo_rename()
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-MC-Unique: nmjOiXyYOhatOWal7vOdQw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 7:52 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> > We can unref both old/new inodes with the same mutex lock.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > Based-on: <20191212163904.159893-1-dgilbert@redhat.com>
> > "virtiofs daemon"
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg664652.html
> >
> >  tools/virtiofsd/passthrough_ll.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 57f58aef26..5c717cb5a1 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -1461,8 +1461,10 @@ static void lo_rename(fuse_req_t req, fuse_ino_t=
 parent, const char *name,
> >      }
> >
> >  out:
> > -    unref_inode_lolocked(lo, oldinode, 1);
> > -    unref_inode_lolocked(lo, newinode, 1);
> > +    pthread_mutex_lock(&lo->mutex);
> > +    unref_inode(lo, oldinode, 1);
> > +    unref_inode(lo, newinode, 1);
> > +    pthread_mutex_unlock(&lo->mutex);
>
> While that would work; I'd rather keep that code simpler and the
> same as every other normal operation - we only use the unref_inode
> in one other place and that's because we're iterating the hash table
> while deleting stuff.

OK I understand.

> Dave
>
> >      lo_inode_put(lo, &oldinode);
> >      lo_inode_put(lo, &newinode);
> >      lo_inode_put(lo, &parent_inode);
> > --
> > 2.21.1
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


