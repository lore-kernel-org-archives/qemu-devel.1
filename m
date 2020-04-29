Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAC6C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887BE2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZTpCh8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887BE2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTo6Z-0003GG-LJ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTo34-0006GA-FZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTo33-0004E9-PW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:50:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jTo33-0004DU-D7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588171852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUJsLntzTBl0Uaxvmi90UDla642Jnk5KalhdTMmWnYM=;
 b=fZTpCh8BkX2fSJZhKsa4mqu7UI3jcEhhPYx4J+eHXZchIcA21pYKJQVfPVogwJ9d/LL3Pf
 rA074xc1DA2RwGBX4k+6fHg8KhdLfwinMnilbaD/1Yl9VTqRDamA5bj97BnCUqi11HugcP
 rvuzVIe8MeNHzN59WeiJ9k4CGWzEKw0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-gfoyxTFbPhunJtf-_Jt2Zw-1; Wed, 29 Apr 2020 10:50:50 -0400
X-MC-Unique: gfoyxTFbPhunJtf-_Jt2Zw-1
Received: by mail-qk1-f200.google.com with SMTP id x8so2912046qkf.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MY6bsQeC3md+TbKmM+nSJIydblQuI2AHoO5zal+e2/8=;
 b=g+IQ4Y+xKQ6jfKE7ieQnMKF6cyHiGRMhxETGzmjp29IEe04vDoUsHcSKU83XtfifVE
 Nt5V0zc/Yw3tH19W7ycka3iXZjM7kCfO5aUhFouiM03ku2Fft5c1hGAHu7qGmZ1qmBQQ
 NjJ+WBUcj/BeIXzgoKvPLN1B7ah2b9g7Ot9WC6TmlTrAtOotKT+xRr57wh6GHMKdFU8t
 486DnvKxGoMrEbj/17QiItOXK2Mjq3CsyqO0TE9DsBXL1ExCGgcA/MiH+9slBISByyCl
 +6bxH046endmlwepddjYQ2X/mID0mZi+anOUKh8aU73r0WdmtG/d3u9rjODDEliwkSOy
 dyNg==
X-Gm-Message-State: AGi0PuaVDdUDVa6AE4BYYc52tQg4iT4mh4S0PfsKVC/cTXhogahhhOb+
 LmCcBh9YBTZqMuTIfgdXiIRB4O0cP/HliEI1y7HrVmXkoaReQ8Q1/xd+QvjEJpza0y1rpIgGPvY
 RZDD8IsigZyBZzfVCvmpWa2vg2sbeo5Q=
X-Received: by 2002:a05:6214:1462:: with SMTP id
 c2mr33138097qvy.202.1588171850163; 
 Wed, 29 Apr 2020 07:50:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypJxVZCeyBHwdt9KpJDj8b0IsZt0xjGYQsH4kJc7ZXoubLK65fccXIsJapLLNrOQr0kEysgqYZ+t55tzGi3/UlI=
X-Received: by 2002:a05:6214:1462:: with SMTP id
 c2mr33138078qvy.202.1588171849949; 
 Wed, 29 Apr 2020 07:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200429124733.22488-1-mszeredi@redhat.com>
 <20200429143600.GE231284@redhat.com>
 <CAOssrKcOgP7eLo+uQdv==HssuqU3qpBKibvYAXypU88QXvypKw@mail.gmail.com>
In-Reply-To: <CAOssrKcOgP7eLo+uQdv==HssuqU3qpBKibvYAXypU88QXvypKw@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 29 Apr 2020 16:50:38 +0200
Message-ID: <CAOssrKf6Tcy1_LUL0X+7pBcrDxoZjuarbw36FVPdkKHf+MTbEg@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: jail lo->proc_self_fd
To: Vivek Goyal <vgoyal@redhat.com>
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 4:47 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Wed, Apr 29, 2020 at 4:36 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Apr 29, 2020 at 02:47:33PM +0200, Miklos Szeredi wrote:
> > > While it's not possible to escape the proc filesystem through
> > > lo->proc_self_fd, it is possible to escape to the root of the proc
> > > filesystem itself through "../..".
> >
> > Hi Miklos,
> >
> > So this attack will work with some form of *at(lo->proc_self_fd, "../..=
")
> > call?
>
> Right.
>
> >
> > >
> > > Use a temporary mount for opening lo->proc_self_fd, that has it's roo=
t at
> > > /proc/self/fd/, preventing access to the ancestor directories.
> >
> > Does this mean that now similar attack can happen using "../.." on tmpd=
ir
> > fd instead and be able to look at peers of tmpdir. Or it is blocked
> > due to mount point or something else.
>
> No, because tmpdir is detached, the root of that tree will be the
> directory pointed to by the fd.  ".." will just lead to the same
> directory.

BTW, I would have liked to do this without a temp directory, but
apparently the fancy new mount stuff isn't up to this task, or at
least I haven't figured out yet.

Thanks,
Miklos


