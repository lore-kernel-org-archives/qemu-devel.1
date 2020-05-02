Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50233C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166E1208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxfmHZkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166E1208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUl7u-0001Ox-75
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 01:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUl73-0000Ju-K1
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUl72-0003vm-TA
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:54:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44031
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUl72-0003o2-G4
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588398895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lxd5LKupkRTW85DpH9u8F/CYKFOkTjPf9t3lyAR6r9w=;
 b=IxfmHZkVU25JtNjZitair9ZUUPjkZvgiXo5T7Dx0c/yV5zcTQdtT/DhOeplFLiMcgt7svH
 pzXvDAUB20d+GVfkF/Ch1Pw5aIzCyV47FgvmWPmW3YbKOR+Xt+jeJLgxo6csAco/N8j4KK
 HiRrQlK6hiKiRsUlI49XKkj/AK/wuWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-PrudPX7mOQeYqc6tYmhhxw-1; Sat, 02 May 2020 01:54:48 -0400
X-MC-Unique: PrudPX7mOQeYqc6tYmhhxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79478107ACF3;
 Sat,  2 May 2020 05:54:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3257C600E5;
 Sat,  2 May 2020 05:54:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFF4311358BC; Sat,  2 May 2020 07:54:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 4/4] scripts/qmp: Fix QEMU Python scripts path
References: <20200421094216.24927-1-f4bug@amsat.org>
 <20200421094216.24927-5-f4bug@amsat.org>
 <395d7263-c4f0-7422-0355-7e082135f6cd@redhat.com>
 <878sidimxu.fsf@dusky.pond.sub.org>
 <21ffc136-7905-e0aa-bad2-8d980fd15349@redhat.com>
Date: Sat, 02 May 2020 07:54:42 +0200
In-Reply-To: <21ffc136-7905-e0aa-bad2-8d980fd15349@redhat.com> (John Snow's
 message of "Thu, 30 Apr 2020 13:56:11 -0400")
Message-ID: <87ees26fvh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 01:54:53
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
 Alex =?utf-8?Q?B?= =?utf-8?Q?enn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 4/30/20 1:04 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>=20
>>> On 4/21/20 5:42 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> QEMU Python scripts have been moved in commit 8f8fd9edba4 ("Introduce
>>>> Python module structure"). Use the same sys.path modification used
>>>> in the referenced commit to be able to use these scripts again.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> ---
>>>>  scripts/qmp/qmp      | 4 +++-
>>>>  scripts/qmp/qom-fuse | 4 +++-
>>>>  scripts/qmp/qom-get  | 4 +++-
>>>>  scripts/qmp/qom-list | 4 +++-
>>>>  scripts/qmp/qom-set  | 4 +++-
>>>>  scripts/qmp/qom-tree | 4 +++-
>>>>  6 files changed, 18 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
>>>> index 0625fc2aba..8e52e4a54d 100755
>>>> --- a/scripts/qmp/qmp
>>>> +++ b/scripts/qmp/qmp
>>>> @@ -11,7 +11,9 @@
>>>>  # See the COPYING file in the top-level directory.
>>>> =20
>>>>  import sys, os
>>>> -from qmp import QEMUMonitorProtocol
>>>> +
>>>> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', '=
python'))
>>>> +from qemu.qmp import QEMUMonitorProtocol
>>>> =20
>>>
>>> Try to avoid using sys.path hacks; they don't work in pylint or mypy an=
d
>>> it provides an active barrier to CQA work here.
>>> (They also tend to be quite fragile.)
>>>
>>> We can discuss the right way to do this; one of those ways is to create
>>> an installable package that we can install locally in a virtual environ=
ment.
>>>
>>> Another way is perhaps to set PYTHONPATH in the calling environment so
>>> that standard "import" directives will work.
>>>
>>> Both ultimately involve changing the environment of the user to
>>> accommodate the script.
>>=20
>> For what it's worth, tests/Makefile.involve does the latter for
>> tests/qapi-schema/test-qapi.py.  Simple enough, but makes manual
>> invocation inconvenient.
>>=20
>> Not necessary for scripts/qapi-gen.py, because its "import qmp.FOO"
>> finds qmp right in scripts/qmp/.
>>=20
>
> Yes, using "proper" package hierarchies often means the loss of being
> able to invoke the scripts directly, unless you are careful to organize
> the package such that the scripts can run both in an "unpackaged" and a
> "packaged" mode.
>
> It can be done, but it's tricky and can be prone to error. Let's take a
> look at how to do it!
>
> Let's imagine we have an honest-to-goodness QAPI parser module. In
> isolation, the layout for such a package would probably look like this:
>
> qapi.git/
>   setup.py
>   qapi-gen.py
>   README.rst
>   qapi/
>     __init__.py
>     parser.py
>     schema.py
>     ...etc
>
>
> Now, anything inside of qapi/ is considered the "qapi module" and you
> will be unable to directly execute anything inside of this folder,
> unless it does not depend on anything else in the "qapi module".
>
> i.e. "import qapi.x" will work, but only from the executing context of a
> thread that understands how to find "qapi". If you are IN this
> directory, you do not have that context, so those directives will not wor=
k.
>
> Python imports are always handled relative to the importing file, not
> the imported file.
>
> qapi-gen in the parent directory, however, can use "from qapi import
> parser" without any problem, because if you are executing it directly,
> it will be able to see the "qapi module" as a folder.

Hmm...

    $ git-grep '^from.*schema' scripts/
    scripts/qapi-gen.py:from qapi.schema import QAPIError, QAPISchema
    scripts/qapi/events.py:from qapi.schema import QAPISchemaEnumMember
    scripts/qapi/gen.py:from qapi.schema import QAPISchemaVisitor
    scripts/qapi/introspect.py:from qapi.schema import (QAPISchemaArrayType=
, QAPISchemaBuiltinType,
    scripts/qapi/types.py:from qapi.schema import QAPISchemaEnumMember, QAP=
ISchemaObjectType
    scripts/qapi/visit.py:from qapi.schema import QAPISchemaObjectType

How come importing from qapi. works in scripts/qapi/*.py, too?

[...]


