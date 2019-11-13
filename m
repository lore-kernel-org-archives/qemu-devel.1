Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFCBC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BACA206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFf4BQmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BACA206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvjh-0001Cc-6p
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iUvcr-0002Pm-LW
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iUvcq-0004Ji-DF
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:36:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iUvcq-0004JX-9b
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573662971;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQFb/AiV2JVeAvhBIhzbSNrgnSukUKHp3jTJfAyZ+rg=;
 b=FFf4BQmUCXrZ+s1XkHGXYWHuyb9wh5DQ7Dzc19EZ5NknF/e0DA1NQr/j1/OgNqDIbwcMK5
 B2fD+pSIEgXthkAEmN8fxldOG0QpCDSG5Yhq20VTGk0nwQgqAqQRPY1WeHMk6XSpALDAup
 UnpvYmfvTQrS5IPmNt6lWzq7+TBV+6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-Zu0UgxR3Pyuvspzi6g08yw-1; Wed, 13 Nov 2019 11:36:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C7DE184CCC6;
 Wed, 13 Nov 2019 16:36:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81B7810E1B43;
 Wed, 13 Nov 2019 16:35:54 +0000 (UTC)
Date: Wed, 13 Nov 2019 16:35:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 02/49] multi-process: util: Add
 qemu_thread_cancel() to cancel running thread
Message-ID: <20191113163552.GJ2445240@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <e821aa9bccb49bf68c94e3d49b105c420dde9981.1571905346.git.jag.raman@oracle.com>
 <20191113153006.GA563983@stefanha-x1.localdomain>
 <fd30b4ee-1f92-82a8-42a6-871b0a9e23b1@oracle.com>
 <20191113155125.GI2445240@redhat.com>
 <89ec048f-6db1-a52d-49de-c758f8408eb0@oracle.com>
MIME-Version: 1.0
In-Reply-To: <89ec048f-6db1-a52d-49de-c758f8408eb0@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Zu0UgxR3Pyuvspzi6g08yw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, john.g.johnson@oracle.com,
 rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 ross.lagerwall@citrix.com, mreitz@redhat.com, liran.alon@oracle.com,
 kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 kanth.ghatraju@oracle.com, pbonzini@redhat.com, kwolf@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com, marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 11:04:58AM -0500, Jag Raman wrote:
>=20
>=20
> On 11/13/2019 10:51 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Nov 13, 2019 at 10:38:06AM -0500, Jag Raman wrote:
> > >=20
> > >=20
> > > On 11/13/2019 10:30 AM, Stefan Hajnoczi wrote:
> > > > On Thu, Oct 24, 2019 at 05:08:43AM -0400, Jagannathan Raman wrote:
> > > > > qemu_thread_cancel() added to destroy a given running thread.
> > > > > This will be needed in the following patches.
> > > > >=20
> > > > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > > ---
> > > > >    include/qemu/thread.h    |  1 +
> > > > >    util/qemu-thread-posix.c | 10 ++++++++++
> > > > >    2 files changed, 11 insertions(+)
> > > >=20
> > > > Is this still needed?  I thought previous discussion concluded that
> > > > thread cancellation is hard to get right and it's not actually used=
 by
> > > > this series?
> > >=20
> > > Hi Stefan,
> > >=20
> > > This is used in PATCH 41/49.
> >=20
> > I don't believe the cancellation usage in that patch is safe :-)
>=20
> Thanks for the feedback, we will address that.
>=20
> May I please ask why it is not safe? Any clarification will help us to
> find a better alternative.

I put some comments inline in the patch 41 explaining my thoughts.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


