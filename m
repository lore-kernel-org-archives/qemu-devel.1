Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2C8C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57879206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTMnZkPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57879206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixQQd-00030V-JJ
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 02:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ixQPs-0002X2-Ob
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ixQPr-0007Pg-N2
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:08:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29875
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ixQPr-0007PY-K6
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580454515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=VF7Lc6L7PKzqaTyOhzb8Bs0z6xhj8HwSrz383sHX258=;
 b=GTMnZkPVVADuLhjhG4/pC5iRw5stAZ1BAw8bnLNwQqW4Zw7vGrxj9Q0twOGclAdlL9yDp6
 qBsnrhg6XkpdK+AXtKIR//RbD0gVbw3VbpZaAj/+nwlPtbdRADBj7J262TrsGH2ti8Xbim
 AJ6M6xNPl0anNzx/e+8BLeWSYKy98tY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-qmsvDFYaOQaOLBkNJucKew-1; Fri, 31 Jan 2020 02:08:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B67E1005512;
 Fri, 31 Jan 2020 07:08:28 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5016260BE0;
 Fri, 31 Jan 2020 07:08:24 +0000 (UTC)
Subject: Re: [PATCH v5 5/6] iotests: Skip Python-based tests if QEMU does not
 support virtio-blk
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20200121095205.26323-1-thuth@redhat.com>
 <20200121095205.26323-6-thuth@redhat.com>
 <ef7deb82-e2da-f572-8e17-aaf59b34dd4c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5490675f-bb3c-dd69-6b16-da2ff10c52bd@redhat.com>
Date: Fri, 31 Jan 2020 08:08:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ef7deb82-e2da-f572-8e17-aaf59b34dd4c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qmsvDFYaOQaOLBkNJucKew-1
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/2020 23.31, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/21/20 10:52 AM, Thomas Huth wrote:
>> We are going to enable some of the python-based tests in the "auto"
>> group,
>> and these tests require virtio-blk to work properly. Running iotests
>> without virtio-blk likely does not make too much sense anyway, so instea=
d
>> of adding a check for the availability of virtio-blk to each and every
>> test (which does not sound very appealing), let's rather add a check for
>> this a central spot in the "check" script instead (so that it is still
>> possible to run "make check" for qemu-system-tricore for example).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/check | 12 ++++++++++--
>> =C2=A0 1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index 2890785a10..1629b6c914 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -642,7 +642,15 @@ fi
>> =C2=A0 python_usable=3Dfalse
>> =C2=A0 if $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >=3D (3=
,6)
>> else 1)'
>> =C2=A0 then
>> -=C2=A0=C2=A0=C2=A0 python_usable=3Dtrue
>> +=C2=A0=C2=A0=C2=A0 # Our python framework also requires virtio-blk
>> +=C2=A0=C2=A0=C2=A0 if "$QEMU_PROG" -M none -device help | grep -q virti=
o-blk
>> >/dev/null 2>&1
>=20
> FYI I proposed a patch adding a binary_get_devices() helper:
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg07314.html
>=20
> You could use something such
>=20
> =C2=A0 @SkipUntil('virtio-blk' in binary_get_devices(qemu_bin))

Unfortunately, that doesn't scale here. You'd have to add this to almost
all python-based iotests, since the virtio-blk dependency is hard-wired
deep in the code there (look at the add_drive function).

 Thomas


