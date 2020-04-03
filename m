Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D84AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED40620757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HatGcaI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED40620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKG8x-0008RL-4V
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 02:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKG89-0007EZ-LU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKG88-0001PI-0C
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:48:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53623
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKG87-0001OJ-O3
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585896518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1kZldAxK3JSVa2g1k7p+7aixXH5rdwhexdaaln8kk4=;
 b=HatGcaI3s76q+BlyL3XDOn+6OtQfH0NKEia7NsCeJftWzStor1gAh1IjiW+ZeHaSh58efD
 yzjmW22yCMBAHNDaJdhkDbK84GqIL6KgagjrVAf5jGWjSsJgdkCUwvoPTjCDs7dyxRZ9vl
 tn+AjUIfqMr3KCzVZMRA3y011N85GQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-jWO291enM0u-I0uBqL2q3w-1; Fri, 03 Apr 2020 02:48:36 -0400
X-MC-Unique: jWO291enM0u-I0uBqL2q3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C463801A02;
 Fri,  3 Apr 2020 06:48:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2BB138D;
 Fri,  3 Apr 2020 06:48:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7500711385E2; Fri,  3 Apr 2020 08:48:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Simran Singhal <singhalsimran0@gmail.com>
Subject: Re: [PATCH v3] qobject: json-streamer: Change bracket_count to
 brace_count
References: <20200402182848.GA3023@simran-Inspiron-5558>
Date: Fri, 03 Apr 2020 08:48:33 +0200
In-Reply-To: <20200402182848.GA3023@simran-Inspiron-5558> (Simran Singhal's
 message of "Thu, 2 Apr 2020 23:58:48 +0530")
Message-ID: <87eet5t67y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simran Singhal <singhalsimran0@gmail.com> writes:

> Change the "parser->bracket_count >=3D 0" to "parser->brace_count >=3D 0"
> to fix the typo.
>
> Fixes: 8d3265b3
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>

First, thank you so much for spotting and fixing my typo!

The commit message neglects to explain what is broken.  I'd like to use
this one:

  json: Fix check for unbalanced right curly brace

  We immediately diagnose unbalanced right curly brace:

      $ qemu-kvm --nodefaults --nographic --qmp stdio
      {"QMP": {"version": {"qemu": {"micro": 91, "minor": 2, "major": 4},
      "package": "v5.0.0-rc1-1-gf6ce4a439a08"}, "capabilities": ["oob"]}}
      }
      {"error": {"class": "GenericError", "desc": "JSON parse error,
      expecting value"}}

  except within square bracket:

      [}

  The check for unbalanced braces has a typo.  Fix it.

  Fixes: 8d3265b3d00db1071d1d3bf8433b4818088fdeb5
  Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
  Reviewed-by: Eric Blake <eblake@redhat.com>

Objections?

> ---
> Changes in v3:
> =09-Add "Fixes: 8d3265b3" in commit message.
>
> Changes in v2:
>         -No need to remove the duplicate occurrence of "parser->bracket_c=
ount >=3D 0"
>         but actually it is a typo and one occurence should be "parser->br=
ace_count >=3D 0".
>
>  qobject/json-streamer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index 47dd7ea576..b93d97b995 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -85,7 +85,7 @@ void json_message_process_token(JSONLexer *lexer, GStri=
ng *input,
>      g_queue_push_tail(&parser->tokens, token);
> =20
>      if ((parser->brace_count > 0 || parser->bracket_count > 0)
> -        && parser->bracket_count >=3D 0 && parser->bracket_count >=3D 0)=
 {
> +        && parser->brace_count >=3D 0 && parser->bracket_count >=3D 0) {
>          return;
>      }

With a commit message that spells out what's broken:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


