Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBBCC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE852080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzdhkY5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE852080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iop2t-0006AP-UR
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ionZN-0003Zv-20
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ionZL-00046s-Mp
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:02:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47000
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ionZL-00046c-It
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578398562;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Qj4QJXSmnXomYqyXEYcofehYmt16u01DCXhHsNzw3Q=;
 b=gzdhkY5WWJuCVQo3GZbpcKMmaZMpV2Fqd9spDbX493E7BsL8+d7UPTczYCUIFdeWdwsUTd
 u93z0NJtdbXrUWMBPekE6Qn2Q6c6Fx/6OhrpHO0kjF3j/LPIiat4fpeDV7itlv0sBk1iWC
 r0hre3OHNowa7phFxT+D0iUpiZDgM3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-pdE11Dc9PHGaX-ZduD-yQA-1; Tue, 07 Jan 2020 07:02:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E97410054E3
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 12:02:40 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 162265C1B0;
 Tue,  7 Jan 2020 12:02:31 +0000 (UTC)
Date: Tue, 7 Jan 2020 12:02:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 087/104] virtiofsd: prevent fv_queue_thread() vs
 virtio_loop() races
Message-ID: <20200107120229.GB3368802@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-88-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-88-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: pdE11Dc9PHGaX-ZduD-yQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:47PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> We call into libvhost-user from the virtqueue handler thread and the
> vhost-user message processing thread without a lock.  There is nothing
> protecting the virtqueue handler thread if the vhost-user message
> processing thread changes the virtqueue or memory table while it is
> running.
>=20
> This patch introduces a read-write lock.  Virtqueue handler threads are
> readers.  The vhost-user message processing thread is a writer.  This
> will allow concurrency for multiqueue in the future while protecting
> against fv_queue_thread() vs virtio_loop() races.
>=20
> Note that the critical sections could be made smaller but it would be
> more invasive and require libvhost-user changes.  Let's start simple and
> improve performance later, if necessary.  Another option would be an
> RCU-style approach with lighter-weight primitives.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>   Merged with log changes
>   pull request 12

Two extraneous lines

> ---
>  tools/virtiofsd/fuse_virtio.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


