Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F312C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507112186D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBpzTs+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507112186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWlHu-0003dq-ES
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWlHF-00039l-Cr
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWlHD-0006Nu-9M
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:57:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWlHD-0006Nj-5d
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574099846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IYvTMlVqgVTvh0LSivXA+/3qzjcs1W/orXrfAjf1MgM=;
 b=XBpzTs+TSf8w2Z7/lKogS1HJpHGBoaWMGXZOxANk+obmIVMsD3oKz8baF5LZ0alUSZyNVo
 0ssmibSX88Uc8w9byLFdKPaMbSyqwMISBCfRVJaRKuaHQfnzW8Qz/Vv9XkM9HN/GmrKMFY
 22+nsyq6Cto8fF4O4ushyKICEHinHmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-bOWZU8rlNE2vTE2ay5ukhA-1; Mon, 18 Nov 2019 12:57:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CEE8801E5B;
 Mon, 18 Nov 2019 17:57:23 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E511810027B9;
 Mon, 18 Nov 2019 17:57:22 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] iotests: Switch nbd tests to use Unix rather than
 TCP
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20191114213415.23499-1-eblake@redhat.com>
 <20191114213415.23499-3-eblake@redhat.com>
 <db43e495-8a10-62af-624a-c09b42488232@redhat.com>
 <b5a6953b-48b7-19a0-a1ba-c266cc81ef02@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3fd54898-7ff2-5c29-aa70-97d5f4a15983@redhat.com>
Date: Mon, 18 Nov 2019 11:57:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b5a6953b-48b7-19a0-a1ba-c266cc81ef02@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: bOWZU8rlNE2vTE2ay5ukhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 11:42 AM, Eric Blake wrote:

>>> +++ b/tests/qemu-iotests/common.filter
>>> @@ -127,7 +127,8 @@ _filter_img_create()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "s#$TEST_DIR#=
TEST_DIR#g" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "s#$SOCK_DIR#=
SOCK_DIR#g" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "s#$IMGFMT#IM=
GFMT#g" \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's#nbd:127.0.0.1:10810#T=
EST_DIR/t.IMGFMT#g' \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's#nbd:127.0.0.1:[0-9]\\=
+#TEST_DIR/t.IMGFMT#g' \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's#nbd+unix:///\??socket=
=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
>>
>> Why the second question mark?=C2=A0 I thought the ? after the /// was=20
>> mandatory.
>=20
> Some of our code outputs:
>=20
> nbd+unix://?socket=3D...
>=20
> when there is no export name, while other outputs:
>=20
> nbd+unix:///?socket=3D...

Re-reading=20
https://github.com/NetworkBlockDevice/nbd/blob/master/doc/uri.md and RFC=20
3986, I see that both forms appear to be valid URIs (both have empty=20
authority, the first has empty path and the second has path '/', but NBD=20
says leading / in path is stripped to form the export name).  However,=20
the NBD document does not mention the 2-slash form with no URI authority=20
or export name; perhaps we should amend that document to make it obvious=20
that it is indeed valid.

>=20
> When there IS an export name, it outputs
>=20
> nbd+unix:///name?socket=3D...

While in this case, the 3-slash form is essential - with only two=20
slashes, the URI 'nbd+unix://name?socket' would be trying to access a=20
URI authority of 'name' with an empty path, rather than the intended=20
empty authority and path of '/name' which gets translated to the NBD=20
export 'name'.

>=20
> So the regex is matching 2 or 3 / (using \? to make the third optional),=
=20
> then a mandatory ?.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


