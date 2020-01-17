Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9E2C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F852073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjVSWRYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F852073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isLki-0003Pw-6I
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isLja-0002M7-KO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isLjY-0001tb-Ob
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:07:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isLjY-0001t7-Kz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579244876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEzpdAEC2aCeXMP5LPbUGIZtNZJWh3LA2vu5OyLtKIw=;
 b=YjVSWRYqzvBG4gEuIzjVD4q87NHtYRwMMEV6f9LC1ebEq8+OzPzv2+nLx3xK7yaLXttwsG
 4YMnNQ0hz9MOUHvvdyzdj8cAB8s8trLtafaenMLEGBoKnb0ijae8UX/rpZFfDOb1+mFpmc
 0gh1+aBPkuO45ID8RQQbAEkf9q9dtBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-gAwOGINpMhW3HKE1eoZczA-1; Fri, 17 Jan 2020 02:07:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC39A107ACC7;
 Fri, 17 Jan 2020 07:07:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9965510013A1;
 Fri, 17 Jan 2020 07:07:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2837A1138600; Fri, 17 Jan 2020 08:07:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
References: <20200116202558.31473-1-armbru@redhat.com>
 <3fb3e411-c5de-fbc1-684b-c7fb1ce2ea7d@redhat.com>
Date: Fri, 17 Jan 2020 08:07:42 +0100
In-Reply-To: <3fb3e411-c5de-fbc1-684b-c7fb1ce2ea7d@redhat.com> (John Snow's
 message of "Thu, 16 Jan 2020 16:17:05 -0500")
Message-ID: <875zhapnlt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: gAwOGINpMhW3HKE1eoZczA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Peter Maydell <peter.maydell@linaro.org>, thuth@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <cleber@redhat.com>,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 1/16/20 3:25 PM, Markus Armbruster wrote:
>> Recent commit 3e7fb5811b "qapi: Fix code generation for empty modules"
>> modules" switched QAPISchema.visit() from
>>=20
>>     for entity in self._entity_list:
>>=20
>> effectively to
>>=20
>>     for mod in self._module_dict.values():
>>         for entity in mod._entity_list:
>>=20
>> Visits in the same order as long as .values() is in insertion order.
>> That's the case only for Python 3.6 and later.  Before, it's in some
>> arbitrary order, which results in broken generated code.
>>=20
>> Fix by making self._module_dict an OrderedDict rather than a dict.
>>=20
>> Fixes: 3e7fb5811baab213dcc7149c3aa69442d683c26c
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/schema.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> index 0bfc5256fb..5100110fa2 100644
>> --- a/scripts/qapi/schema.py
>> +++ b/scripts/qapi/schema.py
>> @@ -795,7 +795,7 @@ class QAPISchema(object):
>>          self.docs =3D parser.docs
>>          self._entity_list =3D []
>>          self._entity_dict =3D {}
>> -        self._module_dict =3D {}
>> +        self._module_dict =3D OrderedDict()
>>          self._schema_dir =3D os.path.dirname(fname)
>>          self._make_module(None) # built-ins
>>          self._make_module(fname)
>>=20
>
> This problem has bitten me *many* times. I'm wondering if there's a
> prescription that isn't just "Wait until we can stipulate 3.6+".

No clue.

3.5 EOL is scheduled for 2020-09-13.
https://devguide.python.org/#status-of-python-branches

We support 3.5 because we support Debian 9.

We'd normally drop support for Debian 9 two years after Debian 10,
i.e. July 2021.  Assuming Debian supports it that far.  Whether they can
truly support Python 3.5 after uptstream EOL seems doubtful.


