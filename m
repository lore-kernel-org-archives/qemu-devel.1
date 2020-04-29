Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D320C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD1320775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9sZ8u9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD1320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTiWU-0002Iy-Dw
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTiVL-0000oz-02
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTiSj-00068T-S1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:55:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jTiSj-00068G-Bv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588150379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N76sKVf/QicJz9YXXE8x05v2wvv+pOQ+DmWlX7nlP7I=;
 b=I9sZ8u9iZQfAR5oAdWrydNFEK1Pgr2hGc8iC3w5+sRfQv40B6TlHAq+iFdrYqhe73NCvc6
 6BjLaX3OmV9q2r71HQZPJxh/+7scZITj0Yv8fjwo/Ft+35TMzslrmxRhclR1G3ZT//MjUo
 Gjj2Ze8uusbbmsbGEf2jUVIUsI5M3f4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-1FQa6vzEPzuuP2QeE9nosQ-1; Wed, 29 Apr 2020 04:52:58 -0400
X-MC-Unique: 1FQa6vzEPzuuP2QeE9nosQ-1
Received: by mail-qk1-f200.google.com with SMTP id h186so1822171qkc.22
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 01:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=N76sKVf/QicJz9YXXE8x05v2wvv+pOQ+DmWlX7nlP7I=;
 b=nAGoZQzSEvmtBx7yJ4l/FaLVr+GcS2lMjtpJoeX2AroVvnY0zplw8OfkFMbzvTZWmC
 lRrF/PMkhZKjP/hM+WRWo3hCRi3eV/yLzXabN6VyscpRrDUuRZjPp1O044YaYkeZmrFl
 qw4UxJn4sZ4WARFx4XyOYSam3N6UWczzlbM+gGwAqfpNAgueAmBtXVMdQMx2jR2sMBGg
 NecDEnqpuVzldjqlCJORH/lnmfwncu5y6sJYKtaQLmO9Fx9k2WNEz7IwinbootA28Dz8
 dfBcpybi9vKvR2spBl7kRHALxwliTvguHFDTmz07JTB/tamcAa70ZPo2MUKsI62aAeiX
 I4Ew==
X-Gm-Message-State: AGi0Pua7ZV6zz5AT9kmfaxGDYOdkns0i73bZhgTf7VZXeqA7JYfRD1Qg
 hP5KH6Jy2uL5CeV0SoSiyHyFItqVk4LXk4o5G9L+XuA7AVeMBhEEXLPLrAduB+q1Vv+lGQif3DL
 ujMLw0R3c6HDj137JR7RBzFohttV2gOg=
X-Received: by 2002:aed:2e83:: with SMTP id k3mr33538026qtd.2.1588150377650;
 Wed, 29 Apr 2020 01:52:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypKNcohycsSxlw+9k3Mkvy949feKlmkWBZsdezNHjGohUcadVie0QPYYOAPUqSfGiuOAX67AXuNEdSJcQ07agdw=
X-Received: by 2002:aed:2e83:: with SMTP id k3mr33537999qtd.2.1588150377386;
 Wed, 29 Apr 2020 01:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
 <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
 <20200428191523.GU2794@work-vm>
 <0da9422f-6399-6ef0-1042-4b2b90d49ed8@redhat.com>
In-Reply-To: <0da9422f-6399-6ef0-1042-4b2b90d49ed8@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 29 Apr 2020 10:52:46 +0200
Message-ID: <CAOssrKfA_7cAio6i4Zy5hM-6VwBXphja6ps4s_NKrLsoF1yC+Q@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Show submounts
To: Max Reitz <mreitz@redhat.com>
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
Cc: virtio-fs-list <virtio-fs@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 10:31 AM Max Reitz <mreitz@redhat.com> wrote:
>
> On 28.04.20 21:15, Dr. David Alan Gilbert wrote:

> > So are you saying we need a:
> >        if (mount(NULL, "/", NULL, MS_REC | MS_SHARED, NULL) < 0) {
> >
> >   and can this go straight after (1) ?
>
> Isn=E2=80=99t MS_SHARED and MS_SLAVE mutually exclusive, that is, both ar=
e just
> different propagation types?  So shouldn=E2=80=99t putting this after (1)=
 be
> effectively the same as replacing (1)?

No, think of it more like a set of groups (mounts in a group have the
same "shared:$ID" tag in /proc/self/mountinfo) and these groups being
arranged into a tree, where child groups get propagation from the
parent group (mounts have a "master:$PARENT_ID" tag), but not the
other way round.

So if a mount is part of a shared group and this group is also the
child of another shared group, then it will have both a "shared:$ID"
and a "master:$PARENT_ID" tag in /proc/self/mountinfo.

For the gory details see Documentation/filesystems/sharedsubtree.txt

Thanks,
Miklos


