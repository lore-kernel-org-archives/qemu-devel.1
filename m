Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693DFC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346C22084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FB+LMcxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346C22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6r8e-00061a-Cs
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j6r7o-0005AQ-8n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j6r7m-0001al-9J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:28:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j6r7m-0001Vk-4t
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582702133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/wDBky7u+KHIb1lSpcmCSQh210AW1YUk6VEoscXbeXQ=;
 b=FB+LMcxcaW6m6q0oh2eSbUqtkUlFCJ1VE1LpYF3+5NLTkbHi4SnGqGqIZidSEsNWNZlhBp
 sP7CbOtClNjeWIequ22dAzfnW1pGD9mBUuQj9aLjWsBNeiwR1FYl3dEy0MXpUFENBoLR2e
 KWBMNEopifPPjHK2mpImXAx0jRJ9Sgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-GOUJiUvpPtmRO-zUiUdwGA-1; Wed, 26 Feb 2020 02:28:51 -0500
X-MC-Unique: GOUJiUvpPtmRO-zUiUdwGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E0211005512;
 Wed, 26 Feb 2020 07:28:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14A5C1001DDE;
 Wed, 26 Feb 2020 07:28:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7456F11386A6; Wed, 26 Feb 2020 08:28:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <ad92d470-7388-c419-f3fb-0bfd541b670b@redhat.com>
 <871rqid35p.fsf@dusky.pond.sub.org>
 <f6008cc8-e7d2-87a1-384e-eb651cf40ab7@redhat.com>
Date: Wed, 26 Feb 2020 08:28:48 +0100
In-Reply-To: <f6008cc8-e7d2-87a1-384e-eb651cf40ab7@redhat.com> (Max Reitz's
 message of "Tue, 25 Feb 2020 18:00:27 +0100")
Message-ID: <87imjtajtb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> On 25.02.20 17:48, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>>=20
>>> On 15.02.20 15:51, Markus Armbruster wrote:
>>>> Review of this patch led to a lengthy QAPI schema design discussion.
>>>> Let me try to condense it into a concrete proposal.
>>>>
>>>> This is about the QAPI schema, and therefore about QMP.  The
>>>> human-friendly interface is out of scope.  Not because it's not
>>>> important (it clearly is!), only because we need to *focus* to have a
>>>> chance at success.
>>>>
>>>> I'm going to include a few design options.  I'll mark them "Option:".
>>>>
>>>> The proposed "amend" interface takes a specification of desired state,
>>>> and figures out how to get from here to there by itself.  LUKS keyslot=
s
>>>> are one part of desired state.
>>>>
>>>> We commonly have eight LUKS keyslots.  Each keyslot is either active o=
r
>>>> inactive.  An active keyslot holds a secret.
>>>>
>>>> Goal: a QAPI type for specifying desired state of LUKS keyslots.
>>>>
>>>> Proposal:
>>>>
>>>>     { 'enum': 'LUKSKeyslotState',
>>>>       'data': [ 'active', 'inactive' ] }
>>>>
>>>>     { 'struct': 'LUKSKeyslotActive',
>>>>       'data': { 'secret': 'str',
>>>>                 '*iter-time': 'int } }
>>>>
>>>>     { 'struct': 'LUKSKeyslotInactive',
>>>>       'data': { '*old-secret': 'str' } }
>>>>
>>>>     { 'union': 'LUKSKeyslotAmend',
>>>>       'base': { '*keyslot': 'int',
>>>>                 'state': 'LUKSKeyslotState' }
>>>>       'discriminator': 'state',
>>>>       'data': { 'active': 'LUKSKeyslotActive',
>>>>                 'inactive': 'LUKSKeyslotInactive' } }
>>>
>>> Looks OK to me.  The only thing is that @old-secret kind of works as an
>>> address, just like @keyslot,
>>=20
>> It does.
>>=20
>>>                              so it might also make sense to me to put
>>> @keyslot/@old-secret into a union in the base structure.
>>=20
>> I'm fine with state-specific extra adressing modes (I better be, I
>> proposed them).
>>=20
>> I'd also be fine with a single state-independent addressing mode, as
>> long as we can come up with sane semantics.  Less flexible when adding
>> states, but we almost certainly won't.
>>=20
>> Let's see how we could merge my two addressing modes into one.
>>=20
>> The two are
>>=20
>> * active
>>=20
>>   keyslot     old-secret      slot(s) selected
>>   absent      N/A             one inactive slot if exist, else error
>>   present     N/A             the slot given by @keyslot
>
> Oh, I thought that maybe we could use old-secret here, too, for
> modifying the iter-time.

Update in place is unsafe.

>                           But if old-secret makes no sense for
> to-be-active slots, then there=E2=80=99s little point in putting old-secr=
et in
> the base.
>
> (OTOH, specifying old-secret for to-be-active slots does have a sensible
> meaning; it=E2=80=99s just that we won=E2=80=99t support changing anythin=
g about
> already-active slots, except making them inactive.  So that might be an
> argument for not making it a syntactic error, but just a semantic error.)

Matter of taste.  I like to keep simple things syntactic, and thus
visible in introspection.

> [...]
>
>> Note we we don't really care what "inactive, both absent" does.  My
>> proposed semantics are just the most regular I could find.  We can
>> therefore resolve the conflict by picking "active, both absent":
>>=20
>>   keyslot     old-secret      slot(s) selected
>>   absent      absent          one inactive slot if exist, else error
>>   present     absent          the slot given by @keyslot
>>   absent      present         all active slots holding @old-secret
>>   present     present         the slot given by @keyslot, error unless
>>                               it's active holding @old-secret
>>=20
>> Changes:
>>=20
>> * inactive, both absent: changed; we select "one inactive slot" instead =
of
>>   "all slots".
>>=20
>>   "All slots" is a no-op when the current state has no active keyslots,
>>   else error.
>>=20
>>   "One inactive slot" is a no-op when the current state has one, else
>>   error.  Thus, we no-op rather than error in some states.
>>=20
>> * active, keyslot absent or present, old-secret present: new; selects
>>   active slot(s) holding @old-secret, no-op when old-secret =3D=3D secre=
t,
>>   else error (no in place update)
>>=20
>> Can do.  It's differently irregular, and has a few more combinations
>> that are basically useless, which I find unappealing.  Matter of taste,
>> I guess.
>>=20
>> Anyone got strong feelings here?
>
> The only strong feeling I have is that I absolutely don=E2=80=99t have a =
strong
> feeling about this. :)
>
> As such, I think we should just treat my rambling as such and stick to
> your proposal, since we=E2=80=99ve already gathered support for it.

Thanks!


