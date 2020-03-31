Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E90C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2082072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5SdiVzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2082072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCxC-0001pY-Dg
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJCwR-0000yx-7V
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJCwP-0004De-Ou
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:12:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJCwP-0004DL-Km
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585645933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFZvQ4iZn6mMt2zN6H+rMYJFu6wmbUQI/mdA0BOMRIk=;
 b=b5SdiVzcxBOdnI0IR07FPbrbD1oPgz+XMlpn6Fcu9rOLknitbdu4C3rdfZPY3GVviiI53l
 lX1i1vCNAlPYSMfCqB/xPy8ZN8Nul/Jb7OAtvdRxz/GSgisRPAVaa8L5Yh7TJc8Fr7mPS3
 vuq9OnTt8wG76ZvUU13yz4nMFQvvb4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-0rAUZIy2NI-khfhS7vGY6w-1; Tue, 31 Mar 2020 05:12:11 -0400
X-MC-Unique: 0rAUZIy2NI-khfhS7vGY6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60C05800D5B;
 Tue, 31 Mar 2020 09:12:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48E2F60BE0;
 Tue, 31 Mar 2020 09:12:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A17AC11385E2; Tue, 31 Mar 2020 11:12:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 2/6] block/mirror: fix use after free of local_err
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-3-vsementsov@virtuozzo.com>
 <8cb2bda7-55f5-2646-3c35-d901089ccde5@redhat.com>
 <f6882909-0c4a-145b-bfb1-e4b92e788f36@virtuozzo.com>
 <4d67184c-48d3-28d5-c09e-94439283aa0a@redhat.com>
Date: Tue, 31 Mar 2020 11:12:05 +0200
In-Reply-To: <4d67184c-48d3-28d5-c09e-94439283aa0a@redhat.com> (Max Reitz's
 message of "Wed, 25 Mar 2020 13:00:30 +0100")
Message-ID: <87369o3n2y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, marcandre.lureau@redhat.com,
 den@openvz.org, jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> On 25.03.20 12:47, Vladimir Sementsov-Ogievskiy wrote:
>> 25.03.2020 14:11, Max Reitz wrote:
>>> On 24.03.20 16:36, Vladimir Sementsov-Ogievskiy wrote:
>>>> local_err is used again in mirror_exit_common() after
>>>> bdrv_set_backing_hd(), so we must zero it. Otherwise try to set
>>>> non-NULL local_err will crash.
>>>
>>> OK, but wouldn=E2=80=99t it be better hygiene to set it to NULL every t=
ime it is
>>> freed?=C2=A0 (There is a second instance of error_report_err() in this
>>> function.=C2=A0 I=E2=80=99m a bit worried we might introduce another lo=
cal_err use
>>> after that one at some point in the future, and forget to run the cocci
>>> script then.)
>>=20
>> Yes, it's better. But if we now decide to fix all such things, it would =
be
>> huge series. May be too huge for 5.0..
>>=20
>> So I decided to fix only real obvious problems now.
>
> Reasonable, yes.

In particular since we have a tree-wide transformation waiting for 5.1.

>> Hmm huge or not?
>>=20
>> Ok, let's try with less restrictions:
>>=20
>> --- a/scripts/coccinelle/error-use-after-free.cocci
>> +++ b/scripts/coccinelle/error-use-after-free.cocci
>> @@ -28,7 +28,7 @@ expression err;
>>=20
>> =C2=A0 fn(...)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0=C2=A0 <...
>> +=C2=A0=C2=A0=C2=A0=C2=A0 ... when any
>> =C2=A0(
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(err);
>> =C2=A0+=C2=A0=C2=A0=C2=A0 err =3D NULL;
>> @@ -46,7 +46,5 @@ expression err;
>> =C2=A0+=C2=A0=C2=A0=C2=A0 err =3D NULL;
>> =C2=A0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... when !=3D err =3D NULL
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when !=3D exit(...)
>> -=C2=A0=C2=A0=C2=A0=C2=A0 fn2(..., err, ...)
>> -=C2=A0=C2=A0=C2=A0=C2=A0 ...>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when any
>> =C2=A0 }
>>=20
>>=20
>> on block/ directory:
>>=20
>> spatch --sp-file scripts/coccinelle/error-use-after-free.cocci
>> --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff
>> --use-gitgrep block
>> git diff --stat
>> =C2=A0scripts/coccinelle/error-use-after-free.cocci |=C2=A0 6 ++----
>> =C2=A0block/block-backend.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0block/commit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
>> =C2=A0block/crypto.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0block/file-posix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
>> =C2=A0block/mirror.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>> =C2=A0block/monitor/block-hmp-cmds.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
>> =C2=A0block/parallels.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
>> =C2=A0block/qapi-sysemu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>> =C2=A0block/qapi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
>> =C2=A0block/qcow.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 ++
>> =C2=A0block/qcow2-cluster.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0block/qcow2-refcount.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0block/qcow2-snapshot.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
>> =C2=A0block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
4 ++++
>> =C2=A0block/replication.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0block/sheepdog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++++++++
>> =C2=A0block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0block/vdi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 2 ++
>> =C2=A0block/vhdx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 ++
>> =C2=A0block/vmdk.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 ++
>> =C2=A0block/vpc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 2 ++
>> =C2=A0block/vvfat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
2 ++
>> =C2=A023 files changed, 61 insertions(+), 4 deletions(-)
>>=20
>>=20
>> If you want, I'll send series.
>>=20
>>>
>>> Are the cocci scripts run regularly by someone?=C2=A0 E.g. as part of a=
 pull
>>> to master?
>>=20
>> I'm afraid not. I have a plan in my mind, to make python checkcode,
>> which will
>> work in pair with checkpatch somehow, and will work on workdir instead o=
f
>> patch. It will simplify significantly adding different code checks,
>> including
>> starting coccinelle scripts.

CI also runs make check, so that's another place you can hook into.

Not sure Coccinelle is fast enough for running it all the time.

> Hm.  I think we need to prepare for noone running the cocci scripts
> (i.e., we should use the above variant with less restrictions so that
> future patches are less likely to reintroduce the problem), or we need
> to ensure the cocci scripts are run regularly.
>
> We can of course also do both.  In this case I think it makes sense to
> do a less-restricted version, because I think it can never hurt to set
> pointers to NULL after freeing them.  (We could do an exception for when
> the error-freeing is immediately followed by a goto out, but I think
> that would make it too complicated.)

Same reasoning applies to all kinds of resource deallocation, not just
error_free().  Perhaps the world should use g_free() & friends only via
g_clear_pointer().  For better or worse, it doesn't.

Related: "[PATCH v7 01/11] qapi/error: add (Error **errp) cleaning
APIs".

> I=E2=80=99d like to start running the cocci scripts myself before every p=
ull
> request, but unfortunately there are still a number of diffs in the
> block area.  I think I=E2=80=99ll send a series to fix those and then I c=
an run
> the scripts regularly to prevent regressions.  So I=E2=80=99ll leave it u=
p to
> you whether you think a less-restricted version would make sense.
>
> Max


