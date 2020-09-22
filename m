Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F15C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6000C2395C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXzFt8X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6000C2395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhd0-0005aR-1U
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKhbL-0004iR-Fa
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:40:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKhbI-0001Ww-BF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600778450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+iOUxLnNNbl03LGxa/4Gk+YWxDzedVk0LKpRY5k5Yo=;
 b=GXzFt8X9sbuElbPIDlmX5MCu++ZqdHFihVUatC2Q/zXakeQ1fOltUUvNi0YZT1J4V+QLE4
 U0qqAND5XFy6O72rvrKHoaqoxtU3YgaeeAH7mGL6PHl+iWBApLLNFT1GqkSSG8R2xaCRpc
 WqwdjIvZ8eg3dA6lXJU4RkeMiWuTNKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-3ON-wZS1OC6PWctf8Hs-Nw-1; Tue, 22 Sep 2020 08:40:45 -0400
X-MC-Unique: 3ON-wZS1OC6PWctf8Hs-Nw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB8D264087;
 Tue, 22 Sep 2020 12:40:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-78.rdu2.redhat.com [10.10.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 075687368D;
 Tue, 22 Sep 2020 12:40:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 62E4F223B13; Tue, 22 Sep 2020 08:40:38 -0400 (EDT)
Date: Tue, 22 Sep 2020 08:40:38 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] virtiofsd: Used glib "shared" thread pool
Message-ID: <20200922124038.GA57620@redhat.com>
References: <20200921213216.GE13362@redhat.com>
 <CAJfpegujM0ygoBT5uPf4zBUDiphDTwgu97NfqaEgaa8HoSnuRw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJfpegujM0ygoBT5uPf4zBUDiphDTwgu97NfqaEgaa8HoSnuRw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:19:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 02:03:18PM +0200, Miklos Szeredi wrote:
> On Mon, Sep 21, 2020 at 11:32 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > glib offers thread pools and it seems to support "exclusive" and "shared"
> > thread pools.
> >
> >
> > https://developer.gnome.org/glib/stable/glib-Thread-Pools.html#g-thread-pool-new
> >
> > Currently we use "exlusive" thread pools but its performance seems to be
> > poor. I tried using "shared" thread pools and performance seems much
> > better. I posted performance results here.
> >
> > https://www.redhat.com/archives/virtio-fs/2020-September/msg00080.html
> >
> > So lets switch to shared thread pools. We can think of making it optional
> > once somebody can show in what cases exclusive thread pools offer better
> > results. For now, my simple performance tests across the board see
> > better results with shared thread pools.
> >
> 
> Needs this as well:

Thanks Miklos. I am wondering why I did not face this issue. May be
I don't have seccomp enabled. Will check.

David, can you please pick this patch as well. May be merge both
the patches.

Do let me know if you want to me post a merged patch instead.

Thanks
Vivek

> 
> --- qemu.orig/tools/virtiofsd/passthrough_seccomp.c 2020-09-16
> 20:21:13.168686176 +0200
> +++ qemu/tools/virtiofsd/passthrough_seccomp.c 2020-09-22
> 14:01:38.499164501 +0200
> @@ -94,6 +94,8 @@ static const int syscall_whitelist[] = {
>      SCMP_SYS(rt_sigaction),
>      SCMP_SYS(rt_sigprocmask),
>      SCMP_SYS(rt_sigreturn),
> +    SCMP_SYS(sched_getattr),
> +    SCMP_SYS(sched_setattr),
>      SCMP_SYS(sendmsg),
>      SCMP_SYS(setresgid),
>      SCMP_SYS(setresuid),
> 
> Thanks,
> Miklos


