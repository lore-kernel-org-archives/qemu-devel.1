Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB90C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2462051A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPCckROa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2462051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBCz-0003Tc-HG
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ixBCE-0002wj-9b
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ixBCC-0001e2-4y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:53:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ixBCC-0001cp-26
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580396006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6G0ompb1ivojDIVNm6pIRuwvrreWG7GCjFh+g8NPY8=;
 b=SPCckROaouls7dwSsDkWP7S/oa2jhep4ffzJ+ND3tUJ3AFGUBJsTQshrIiU51kdn6qpw1N
 FPvTxZbt/PvM8fE2HH560XeDjNmR0cYLsGUDjb9IMXIj+HZzWj5jYnHXgAD5AmolWLzZDP
 zJUpaQHAKK/9OE5Diukh9kpWfza/ztg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-uHZwcKHNN1WqyjDKbm6P4w-1; Thu, 30 Jan 2020 09:53:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88782800D5E;
 Thu, 30 Jan 2020 14:53:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFF44100194E;
 Thu, 30 Jan 2020 14:53:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 707411138404; Thu, 30 Jan 2020 15:53:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87r1zti6r8.fsf@dusky.pond.sub.org>
 <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com>
 <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com>
 <20200130142310.GF6438@linux.fritz.box>
Date: Thu, 30 Jan 2020 15:53:17 +0100
In-Reply-To: <20200130142310.GF6438@linux.fritz.box> (Kevin Wolf's message of
 "Thu, 30 Jan 2020 15:23:10 +0100")
Message-ID: <87eevhov1e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: uHZwcKHNN1WqyjDKbm6P4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 30.01.2020 um 13:53 hat Daniel P. Berrang=C3=A9 geschrieben:
[...]
>> Personally I really don't like the idea of using "new-secret:null"
>> as a way to request deletion of a keyslot. That's too magical
>> for an action that is so dangerous to data IMhO.
>>=20
>> I think of these operations as activating & deactivating keyslots,
>> hence my suggestion to use an explicit "active: true|false" to
>> associate the core action being performed, instead of inferring
>> the action indirectly from the secret.
>
> The general idea of the amend interface is more that you describe a
> desired state rather than operations to achieve it.

Point taken.

>> I think this could lend itself better to future extensions too.
>> eg currently we're just activating or deactivating a keyslot.
>> it is conceivable in future (LUKS2) we might want to modify an
>> existing keyslot in some way. In that scenario, "active" can
>> be updated to be allowed to be optional such that:
>>=20
>>  - active: true ->  activate a currently inactive keyslot
>>  - active: false -> deactivate a currently active keyslot
>>  - active omitted -> modify a currently active keyslot
>
> This distinction feels artificial to me. All three operations just
> change the content of a keyslot. Whether it contained a key or not in
> the old state shouldn't make a difference for how to get a new value
> (which could be a new key or just an empty keyslot) written to it.

*If* you can get it to fail only safely.  Can you?

> Making an omitted key mean something different from the other options so
> that it's not just defaulting to one of them is problematic, too. We
> have at least one place where it works like this (backing files) and it
> tends to give us headaches.

Seconded.


