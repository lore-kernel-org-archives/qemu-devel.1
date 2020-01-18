Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33E4C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E03124699
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQ8+3PMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E03124699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isolc-0001Q8-K7
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 09:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isokO-0000Bd-2o
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isokI-0007Ut-Ql
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:06:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isokI-0007UA-Mq
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579356397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1rKRKN3OpUWiFF7mmOWHDQpByBqOQ7tZ0Y7nIN7DNi4=;
 b=HQ8+3PMFvy0WGmQItGVY5hH5JivqCzaIHtKEvw8Gd5yfOwF58VIIhwQO30IrALPwnDFDUT
 Um5OmbrGlvTnO/sOwsW3uBoOxga3JKo8RmubDG9MTGJ0v4zKa7RAdX1MZEsySyPVDQlEpq
 3I1u5gxXpxn7rKVQgRM0lckIqkeKWsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-YOaUvgn_NdqXjvPZdRt9rg-1; Sat, 18 Jan 2020 09:06:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E03A71005510;
 Sat, 18 Jan 2020 14:06:31 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0DBC5C1D4;
 Sat, 18 Jan 2020 14:06:23 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 0/6] buildsys: Build faster (mostly tools and linux-user)
Date: Sat, 18 Jan 2020 15:06:13 +0100
Message-Id: <20200118140619.26333-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: YOaUvgn_NdqXjvPZdRt9rg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In some configuration (linux-user, tools) we can ignore building
various objects (and the libfdt).

Tested with all the combinations of --[enable|disable]-tools,
--[enable|disable]-user and --[enable|disable]-system using the
following commands (suggested by Laurent Vivier in v1):

  $ mkdir build
  $ cd build
  $ for user in enable disable; do \
        for tools in enable disable; do \
            for system in enable disable; do \
                rm -fr build-$user-$system-$tools && \
                mkdir build-$user-$system-$tools && \
                    (cd build-$user-$system-$tools && \
                     ../../configure \
                                     --${user}-user \
                                     --${system}-system \
                                     --${tools}-tools \
                                     --disable-docs \
                    ); \
            done; \
        done; \
    done

Then building each of the 8 subdirectories on x86_64 and aarch64
hosts, running 'make check', and only on x86_64:
'make run-tcg-tests-x86_64-linux-user'.

All CI green:
https://gitlab.com/philmd/qemu/pipelines/110420332
https://travis-ci.org/philmd/qemu/builds/638781159
https://app.shippable.com/github/philmd/qemu/runs/587/summary/console

Since v1:
- no code change, improved commit description, added review tags
- added 2 new patches touching hw/core/ (remove reset.o from linux-user)

$ git backport-diff -u v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/6:[----] [--] 'configure: Do not build libfdt if not required'
002/6:[----] [--] 'Makefile: Clarify all the codebase requires qom/ objects=
'
003/6:[----] [--] 'Makefile: Restrict system emulation and tools objects'
004/6:[----] [--] 'Makefile: Remove unhelpful comment'
005/6:[down] 'hw/core: Restrict reset handlers API to system-mode'
006/6:[down] 'hw/core/Makefile: Group generic objects versus system-mode ob=
jects'

Supersedes: <20200109153939.27173-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (6):
  configure: Do not build libfdt if not required
  Makefile: Clarify all the codebase requires qom/ objects
  Makefile: Restrict system emulation and tools objects
  Makefile: Remove unhelpful comment
  hw/core: Restrict reset handlers API to system-mode
  hw/core/Makefile: Group generic objects versus system-mode objects

 configure             |  2 ++
 Makefile.objs         | 31 ++++++++++---------------------
 hw/core/Makefile.objs | 31 ++++++++++++++++---------------
 3 files changed, 28 insertions(+), 36 deletions(-)

--=20
2.21.1


