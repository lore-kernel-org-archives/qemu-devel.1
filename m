Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4286EC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD442073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sve8yEhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD442073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPCi-0005yW-4K
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isPBo-000561-Cq
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isPBk-00080B-JZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:49:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isPBk-0007zn-FI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579258155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20gA7lfSxlrDhh3ib4WHqKmwh3cbL0CCifJAg3rZAs0=;
 b=Sve8yEhJgRQiO72OQGCuAN2fWT1BdWhwGPaz9erVbiPiUo9vUpigQtkEKSCwyIzwIyDNdy
 tsA38iF6NeTc5WwHf+9PBjzr3JkMg9bABQWwBe1W3qg5bB4XwtYDyt2dKmdXQT+GRuI6ZH
 M0UZWE4rQaFHc1zwN5o0MNpo8tkMolA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-fYRFUq3WMneJSnc0IcrZUQ-1; Fri, 17 Jan 2020 05:49:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A49801800D4F;
 Fri, 17 Jan 2020 10:49:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F7775C299;
 Fri, 17 Jan 2020 10:49:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 396DC1138600; Fri, 17 Jan 2020 11:49:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
References: <20200116202558.31473-1-armbru@redhat.com>
 <163735a5-b8d0-e657-86b2-a3921d754381@redhat.com>
Date: Fri, 17 Jan 2020 11:49:10 +0100
In-Reply-To: <163735a5-b8d0-e657-86b2-a3921d754381@redhat.com> (Thomas Huth's
 message of "Fri, 17 Jan 2020 10:34:55 +0100")
Message-ID: <87tv4ul5nd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: fYRFUq3WMneJSnc0IcrZUQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 16/01/2020 21.25, Markus Armbruster wrote:
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
> Thanks, this fixes the problems on Travis for me!
>
> Tested-by: Thomas Huth <thuth@redhat.com>
>
> Peter, could you maybe apply this directly to the master branch as a
> build fix?

The commit message isn't quite right: s/Visits in the same order/Visits
modules in the same order/.  Peter, want me to respin for that?


