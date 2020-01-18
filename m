Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB49C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B393D24680
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghVAALAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B393D24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isi0k-0005aM-RU
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 01:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isi07-00059F-W3
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isi06-00050X-Jh
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:54:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20602
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isi06-000506-Fx
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579330469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71DXIxcwoCPPPtNBoVu4Zya6RjKdYhCnh38F8Jcg6iU=;
 b=ghVAALANsuOxjA2cRDEb7qSGPOPX+N/eWhtJSztOkzZuJExl6/7ENkjXX1QAtT4axdNebk
 8k4RxCj260J7NiiRrQFfS9lW1xpd4nUysh+YLVxecJY82VJmKsvHQ2Zip+rLxzdyalATVw
 P5gzQN8YTyPU/hBHhV7Hn5qUy3fMtP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-lO2TuqiAPJuI_vrKnOF43g-1; Sat, 18 Jan 2020 01:54:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CDE1184C707;
 Sat, 18 Jan 2020 06:54:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 060A619C7F;
 Sat, 18 Jan 2020 06:54:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F00D1138600; Sat, 18 Jan 2020 07:54:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
References: <20200116202558.31473-1-armbru@redhat.com>
 <3fb3e411-c5de-fbc1-684b-c7fb1ce2ea7d@redhat.com>
 <875zhapnlt.fsf@dusky.pond.sub.org>
 <a6ea59a5-0877-fdeb-5b37-9ec3f31074a4@redhat.com>
Date: Sat, 18 Jan 2020 07:54:18 +0100
In-Reply-To: <a6ea59a5-0877-fdeb-5b37-9ec3f31074a4@redhat.com> (John Snow's
 message of "Fri, 17 Jan 2020 14:41:06 -0500")
Message-ID: <87lfq5s19h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: lO2TuqiAPJuI_vrKnOF43g-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, thuth@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <cleber@redhat.com>,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 1/17/20 2:07 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>=20
>>> On 1/16/20 3:25 PM, Markus Armbruster wrote:
>>>> Recent commit 3e7fb5811b "qapi: Fix code generation for empty modules"
>>>> modules" switched QAPISchema.visit() from
>>>>
>>>>     for entity in self._entity_list:
>>>>
>>>> effectively to
>>>>
>>>>     for mod in self._module_dict.values():
>>>>         for entity in mod._entity_list:
>>>>
>>>> Visits in the same order as long as .values() is in insertion order.
>>>> That's the case only for Python 3.6 and later.  Before, it's in some
>>>> arbitrary order, which results in broken generated code.
>>>>
>>>> Fix by making self._module_dict an OrderedDict rather than a dict.
>>>>
>>>> Fixes: 3e7fb5811baab213dcc7149c3aa69442d683c26c
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>  scripts/qapi/schema.py | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>>>> index 0bfc5256fb..5100110fa2 100644
>>>> --- a/scripts/qapi/schema.py
>>>> +++ b/scripts/qapi/schema.py
>>>> @@ -795,7 +795,7 @@ class QAPISchema(object):
>>>>          self.docs =3D parser.docs
>>>>          self._entity_list =3D []
>>>>          self._entity_dict =3D {}
>>>> -        self._module_dict =3D {}
>>>> +        self._module_dict =3D OrderedDict()
>>>>          self._schema_dir =3D os.path.dirname(fname)
>>>>          self._make_module(None) # built-ins
>>>>          self._make_module(fname)
>>>>
>>>
>>> This problem has bitten me *many* times. I'm wondering if there's a
>>> prescription that isn't just "Wait until we can stipulate 3.6+".
>>=20
>> No clue.
>>=20
>> 3.5 EOL is scheduled for 2020-09-13.
>> https://devguide.python.org/#status-of-python-branches
>>=20
>> We support 3.5 because we support Debian 9.
>>=20
>> We'd normally drop support for Debian 9 two years after Debian 10,
>> i.e. July 2021.  Assuming Debian supports it that far.  Whether they can
>> truly support Python 3.5 after uptstream EOL seems doubtful.
>>=20
>
> We should decide whether we consider Debian LTS to be adequately
> supported, yes-or-no.
>
> We should use a rule of "two years after successor, or End-of-Support,
> whichever comes first."

Yes.

> For Debian, is end of support three years after it comes out, or is it
> when the LTS is EOL?

We need to define end-of-support for Debian: is it Debian proper or is
it Debian LTS?

<https://wiki.debian.org/DebianOldStable>:

    Q) How long will security updates be provided?

    The security team tries to support a stable distribution for about
    one year after the next stable distribution has been released,
    except when another stable distribution is released within this
    year.  It is not possible to support three distributions; supporting
    two simultaneously is already difficult enough.

<https://wiki.debian.org/LTS>:

    Debian Long Term Support (LTS) is a project to extend the lifetime
    of all Debian stable releases to (at least) 5 years.  Debian LTS is
    not handled by the Debian security team, but by a separate group of
    volunteers and companies interested in making it a success.

    Thus the Debian LTS team takes over security maintenance of the
    various releases once the Debian Security team stops its work.

Debian 10 "Buster" was released in July 2019.  Debian 9 "Stretch" will
receive security updates from Debian until mid 2020, i.e. just about
when Python 3.5 reaches EOL.  LTS will attempt to support it until June
2022.

I think we should give ourselves a bit more flexibility than the
categorical "Support for the previous major version will be dropped 2
years after the new major version is released."  At some point, the cost
of supporting old hosts exceeds the utility.  We should face this
tradeoff.

> In this specific case, do we trust that Debian 9 LTS will continue to
> patch Python3.5 all the way up until July 2021?

June 2022 even.

We use Python at compile time with trusted input.  The need for security
maintenance is relatively low there.  I'm not ready to vouch for "and we
don't use Python for anything else".


