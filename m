Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6912244C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHFKmlRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6912244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZ8c-0007bp-CZ
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIZ7U-00079l-Dz
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIZ7R-0004Ve-0j
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600269192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dZr3zw/KYwgkoWuiC+rHIoT2lfhE44D3Pg74p3+09gY=;
 b=UHFKmlRgdfs/DVTr+zsWGmSkbH/T43kFpWUlid/JFI5PVfA0YGgcSs6SrYN8xwKVJNDaeJ
 GQEooulFj3hn9ZmdhAbFcB50JkSwHEn8No2dLfb478JmrMnsKaVu+dLcal4733F/c0U3bf
 jlOGu+oRFzO4PUFMtZAYloPdDantWwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-CeHV4TQaO-OjsNCFL0wHNA-1; Wed, 16 Sep 2020 11:13:07 -0400
X-MC-Unique: CeHV4TQaO-OjsNCFL0wHNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AF0964082;
 Wed, 16 Sep 2020 15:13:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2463D78815;
 Wed, 16 Sep 2020 15:13:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A3391113864A; Wed, 16 Sep 2020 17:13:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 09/37] qapi/common.py: Add indent manager
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-10-jsnow@redhat.com>
Date: Wed, 16 Sep 2020 17:13:04 +0200
In-Reply-To: <20200915224027.2529813-10-jsnow@redhat.com> (John Snow's message
 of "Tue, 15 Sep 2020 18:39:59 -0400")
Message-ID: <87k0wtiwlb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> Code style tools really dislike the use of global keywords, because it
> generally involves re-binding the name at runtime which can have strange
> effects depending on when and how that global name is referenced in
> other modules.
>
> Make a little indent level manager instead.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/common.py | 50 +++++++++++++++++++++++++++++-------------
>  scripts/qapi/visit.py  |  7 +++---
>  2 files changed, 38 insertions(+), 19 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 4fb265a8bf..87d87b95e5 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -93,33 +93,53 @@ def c_name(name, protect=True):
>  pointer_suffix = ' *' + eatspace
>  
>  
> -def genindent(count):
> -    ret = ''
> -    for _ in range(count):
> -        ret += ' '
> -    return ret
> +class Indent:

Since this class name will be used just once...  Indentation or
IndentationManager?

> +    """
> +    Indent-level management.
>  
> +    :param initial: Initial value, default 0.

The only caller passes 0.

Let's drop the parameter, and hardcode the default initial value until
we have an actual use for another initial value.

> +    """
> +    def __init__(self, initial: int = 0) -> None:
> +        self._level = initial
>  
> -indent_level = 0
> +    def __int__(self) -> int:
> +        """Return the indent as an integer."""

Isn't "as an integer" obvious?

Let's replace "the indent" by "the indentation" globally.

> +        return self._level
>  
> +    def __repr__(self) -> str:
> +        return "{}({:d})".format(type(self).__name__, self._level)

Is __repr__ needed?

>  
> -def push_indent(indent_amount=4):
> -    global indent_level
> -    indent_level += indent_amount
> +    def __str__(self) -> str:
> +        """Return the indent as a string."""
> +        return ' ' * self._level
>  
> +    def __bool__(self) -> bool:
> +        """True when there is a non-zero indent."""
> +        return bool(self._level)

This one lets us shorten

    if int(INDENT):

to

    if INDENT:

There's just one instance.  Marginal.  I'm not rejecting it.

> -def pop_indent(indent_amount=4):
> -    global indent_level
> -    indent_level -= indent_amount
> +    def push(self, amount: int = 4) -> int:
> +        """Push `amount` spaces onto the indent, default four."""
> +        self._level += amount
> +        return self._level
> +
> +    def pop(self, amount: int = 4) -> int:
> +        """Pop `amount` spaces off of the indent, default four."""
> +        if self._level < amount:
> +            raise ArithmeticError(
> +                "Can't pop {:d} spaces from {:s}".format(amount, repr(self)))
> +        self._level -= amount
> +        return self._level

The push / pop names never made sense.  The functions don't push onto /
pop from a stack, they increment / decrement a counter, and so do the
methods.  Good opportunity to fix the naming.

The @amount parameter has never been used.  I don't mind keeping it.

> +
> +
> +INDENT = Indent(0)

Uh, does this really qualify as a constant?  It looks quite variable to
me...

>  # Generate @code with @kwds interpolated.
>  # Obey indent_level, and strip eatspace.
>  def cgen(code, **kwds):
>      raw = code % kwds
> -    if indent_level:
> -        indent = genindent(indent_level)
> -        raw, _ = re.subn(r'^(?!(#|$))', indent, raw, flags=re.MULTILINE)
> +    if INDENT:
> +        raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)
>      return re.sub(re.escape(eatspace) + r' *', '', raw)
>  
>  
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 31bf46e7f7..66ce3dc52e 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -19,8 +19,7 @@
>      gen_endif,
>      gen_if,
>      mcgen,
> -    pop_indent,
> -    push_indent,
> +    INDENT,
>  )
>  from .gen import QAPISchemaModularCVisitor, ifcontext
>  from .schema import QAPISchemaObjectType
> @@ -68,7 +67,7 @@ def gen_visit_object_members(name, base, members, variants):
>      if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
>  ''',
>                           name=memb.name, c_name=c_name(memb.name))
> -            push_indent()
> +            INDENT.push()
>          ret += mcgen('''
>      if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
>          return false;
> @@ -77,7 +76,7 @@ def gen_visit_object_members(name, base, members, variants):
>                       c_type=memb.type.c_name(), name=memb.name,
>                       c_name=c_name(memb.name))
>          if memb.optional:
> -            pop_indent()
> +            INDENT.pop()
>              ret += mcgen('''
>      }
>  ''')


