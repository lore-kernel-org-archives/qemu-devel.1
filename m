Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A38C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128FA206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkaeBADB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128FA206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJPP-0001P2-4q
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJJO9-00005E-En
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJJO8-0000Wu-8J
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:05:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJJO8-0000WZ-4o
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585670715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLyHXzqDj/1fVIZaCeWF5Ikd2ZBZrlvGxWAPZoocpy4=;
 b=VkaeBADBGDxUKvpSdw8xylaWa3hF/ZhoaIc+Cvcc1PaijWx3epoYC2BzuT3o3R4/mTT2L/
 lm9fhs6EWwQ2eSMNrjj+AXtvXM1DWPi8Yljn/3cvUfXlnJeU0u/SDMhPOn6/NLCQxKD1td
 FlZV9+xQSc0SrlgCyS0PUmoNMcLI+1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-9HxC4RCZNE2E6nCUJFitIA-1; Tue, 31 Mar 2020 12:05:11 -0400
X-MC-Unique: 9HxC4RCZNE2E6nCUJFitIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C00218B5FA2;
 Tue, 31 Mar 2020 16:05:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34FC210002BB;
 Tue, 31 Mar 2020 16:05:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B3F9011385E2; Tue, 31 Mar 2020 18:05:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] qemu-options.hx: 9p: clarify -virtfs vs. -fsdev
References: <208f1fceffce2feaf7c900b29e326b967dce7762.1585661532.git.qemu_oss@crudebyte.com>
 <20200331172727.6e844deb.cohuck@redhat.com>
 <6318846.9qTBnWfJNl@silver>
Date: Tue, 31 Mar 2020 18:05:08 +0200
In-Reply-To: <6318846.9qTBnWfJNl@silver> (Christian Schoenebeck's message of
 "Tue, 31 Mar 2020 17:41:08 +0200")
Message-ID: <87369otsqz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christian Schoenebeck <qemu_oss@crudebyte.com> writes:

> On Dienstag, 31. M=C3=A4rz 2020 17:27:27 CEST Cornelia Huck wrote:
>> > diff --git a/qemu-options.hx b/qemu-options.hx
>> > index 962a5ebaa6..fd3830c6cd 100644
>> > --- a/qemu-options.hx
>> > +++ b/qemu-options.hx
>> > @@ -1542,9 +1542,17 @@ SRST
>> >=20
>> >  ``-virtfs proxy,sock_fd=3Dsock_fd,mount_tag=3Dmount_tag
>> >  [,writeout=3Dwriteout][,readonly]``> =20
>> >    \
>> > =20
>> >  ``-virtfs synth,mount_tag=3Dmount_tag``
>> >=20
>> > -    Define a new filesystem device and expose it to the guest using a
>> > -    virtio-9p-device. The general form of a Virtual File system
>> > -    pass-through options are:
>> > +    Define a new virtual filesystem device and expose it to the guest
>> > using +    a virtio-9p-device (a.k.a. 9pfs), which essentially means t=
hat
>> > a certain +    directory on host is made directly accessible by guest =
as
>> > a pass-through +    file system by using the 9P network protocol for
>> > communication between +    host and guests, if desired even accessible=
,
>> > shared by several guests +    simultaniously.
>> > +
>> > +    Note that ``-virtfs`` is actually just a convenience shortcut for=
 its
>> > +    generalized form ``-fsdev -device virtio-9p-pci``.
>>=20
>> Huh. This prompted me to try this on s390, and it actually creates a
>> virtio-9p-pci device there as well, not a virtio-9p-ccw device. A bit
>> surprising; but I don't see 9p used much (if at all) on s390 anyway.
>
> Yeah, "virtio-9p-pci" is currently hard coded in softmmu/vl.c [line 3352]=
:
> https://github.com/qemu/qemu/blob/17083d6d1e0635371418c26b613a6fa68d392f4=
9/softmmu/vl.c#L3352

Should it be "virtio-9p" instead?  It's an alias for "virtio-9p-pci",
except for s390x, where it's an alias for "virtio-9p-ccw".


