Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3150C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E346B246AD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc2ZIOqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E346B246AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXkme-0008Mp-Ko
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 08:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXklS-0007iB-Uf
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXklP-0004Aq-OS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603888874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0PCd2hn/MmynDBsGf8P/xtXYMah3h2202jJ32+kMtgk=;
 b=bc2ZIOqf9VIV2sn17xu3NmVZMVrFlu1TBx8pmO0pev1xNs2CX7Q1XxKpGiZI0CBmkhncmj
 zpxXwt7OyskbieGHTGbq/G9JCiGMOu/cx8X8LuTLnww7CNmMY1NW4wqekfdZmn1goPBOch
 EyU7tu3BiFoN8Q5MtShdZGEHA/aRf5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-ImeyPNk1NamzfQd2HDVmUQ-1; Wed, 28 Oct 2020 08:41:12 -0400
X-MC-Unique: ImeyPNk1NamzfQd2HDVmUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E856D18C89D3;
 Wed, 28 Oct 2020 12:41:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA7E260C11;
 Wed, 28 Oct 2020 12:41:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B517113865F; Wed, 28 Oct 2020 13:41:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Our abstract UNIX domain socket support is a mess
Date: Wed, 28 Oct 2020 13:41:06 +0100
Message-ID: <87o8kmwmjh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: xiaoqiang zhao <zxq_yx_007@163.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 776b97d360 "qemu-sockets: add abstract UNIX domain socket
support" (v5.1) has made a mess.

First, what are abstract UNIX domain sockets?  They use a separate
"abstract" namespace which is independent of the filesystem.  This is a
non-portable Linux extension.  See unix(7).

Traditional pathname sockets have a zero-terminated string in
sockaddr_un member sun_path.  Abstract sockets have a binary blob
starting with a 0 byte.  Works, because the empty string is not a valid
pathname.

This interface is a hack.  The leading 0 byte is ugly.  The size of the
blob is given by the socklen_t argument passed with the struct
sockaddr_un.  People use strings, then forget to either cut the length
to the size of the string, or pad to the blob to sizeof(sockaddr_un),
and do it consistently.

QEMU's interface is differently messy.

Our equivalent to struct sockaddr_un is QAPI type UnixSocketAddress:

    { 'struct': 'UnixSocketAddress',
      'data': {
        'path': 'str' }

@path corresponds to sockaddr_un member sun_path.  sun_family =3D AF_UNIX
and socklen_t sizeof(sockaddr_un) are implied.

We didn't repurpose @path for abstract sockets like the Linux kernel did
with sun_path.  Instead, we added a flag @abstract (default false).
When it's on, we make a binary blob by prefixing @path with a 0 byte,
and pad it with more 0 bytes.

We added a second flag @tight (default true) to optionally cut the
socklen_t to the end of the string (the terminating 0 byte is not
included).

Six revisions were posted, and the QAPI maintainers were cc'ed on none
of them.  I spotted @tight in the pull request by chance, and found it
odd.  I inquired, and Daniel explained:

    In the abstract namespace the length of the socket is critical
    information. ie

       "\0foo" (length =3D=3D 4,  tight=3Dtrue)

    is a completely different socket from

       "\0foo\0..repeated...\0" (length =3D=3D sizeof(sun_path), tight=3Dfa=
lse)

    In theory you can have any length in between those extremes,
    each being a different socket, but in practice no one is that
    insane. Apps either use the full length, or the minimal
    length. The "tight" terminology is copied from "socat" which
    uses this same option name

    Message-ID: <87imgqr8g9.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg05812.html

I did not press further, or dig deeper.  I should have.  I did only when
Kevin reported @tight's default is backward in QMP.  I'm not liking what
I found.


Issue#1: our interface is differently ugly, for no good reason

Like the Linux kernel, we also appropriate existing @path for abstract
sockets.  With less excuse, though; we could have created a neater
interface, easily.

Unlike the Linux kernel, we don't do blobs.  In other words, our variant
of the hack is not general.

Elsewhere in QMP, we use base64 for blobs.

Aside: QMP can do embedded 0 bytes.  It represents them as overlong
UTF-8 =E2=80=9C\xC0\x80", though.

Not sure the interface is worth fixing now.  Abstract sockets are niche.
In my opinion, we should've said no.


Issue#2: we offer abstract sockets even on non-Linux hosts

I expect this to fail with ENOENT elsehwere.  I tested OpenBSD, and
fails that way.  We report this failure like

    Failed to connect socket abc: No such file or directory

Tolerable, although ENOTSUP would be better.

Introspection lies: it has @abstract regardless of host support.  Easy
enough to fix: since Linux provides them since 2.2, 'if':
'defined(CONFIG_LINUX)' should do.

This should also change the error report to

    Parameter 'backend.data.addr.data.abstract' is unexpected

Improvement, I think.


Issue#3: @tight's default is backward in QMP

Incorrect use of the QAPI type in C, plus insufficient test coverage.

Fixable.  Treat 5.1's default as bug.


Final plea: please copy the QAPI schema maintainers on all
schema-changing patches!  We happen to have some interface design
expertise.  Make use of it!  Also, please give us a chance to correct
mistakes while corrections are easy and cheap.


