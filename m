Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DB0C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7CD2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5tKyiaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7CD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eG6-0004X2-2N
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j3eFO-00042J-Rk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j3eFN-0000NI-E8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:07:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41282
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j3eFN-0000Mn-9m
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581937648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOe8PalnRgQIHUfJjQPuDHUZq01LUC8mjQTKSuB+pQ4=;
 b=J5tKyiaQMazmARZCCWRWjrvww8p9SL4gjXksQhJ84bSaQVBMgIDFP0vX0gnWaZ/1dKhUp6
 mjVEI8ipBrtPA31Ijy8t6tgM/6cGg4It1B/SWtsEjkTiajyWjlJVvfaF+83LtsgpvRWM/q
 fXLEylRMoW/rPphgAL9HME3wfOOoyTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-lSfLezjhMfiU4piss_KeJQ-1; Mon, 17 Feb 2020 06:07:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F08B800D53;
 Mon, 17 Feb 2020 11:07:26 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90EFB8681F;
 Mon, 17 Feb 2020 11:07:24 +0000 (UTC)
Message-ID: <fd30b30b11772bd59ccf4573a35fc01d5bd51379.camel@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots (was: [PATCH
 02/13] qcrypto-luks: implement encryption key management)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Date: Mon, 17 Feb 2020 13:07:23 +0200
In-Reply-To: <20200217103700.GC6309@linux.fritz.box>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <20200217103700.GC6309@linux.fritz.box>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: lSfLezjhMfiU4piss_KeJQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-02-17 at 11:37 +0100, Kevin Wolf wrote:
> Am 15.02.2020 um 15:51 hat Markus Armbruster geschrieben:
> > Review of this patch led to a lengthy QAPI schema design discussion.
> > Let me try to condense it into a concrete proposal.
> > 
> > This is about the QAPI schema, and therefore about QMP.  The
> > human-friendly interface is out of scope.  Not because it's not
> > important (it clearly is!), only because we need to *focus* to have a
> > chance at success.
> > 
> > I'm going to include a few design options.  I'll mark them "Option:".
> > 
> > The proposed "amend" interface takes a specification of desired state,
> > and figures out how to get from here to there by itself.  LUKS keyslots
> > are one part of desired state.
> > 
> > We commonly have eight LUKS keyslots.  Each keyslot is either active or
> > inactive.  An active keyslot holds a secret.
> > 
> > Goal: a QAPI type for specifying desired state of LUKS keyslots.
> > 
> > Proposal:
> > 
> >     { 'enum': 'LUKSKeyslotState',
> >       'data': [ 'active', 'inactive' ] }
> > 
> >     { 'struct': 'LUKSKeyslotActive',
> >       'data': { 'secret': 'str',
> >                 '*iter-time': 'int } }
> > 
> >     { 'struct': 'LUKSKeyslotInactive',
> >       'data': { '*old-secret': 'str' } }
> > 
> >     { 'union': 'LUKSKeyslotAmend',
> >       'base': { '*keyslot': 'int',
> >                 'state': 'LUKSKeyslotState' }
> >       'discriminator': 'state',
> >       'data': { 'active': 'LUKSKeyslotActive',
> >                 'inactive': 'LUKSKeyslotInactive' } }
> > 
> > LUKSKeyslotAmend specifies desired state for a set of keyslots.
> 
> Though not arbitrary sets of keyslots, it's only a single keyslot or
> multiple keyslots containing the same secret. Might be good enough in
> practice, though it means that you may have to issue multiple amend
> commands to get to the final state that you really want (even if doing
> everything at once would be safe).
> 
> > Four cases:
> > 
> > * @state is "active"
> > 
> >   Desired state is active holding the secret given by @secret.  Optional
> >   @iter-time tweaks key stretching.
> > 
> >   The keyslot is chosen either by the user or by the system, as follows:
> > 
> >   - @keyslot absent
> > 
> >     One inactive keyslot chosen by the system.  If none exists, error.
> > 
> >   - @keyslot present
> > 
> >     The keyslot given by @keyslot.
> > 
> >     If it's already active holding @secret, no-op.  Rationale: the
> >     current state is the desired state.
> > 
> >     If it's already active holding another secret, error.  Rationale:
> >     update in place is unsafe.
> > 
> >     Option: delete the "already active holding @secret" case.  Feels
> >     inelegant to me.  Okay if it makes things substantially simpler.
> > 
> > * @state is "inactive"
> > 
> >   Desired state is inactive.
> > 
> >   Error if the current state has active keyslots, but the desired state
> >   has none.
> > 
> >   The user choses the keyslot by number and/or by the secret it holds,
> >   as follows:
> > 
> >   - @keyslot absent, @old-secret present
> > 
> >     All active keyslots holding @old-secret.  If none exists, error.
> > 
> >   - @keyslot present, @old-secret absent
> > 
> >     The keyslot given by @keyslot.
> > 
> >     If it's already inactive, no-op.  Rationale: the current state is
> >     the desired state.
> > 
> >   - both @keyslot and @old-secret present
> > 
> >     The keyslot given by keyslot.
> > 
> >     If it's inactive or holds a secret other than @old-secret, error.
> > 
> >     Option: error regardless of @old-secret, if that makes things
> >     simpler.
> > 
> >   - neither @keyslot not @old-secret present
> > 
> >     All keyslots.  Note that this will error out due to "desired state
> >     has no active keyslots" unless the current state has none, either.
> > 
> >     Option: error out unconditionally.
> > 
> > Note that LUKSKeyslotAmend can specify only one desired state for
> > commonly just one keyslot.  Rationale: this satisfies practical needs.
> > An array of LUKSKeyslotAmend could specify desired state for all
> > keyslots.  However, multiple array elements could then apply to the same
> > slot.  We'd have to specify how to resolve such conflicts, and we'd have
> > to code up conflict detection.  Not worth it.
> > 
> > Examples:
> > 
> > * Add a secret to some free keyslot:
> > 
> >   { "state": "active", "secret": "CIA/GRU/MI6" }
> > 
> > * Deactivate all keyslots holding a secret:
> > 
> >   { "state": "inactive", "old-secret": "CIA/GRU/MI6" }
> > 
> > * Add a secret to a specific keyslot:
> > 
> >   { "state": "active", "secret": "CIA/GRU/MI6", "keyslot": 0 }
> > 
> > * Deactivate a specific keyslot:
> > 
> >   { "state": "inactive", "keyslot": 0 }
> > 
> >   Possibly less dangerous:
> > 
> >   { "state": "inactive", "keyslot": 0, "old-secret": "CIA/GRU/MI6" }
> > 
> > Option: Make use of Max's patches to support optional union tag with
> > default value to let us default @state to "active".  I doubt this makes
> > much of a difference in QMP.  A human-friendly interface should probably
> > be higher level anyway (Daniel pointed to cryptsetup).
> > 
> > Option: LUKSKeyslotInactive member @old-secret could also be named
> > @secret.  I don't care.
> > 
> > Option: delete @keyslot.  It provides low-level slot access.
> > Complicates the interface.  Fine if we need lov-level slot access.  Do
> > we?
> > 
> > I apologize for the time it has taken me to write this.
> > 
> > Comments?
> 
> Works for me (without taking any of the options).
> 
> The unclear part is what the human-friendly interface should look like
> and where it should live. I'm afraid doing only the QMP part and calling
> the feature completed like we do so often won't work in this case.

IMHO, I think that the best way to create human friendly part is to implement
luks specific commands for qemu-img and use interface very similar
to what cryptsetup does.

Best regards,
	Maxim Levitsky
> 
> Kevin



