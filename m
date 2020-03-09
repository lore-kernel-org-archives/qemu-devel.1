Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868FFC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516CC20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFZIxM0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516CC20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKz7-0007E7-Df
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBKZx-00027i-Kj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBKZv-0001Um-UJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBKZv-0001U8-Q2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583768667;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpTBlitmyrw4ZgnVEIygjf55ErpI+6cvdfGZY1NHMj0=;
 b=bFZIxM0gBto0mK8UrjdAY7E+HFCv6FKrZtytzlwyqDqk0bcx//VXZ3EKMsoHsAGQ5Filwp
 zBIX4N2qWDTUdqWRo4siXOEozV4MMVXwzc9sj+ltNK2enOmUTllHrneCvX9dZKoQic8mq8
 oXP6hZE+MhwqOv4VGfcez16y8qrhBLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-HlWGHwjzM-eHHlPgbsM04g-1; Mon, 09 Mar 2020 11:44:23 -0400
X-MC-Unique: HlWGHwjzM-eHHlPgbsM04g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97A84100550E;
 Mon,  9 Mar 2020 15:44:21 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93FAE19C69;
 Mon,  9 Mar 2020 15:44:15 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:44:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/4] block: Add trivial backing_fmt support to qcow,
 sheepdog, vmdk
Message-ID: <20200309154412.GL3033513@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-2-eblake@redhat.com>
 <20200309152112.GC6478@linux.fritz.box>
 <7b7f12f8-ca03-12d4-b93d-2edefb51cb42@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7b7f12f8-ca03-12d4-b93d-2edefb51cb42@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 pkrempa@redhat.com, "open list:Sheepdog" <sheepdog@lists.wpkg.org>,
 qemu-block@nongnu.org, libvir-list@redhat.com,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, mreitz@redhat.com,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Liu Yuan <namei.unix@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 10:32:52AM -0500, Eric Blake wrote:
> On 3/9/20 10:21 AM, Kevin Wolf wrote:
> > Am 06.03.2020 um 23:51 hat Eric Blake geschrieben:
> > > For qcow2 and qed, we want to encourage the use of -F always, as thes=
e
> > > formats can suffer from data corruption or security holes if backing
> > > format is probed.  But for other formats, the backing format cannot b=
e
> > > recorded.  Making the user decide on a per-format basis whether to
> > > supply a backing format string is awkward, better is to just blindly
> > > accept a backing format argument even if it is ignored by the
> > > contraints of the format at hand.
> > >=20
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> >=20
> > I'm not sure if I agree with this reasoning. Accepting and silently
> > ignoring -F could give users a false sense of security. If I specify a
> > -F raw and QEMU later probes qcow2, that would be very surprising.
>=20
> Do we know what formats qcow, sheepdog, and vmdk expect to probe?  I'm
> wondering if we can compromise by checking that the requested backing ima=
ge
> has the specified format, and error if it is not, rather than completely
> ignoring it - but at the same time, the image formats have no where to
> record a backing format.

Consider the user creates an image with "-F raw". We can validate the backi=
ng
image is raw, and so our check succeeds.  Later the malicious <something> c=
an
write a qcow header into this raw file and QEMU will thereafter probe the
image as qcow, not raw.

IOW, in the case of "-F raw", even if we immediately check the format, we'r=
e
still not offering the protection promised by the "-F" flag, because that
promise refers to the runtime behaviour of the QEMU emulator, not the
immediate qemu-img cmd.

We could support "-F ..." and validate any non-raw formats, while raising a
runtime error in the case of "-F raw", as only the "raw" backing format has
the probing security risk.

Users who need  to use qcow, with a backing file, without a format can
just not pass "-F" and in doing so will be insecure.

We could take this opportunity to deprecate 'qcow' perhaps, declare it
a read-only format, restricted to qemu-img/qemu-io for purpose of data
liberation ?

For sheepdog, if it is something we genuinely still care about, then
adding a backing file format record seems neccessary, unless we either
forbid use of raw backing files, or forbid use of non-raw backing files,
either way would be safe.

> I'm guessing that qcow works with either raw or qcow as backing format (a=
nd
> anything else is odd - a qcow2 backing to a qcow is unusual, and would be
> better to reject).  I'm not sure if sheepdog can be backed by anything bu=
t
> another sheepdog, similarly, I'm not sure if a vmdk can be backed by
> anything but another vmdk.  If so, it should be simple enough to do a v4 =
of
> this patch which requires -F to be a known-acceptable probe type for thes=
e
> images.
>=20
> Still, the point of this patch is that I want to add -F into all the
> iotests, and without something along the lines of this patch, all of thos=
e
> iotests are broken for these image formats.  Patch 2 is a lot harder to
> write if we have to make our use of -F conditional on the image format in
> question.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


