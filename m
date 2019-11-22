Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C1DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0120B20707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmtgbl4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0120B20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY3OK-0007fb-Uv
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 02:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iY3NO-0007AS-EQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iY3NM-0005mj-L8
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:29:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iY3NM-0005ma-HV
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574407747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5zHUa2oDblpWdPLrJMtE3hOfzL6bagvM7VLAfB+tLE=;
 b=gmtgbl4uBOz33VKIoqgukNVyuAGavc0ASwsdmMccZEc7nxR51m/Cs1sOAZNUAubt/9xTCu
 /V5tuTc4lc8bsNz+qGNoOLDKFKpc/y0uWlfu/yU/Yt1SWGAkUMBNk1/0oKCL/24CMHkeZ2
 bPB1DZ1X3335Squ1XbPJh4C13LJV62s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-X6zO00C1OPiXhrItQV8Beg-1; Fri, 22 Nov 2019 02:29:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF5F593A1;
 Fri, 22 Nov 2019 07:29:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4B415C548;
 Fri, 22 Nov 2019 07:29:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67C611138606; Fri, 22 Nov 2019 08:29:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/14] qapi: Introduce default values for
 struct members
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-4-mreitz@redhat.com>
 <87eey1b73y.fsf@dusky.pond.sub.org>
 <0214e73e-062e-a9c8-16c9-e99354c07277@redhat.com>
 <871ru1811o.fsf@dusky.pond.sub.org>
 <817914b7-79d7-a2c9-142b-0a040b1da7ff@redhat.com>
Date: Fri, 22 Nov 2019 08:29:00 +0100
In-Reply-To: <817914b7-79d7-a2c9-142b-0a040b1da7ff@redhat.com> (Eric Blake's
 message of "Thu, 21 Nov 2019 13:56:04 -0600")
Message-ID: <874kyw74jn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: X6zO00C1OPiXhrItQV8Beg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 11/21/19 1:46 PM, Markus Armbruster wrote:
>
>>>> The '*' is redundant in this form.
>>>>
>>>> Can anyone think of reasons for keeping it anyway?  Against?
>>>
>>> Is there ever a reason to allow an optional member but without a
>>> 'default' value?  Or can we just blindly state that if 'default' is
>>> not present, that is the same as 'default':0/'default':null?
>>>
>>> Or, applying your statement further,
>>>
>>> 'data': { '*a':'int', '*b':'str' }
>>>
>>> is shorthand for:
>>>
>>> 'data': { 'a': { 'type':'int', 'default':0 },
>>>            'b': { 'type':'str', 'default':null } }
>>
>> You propose to default 'default' to a type-specific value.
>>
>> I don't think that's a good idea.
>
> ...
>
>
>> When an absent member behaves just like it was present with a certain
>> value DFLT, we want to be able to say in the schema 'default': DFLT.
>>
>> But the schema language also needs to let us say "absent member behaves
>> unlike any value".
>>
>> If we define 'default' to default to a value, then that value must have
>> this special meaning.
>>
>> Where that value is also a valid value, the schema language cannot
>> express "absent member behaves like it was present with that value".
>>
>> I think this makes 0 a poor default value for 'default': "behaves like
>> member was present with value 0" is fairly common, I think.
>>
>> Defaulting 'default' to null regardless of member type could work.
>>
>> null is a valid value of the 'null' type and of alternate types with a
>> member of type 'null'.  For optional members of such types, the schema
>> language then can't express ""absent member behaves like it was present
>> with value null".  I think the need to say that is much less common than
>> the needs to say "like value 0".
>>
>> Checking...  *sigh*: there are a few optional members that can take null
>> values, e.g. MigrateSetParameters member @tls-creds.  I read its doc
>> comment twice, and I have to admit I can't make heads or tails of it.
>> Can't say for sure whether absent behaves like null, or some other
>> value, or unlike any value.
>>
>> QAPI/QMP introspection already specifies null to have exactly this
>> special meaning.
>
> Maybe that means we need '*name':'t' to expand into something longer, may=
be
>  'name':{'type':'t', 'optional':true}
> which in  turn would be synonymous with your idea of ALL types
> accepting a default of null:
>  'name':{'type':'t', 'optional':true, 'default':null}

Yes, this is something we can consider.

Currently, we normalize away the '*' prefix when we go from the abstract
parse tree (which we call "expressions") to the internal representation:

    def _make_member(self, name, typ, ifcond, info):
        optional =3D False
        if name.startswith('*'):
            name =3D name[1:]
            optional =3D True
        if isinstance(typ, list):
            assert len(typ) =3D=3D 1
            typ =3D self._make_array_type(typ[0], info)
        return QAPISchemaObjectTypeMember(name, info, typ, optional, ifcond=
)

This keeps the normalization internal.

Other normalizations we perform on the abstract parse tree.  For
instance, here's the one that normalizes shorthand member "'KEY': 'ARG'"
to longhand "'KEY': { 'type': 'ARG' }":

    def normalize_members(members):
        if isinstance(members, OrderedDict):
            for key, arg in members.items():
                if isinstance(arg, dict):
                    continue
                members[key] =3D {'type': arg}

For these normalizations, both the shorthand and the longhand form are
part of the schema language.  We could do the same for '*'.

> At any rate, your counterpoint is taken - whatever we pick, we'll want
> to make sure that introspection can expose semantics, and whether we
> can make '*' redundant with some other form of longhand in the qapi
> language is in part determined by whether we also reflect that through
> introspection.

Introspection has the true member name, without the '*' prefix.

We'll also want to avoid unnecessary compromises on QAPI schema
expressiveness.  If we use null to mean "schema does not specify
behavior when member is absent", we can't use it to mean "absent member
behaves like the value null".  A bit of a blemish, but I think it's a
tolerable one.

>                 If that means that keeping '*' in the longhand form of
> optional members (whether or not those members have a default value),
> then so be it.

I believe both

    '*KEY': { 'type': ARG': 'default': null }

and

    'KEY': { 'type': ARG': 'default': null }

are viable longhand forms for '*KEY': 'ARG'.

I prefer the latter, but I'm open to arguments.


