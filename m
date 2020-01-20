Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D24C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3538217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVqEeEy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3538217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZa3-0001EE-PY
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itZYO-00086P-L4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itZYK-0002Gw-Pd
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:05:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itZYK-0002Fp-LX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579536323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=sDRgG/5gkJhM7+g764imx+5pAkESVNOXEhbGqKdIszE=;
 b=hVqEeEy3ApdmDaY6ZsP19DcpkbVNbebKflDm1Mvampf2dYXAszAleq8Tcg0bTgbSIGsn5u
 tSQMhbe9SKVxxL3jVuK6bCOZ2rVI1ahGZ6hDvwNHWJFDZwcU4e9zYbfvQsUc1dDgfPxH/F
 TRYuMLLH9wTCRsNTX4OBUrkoPxPsQMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-R35PupXQOxWLpIgPiRfTpg-1; Mon, 20 Jan 2020 11:05:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CFCEA0CBF;
 Mon, 20 Jan 2020 16:05:21 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3CE77DB34;
 Mon, 20 Jan 2020 16:05:17 +0000 (UTC)
Subject: Re: [PATCH v4 5/6] iotests: Skip Python-based tests if QEMU does not
 support virtio-blk
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
References: <20191202101039.8981-1-thuth@redhat.com>
 <20191202101039.8981-6-thuth@redhat.com>
 <a51a4748-fa43-d2b2-ffa2-05769e8f32f3@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c0b9256b-0954-a683-6b1e-c5c7017535cd@redhat.com>
Date: Mon, 20 Jan 2020 17:05:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a51a4748-fa43-d2b2-ffa2-05769e8f32f3@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: R35PupXQOxWLpIgPiRfTpg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/01/2020 15.50, Max Reitz wrote:
> On 02.12.19 11:10, Thomas Huth wrote:
>> We are going to enable some of the python-based tests in the "auto" group,
>> and these tests require virtio-blk to work properly. Running iotests
>> without virtio-blk likely does not make too much sense anyway, so instead
>> of adding a check for the availability of virtio-blk to each and every
>> test (which does not sound very appealing), let's rather add a check for
>> this a central spot in the "check" script instead (so that it is still
>> possible to run "make check" for qemu-system-tricore for example).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/check | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index 90970b0549..bce3035d5a 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -642,7 +642,11 @@ fi
>>  python_usable=false
>>  if $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >= (3,6) else 1)'
>>  then
>> -    python_usable=true
>> +    # Our python framework also requires virtio-blk
>> +    if "$QEMU_PROG" -M none -device help | grep -q virtio-blk >/dev/null 2>&1
>> +    then
>> +        python_usable=true
>> +    fi
>>  fi
>>  
>>  default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
>> @@ -830,7 +834,7 @@ do
>>                  run_command="$PYTHON $seq"
>>              else
>>                  run_command="false"
>> -                echo "Unsupported Python version" > $seq.notrun
>> +                echo "Unsupported Python version or missing virtio-blk" > $seq.notrun
> 
> A $python_unusable_because might be helpful (set in to-be-added else
> branches for the ifs that set python_usable to true), but either way:

Sounds like a good idea, I'll give it a try and send a v5.

 Thanks,
  Thomas


