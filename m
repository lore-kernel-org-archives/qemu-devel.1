Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C8CC2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF5620787
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrC5CR5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF5620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZHw-0001IM-QM
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJZGN-0007Vp-Uu
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJZGM-0002wZ-8a
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:02:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34142
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJZGM-0002pr-0U
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585731737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7BuyqJ3bQexnnE1BQTonpzizOa3CJ+xhbg4Oo2W2jCo=;
 b=FrC5CR5h6bjjn1AxpyGGE7CMKRLW4q8SnG4e3sx63xa5fg2WUGTwwmJ4QD9+K2tu6C04FW
 TuKG6jzjycGfcKwWZx+pRmfKi8HacJWqzfK6B5Ie9nuC+8qtCq0qvC15IGQATFMmTrvZ8C
 1xmv9u0sc86e2Us2HpzPXqKTHE79+0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-DJzVFE7-Mzu_1iSVGk5C8A-1; Wed, 01 Apr 2020 05:02:15 -0400
X-MC-Unique: DJzVFE7-Mzu_1iSVGk5C8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44BA91005513;
 Wed,  1 Apr 2020 09:02:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD2455C1B0;
 Wed,  1 Apr 2020 09:02:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42DB611385E2; Wed,  1 Apr 2020 11:02:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Questionable aspects of QEMU Error's design
Date: Wed, 01 Apr 2020 11:02:11 +0200
Message-ID: <87o8sblgto.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU's Error was patterned after GLib's GError.  Differences include:

* &error_fatal, &error_abort for convenience

* Error can optionally store hints

* Pointlessly different names: error_prepend() vs. g_error_prefix() and
  so forth *shrug*

* Propagating errors

  Thanks to Vladimir, we'll soon have "auto propagation", which is less
  verbose and less error-prone.

* Accumulating errors

  error_propagate() permits it, g_propagate_error() does not[*].

  I believe this feature is used rarely.  Perhaps we'd be better off
  without it.  The problem is identifying its uses.  If I remember
  correctly, Vladimir struggled with that for his "auto propagation"
  work.

  Perhaps "auto propagation" will reduce the number of manual
  error_propagate() to the point where we can identify accumulations.
  Removing the feature would become feasible then.

* Distinguishing different errors

  Where Error has ErrorClass, GError has Gquark domain, gint code.  Use
  of ErrorClass other than ERROR_CLASS_GENERIC_ERROR is strongly
  discouraged.  When we need callers to distinguish errors, we return
  suitable error codes separately.

* Return value conventions

  Common: non-void functions return a distinct error value on failure
  when such a value can be defined.  Patterns:

  - Functions returning non-null pointers on success return null pointer
    on failure.

  - Functions returning non-negative integers on success return a
    negative error code on failure.

  Different: GLib discourages void functions, because these lead to
  awkward error checking code.  We have tons of them, and tons of
  awkward error checking code:

    Error *err =3D NULL;
    frobnicate(arg, &err);
    if (err) {
        ... recover ...
        error_propagate(errp, err);
    }

  instead of

    if (!frobnicate(arg, errp))
        ... recover ...
    }

  Can also lead to pointless creation of Error objects.

  I consider this a design mistake.  Can we still fix it?  We have more
  than 2000 void functions taking an Error ** parameter...

  Transforming code that receives and checks for errors with Coccinelle
  shouldn't be hard.  Transforming code that returns errors seems more
  difficult.  We need to transform explicit and implicit return to
  either return true or return false, depending on what we did to the
  @errp parameter on the way to the return.  Hmm.


[*] According to documentation; the code merely calls g_warning() then,
in typical GLib fashion.


