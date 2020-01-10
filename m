Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48EAC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9125C205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERnsE6z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9125C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwZ9-00075R-Co
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1ipwQF-0003jD-AK
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1ipwQD-0003Ll-UJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:42:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58499
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1ipwQD-0003Iu-Ph
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jBg45+LpjtXGUrIhyGhSEWIbaLqX0f99qskaxLuoAWc=;
 b=ERnsE6z83ep8w3C0/peWwqkhntr1PuE9853tasadpqf11JQPWmjLwXAG2lf01zeiI2tqSD
 jSqR82aT8wXGYAc/4mncj84xUO08qDQ7VdKa2heZWE69NRMCaRkZDzb5wVL8U8Y4CWys5J
 KgGWz2c3DDdyf2l/VayPqyGds5Pt2kI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-aR4sCtifPc-CNSLnxDV7EA-1; Fri, 10 Jan 2020 10:40:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D4C8B20E1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:40:41 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61D5560CC0;
 Fri, 10 Jan 2020 15:40:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id E8339220A24; Fri, 10 Jan 2020 10:40:37 -0500 (EST)
Date: Fri, 10 Jan 2020 10:40:37 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 068/104] virtiofsd: passthrough_ll: control readdirplus
Message-ID: <20200110154037.GC28043@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-69-dgilbert@redhat.com>
 <20200107112316.GL3368802@redhat.com>
 <20200110150447.GH3901@work-vm>
 <CAOssrKdRn9NGV9TuvCkRRXEwZep6B-R2598iYLY4-9d6zkPUXg@mail.gmail.com>
 <20200110151808.GT3423494@redhat.com>
 <CAOssrKf0ohB66yUpH38jH-dvOCs1zS5zfa5KL9g+0ZCAcMXs4w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOssrKf0ohB66yUpH38jH-dvOCs1zS5zfa5KL9g+0ZCAcMXs4w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: aR4sCtifPc-CNSLnxDV7EA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 04:30:01PM +0100, Miklos Szeredi wrote:
> On Fri, Jan 10, 2020 at 4:18 PM Daniel P. Berrang=E9 <berrange@redhat.com=
> wrote:
> >
> > On Fri, Jan 10, 2020 at 04:13:08PM +0100, Miklos Szeredi wrote:
> > > On Fri, Jan 10, 2020 at 4:04 PM Dr. David Alan Gilbert
> > > <dgilbert@redhat.com> wrote:
> > > >
> > > > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > > > On Thu, Dec 12, 2019 at 04:38:28PM +0000, Dr. David Alan Gilbert =
(git) wrote:
> > > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > > >
> > > > >
> > > > > What is readdirplus and what do we need a command line option to
> > > > > control it ? What's the user benefit of changing the setting ?
> > > >
> > > > cc'ing Miklos who understands this better than me.
> > > >
> > > > My understanding is that readdirplus is a heuristic inherited from =
NFS
> > > > where when you iterate over the directory you also pick up stat() d=
ata
> > > > for each entry in the directory.  You then cache that stat data
> > > > somewhere.
> > > > The Plus-ness is that a lot of directory operations involve you sta=
ting
> > > > each entry (e.g. to figure out if you can access it etc) so rolling=
 it
> > > > into one op avoids the separate stat.  The unplus-ness is that it's=
 an
> > > > overhead and I think changes some of the caching behaviour.
> > >
> > > Yeah, so either may give better performance and it's hard to pick a
> > > clear winner.  NFS also has an option to control this.
> >
> > IIUC from the man page, the NFS option for controlling this is a client
> > side mount option. This makes sense as only the client really has knowl=
edge
> > of whether its workload will benefit.
> >
> > With this in mind, should the readdirplus control for virtio-fs also be=
 a
> > guest mount option instead of a host virtiofsd CLI option ? The guest a=
dmin
> > seems best placed to know whether their workload will benefit or not.
>=20
> Definitely.   In fact other options, e.g. ones that control caching,
> should probably also be client side (cache=3DXXX, writeback,
> timeout=3DXXX, etc).

I am not sure about cache options. So if we want to share a directory
between multiple guests with stronger coherency (cache=3Dnone), then admin
should decide that cache=3Dalways/auto is not supported on this export.

Also, how will one client know whether there are other clients same
directory with strong coherency requirements and it should use cache=3Dnone
instead of cache=3Dalways/auto.

Having said that, it also makes sense that client knows its workoad
and can decide if cache=3Dauto works best for it and use that instead.

May be we need both client and server side options. Client will request
certain cache=3Dxxx options and server can deny these if admin decides
not to enable that option for that particular mount.

For example, if admin decides that we can only support cache=3Dnone on
this particular dir due to other guest sharing it, then daemon should
be able to deny cache=3Dauto/always requests from client.

Thanks
Vivek


