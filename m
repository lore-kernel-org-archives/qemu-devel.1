Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9402CC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 14:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5775020656
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 14:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eqq1sdQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5775020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2yo7-00039o-Ja
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 09:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2ynW-0002ej-D3
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 09:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2ynQ-0000t8-IY
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 09:51:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2ynQ-0000r0-Dq
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 09:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581778311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKIbhaG9tpcPeye9+9rxYj/2sP1grlAm8NUchNLFZgc=;
 b=Eqq1sdQ9mykhYTvT494l+SS8xMy+ZpnMkVlA3GDDPMyDcnryDtpSfisOIcVhoJ7YePX/GF
 9YVTUI9nvjmVu9+02g9BlbQR8ActazTJxiPmA+ZtwJh6dz4Ka/f/6xAfAC3HjFKR4bVPOw
 cfI4VrmKAeaIheuMRtFQG26KWxAQjus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-rL7gq_gWMlyhB4COLqvbaQ-1; Sat, 15 Feb 2020 09:51:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69AC48010C4;
 Sat, 15 Feb 2020 14:51:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA5915C21A;
 Sat, 15 Feb 2020 14:51:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A8C611385C9; Sat, 15 Feb 2020 15:51:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: QAPI schema for desired state of LUKS keyslots (was: [PATCH 02/13]
 qcrypto-luks: implement encryption key management)
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
Date: Sat, 15 Feb 2020 15:51:46 +0100
In-Reply-To: <20200114193350.10830-3-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Tue, 14 Jan 2020 21:33:39 +0200")
Message-ID: <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: rL7gq_gWMlyhB4COLqvbaQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Review of this patch led to a lengthy QAPI schema design discussion.
Let me try to condense it into a concrete proposal.

This is about the QAPI schema, and therefore about QMP.  The
human-friendly interface is out of scope.  Not because it's not
important (it clearly is!), only because we need to *focus* to have a
chance at success.

I'm going to include a few design options.  I'll mark them "Option:".

The proposed "amend" interface takes a specification of desired state,
and figures out how to get from here to there by itself.  LUKS keyslots
are one part of desired state.

We commonly have eight LUKS keyslots.  Each keyslot is either active or
inactive.  An active keyslot holds a secret.

Goal: a QAPI type for specifying desired state of LUKS keyslots.

Proposal:

    { 'enum': 'LUKSKeyslotState',
      'data': [ 'active', 'inactive' ] }

    { 'struct': 'LUKSKeyslotActive',
      'data': { 'secret': 'str',
                '*iter-time': 'int } }

    { 'struct': 'LUKSKeyslotInactive',
      'data': { '*old-secret': 'str' } }

    { 'union': 'LUKSKeyslotAmend',
      'base': { '*keyslot': 'int',
                'state': 'LUKSKeyslotState' }
      'discriminator': 'state',
      'data': { 'active': 'LUKSKeyslotActive',
                'inactive': 'LUKSKeyslotInactive' } }

LUKSKeyslotAmend specifies desired state for a set of keyslots.

Four cases:

* @state is "active"

  Desired state is active holding the secret given by @secret.  Optional
  @iter-time tweaks key stretching.

  The keyslot is chosen either by the user or by the system, as follows:

  - @keyslot absent

    One inactive keyslot chosen by the system.  If none exists, error.

  - @keyslot present

    The keyslot given by @keyslot.

    If it's already active holding @secret, no-op.  Rationale: the
    current state is the desired state.

    If it's already active holding another secret, error.  Rationale:
    update in place is unsafe.

    Option: delete the "already active holding @secret" case.  Feels
    inelegant to me.  Okay if it makes things substantially simpler.

* @state is "inactive"

  Desired state is inactive.

  Error if the current state has active keyslots, but the desired state
  has none.

  The user choses the keyslot by number and/or by the secret it holds,
  as follows:

  - @keyslot absent, @old-secret present

    All active keyslots holding @old-secret.  If none exists, error.

  - @keyslot present, @old-secret absent

    The keyslot given by @keyslot.

    If it's already inactive, no-op.  Rationale: the current state is
    the desired state.

  - both @keyslot and @old-secret present

    The keyslot given by keyslot.

    If it's inactive or holds a secret other than @old-secret, error.

    Option: error regardless of @old-secret, if that makes things
    simpler.

  - neither @keyslot not @old-secret present

    All keyslots.  Note that this will error out due to "desired state
    has no active keyslots" unless the current state has none, either.

    Option: error out unconditionally.

Note that LUKSKeyslotAmend can specify only one desired state for
commonly just one keyslot.  Rationale: this satisfies practical needs.
An array of LUKSKeyslotAmend could specify desired state for all
keyslots.  However, multiple array elements could then apply to the same
slot.  We'd have to specify how to resolve such conflicts, and we'd have
to code up conflict detection.  Not worth it.

Examples:

* Add a secret to some free keyslot:

  { "state": "active", "secret": "CIA/GRU/MI6" }

* Deactivate all keyslots holding a secret:

  { "state": "inactive", "old-secret": "CIA/GRU/MI6" }

* Add a secret to a specific keyslot:

  { "state": "active", "secret": "CIA/GRU/MI6", "keyslot": 0 }

* Deactivate a specific keyslot:

  { "state": "inactive", "keyslot": 0 }

  Possibly less dangerous:

  { "state": "inactive", "keyslot": 0, "old-secret": "CIA/GRU/MI6" }

Option: Make use of Max's patches to support optional union tag with
default value to let us default @state to "active".  I doubt this makes
much of a difference in QMP.  A human-friendly interface should probably
be higher level anyway (Daniel pointed to cryptsetup).

Option: LUKSKeyslotInactive member @old-secret could also be named
@secret.  I don't care.

Option: delete @keyslot.  It provides low-level slot access.
Complicates the interface.  Fine if we need lov-level slot access.  Do
we?

I apologize for the time it has taken me to write this.

Comments?


