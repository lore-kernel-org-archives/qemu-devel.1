Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F177C7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 06:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398B1206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 06:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZZlDC+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398B1206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3aAT-0007Mo-Bp
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 01:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j3a9Z-0006m0-Pl
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 01:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j3a9Y-0000iY-Jx
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 01:45:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j3a9Y-0000hr-Gp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 01:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581921911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8W2QKPMu23evWvF8SI1Ux0YdyB7JmoCOr3ps2fnB6Dc=;
 b=PZZlDC+dTfPiPhhAMgMvzj9ZYkv4QtwtTKUNvq8eFooE4ZwUVdD2Ei6Z96N+fHLW7d8Tlk
 YXoHsNDEfIvTGL95ig3J+tbZEBjhu5UYwqTHLHCFXpOVfM3kVBt03o+kKHKYGYvbWctgLC
 5iglqBguVGsnxz8/fNhumKKJTqsp7oc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-x58YhQGwPzONc56Mh8RTgA-1; Mon, 17 Feb 2020 01:45:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 126F4107ACC4;
 Mon, 17 Feb 2020 06:45:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E99A890F6B;
 Mon, 17 Feb 2020 06:45:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 561FA11385C9; Mon, 17 Feb 2020 07:45:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <59039903dba3c277ef9dbc2397a896c906f120d1.camel@redhat.com>
Date: Mon, 17 Feb 2020 07:45:02 +0100
In-Reply-To: <59039903dba3c277ef9dbc2397a896c906f120d1.camel@redhat.com>
 (Maxim Levitsky's message of "Sun, 16 Feb 2020 10:05:15 +0200")
Message-ID: <87lfp1ww41.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: x58YhQGwPzONc56Mh8RTgA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
 Daniel =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Sat, 2020-02-15 at 15:51 +0100, Markus Armbruster wrote:
>> Review of this patch led to a lengthy QAPI schema design discussion.
>> Let me try to condense it into a concrete proposal.
>>=20
>> This is about the QAPI schema, and therefore about QMP.  The
>> human-friendly interface is out of scope.  Not because it's not
>> important (it clearly is!), only because we need to *focus* to have a
>> chance at success.
> 100% agree.
>>=20
>> I'm going to include a few design options.  I'll mark them "Option:".
>>=20
>> The proposed "amend" interface takes a specification of desired state,
>> and figures out how to get from here to there by itself.  LUKS keyslots
>> are one part of desired state.
>>=20
>> We commonly have eight LUKS keyslots.  Each keyslot is either active or
>> inactive.  An active keyslot holds a secret.
>>=20
>> Goal: a QAPI type for specifying desired state of LUKS keyslots.
>>=20
>> Proposal:
>>=20
>>     { 'enum': 'LUKSKeyslotState',
>>       'data': [ 'active', 'inactive' ] }
>>=20
>>     { 'struct': 'LUKSKeyslotActive',
>>       'data': { 'secret': 'str',
>>                 '*iter-time': 'int } }
>>=20
>>     { 'struct': 'LUKSKeyslotInactive',
>>       'data': { '*old-secret': 'str' } }
>>=20
>>     { 'union': 'LUKSKeyslotAmend',
>>       'base': { '*keyslot': 'int',
>>                 'state': 'LUKSKeyslotState' }
>>       'discriminator': 'state',
>>       'data': { 'active': 'LUKSKeyslotActive',
>>                 'inactive': 'LUKSKeyslotInactive' } }
>>=20
>> LUKSKeyslotAmend specifies desired state for a set of keyslots.
>>=20
>> Four cases:
>>=20
>> * @state is "active"
>>=20
>>   Desired state is active holding the secret given by @secret.  Optional
>>   @iter-time tweaks key stretching.
>>=20
>>   The keyslot is chosen either by the user or by the system, as follows:
>>=20
>>   - @keyslot absent
>>=20
>>     One inactive keyslot chosen by the system.  If none exists, error.
>>=20
>>   - @keyslot present
>>=20
>>     The keyslot given by @keyslot.
>>=20
>>     If it's already active holding @secret, no-op.  Rationale: the
>>     current state is the desired state.
>>=20
>>     If it's already active holding another secret, error.  Rationale:
>>     update in place is unsafe.
>>=20
>>     Option: delete the "already active holding @secret" case.  Feels
>>     inelegant to me.  Okay if it makes things substantially simpler.
> I didn't really understand this, since in state=3Dactive we shouldn't
> delete anything. Looks OK otherwise.

Let me try to clarify.

Option: make the "already active holding @secret" case an error like the
"already active holding another secret" case.  In longhand:

     - @keyslot present

       The keyslot given by @keyslot.

       If it's already active, error.

It feels inelegant to me, because it deviates from "specify desired
state" paradigm: the specified desired state is fine, the way to get
there from current state is obvious (do nothing), yet it's still an
error.

>> * @state is "inactive"
>>=20
>>   Desired state is inactive.
>>=20
>>   Error if the current state has active keyslots, but the desired state
>>   has none.
>>=20
>>   The user choses the keyslot by number and/or by the secret it holds,
>>   as follows:
>>=20
>>   - @keyslot absent, @old-secret present
>>=20
>>     All active keyslots holding @old-secret.  If none exists, error.
>>=20
>>   - @keyslot present, @old-secret absent
>>=20
>>     The keyslot given by @keyslot.
>>=20
>>     If it's already inactive, no-op.  Rationale: the current state is
>>     the desired state.
>>=20
>>   - both @keyslot and @old-secret present
>>=20
>>     The keyslot given by keyslot.
>>=20
>>     If it's inactive or holds a secret other than @old-secret, error.
> Yea, that would be very nice to have.
>>=20
>>     Option: error regardless of @old-secret, if that makes things
>>     simpler.
>>=20
>>   - neither @keyslot not @old-secret present
>>=20
>>     All keyslots.  Note that this will error out due to "desired state
>>     has no active keyslots" unless the current state has none, either.
>>=20
>>     Option: error out unconditionally.
> Yep, that the best IMHO.

It's a matter of taste.

If we interpret "both absent" as "all keyslots", then all cases flow out
of the following simple spec:

    0. Start with the set of all keyslots

    1. If @old-secret is present, interset it with the set of slots
       holding that secret.

    2. If @keyslots is present, intersect it with the set of slots with
       that slot number.

The order of steps 1 and 2 doesn't matter.

To error out unconditionally, we have to make "both absent" a special
case.

A good way to resolve such matters of taste is to try writing doc
comments for all proposals.  If you find you hate one of them much less,
you have a winner :)

[...]


