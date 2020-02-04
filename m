Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB5CC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D262084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0QTaPRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D262084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz2NJ-0003ed-Pp
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iz2Me-0002vx-T3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iz2Md-0001yB-NE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:51:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60536
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iz2Md-0001wS-Im
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580838715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHKU4SQodCHFPoWDOUHcEFmRUhJgjxIv1YDK6sY6tkc=;
 b=U0QTaPRPvN2/TePBBhwklFU7bq7+S9mZRK3nTBoGcDeELTVia3XAAqXgkwkl+0NbjAk1Rs
 J3oTfwMYXLDOqBK9ThIEerEJLy0kT+JKuxpB6A1LF2BihxK4XFJqaj7zQRZEFlwZtikAd2
 xRrBugVYbvjDP0WVRZnzJtdurXJsxgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-TieFpyBNNKKMVuCUviS1SA-1; Tue, 04 Feb 2020 12:51:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A625A8C0360;
 Tue,  4 Feb 2020 17:51:51 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C05775C1B5;
 Tue,  4 Feb 2020 17:51:33 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
 <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <89497824-33be-7238-982e-bd0edb2f5d00@redhat.com>
Date: Tue, 4 Feb 2020 11:51:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: TieFpyBNNKKMVuCUviS1SA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Liu Yuan <namei.unix@gmail.com>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:42 AM, Max Reitz wrote:

>>
>> I understand that this is preexisting logic, but could I ask: why?
>> What's wrong
>> if driver can guarantee that created file is all-zero, but is not sure
>> about
>> file resizing? I agree that it's normal for these flags to have the same
>> value,
>> but what is the reason for this restriction?..
>=20
> If areas added by truncation (or growth, rather) are always zero, then
> the file can always be created with size 0 and grown from there.  Thus,
> images where truncation adds zeroed areas will generally always be zero
> after creation.
>=20
>> So, the only possible combination of flags, when they differs, is
>> create=3D0 and
>> truncate=3D1.. How is it possible?
>=20
> For preallocated qcow2 images, it depends on the storage whether they
> are actually 0 after creation.  Hence qcow2_has_zero_init() then defers
> to bdrv_has_zero_init() of s->data_file->bs.
>=20
> But when you truncate them (with PREALLOC_MODE_OFF, as
> BlockDriver.bdrv_has_zero_init_truncate()=E2=80=99s comment explains), th=
e new
> area is always going to be 0, regardless of initial preallocation.
>=20
>=20
> I just noticed a bug there, though: Encrypted qcow2 images will not see
> areas added through growth as 0.  Hence, qcow2=E2=80=99s
> bdrv_has_zero_init_truncate() implementation should not return true
> unconditionally, but only for unencrypted images.

Hence patch 5 earlier in the series :)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


