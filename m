Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CBDC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEB32084D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhLvzwTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEB32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwmK-0003sr-Hw
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1ipwiS-000074-Vk
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mszeredi@redhat.com>) id 1ipwiQ-0003U5-5H
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:00:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mszeredi@redhat.com>) id 1ipwiQ-0003QN-0o
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578672048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9CvWAvOV23LADIsDc0mAhU0nx4Z0CbtTvdf6J+kNis=;
 b=VhLvzwTzBGnWF9DoFaR3/POGodm+CIVp3pG+G77cDdpXf07WWWyQamvUvqcCCyhW4II+7j
 jz+gzv8cK6wBv+x8AkvtgeJtuthmpjnQRF5RHPUG4FKgLpoRW8kMXnTNNKda1/puaKII81
 UVdzipTAzNejCuAod02Yn6kSYIr+sPg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-jOnPkHwlNqy4XE1CbICFLA-1; Fri, 10 Jan 2020 11:00:46 -0500
Received: by mail-io1-f72.google.com with SMTP id 13so1782664iof.14
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 08:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z9CvWAvOV23LADIsDc0mAhU0nx4Z0CbtTvdf6J+kNis=;
 b=b1KiSOptQMnrfNg+fVdgcpfayuFXiDg7hzCwDr5hJlPQQGBtilDaTQYeObOPbPMzno
 vL/OZRVxJKjHZgmtw2GW2IZva67hafNkO9TgHa4Mu92Hop62lw84Gsj5Px36v9wk06zW
 lyjcQmt9uZLSW+GNxcRN/qMS0BcJU7B7HfY71X9hoX8QzRzk143ixPMOhnKBN7nLMvvD
 O4pNR2Iv3qqxU+BUyTkNdne77l46RQf4ezThhOZe2DqJzsGsx6yso1Y76Qgjm2O5FBEw
 DliHdGkUO9WwYDGLDflUpadfuWHWmR2Q1SrRrGGAonBH46XMDITH/QkVaK+soXUYSzaE
 FoRQ==
X-Gm-Message-State: APjAAAVDi2iYWcpqPTsNQ5Sv0ZkCLuDv30B+t4EMPKPgWxux3VwAHAaL
 2OwHaF9BsT2ayqdAWt2PjzBvssqX4bA3A1sA2YXtlgPanmSGAz6cqtjn1NZlsnQP0ep2P/Aymvc
 mnIVP12YTIpjr61Eiww7kna0WZGrG2WE=
X-Received: by 2002:a92:9c04:: with SMTP id h4mr3375324ili.6.1578672044878;
 Fri, 10 Jan 2020 08:00:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvjZ77PT1S9mGgx9Aqra7xS1pvcTPOmC9SmqrOlLCH388nmlWiWthXpPmDx5F81NWik3NBGIWHBGihaZxyZUQ=
X-Received: by 2002:a92:9c04:: with SMTP id h4mr3375218ili.6.1578672043861;
 Fri, 10 Jan 2020 08:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-69-dgilbert@redhat.com>
 <20200107112316.GL3368802@redhat.com> <20200110150447.GH3901@work-vm>
 <CAOssrKdRn9NGV9TuvCkRRXEwZep6B-R2598iYLY4-9d6zkPUXg@mail.gmail.com>
 <20200110151808.GT3423494@redhat.com>
 <CAOssrKf0ohB66yUpH38jH-dvOCs1zS5zfa5KL9g+0ZCAcMXs4w@mail.gmail.com>
 <20200110154037.GC28043@redhat.com>
In-Reply-To: <20200110154037.GC28043@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Fri, 10 Jan 2020 17:00:32 +0100
Message-ID: <CAOssrKdqkX8=WkdtJMsF8ajPJYY6ymxqbw6gupg6ONzJnqCEDg@mail.gmail.com>
Subject: Re: [PATCH 068/104] virtiofsd: passthrough_ll: control readdirplus
To: Vivek Goyal <vgoyal@redhat.com>
X-MC-Unique: jOnPkHwlNqy4XE1CbICFLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 4:40 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Jan 10, 2020 at 04:30:01PM +0100, Miklos Szeredi wrote:
> > On Fri, Jan 10, 2020 at 4:18 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > >
> > > On Fri, Jan 10, 2020 at 04:13:08PM +0100, Miklos Szeredi wrote:
> > > > On Fri, Jan 10, 2020 at 4:04 PM Dr. David Alan Gilbert
> > > > <dgilbert@redhat.com> wrote:
> > > > >
> > > > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > > > On Thu, Dec 12, 2019 at 04:38:28PM +0000, Dr. David Alan Gilber=
t (git) wrote:
> > > > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > > > >
> > > > > >
> > > > > > What is readdirplus and what do we need a command line option t=
o
> > > > > > control it ? What's the user benefit of changing the setting ?
> > > > >
> > > > > cc'ing Miklos who understands this better than me.
> > > > >
> > > > > My understanding is that readdirplus is a heuristic inherited fro=
m NFS
> > > > > where when you iterate over the directory you also pick up stat()=
 data
> > > > > for each entry in the directory.  You then cache that stat data
> > > > > somewhere.
> > > > > The Plus-ness is that a lot of directory operations involve you s=
tating
> > > > > each entry (e.g. to figure out if you can access it etc) so rolli=
ng it
> > > > > into one op avoids the separate stat.  The unplus-ness is that it=
's an
> > > > > overhead and I think changes some of the caching behaviour.
> > > >
> > > > Yeah, so either may give better performance and it's hard to pick a
> > > > clear winner.  NFS also has an option to control this.
> > >
> > > IIUC from the man page, the NFS option for controlling this is a clie=
nt
> > > side mount option. This makes sense as only the client really has kno=
wledge
> > > of whether its workload will benefit.
> > >
> > > With this in mind, should the readdirplus control for virtio-fs also =
be a
> > > guest mount option instead of a host virtiofsd CLI option ? The guest=
 admin
> > > seems best placed to know whether their workload will benefit or not.
> >
> > Definitely.   In fact other options, e.g. ones that control caching,
> > should probably also be client side (cache=3DXXX, writeback,
> > timeout=3DXXX, etc).
>
> I am not sure about cache options. So if we want to share a directory
> between multiple guests with stronger coherency (cache=3Dnone), then admi=
n
> should decide that cache=3Dalways/auto is not supported on this export.
>
> Also, how will one client know whether there are other clients same
> directory with strong coherency requirements and it should use cache=3Dno=
ne
> instead of cache=3Dalways/auto.
>
> Having said that, it also makes sense that client knows its workoad
> and can decide if cache=3Dauto works best for it and use that instead.
>
> May be we need both client and server side options. Client will request
> certain cache=3Dxxx options and server can deny these if admin decides
> not to enable that option for that particular mount.
>
> For example, if admin decides that we can only support cache=3Dnone on
> this particular dir due to other guest sharing it, then daemon should
> be able to deny cache=3Dauto/always requests from client.

Makes sense.  The server dictates policy, the client just passes the
options onto the server.

Thanks,
Miklos


