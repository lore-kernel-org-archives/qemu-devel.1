Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1629C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8F920578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eqk3YwAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8F920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKVu-0002m6-Sx
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBKSX-0004l9-2D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBKSV-0005ke-DE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:36:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36740
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBKSU-0005iS-Pu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583768203;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eG+zSgZUNz/14nsquyO0VyjTc4txO/Znzv9papAs/e4=;
 b=Eqk3YwAB/mjy0FhIot5OPXzM4UOH97kWaizBMSuL/F0soG1d56NZyyDbvz9hF24uuUDBLn
 sc1CiRAkb9eN5C5kObbjGF34x03qdVmmBBPpBJ/mN05ClT9qmqK+fKfx9Kd+ue7cbYBKIP
 O5932x/LVDHsNMXwKBvMjP5KnV0ibBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-TNcIz1DENmmxLvE89sU2zA-1; Mon, 09 Mar 2020 11:36:36 -0400
X-MC-Unique: TNcIz1DENmmxLvE89sU2zA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1514CDB60;
 Mon,  9 Mar 2020 15:36:35 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E754E1BC6D;
 Mon,  9 Mar 2020 15:36:27 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:36:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 1/4] block: Add trivial backing_fmt support to qcow,
 sheepdog, vmdk
Message-ID: <20200309153624.GK3033513@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-2-eblake@redhat.com>
 <20200309152112.GC6478@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200309152112.GC6478@linux.fritz.box>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Fam Zheng <fam@euphon.net>, pkrempa@redhat.com,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 libvir-list@redhat.com, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Liu Yuan <namei.unix@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 04:21:12PM +0100, Kevin Wolf wrote:
> Am 06.03.2020 um 23:51 hat Eric Blake geschrieben:
> > For qcow2 and qed, we want to encourage the use of -F always, as these
> > formats can suffer from data corruption or security holes if backing
> > format is probed.  But for other formats, the backing format cannot be
> > recorded.  Making the user decide on a per-format basis whether to
> > supply a backing format string is awkward, better is to just blindly
> > accept a backing format argument even if it is ignored by the
> > contraints of the format at hand.
> >=20
> > Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> I'm not sure if I agree with this reasoning. Accepting and silently
> ignoring -F could give users a false sense of security. If I specify a
> -F raw and QEMU later probes qcow2, that would be very surprising.

And if the user specifies "-F raw" and we probe qcow2, and the user
does not realize this, they can become silently reliant on always
probing qcow2. If we then honour the "-F raw" option in a later
QEMU release, we'll break the behaviour they've relied on.

IMHO, we must not accept "-F fmt" unless we're in a position to
honour it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


