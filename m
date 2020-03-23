Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCDEC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BC22072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxpAkmem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BC22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJks-0003EW-P7
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 05:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jGJkF-0002kU-6R
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jGJkE-0002hG-4Q
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:51:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jGJkE-0002h6-1U
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584957101;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNa8iCJTHhnJbWOKq9OanBw15fWGGMIvyoguE/mi5EU=;
 b=hxpAkmemhidkpR22IA9bGvTn1e2GltyQ/CsgUtMp41hkmVprNdG2zJJ2KGfxok5hHE2Kav
 1m7cpMc4muEhru6dSvXSIXWJsCv5YeAd2oIONUmny+wpfNuU+wjA4N0qPyLSa2nipQ8Wgu
 ZCFOmY01iXD6NcC+QSIiNnWrUiXkcsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-5P8WT0_xOsW1Gvuqfo5V6A-1; Mon, 23 Mar 2020 05:51:38 -0400
X-MC-Unique: 5P8WT0_xOsW1Gvuqfo5V6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BE69107ACC7;
 Mon, 23 Mar 2020 09:51:37 +0000 (UTC)
Received: from redhat.com (ovpn-112-208.ams2.redhat.com [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57F5C9B930;
 Mon, 23 Mar 2020 09:51:35 +0000 (UTC)
Date: Mon, 23 Mar 2020 09:51:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: discard and v2 qcow2 images
Message-ID: <20200323095132.GB3379720@redhat.com>
References: <20200320185848.GA5720@igalia.com>
 <c0dcacfd-16cc-e2c2-304a-043e281d6bde@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c0dcacfd-16cc-e2c2-304a-043e281d6bde@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 02:35:44PM -0500, Eric Blake wrote:
> On 3/20/20 1:58 PM, Alberto Garcia wrote:
> > Hi,
> >=20
> > when full_discard is false in discard_in_l2_slice() then the selected
> > cluster should be deallocated and it should read back as zeroes. This
> > is done by clearing the cluster offset field and setting OFLAG_ZERO in
> > the L2 entry.
> >=20
> > This flag is however only supported when qcow_version >=3D 3. In older
> > images the cluster is simply deallocated, exposing any possible
> > previous data from the backing file.
>=20
> Discard is advisory, and has no requirements that discarded data read bac=
k
> as zero.  However, if write zeroes uses discard under the hood, then THAT
> usage must guarantee reading back as zero.
>=20
> >=20
> > This can be trivially reproduced like this:
> >=20
> >     qemu-img create -f qcow2 backing.img 64k
> >     qemu-io -c 'write -P 0xff 0 64k' backing.img
> >     qemu-img create -f qcow2 -o compat=3D0.10 -b backing.img top.img
> >     qemu-io -c 'write -P 0x01 0 64k' top.img
> >=20
> > After this, top.img is filled with 0x01. Now we issue a discard
> > command:
> >=20
> >     qemu-io -c 'discard 0 64k' top.img
> >=20
> > top.img should now read as zeroes, but instead you get the data from
> > the backing file (0xff). If top.img was created with compat=3D1.1
> > instead (the default) then it would read as zeroes after the discard.
>=20
> I'd argue that this is undesirable behavior, but not a bug.

I think the ability to read old data from the backing file could
potentially be considered a security flaw, depending on what the
original data was in the backing file.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


