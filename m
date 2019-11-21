Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E8C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB5420643
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0mf9uez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB5420643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXsS6-00026v-Ue
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXsQ8-00006a-Dj
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXsQ5-00036X-14
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:47:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXsQ4-00034B-TT
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574365626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWRsNhnLBH1LBQAqWghzm8BE9YMY6D+e/4e45FCIssc=;
 b=D0mf9uez8yccx+ARcfHa4HIkFrKFZWxbGD4FE1HHV2rmwCl0e1grZHmspwXWJtZuueDRYk
 x09zIz+cr7dk4s6EhFsZFUfjlBmMfNOC5L+0bbLpM3eM5r7zRWJLcFXyLhK6pqF4LTuDYz
 JtEyJyqRTp6Itfns4tKCCemlYDjXqMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-eGrpUa8pPtq8b37LQRIoAA-1; Thu, 21 Nov 2019 14:47:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B933218B5FA0;
 Thu, 21 Nov 2019 19:47:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 576235E263;
 Thu, 21 Nov 2019 19:47:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C7ADB1138606; Thu, 21 Nov 2019 20:46:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/14] qapi: Introduce default values for
 struct members
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-4-mreitz@redhat.com>
 <87eey1b73y.fsf@dusky.pond.sub.org>
 <0214e73e-062e-a9c8-16c9-e99354c07277@redhat.com>
Date: Thu, 21 Nov 2019 20:46:59 +0100
In-Reply-To: <0214e73e-062e-a9c8-16c9-e99354c07277@redhat.com> (Eric Blake's
 message of "Thu, 21 Nov 2019 09:24:44 -0600")
Message-ID: <871ru1811o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: eGrpUa8pPtq8b37LQRIoAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 11/21/19 9:07 AM, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>>
>>> With this change, it is possible to give default values for struct
>>> members, as follows:
>>>
>>>    What you had to do so far:
>>>
>>>      # @member: Some description, defaults to 42.
>>>      { 'struct': 'Foo',
>>>        'data': { '*member': 'int' } }
>>>
>>>    What you can do now:
>>>
>>>      { 'struct': 'Foo',
>>>        'data': { '*member': { 'type': 'int', 'default': 42 } }
>>
>> The '*' is redundant in this form.
>>
>> Can anyone think of reasons for keeping it anyway?  Against?
>
> Is there ever a reason to allow an optional member but without a
> 'default' value?  Or can we just blindly state that if 'default' is
> not present, that is the same as 'default':0/'default':null?
>
> Or, applying your statement further,
>
> 'data': { '*a':'int', '*b':'str' }
>
> is shorthand for:
>
> 'data': { 'a': { 'type':'int', 'default':0 },
>           'b': { 'type':'str', 'default':null } }

You propose to default 'default' to a type-specific value.

I don't think that's a good idea.

Quoting myself on v3:

    In many programming languages, absent optional arguments / members
    default to a default value specified in the declaration.  Simple.

    In others, 'absent' is effectively an additional value.  The code
    consuming the argument / member can interpret 'absent' however it wants=
.
    It may eliminate the additional value by mapping it to a default value,
    but it can also interpret 'absent' unlike any value.  If there's more
    than one consumer, their interpretations need not be consistent.  The
    declaration provides no clue on semantics of 'absent'.

    QAPI is in the latter camp.  I trust you can already sense how much I
    like that.
    [...]
    If I could go back in time, I'd flip QAPI to "'absent' defaults to a
    default value".  Lacking a time machine, we're stuck with cases of
    "'absent' means something you can't express with a value" and "'absent'
    means different things in different contexts" that have been enshrined
    in external interfaces.  Is there anything we could do to improve
    matters for saner cases?

    I think there is: we could provide for an *optional* default value.  If
    the schema specifies it, that's what 'absent' means.  If it doesn't, al=
l
    bets are off, just like they are now.

This patch implements this idea.

When an absent member behaves just like it was present with a certain
value DFLT, we want to be able to say in the schema 'default': DFLT.

But the schema language also needs to let us say "absent member behaves
unlike any value".

If we define 'default' to default to a value, then that value must have
this special meaning.

Where that value is also a valid value, the schema language cannot
express "absent member behaves like it was present with that value".

I think this makes 0 a poor default value for 'default': "behaves like
member was present with value 0" is fairly common, I think.

Defaulting 'default' to null regardless of member type could work.

null is a valid value of the 'null' type and of alternate types with a
member of type 'null'.  For optional members of such types, the schema
language then can't express ""absent member behaves like it was present
with value null".  I think the need to say that is much less common than
the needs to say "like value 0".

Checking...  *sigh*: there are a few optional members that can take null
values, e.g. MigrateSetParameters member @tls-creds.  I read its doc
comment twice, and I have to admit I can't make heads or tails of it.
Can't say for sure whether absent behaves like null, or some other
value, or unlike any value.

QAPI/QMP introspection already specifies null to have exactly this
special meaning.

> So I could live with permitting '*' only in the shorthand form, and
> declaring that it is incompatible with longhand form because the
> existence of a 'default' key in longhand form is evidence that the
> member is therefore optional.

Noted.

More opinions?


