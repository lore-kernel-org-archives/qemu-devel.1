Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2A9C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C152238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C152238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZLz-0005FA-Vl
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49955)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hqZLp-0004qm-PE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hqZLo-0008Fy-I8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hqZLo-0008EK-Ag
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8FD731628FF
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:43:45 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F4261017E30;
 Thu, 25 Jul 2019 08:43:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 09:43:38 +0100
Message-Id: <20190725084341.8287-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 25 Jul 2019 08:43:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/3] require newer glib2 to enable
 autofree'ing of stack variables exiting scope
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both GCC and CLang support a C extension attribute((cleanup)) which
allows you to define a function that is invoked when a stack variable
exits scope. This typically used to free the memory allocated to it,
though you're not restricted to this. For example it could be used to
unlock a mutex.

We could use that functionality now, but the syntax is a bit ugly in
plain C. Since version 2.44 of GLib, there have been a few macros to
make it more friendly to use - g_autofree, g_autoptr and
G_DEFINE_AUTOPTR_CLEANUP_FUNC.

  https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.html

  https://blogs.gnome.org/desrt/2015/01/30/g_autoptr/

The key selling point is that it simplifies the cleanup code paths,
often eliminating the need to goto cleanup labels. This improves
the readability of the code and makes it less likely that you'll
leak memory accidentally.

Inspired by seeing it added to glib, and used in systemd, Libvirt
finally got around to adopting this in Feb 2019. Overall our
experience with it has been favourable/positive, with the code
simplification being very nice.

The main caveats with it are

 - Only works with GCC or CLang. We don't care as those are
   the only two compilers we declare support for.

 - You must always initialize the variables when declared
   to ensure predictable behaviour when they leave scope.
   Chances are most methods with goto jumps for cleanup
   are doing this already

 - You must not directly return the value that's assigned
   to a auto-cleaned variable. You must steal the pointer
   in some way. ie

    BAD:
        g_autofree char *wibble =3D g_strdup("wibble")
	....
	return wibble;

    GOOD:
        g_autofree char *wibble =3D g_strdup("wibble")
	...
	return g_steal_pointer(wibble);

    g_steal_pointer is an inline function which simply copies
    the pointer to a new variable, and sets the original variable
    to NULL, thus avoiding cleanup.

I've illustrated the usage by converting a bunch of the crypto code in
QEMU to use auto cleanup.

Changed on v2:

 - Actually commit the rest of the changes to patch 3 so that what's
   posted works :-) Sigh.

Daniel P. Berrang=C3=A9 (3):
  glib: bump min required glib library version to 2.48
  crypto: define cleanup functions for use with g_autoptr
  crypto: use auto cleanup for many stack variables

 configure                   |  2 +-
 crypto/afsplit.c            | 28 ++++----------
 crypto/block-luks.c         | 74 +++++++++++--------------------------
 crypto/block.c              | 15 +++-----
 crypto/hmac-glib.c          |  5 ---
 crypto/pbkdf.c              |  5 +--
 crypto/secret.c             | 38 ++++++++-----------
 crypto/tlscredsanon.c       | 16 +++-----
 crypto/tlscredspsk.c        |  5 +--
 crypto/tlscredsx509.c       | 16 +++-----
 include/crypto/block.h      |  2 +
 include/crypto/cipher.h     |  2 +
 include/crypto/hmac.h       |  2 +
 include/crypto/ivgen.h      |  2 +
 include/crypto/tlssession.h |  2 +
 include/glib-compat.h       | 42 +--------------------
 16 files changed, 78 insertions(+), 178 deletions(-)

--=20
2.21.0


