Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD86C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E6C20714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsFmfwEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E6C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEbrx-0007ZQ-GT
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 12:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEbrH-0006ut-2v
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEbrF-0001Ai-Ls
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:47:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEbrF-000195-Hr
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584550072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2DCy50pr2+7e7rUAcjV+qA53fXAwpJyNnHZIy2EWkg=;
 b=SsFmfwEAz9fZeWmmX2bfibD0ITjxLiftUAh4NyXKZHg508zm3MTlifuJNBATa4svYQkzcR
 BRNFss5Mq7XFADoctdKk8FSxXIgHYuyWZUufeHDyFRmvbwqTRHrVfnl9kmeDjNU1lAsah2
 nkQkICEfmGX1iHYzGVw9mAmuHfU68Ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-gW-dhm-POtaQV05Ki44N5A-1; Wed, 18 Mar 2020 12:47:50 -0400
X-MC-Unique: gW-dhm-POtaQV05Ki44N5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 135D218AB2C0;
 Wed, 18 Mar 2020 16:47:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFD8A6EF85;
 Wed, 18 Mar 2020 16:47:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7750D1138404; Wed, 18 Mar 2020 17:47:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 28/34] qapi: Implement deprecated-output=hide for QMP
 command results
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200317115459.31821-29-armbru@redhat.com>
 <955280e0-7165-5e3c-b08d-522275eb2e30@redhat.com>
Date: Wed, 18 Mar 2020 17:47:46 +0100
In-Reply-To: <955280e0-7165-5e3c-b08d-522275eb2e30@redhat.com> (Eric Blake's
 message of "Wed, 18 Mar 2020 05:40:02 -0500")
Message-ID: <871rpp4nkd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 3/17/20 6:54 AM, Markus Armbruster wrote:
>> This policy suppresses deprecated bits in output, and thus permits
>> "testing the future".  Implement it for QMP command results.  Example:
>> when QEMU is run with -compat deprecated-output=3Dhide, then
>>
>>      {"execute": "query-cpus-fast"}
>>
>> yields
>>
>>      {"return": [{"thread-id": 9805, "props": {"core-id": 0, "thread-id"=
: 0, "socket-id": 0}, "qom-path": "/machine/unattached/device[0]", "cpu-ind=
ex": 0, "target": "x86_64"}]}
>>
>> instead of
>>
>>      {"return": [{"arch": "x86", "thread-id": 22436, "props": {"core-id"=
: 0, "thread-id": 0, "socket-id": 0}, "qom-path": "/machine/unattached/devi=
ce[0]", "cpu-index": 0, "target": "x86_64"}]}
>>
>> Note the suppression of deprecated member "arch".
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/tests/test-qmp-cmds.c
>> @@ -1,4 +1,5 @@
>>   #include "qemu/osdep.h"
>> +#include "qapi/compat-policy.h"
>>   #include "qapi/qmp/qdict.h"
>>   #include "qapi/qmp/qjson.h"
>>   #include "qapi/qmp/qnum.h"
>> @@ -45,12 +46,17 @@ void qmp_user_def_cmd1(UserDefOne * ud1, Error **err=
p)
>>   {
>>   }
>>   -void qmp_test_features0(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
>> -                       FeatureStruct2 *fs2, FeatureStruct3 *fs3,
>> -                       FeatureStruct4 *fs4, CondFeatureStruct1 *cfs1,
>> -                       CondFeatureStruct2 *cfs2, CondFeatureStruct3 *cf=
s3,
>> -                       Error **errp)
>> +FeatureStruct1 *qmp_test_features0(bool has_fs0, FeatureStruct0 *fs0,
>> +                                   bool has_fs1, FeatureStruct1 *fs1,
>> +                                   bool has_fs2, FeatureStruct2 *fs2,
>> +                                   bool has_fs3, FeatureStruct3 *fs3,
>> +                                   bool has_fs4, FeatureStruct4 *fs4,
>> +                                   bool has_cfs1, CondFeatureStruct1 *c=
fs1,
>> +                                   bool has_cfs2, CondFeatureStruct2 *c=
fs2,
>> +                                   bool has_cfs3, CondFeatureStruct3 *c=
fs3,
>> +                                   Error **errp)
>>   {
>> +    return g_new(FeatureStruct1, 1);
>
> Should this be using g_new0, rather than random contents?

Accident.  It's not actually used.

>>   }
>>     void qmp_test_command_features1(Error **errp)
>> @@ -271,6 +277,30 @@ static void test_dispatch_cmd_io(void)
>>       qobject_unref(ret3);
>>   }
>>   +static void test_dispatch_cmd_ret_deprecated(void)
>> +{
>> +    const char *cmd =3D "{ 'execute': 'test-features0' }";
>> +    QDict *ret;
>> +
>> +    memset(&compat_policy, 0, sizeof(compat_policy));
>> +
>> +    /* default accept */
>> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
>> +    assert(ret && qdict_size(ret) =3D=3D 1);
>> +    qobject_unref(ret);
>> +
>> +    compat_policy.has_deprecated_output =3D true;
>> +    compat_policy.deprecated_output =3D COMPAT_POLICY_OUTPUT_ACCEPT;
>
> Of course, if we ever enable defaults in QAPI, we can get rid of
> has_deprecated_output by recording proper defaults for bools.  But
> that's a different project ;)

Yes.  The has_FOO have been annoying me since forever.  I just never get
around to doing anything about it.

>> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
>> +    assert(ret && qdict_size(ret) =3D=3D 1);
>> +    qobject_unref(ret);
>> +
>> +    compat_policy.deprecated_output =3D COMPAT_POLICY_OUTPUT_HIDE;
>> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
>> +    assert(ret && qdict_size(ret) =3D=3D 0);
>> +    qobject_unref(ret);
>> +}
>> +
>
> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


