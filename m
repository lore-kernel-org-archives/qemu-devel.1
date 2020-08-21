Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D12C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4331320578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2cZkdS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4331320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99qH-0000Ol-GL
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k99pV-0007YG-On
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k99pT-0005p7-Nn
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598027026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfQ/drJO8MrbreiGOA+hpIjL4Yln/6QIv4a0ttbxKxo=;
 b=X2cZkdS5vr+8EqwJYB7rASKA8J9FqNif5Wp5K1DNY4izOEfl5Hiuo+kTPxNaMPqKaqgx7j
 XhAPSfFI9iJjVmlDBrfFCtoB1bUPioCDK0o0aF9ramfYDqDm2CsmKJ8PqBDKspyG91dn/1
 B1wE9hnvKMy6Wdxci0a+iGsNnjCjoOA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-lskh9EOvPV-de4AKSe8tsA-1; Fri, 21 Aug 2020 12:23:45 -0400
X-MC-Unique: lskh9EOvPV-de4AKSe8tsA-1
Received: by mail-wr1-f69.google.com with SMTP id r14so705995wrq.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PByRGsvrdNbxrtZ726BuddNNriKme2BVe/49PBykFyU=;
 b=sxXq2tDPZLvrlL9J7/7XaFzpxW0Ir4zGhX26+aep+nlI/2fTZSFXEp2VeqXmDZq/wY
 Pqpx+uhNrV6eQkn196ZagjvNlE1seECFdM+2nE6rnjhIU9iofAC4LQ3+BES0eLtazqHH
 jPdKef3yO7xPaAK0dQvkWXoa/3ofMiDzRjnanvDeI7GucFcESI+RYpxC5Pi+MZfd1yQG
 yv5pJz/EuFzmLCBgyJaXVQzfRvVwIdU9kuepxDfqD7uJStkLOR5syh5kTQj6WQ0NwxFY
 VekNU7LAj8LRNuVBviXfMkfUdeKZ5SvypEBpodI8THNQRRoHFhGDrsWcJmi8OnCZVONr
 +LPw==
X-Gm-Message-State: AOAM530ELABdmbDRUQ3UF8sXbArYUV+KO0P6I56xc2px7o2M9rTU6gAv
 LebnN0YdCxKocSxgBJSVZ3yMb3nMVUqXyxqMSPM3cEv6EYqXhJXzohTsKpIC5MaKXJPySw17o6x
 S3/Gauw0CMAa5q7A=
X-Received: by 2002:adf:94a1:: with SMTP id 30mr3260291wrr.37.1598027023694;
 Fri, 21 Aug 2020 09:23:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygj8gogjlZmK0iQ3KZAXRG6l2lGOhatic7f6pMLXYnOq2H9myjg57YOsHh4wUZcO+ThoUNCw==
X-Received: by 2002:adf:94a1:: with SMTP id 30mr3260278wrr.37.1598027023476;
 Fri, 21 Aug 2020 09:23:43 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id g25sm5739084wmh.35.2020.08.21.09.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:23:42 -0700 (PDT)
Date: Fri, 21 Aug 2020 18:23:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] util/meson.build: fix fdmon-io_uring build
Message-ID: <20200821162339.33waweneizhzases@steredhat>
References: <20200821154853.94379-1-sgarzare@redhat.com>
 <b750b7e1-2fca-2662-b575-2883d1073743@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b750b7e1-2fca-2662-b575-2883d1073743@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 06:12:45PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Stefano,
> 
> On 8/21/20 5:48 PM, Stefano Garzarella wrote:
> > libqemuutil.a build fails with this error:
> > 
> >   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `get_sqe':
> >   qemu/build/../util/fdmon-io_uring.c:83: undefined reference to `io_uring_get_sqe'
> >   /usr/bin/ld: qemu/build/../util/fdmon-io_uring.c:92: undefined reference to `io_uring_submit'
> >   /usr/bin/ld: qemu/build/../util/fdmon-io_uring.c:96: undefined reference to `io_uring_get_sqe'
> >   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_wait':
> >   qemu/build/../util/fdmon-io_uring.c:289: undefined reference to `io_uring_submit_and_wait'
> >   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_setup':
> >   qemu/build/../util/fdmon-io_uring.c:328: undefined reference to `io_uring_queue_init'
> >   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_destroy':
> >   qemu/build/../util/fdmon-io_uring.c:343: undefined reference to `io_uring_queue_exit'
> >   collect2: error: ld returned 1 exit status
> 
> Can you add a gitlab job to reproduce this? (Or at least explain
> how to reproduce, so we add that job later). Thanks!

I think the only prerequisite is to install 'liburing-devel' package
(Fedora 32) on the build system, and then fdmon-io_uring.c will be built.

I'll try to add a gitlab job ;-)

Thanks,
Stefano

> 
> > 
> > This patch fix the issue adding 'linux_io_uring' dependency for
> > fdmon-io_uring.c
> > 
> > Fixes: a81df1b68b ("libqemuutil, qapi, trace: convert to meson")
> > Cc: pbonzini@redhat.com
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  util/meson.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/util/meson.build b/util/meson.build
> > index 23b8ad459b..e6b207a99e 100644
> > --- a/util/meson.build
> > +++ b/util/meson.build
> > @@ -4,7 +4,7 @@ util_ss.add(when: 'CONFIG_ATOMIC64', if_false: files('atomic64.c'))
> >  util_ss.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
> >  util_ss.add(when: 'CONFIG_POSIX', if_true: files('fdmon-poll.c'))
> >  util_ss.add(when: 'CONFIG_EPOLL_CREATE1', if_true: files('fdmon-epoll.c'))
> > -util_ss.add(when: 'CONFIG_LINUX_IO_URING', if_true: files('fdmon-io_uring.c'))
> > +util_ss.add(when: ['CONFIG_LINUX_IO_URING', linux_io_uring], if_true: files('fdmon-io_uring.c'))
> >  util_ss.add(when: 'CONFIG_POSIX', if_true: files('compatfd.c'))
> >  util_ss.add(when: 'CONFIG_POSIX', if_true: files('event_notifier-posix.c'))
> >  util_ss.add(when: 'CONFIG_POSIX', if_true: files('mmap-alloc.c'))
> > 
> 


