Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C607CC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 06:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED86207CD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 06:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZULOawaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED86207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR8qg-00023K-2t
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 02:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kR8pL-0001Ul-OG
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 02:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kR8pI-0000lS-St
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 02:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602313073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAqwese4kWiB9Lue+SEleTn49oLxuaE56s3SqPegXaE=;
 b=ZULOawaPygjdoeCdiLZ6d7pQ7Tv+DHMZPLyC5Ou8WhaQCgFWuWOG1w0N9ShjBaMBU0gJkX
 qnj/x6DErNsxp5CMSj9k2gaG/pukpcGwIDbKzyVvVi7uZ9GPeC4LkvINpefgRw18R2yORD
 W6+Df9BDH4sPos0b6AX3eClZ/nG5csE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-pnKZX9oCNNu_v_OJbdhUvg-1; Sat, 10 Oct 2020 02:57:49 -0400
X-MC-Unique: pnKZX9oCNNu_v_OJbdhUvg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BDCB1005E6C;
 Sat, 10 Oct 2020 06:57:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D0645C1C7;
 Sat, 10 Oct 2020 06:57:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3F4311329AE; Sat, 10 Oct 2020 08:57:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v6 26/36] qapi/gen.py: Fix edge-case of _is_user_module
References: <20201009161558.107041-1-jsnow@redhat.com>
 <20201009161558.107041-27-jsnow@redhat.com>
 <87zh4vcnv9.fsf@dusky.pond.sub.org>
 <20201009173949.GE7303@habkost.net>
Date: Sat, 10 Oct 2020 08:57:44 +0200
In-Reply-To: <20201009173949.GE7303@habkost.net> (Eduardo Habkost's message of
 "Fri, 9 Oct 2020 13:39:49 -0400")
Message-ID: <878scea7pz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Oct 09, 2020 at 07:26:02PM +0200, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>=20
>> > The edge case is that if the name is '', this expression returns a
>> > string instead of a bool, which violates our declared type.
>> > In practice, module names are not allowed to be the empty string, but
>> > this constraint is not modeled for the type system.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Actually:

1. We also map None to None, which is also not bool.

2. There is no declared type to violate until the next patch.

3. The subject's claim 'Fix edge-case' is misleading: this is a cleanup,
   not a bug fix.

Easy enough to fix:

    qapi/gen: Make _is_user_module() return bool

    _is_user_module() returns thruth values.  The next commit wants it to
    return bool.  Make it so.

>> > ---
>> >  scripts/qapi/gen.py | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>> > index fff0c0acb6d..2c305c4f82c 100644
>> > --- a/scripts/qapi/gen.py
>> > +++ b/scripts/qapi/gen.py
>> > @@ -241,7 +241,7 @@ def __init__(self, prefix, what, user_blurb, built=
in_blurb, pydoc):
>> > =20
>> >      @staticmethod
>> >      def _is_user_module(name):
>> > -        return name and not name.startswith('./')
>> > +        return bool(name and not name.startswith('./'))
>>=20
>>            return not (name is None or name.startswith('./')
>>=20
>> Looks slightly clearer to me.
>
> That would have exactly the same behavior as the
>   name is not None and name.startswith('./')
> expression we had in v1.

True.

Let's review what this function should do, and what it does.

The function should return whether @name is a user module name.
Returning truthy and falsy is fine; the callers expect no more.

system module names are either pathnames starting with './' (see
_add_system_module(), or None.

user module names are pathnames not starting with './' (see
_module_name()).

Before the patch:

    if @name is falsy, i.e. None or '', return @name
    else return name.startswith('./')

Thus, the function maps

    None              -> None   (1)
    ''                -> ''     (2)
    './' + any string -> False  (3)
    any other string  -> True   (4)

This is correct.  Case (2) can't actually happen ('' is not a pathname).

John's version of the patch normalizes case (1) and (2) to

    None              -> False  (1)
    ''                -> False  (2)

so the next patch can declare the function returns bool.  Safe, because
it doesn't change "thruthiness".

My version of the patch=20

    if @name is None, return False,
    else return not name.startswith('./')

Now the function maps

    None              -> False  (1)
    ''                -> True   (2)
    './' + any string -> False  (3)
    any other string  -> True   (4)

The only difference to John's patch is case (2).  That case is
impossible, so no difference in actual behavior.  Nevertheless, mapping
'' to True is unclean: it claims '' is a user module name, which it
isn't.

This would be clean:

    @staticmethod
    def _is_system_module(name):
        return name is None or name.startswith('./')

Adjusting callers would be straightforward.

Not worth it right now.  Taking John's patch with the rewritten commit
message.

Eduardo, thanks for making me think!


