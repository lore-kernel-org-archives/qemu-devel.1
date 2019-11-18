Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF59C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C372186D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7DoJMta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C372186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWl45-0004cW-KH
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWl3A-00045O-Do
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWl38-0001xz-0u
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:42:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33628
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWl37-0001xf-Oj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574098972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6KXtgtt0tQ9LykXQDYypaEdHGOf52sGadbTfMwETPo=;
 b=R7DoJMtabF0sGpky/1Ge80ADL0iKxY2BBAptAop+N/Kl9ThL4OOB91rOQDUWr8l0634oWu
 BCM6kMZmxbqcD1PiSM3oEsxyS7AKlnGK1oeeQWQTCoX14a20RT2e8745yaI8IrU9lprJQN
 wA0XhjOhtMjT6qODZ3IjshvOffbTqho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-I0UjfMxvOLaiRhUb3BOcAQ-1; Mon, 18 Nov 2019 12:42:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AADEB800580;
 Mon, 18 Nov 2019 17:42:49 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FE1F5D9C9;
 Mon, 18 Nov 2019 17:42:49 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] iotests: Switch nbd tests to use Unix rather than
 TCP
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20191114213415.23499-1-eblake@redhat.com>
 <20191114213415.23499-3-eblake@redhat.com>
 <db43e495-8a10-62af-624a-c09b42488232@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b5a6953b-48b7-19a0-a1ba-c266cc81ef02@redhat.com>
Date: Mon, 18 Nov 2019 11:42:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <db43e495-8a10-62af-624a-c09b42488232@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: I0UjfMxvOLaiRhUb3BOcAQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 11:29 AM, Max Reitz wrote:
> On 14.11.19 22:34, Eric Blake wrote:
>> Up to now, all it took to cause a lot of iotest failures was to have a
>> background process such as 'nbdkit -p 10810 null' running, because we
>> hard-coded the TCP port.  Switching to a Unix socket eliminates this
>> contention.  We still have TCP coverage in test 233, and that test is
>> more careful to not pick a hard-coded port.
>=20
> For me, all it took was to run qcow2 and nbd tests in parallel (some
> qcow2 tests create nbd servers, too), so this is great.
>=20
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   tests/qemu-iotests/common.filter | 6 ++++--
>>   tests/qemu-iotests/common.rc     | 8 ++++----
>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/commo=
n.filter
>> index f870e00e4421..5367deea398e 100644
>> --- a/tests/qemu-iotests/common.filter
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -127,7 +127,8 @@ _filter_img_create()
>>           -e "s#$TEST_DIR#TEST_DIR#g" \
>>           -e "s#$SOCK_DIR#SOCK_DIR#g" \
>>           -e "s#$IMGFMT#IMGFMT#g" \
>> -        -e 's#nbd:127.0.0.1:10810#TEST_DIR/t.IMGFMT#g' \
>> +        -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
>> +        -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'=
 \
>=20
> Why the second question mark?  I thought the ? after the /// was mandator=
y.

Some of our code outputs:

nbd+unix://?socket=3D...

when there is no export name, while other outputs:

nbd+unix:///?socket=3D...

When there IS an export name, it outputs

nbd+unix:///name?socket=3D...

So the regex is matching 2 or 3 / (using \? to make the third optional),=20
then a mandatory ?.


>> +++ b/tests/qemu-iotests/common.rc
>> @@ -217,7 +217,7 @@ if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>>           TEST_IMG=3D"$DRIVER,file.filename=3D$TEST_DIR/t.$IMGFMT"
>>       elif [ "$IMGPROTO" =3D "nbd" ]; then
>>           TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>> -        TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.host=3D127.0.0.1,fil=
e.port=3D10810"
>> +        TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix,file.pat=
h=3D$SOCKDIR/$IMGFMT"
>=20
> Maybe nbd.$IMGFMT?

At first glance, it seems reasonable.  But reading further,

>=20
>>       elif [ "$IMGPROTO" =3D "ssh" ]; then
>>           TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>>           TEST_IMG=3D"$DRIVER,file.driver=3Dssh,file.host=3D127.0.0.1,fi=
le.path=3D$TEST_IMG_FILE"
>> @@ -233,7 +233,7 @@ else
>>           TEST_IMG=3D$TEST_DIR/t.$IMGFMT
>>       elif [ "$IMGPROTO" =3D "nbd" ]; then
>>           TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>> -        TEST_IMG=3D"nbd:127.0.0.1:10810"
>> +        TEST_IMG=3D"nbd+unix:///?socket=3D$SOCK_DIR/nbd"
>=20
> Shouldn=E2=80=99t this be $IMGFMT, too (instead of nbd)?  (Or maybe nbd.$=
IMGFMT)

Now I'm starting to wonder.  With NBD and non-raw, there are two places=20
to do the image format:

qcow2 file -> qemu-nbd -f qcow2 -> raw bytes over NBD -> qemu client -f=20
raw -> guest  (our typical usage)

qcow2 file -> qemu-nbd -f raw -> qcow2 bytes over NBD -> qemu client -f=20
qcow2 -> guest  (limited use, since NBD does not [yet] have resize support]

so naming the socket $SOCK_DIR/nbd.qcow2 when the socket carries raw=20
data (our typical use) seems awkward.  But then again, running './check=20
-qcow2 -nbd' shows that we seldom test qcow2 format over nbd protocol=20
(precisely because nbd does not yet have resize).

If anything, I'm inclined to use $SOCK_DIR/nbd.raw to indicate that the=20
NBD client sees raw format, regardless of the format in use by the=20
server, to leave the door open for $SOCK_DIR/nbd.qcow2 when we finally=20
are happy to test qcow2 format over NBD.

Or stick to just $SOCK_DIR/nbd hard-coded everywhere, and quit trying to=20
use $IMGFMT in the socket name, to make all the usage consistent.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


