Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B2C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66FD2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="L3v2YJG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66FD2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6nd-0000l2-IR
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT6kJ-00065A-SZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT6kI-00033o-Mj
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:04:23 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:34770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iT6kI-00033F-Gi
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:04:22 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 5B7F396EF0;
 Fri,  8 Nov 2019 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573229060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cu0NmiU4i/0N8hNdRLUSeqh66axhhEBYdkM4IbciSTA=;
 b=L3v2YJG29qZ25AA1U1Cknoc3RCI4iC29Muhf121+cmJNhZUaVOvgjKAbb31KXyu93FSzSh
 cB5DH2XgeIiXIayD/ThxYPSLAoWKHiomsB9tURFq8hN2C8k7y7Y3FiMeSM+chnA1/OXogB
 Adt3heg/kOIZ0b/Tn3cbp93EiQLcXrg=
Subject: Re: [PATCH v6 02/25] json-lexer: make it safe to call destroy
 multiple times
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191108150123.12213-3-marcandre.lureau@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <bb2dcf63-1a8f-44e9-e68a-4b8fdeb17e7b@greensocs.com>
Date: Fri, 8 Nov 2019 17:04:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191108150123.12213-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573229060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cu0NmiU4i/0N8hNdRLUSeqh66axhhEBYdkM4IbciSTA=;
 b=fUWAL7dFamic3r+pn4aHdrrjznEEd3sPF+zTkePlFx+zkd3gb1eLfkUQ9c1flls6tqlnkm
 Lb1/ya2LovLVmmLhZamVO1bljVyr9q1vO3yoOPPqAcTqiVpGP+4/8YZHrIg2VWMhn5emQu
 w/rNG0Beuwc1qBKerp29S1g559JhDzw=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573229060; a=rsa-sha256; cv=none;
 b=PRuKRRi6JdfPfmrH5ZqDqCnzClIdGuKXb71OHMbFqvEBy0lKbpBt1pnE7KUNTRyXqfymgB
 QlGHUeQlx6Bxtz0K0wsishAkGGnEHwQhEoiSfLAkX7wWZWZ8EXjy7REJwnTol7HKs4YkOK
 r2DXQ9solo3tZF0ayMfEvX6tb7Wyi/g=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/8/19 4:01 PM, Marc-Andr=C3=A9 Lureau wrote:
> We can easily avoid the burden of checking if the lexer was
> initialized prior to calling destroy by the caller, let's do it.
>=20
> This allows simplification in state tracking with the following patch,
> "qmp: add QmpSession" can call qmp_session_destroy() multiple times,
> which in turns calls json_lexer_destroy().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/json-lexer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
> index 632320d72d..fa7a2c43a8 100644
> --- a/qobject/json-lexer.c
> +++ b/qobject/json-lexer.c
> @@ -361,5 +361,8 @@ void json_lexer_flush(JSONLexer *lexer)
> =20
>  void json_lexer_destroy(JSONLexer *lexer)
>  {
> -    g_string_free(lexer->token, true);
> +    if (lexer->token) {
> +        g_string_free(lexer->token, true);
> +        lexer->token =3D NULL;
> +    }
>  }
>=20

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

--
Damien

