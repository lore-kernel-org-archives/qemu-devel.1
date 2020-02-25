Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD5EC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0678B2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRH8S+bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0678B2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dPQ-0006Nk-8g
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j6dNX-000552-IW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j6dNV-0000Nj-Mw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:48:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47758
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j6dNR-0000M0-HW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582649287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Y/0NxQCFiyrkPiGjm9Xt2HYrTAmkUy2RxXAEb6qEs4=;
 b=FRH8S+bmrIm5payFt7tbylsXXRHmA9VliUbufk28QvhFWi3JC19m9j1L8xYUuRtE3FSVvk
 qjRuIc4bxvh33OolvHErNRPXfI3H1YjwAbEwDpX0h0w15XAY2rgWsuzfP8epo6EenWNtok
 sBbAUe6SAfL68qyXd1YOK/KyvcTHqtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-JRTC82ZwO-qFGcU-cm-s4w-1; Tue, 25 Feb 2020 11:48:05 -0500
X-MC-Unique: JRTC82ZwO-qFGcU-cm-s4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E54B61005512;
 Tue, 25 Feb 2020 16:48:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 698876031E;
 Tue, 25 Feb 2020 16:48:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CFFF111386A6; Tue, 25 Feb 2020 17:48:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <ad92d470-7388-c419-f3fb-0bfd541b670b@redhat.com>
Date: Tue, 25 Feb 2020 17:48:02 +0100
In-Reply-To: <ad92d470-7388-c419-f3fb-0bfd541b670b@redhat.com> (Max Reitz's
 message of "Tue, 25 Feb 2020 13:15:29 +0100")
Message-ID: <871rqid35p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> On 15.02.20 15:51, Markus Armbruster wrote:
>> Review of this patch led to a lengthy QAPI schema design discussion.
>> Let me try to condense it into a concrete proposal.
>>=20
>> This is about the QAPI schema, and therefore about QMP.  The
>> human-friendly interface is out of scope.  Not because it's not
>> important (it clearly is!), only because we need to *focus* to have a
>> chance at success.
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
>
> Looks OK to me.  The only thing is that @old-secret kind of works as an
> address, just like @keyslot,

It does.

>                              so it might also make sense to me to put
> @keyslot/@old-secret into a union in the base structure.

I'm fine with state-specific extra adressing modes (I better be, I
proposed them).

I'd also be fine with a single state-independent addressing mode, as
long as we can come up with sane semantics.  Less flexible when adding
states, but we almost certainly won't.

Let's see how we could merge my two addressing modes into one.

The two are

* active

  keyslot     old-secret      slot(s) selected
  absent      N/A             one inactive slot if exist, else error
  present     N/A             the slot given by @keyslot

* inactive

  keyslot     old-secret      slot(s) selected
  absent      absent          all keyslots
  present     absent          the slot given by @keyslot
  absent      present         all active slots holding @old-secret
  present     present         the slot given by @keyslot, error unless
                              it's active holding @old-secret

They conflict:

> (One of the problems that come to mind with that approach is that not
> specifying either of @old-secret or @keyslot has different meanings for
> activating/inactivating a keyslot: When activating it, it means =E2=80=9C=
The
> first unused one=E2=80=9D; when deactivating it, it=E2=80=99s just an err=
or because it
> doesn=E2=80=99t really mean anything.)
>
> *shrug*

Note we we don't really care what "inactive, both absent" does.  My
proposed semantics are just the most regular I could find.  We can
therefore resolve the conflict by picking "active, both absent":

  keyslot     old-secret      slot(s) selected
  absent      absent          one inactive slot if exist, else error
  present     absent          the slot given by @keyslot
  absent      present         all active slots holding @old-secret
  present     present         the slot given by @keyslot, error unless
                              it's active holding @old-secret

Changes:

* inactive, both absent: changed; we select "one inactive slot" instead of
  "all slots".

  "All slots" is a no-op when the current state has no active keyslots,
  else error.

  "One inactive slot" is a no-op when the current state has one, else
  error.  Thus, we no-op rather than error in some states.

* active, keyslot absent or present, old-secret present: new; selects
  active slot(s) holding @old-secret, no-op when old-secret =3D=3D secret,
  else error (no in place update)

Can do.  It's differently irregular, and has a few more combinations
that are basically useless, which I find unappealing.  Matter of taste,
I guess.

Anyone got strong feelings here?


