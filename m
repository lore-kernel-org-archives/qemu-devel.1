Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F95C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAAA214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZOEf0ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAAA214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j93i9-0003rv-DI
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 04:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j93hS-0003M5-J9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j93hR-0006gy-2n
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:18:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29359
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j93hQ-0006gb-Tz
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583227128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNz0hwX/RQnnHwpy+/Pg/Zrxl0gGQWBpeekrdUgxxFs=;
 b=CZOEf0ldxivmGCQCwI7sST8YgG2htwot1C4MCphOoE8Tz6kWjj+dAGQiKMnFyvKTyYjwB5
 663Jb7SbIIzOJyodBZ4zRO0RatVmxjUu02HicyLA9YKxltykMq8Jrhna8jwBzC6OLjb+pi
 I2eo++ExmK7zRX6W7MPMyjbcK4Rg8iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-xxz_oOeePm2D79pjSDTVRg-1; Tue, 03 Mar 2020 04:18:46 -0500
X-MC-Unique: xxz_oOeePm2D79pjSDTVRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7864E8024E1;
 Tue,  3 Mar 2020 09:18:45 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E1935DDAA;
 Tue,  3 Mar 2020 09:18:37 +0000 (UTC)
Message-ID: <6e42d2ac5a761548ed3b4fdf7382441646839a9b.camel@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots (was: [PATCH
 02/13] qcrypto-luks: implement encryption key management)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Tue, 03 Mar 2020 11:18:36 +0200
In-Reply-To: <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 2020-02-15 at 15:51 +0100, Markus Armbruster wrote:
> Review of this patch led to a lengthy QAPI schema design discussion.
> Let me try to condense it into a concrete proposal.
> 
> This is about the QAPI schema, and therefore about QMP.  The
> human-friendly interface is out of scope.  Not because it's not
> important (it clearly is!), only because we need to *focus* to have a
> chance at success.
> 
> I'm going to include a few design options.  I'll mark them "Option:".
> 
> The proposed "amend" interface takes a specification of desired state,
> and figures out how to get from here to there by itself.  LUKS keyslots
> are one part of desired state.
> 
> We commonly have eight LUKS keyslots.  Each keyslot is either active or
> inactive.  An active keyslot holds a secret.
> 
> Goal: a QAPI type for specifying desired state of LUKS keyslots.
> 
> Proposal:
> 
>     { 'enum': 'LUKSKeyslotState',
>       'data': [ 'active', 'inactive' ] }
> 
>     { 'struct': 'LUKSKeyslotActive',
>       'data': { 'secret': 'str',
>                 '*iter-time': 'int } }
> 
>     { 'struct': 'LUKSKeyslotInactive',
>       'data': { '*old-secret': 'str' } }
> 
>     { 'union': 'LUKSKeyslotAmend',
>       'base': { '*keyslot': 'int',
>                 'state': 'LUKSKeyslotState' }
>       'discriminator': 'state',
>       'data': { 'active': 'LUKSKeyslotActive',
>                 'inactive': 'LUKSKeyslotInactive' } }
> 
> LUKSKeyslotAmend specifies desired state for a set of keyslots.
> 
> Four cases:
> 
> * @state is "active"
> 
>   Desired state is active holding the secret given by @secret.  Optional
>   @iter-time tweaks key stretching.
> 
>   The keyslot is chosen either by the user or by the system, as follows:
> 
>   - @keyslot absent
> 
>     One inactive keyslot chosen by the system.  If none exists, error.
> 
>   - @keyslot present
> 
>     The keyslot given by @keyslot.
> 
>     If it's already active holding @secret, no-op.  Rationale: the
>     current state is the desired state.
> 
>     If it's already active holding another secret, error.  Rationale:
>     update in place is unsafe.
> 
>     Option: delete the "already active holding @secret" case.  Feels
>     inelegant to me.  Okay if it makes things substantially simpler.
> 
> * @state is "inactive"
> 
>   Desired state is inactive.
> 
>   Error if the current state has active keyslots, but the desired state
>   has none.
> 
>   The user choses the keyslot by number and/or by the secret it holds,
>   as follows:
> 
>   - @keyslot absent, @old-secret present
> 
>     All active keyslots holding @old-secret.  If none exists, error.
> 
>   - @keyslot present, @old-secret absent
> 
>     The keyslot given by @keyslot.
> 
>     If it's already inactive, no-op.  Rationale: the current state is
>     the desired state.
> 
>   - both @keyslot and @old-secret present
> 
>     The keyslot given by keyslot.
> 
>     If it's inactive or holds a secret other than @old-secret, error.
> 
>     Option: error regardless of @old-secret, if that makes things
>     simpler.
> 
>   - neither @keyslot not @old-secret present
> 
>     All keyslots.  Note that this will error out due to "desired state
>     has no active keyslots" unless the current state has none, either.
> 
>     Option: error out unconditionally.
> 
> Note that LUKSKeyslotAmend can specify only one desired state for
> commonly just one keyslot.  Rationale: this satisfies practical needs.
> An array of LUKSKeyslotAmend could specify desired state for all
> keyslots.  However, multiple array elements could then apply to the same
> slot.  We'd have to specify how to resolve such conflicts, and we'd have
> to code up conflict detection.  Not worth it.
> 
> Examples:
> 
> * Add a secret to some free keyslot:
> 
>   { "state": "active", "secret": "CIA/GRU/MI6" }
> 
> * Deactivate all keyslots holding a secret:
> 
>   { "state": "inactive", "old-secret": "CIA/GRU/MI6" }
> 
> * Add a secret to a specific keyslot:
> 
>   { "state": "active", "secret": "CIA/GRU/MI6", "keyslot": 0 }
> 
> * Deactivate a specific keyslot:
> 
>   { "state": "inactive", "keyslot": 0 }
> 
>   Possibly less dangerous:
> 
>   { "state": "inactive", "keyslot": 0, "old-secret": "CIA/GRU/MI6" }
> 
> Option: Make use of Max's patches to support optional union tag with
> default value to let us default @state to "active".  I doubt this makes
> much of a difference in QMP.  A human-friendly interface should probably
> be higher level anyway (Daniel pointed to cryptsetup).
> 
> Option: LUKSKeyslotInactive member @old-secret could also be named
> @secret.  I don't care.
> 
> Option: delete @keyslot.  It provides low-level slot access.
> Complicates the interface.  Fine if we need lov-level slot access.  Do
> we?
> 
> I apologize for the time it has taken me to write this.
> 
> Comments?

I tried today to implement this but I hit a very unpleasant roadblock:

Since QCrypto is generic (even though it only implements currently luks for raw/qcow2 usage,
and legacy qcow2 aes encryption), I still can't assume that this is always the case.
Thus I implemented the Qcrypto amend API in this way:

##
# @QCryptoBlockAmendOptions:
#
# The options that are available for all encryption formats
# when amending encryption settings
#
# Since: 5.0
##
{ 'union': 'QCryptoBlockAmendOptions',
  'base': 'QCryptoBlockOptionsBase',
  'discriminator': 'format',
  'data': {
          'luks': 'QCryptoBlockAmendOptionsLUKS' } }

However the QCryptoBlockAmendOptionsLUKS is a union too to be in line with the API proposal,
but that is not supported on QAPI level and after I and Markus talked about we are not sure
that it is worth it to implement this support only for this case.

So far I see the following solutions


1. Drop the QCryptoBlockAmendOptionsLUKS union for now.
This will bring the schema pretty much to be the same as my original proposal,
however the API will be the same thus once nested unions are implemented this union
can always be introduced again.

2. Drop the QCryptoBlockAmendOptions union. Strictly speaking this union is not needed
since it only has one member anyway, however this union is used both by qcow2 QAPI scheme,
so that it doesn't hardcode an encryption format for amend just like it doesn't for creation,
(this can be hardcoded for now as well for now as long as we don't have more amendable encryption formats).
However I also use the QCryptoBlockAmendOptions in C code in QCrypto API thus it will be ugly to use the 
QCryptoBlockAmendOptionsLUKS instead.


3. Make QCryptoBlockAmendOptionsLUKS a struct and add to it a nested member with new union type 
(say QCryptoBlockAmendOptionsLUKS1) which will be exactly as QCryptoBlockAmendOptionsLUKS was.

This IMHO is even uglier since it changes the API (which we can't later fix) and adds both a dummy struct
field and a dummy struct name.

I personally vote 1.

Best regards,
	Maxim Levitsky





