Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F5C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592F121783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FY37ZM2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592F121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAJI-0005xD-Bm
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUAHK-0004YE-Oy
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUAHH-0000yg-UD
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:02:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31554
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUAHH-0000yC-Qe
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573480967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9vvuPlQuh8uC7G0U77VoyVjnikcxTk2BTjbsd1Y5eg=;
 b=FY37ZM2JUQ2JkhjdypWNOixp85783zecUybtzGY1tWkdApOr//A7jS0HxJj9cY5/jy0+h+
 FqJGjHhzR29Mj/+YNGpaFh8DZOOJJzmeP2r1eK22Tx6kAxGV9A0XxbjRlRa3VQ4Y5+WJtA
 bN6gW0sIAUXNSXuCWiiYnf1FrlsWPZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-CAcjRv0TMmGjhW_tHHk1aA-1; Mon, 11 Nov 2019 09:02:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F016B100727E;
 Mon, 11 Nov 2019 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-162.ams2.redhat.com
 [10.36.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9D1860852;
 Mon, 11 Nov 2019 14:02:39 +0000 (UTC)
Subject: Re: [PATCH v3 4/6] iotests: Skip "make check-block" if QEMU does not
 support virtio-blk
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191022072135.11188-1-thuth@redhat.com>
 <20191022072135.11188-5-thuth@redhat.com>
 <76688061-c59d-953e-b3db-097e3f46fff0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fcd271a6-2d90-5087-237d-f308b2367c04@redhat.com>
Date: Mon, 11 Nov 2019 15:02:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <76688061-c59d-953e-b3db-097e3f46fff0@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CAcjRv0TMmGjhW_tHHk1aA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/10/2019 12.21, Max Reitz wrote:
> On 22.10.19 09:21, Thomas Huth wrote:
>> The next patch is going to add some python-based tests to the "auto"
>> group, and these tests require virtio-blk to work properly. Running
>> iotests without virtio-blk likely does not make too much sense anyway,
>> so instead of adding a check for the availability of virtio-blk to each
>> and every test (which does not sound very appealing), let's rather add
>> a check for this at the top level in the check-block.sh script instead
>> (so that it is possible to run "make check" without the "check-block"
>> part for qemu-system-tricore for example).
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/check-block.sh | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/check-block.sh b/tests/check-block.sh
>> index 679aedec50..e9e2978818 100755
>> --- a/tests/check-block.sh
>> +++ b/tests/check-block.sh
>> @@ -26,10 +26,24 @@ if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/d=
ev/null ; then
>>      exit 0
>>  fi
>> =20
>> -if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
>> +if [ -n "$QEMU_PROG" ]; then
>> +    qemu_prog=3D"$QEMU_PROG"
>> +else
>> +    for binary in *-softmmu/qemu-system-* ; do
>=20
> Hm, I know I=E2=80=99ve already given my R-b, but looking at this again =
=E2=80=93 what
> if the user builds qemu for multiple targets?  Then this will just test
> any target, whereas the iotests might test something else, because the
> algorithm there is slightly different:
>=20
> First, check $QEMU_PROG (same as here).
>=20
> Second, check $build_iotests/qemu.  I think we can do this here, because
> we know that $build_iotests is $PWD/tests/qemu-iotests (or invoking
> ./check below wouldn=E2=80=99t work).
>=20
> Third, and this is actually important, I think, is that we first look
> for the qemu that matches the host architecture (uname -m, with an
> exception for ppc64).  I think we really should do that here, too.
>=20
> Fourth, look for any qemu, as is done here.
>=20
> So I think we could do without #2, but it probably doesn=E2=80=99t hurt t=
o check
> that, too.  I don=E2=80=99t think we should do without #3, though.

Maybe we should simply move the check into tests/qemu-iotests/check to
avoid duplication of that logic?
We could then also only simply skip the python tests instead of skipping
everything, in case the chosen QEMU binary does not support virtio-blk.

 Thomas


