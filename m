Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDFAC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29769222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qe/LaS99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29769222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUnOW-0003bo-4k
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUnMz-0001ys-Uf
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUnMy-0007Ga-B5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603183907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OyAKNOaKyuE1QKu7RIdSD0VqiDWxi1CFu28of8SkkPk=;
 b=Qe/LaS99Iciu8LQsKlCP+jGjUDAl/fgiPujsph6X14wbCkQrGkPaKkByMjkTVt1eslTqAF
 olRrm6q2YjxI1Sp4bH0bfMIOwf6LWuI6X7jBYOwp5QrCoU0go2GRXzPua6M0cWjpzyejk0
 FPRleOFJ8vsP7Izt/h2TBPkmiDAw/aU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-WrjBAbpkNPeTifs4ezgH5g-1; Tue, 20 Oct 2020 04:51:43 -0400
X-MC-Unique: WrjBAbpkNPeTifs4ezgH5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B90D1084D61;
 Tue, 20 Oct 2020 08:51:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7E6D5C1A3;
 Tue, 20 Oct 2020 08:51:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C8D21132A08; Tue, 20 Oct 2020 10:51:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 4/7] nbd: Update qapi to support exporting multiple
 bitmaps
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-5-eblake@redhat.com>
 <6ee3ac4f-65c3-fdfd-9adb-9bea5f5739e3@virtuozzo.com>
 <56b413b5-2213-1b4e-5cac-865d8f0e0689@redhat.com>
Date: Tue, 20 Oct 2020 10:51:37 +0200
In-Reply-To: <56b413b5-2213-1b4e-5cac-865d8f0e0689@redhat.com> (Eric Blake's
 message of "Mon, 19 Oct 2020 16:45:36 -0500")
Message-ID: <87lfg1gu06.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, rjones@redhat.com,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/14/20 7:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 10.10.2020 00:55, Eric Blake wrote:
>>> Since 'nbd-server-add' is deprecated, and 'block-export-add' is new to
>>> 5.2, we can still tweak the interface.=C2=A0 Allowing 'bitmaps':['str']=
 is
>>> nicer than 'bitmap':'str'.=C2=A0 This wires up the qapi and qemu-nbd
>>> changes to permit passing multiple bitmaps as distinct metadata
>>> contexts that the NBD client may request, but the actual support for
>>> more than one will require a further patch to the server.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>> [..]
>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'B':
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit=
map =3D optarg;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp=
 =3D g_new(strList, 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp=
->value =3D g_strdup(optarg);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp=
->next =3D bitmaps;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit=
maps =3D tmp;
>> If publish QAPI_LIST_ADD, defined in block.c, it would look like:
>>  =C2=A0=C2=A0=C2=A0 QAPI_LIST_ADD(bitmaps, g_strdup(optarg));
>
> #define QAPI_LIST_ADD(list, element) do { \
>     typeof(list) _tmp =3D g_new(typeof(*(list)), 1); \
>     _tmp->value =3D (element); \
>     _tmp->next =3D (list); \
>     (list) =3D _tmp; \
> } while (0)
>
>
> Markus, thoughts on if we should publish this macro,

If it's widely useful.

"git-grep -- '->value =3D'" matches ~200 times.  A patch converting these
to the macro where possible would make a strong case for having the
macro.

>                                                      and if so, which
> header would be best?

The macro is generic: @list's type may be any of the struct TYPEList we
generate for the QAPI type ['TYPE'].

We don't want to generate this macro next to each of these struct
definitions.  A non-generic macro would go there, but let's not generate
almost a hundred non-generic macros where a single generic one can do
the job.

The closest we have to a common base is GenericList.  It's in in
visitor.h because it's only used by visitors so far.  Adding the macro
next it is not so smart, because we don't want non-visitor code to
include visitor.h just for this macro.

Perhaps the macro should go into qapi/util.h, and perhaps GenericList
and GenericAlternate should move there, too.


[...]


