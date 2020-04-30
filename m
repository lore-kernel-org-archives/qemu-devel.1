Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D2BC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E152E20784
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaLVFQjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E152E20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1Qd-0002GC-29
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1PY-00011T-Dy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1NL-0002Kz-MU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:06:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1NL-0002Kl-75
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588223080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1t4IM8HaMQCrhM0Vq4VW4Ta32+34QepPkeLI3B2oqqk=;
 b=PaLVFQjUUrRbSTXTe7fAOvYbcPPtnEbtxeORPYzfyJROdDp+sUl10sg2DJq/xgbVYn2UI3
 T9YrDReSk430fI++QUu03rJQ81z5gQAlYdn+RpShVYpxxTRuDaKenlIxqXjSZMHMN9dBbi
 02iKJefflQottexhkvruHcOhY7+R10s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-VZmU-tQ4P4OKFGdtxv0IZQ-1; Thu, 30 Apr 2020 01:04:35 -0400
X-MC-Unique: VZmU-tQ4P4OKFGdtxv0IZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CBF618957E6;
 Thu, 30 Apr 2020 05:04:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B4DD99D8;
 Thu, 30 Apr 2020 05:04:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 996FD11358BC; Thu, 30 Apr 2020 07:04:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 4/4] scripts/qmp: Fix QEMU Python scripts path
References: <20200421094216.24927-1-f4bug@amsat.org>
 <20200421094216.24927-5-f4bug@amsat.org>
 <395d7263-c4f0-7422-0355-7e082135f6cd@redhat.com>
Date: Thu, 30 Apr 2020 07:04:29 +0200
In-Reply-To: <395d7263-c4f0-7422-0355-7e082135f6cd@redhat.com> (John Snow's
 message of "Wed, 29 Apr 2020 09:54:48 -0400")
Message-ID: <878sidimxu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9?= =?utf-8?Q?e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 4/21/20 5:42 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> QEMU Python scripts have been moved in commit 8f8fd9edba4 ("Introduce
>> Python module structure"). Use the same sys.path modification used
>> in the referenced commit to be able to use these scripts again.
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  scripts/qmp/qmp      | 4 +++-
>>  scripts/qmp/qom-fuse | 4 +++-
>>  scripts/qmp/qom-get  | 4 +++-
>>  scripts/qmp/qom-list | 4 +++-
>>  scripts/qmp/qom-set  | 4 +++-
>>  scripts/qmp/qom-tree | 4 +++-
>>  6 files changed, 18 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
>> index 0625fc2aba..8e52e4a54d 100755
>> --- a/scripts/qmp/qmp
>> +++ b/scripts/qmp/qmp
>> @@ -11,7 +11,9 @@
>>  # See the COPYING file in the top-level directory.
>> =20
>>  import sys, os
>> -from qmp import QEMUMonitorProtocol
>> +
>> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'py=
thon'))
>> +from qemu.qmp import QEMUMonitorProtocol
>> =20
>
> Try to avoid using sys.path hacks; they don't work in pylint or mypy and
> it provides an active barrier to CQA work here.
> (They also tend to be quite fragile.)
>
> We can discuss the right way to do this; one of those ways is to create
> an installable package that we can install locally in a virtual environme=
nt.
>
> Another way is perhaps to set PYTHONPATH in the calling environment so
> that standard "import" directives will work.
>
> Both ultimately involve changing the environment of the user to
> accommodate the script.

For what it's worth, tests/Makefile.involve does the latter for
tests/qapi-schema/test-qapi.py.  Simple enough, but makes manual
invocation inconvenient.

Not necessary for scripts/qapi-gen.py, because its "import qmp.FOO"
finds qmp right in scripts/qmp/.


