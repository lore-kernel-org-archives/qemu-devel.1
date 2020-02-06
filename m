Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A08DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DC721775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSahJopW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DC721775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhTe-0008Ps-6W
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izhSh-0007rT-UX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izhSf-00082P-UR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:44:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43166
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izhSf-00080q-Qf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580996692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6B/UiFB/a7ju9msU8j0jQP/B4XNbkYRE8K52J18Vgk=;
 b=RSahJopWeKko6le/D0BW4BSufYfj8BTy5eqy0XCAimfwsoRWu4FJiJIrAKVLi5bDcwvs6E
 0Q9xqpJJi/INP+IyVi+Ku2RbBwfSyj/QRu7U+UcrnPi6bwcIXkeLTe9gBIoee1DdL7QzBd
 ATCisTlUos4vvwoutV0v4Knv6+0BLiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-3aKKuVTMMimUNujMBiVG1A-1; Thu, 06 Feb 2020 08:44:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFDFC801A00;
 Thu,  6 Feb 2020 13:44:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7B0E19C7F;
 Thu,  6 Feb 2020 13:44:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 321B011386A7; Thu,  6 Feb 2020 14:44:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
References: <20200128171116.GU1446339@redhat.com>
 <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org>
 <20200130150108.GM1891831@redhat.com>
 <877e18oq76.fsf@dusky.pond.sub.org>
 <87mu9xxwzv.fsf@dusky.pond.sub.org>
 <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
 <87tv45wdui.fsf@dusky.pond.sub.org>
 <20200205110250.GB5768@dhcp-200-226.str.redhat.com>
 <87blqdgl70.fsf@dusky.pond.sub.org>
Date: Thu, 06 Feb 2020 14:44:45 +0100
In-Reply-To: <87blqdgl70.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Wed, 05 Feb 2020 15:31:15 +0100")
Message-ID: <87blqbu8xe.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 3aKKuVTMMimUNujMBiVG1A-1
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Kevin Wolf <kwolf@redhat.com> writes:
>
>> Am 05.02.2020 um 11:03 hat Markus Armbruster geschrieben:
>>> Kevin Wolf <kwolf@redhat.com> writes:
[...]
>>> > Adding a key gets more complicated with your proposed interface becau=
se
>>> > state must be set explicitly now whereas before it was derived
>>> > automatically from the fact that if you give a key, only active makes
>>> > sense.
>>>=20
>>> The explicitness could be viewed as an improvement :)
>>
>> Not really. I mean, I really know to appreciate the advantages of
>> -blockdev where needed, but usually I don't want to type all that stuff
>> for the most common tasks. qemu-img amend is similar.
>>
>> For deleting, I might actually agree that explicitness is an
>> improvement, but for creating it's just unnecessary verbosity.
>>
>>> If you'd prefer implicit here: Max has patches for making union tags
>>> optional with a default.  They'd let you default active to true.
>>
>> I guess this would improve the usability in this case.

Thinking and writing in the "Making QEMU easier for management tools and
applications" monster thread have made me realize we're mixing up two
aspects that ought to be kept separate: machine-friendly QMP and
human-friendly CLI.

You argue that

    $ qemu-img amend -o encrypt.keys.0.new-secret=3Dsec0 test.qcow2

is nicer than

    $ qemu-img amend -o encrypt.keys.0.state=3Dactive,encrypt.keys.0.secret=
=3Dsec0 test.qcow2

and you do have a point: humans want their CLI terse.  Redundancy is
unwanted, except perhaps to protect users from dangerous accidents.  In
this example, state=3Dactive is redundant when a secret is given, because
anything else would be an error.

In QMP, however, we like things simple and explicit, and we eschew
magic.

This particular magic might just be simple enough to be acceptable in
QMP.  We'd "merely" have to support explicit defaults in the schema (a
clear improvement if you ask me), and optional union tags (tolerable as
long as the default comes from the schema, I guess).

My point is: QAPI schema design *must* focus on QMP and nothing else.
If we try to serve both QMP and human-friendly CLI, we'll likely botch
both.

I believe a truly human-friendly CLI requires more than just
human-friendly concrete syntax for QMP.  Same as HMP, really.


