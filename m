Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CA5C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD49C206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2sVMMaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD49C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmLY-0001Oa-Vn
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCmKO-0000RO-E5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCmKN-0006QH-D8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:34:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41732
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCmKN-0006PL-8S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584113662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8L9kYJQLq8wQnmsdmFdZ5Ni8ot4fwiL6ME5fia5Okc=;
 b=K2sVMMaVIMO4wRlF4IWTXSM1hcZ5zVOrleZwiiVC9+nzGdJ9Rs/c8tHFQQSYSq9WCBMt5I
 nuYq5Ugk57zkSlo7fwOdkK+6/XYYhZzp6/OPu0ck+Wmt4mF/4A0WJHlv0D6JyvWqs+Shil
 LebYV+FZhVzyLHFZBmOhqz7uAyjl+CQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-1hGg6TUyOb2T0O_8zxpLJw-1; Fri, 13 Mar 2020 11:34:18 -0400
X-MC-Unique: 1hGg6TUyOb2T0O_8zxpLJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2615190B2A8;
 Fri, 13 Mar 2020 15:34:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BD715C1B5;
 Fri, 13 Mar 2020 15:34:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA8AA11386A6; Fri, 13 Mar 2020 16:34:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <87eetwlmlm.fsf@dusky.pond.sub.org>
 <efaed3e4-3f4d-f538-5087-96391fc20d2f@virtuozzo.com>
Date: Fri, 13 Mar 2020 16:34:07 +0100
In-Reply-To: <efaed3e4-3f4d-f538-5087-96391fc20d2f@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 13 Mar 2020 11:06:37 +0300")
Message-ID: <87d09ggtg0.fsf@dusky.pond.sub.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 13.03.2020 10:50, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>> [...]
>>> +// Warn several Error * definitions.
>>> +@check1 disable optional_qualifier exists@
>>> +identifier fn =3D rule1.fn, local_err, local_err2;
>>> +@@
>>> +
>>> + fn(..., Error ** ____, ...)
>>> + {
>>> +     ...
>>> +     Error *local_err =3D NULL;
>>> +     ... when any
>>> +     Error *local_err2 =3D NULL;
>>> +     ... when any
>>> + }
>>> +
>>> +@ script:python @
>>> +fn << check1.fn;
>>> +@@
>>> +
>>> +print('Warning: function {} has several definitions of '
>>> +      'Error * local variable'.format(fn))
>>
>> Printing the positions like you do in the next rule is useful when
>> examining these warnings.
>
> I decided that searching for Error * definition is simple, and better for
> user to search all definitions by hand (may be more than too).
>
> But understanding control flows is more complex thing and better to help
> user with line positions.
>
> But if you want, we can add them of course. Note, that for some reasons s=
ome
> times coccinelle instead of original filename prints something like /tmp/=
...original-name...
> so it don't look nice and may be a bit misleading.

I noticed when I actually tried mu idea %-}


