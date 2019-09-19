Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F34C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A88321907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="upzoG6m7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A88321907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAuES-0004HD-QN
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iAu9N-0001WD-Sc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iAu9M-00053A-Hu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:59:01 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:37352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iAu9M-00051O-0i
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:59:00 -0400
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 3746896F50;
 Thu, 19 Sep 2019 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1568890737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbTJIlhLvYvwCrIGPZsHYaRz7P3HlHTJ+djg4ZnoVqo=;
 b=upzoG6m7nNPo+QjmYkA42RNdNB81n0E8sRqFksyTZyCkv1siojoE0/Qe/z0I3eL5o/OKVJ
 Cm+47Pi12tdXulVgsL6FcK31v+qkAH5C6ZBYS3to8bRMZApH5RiZoxgq+T2mbIMMhxOVi5
 N1smjiP2Z9Ml1sDHgL1JLqMhCm9AKWI=
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190919104907.18005-1-philmd@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <641b9c18-c9b7-d557-94aa-8690f9c04766@greensocs.com>
Date: Thu, 19 Sep 2019 12:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190919104907.18005-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1568890737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbTJIlhLvYvwCrIGPZsHYaRz7P3HlHTJ+djg4ZnoVqo=;
 b=T4of8v0+m3wRab4UXyXHET8J97L2csWGWwSrzhrX04rOhaXCic0rduhOyohM7cbxCJDGGi
 KfEW9o/tymMRvhmZ3uPtokAWQa0ihOasEtEF1mTKWYb56bMmlVn0nRhq4SzT6pENN0Az6H
 NhxE3E+GciDpHqIDhUL0mdOLAwjgH/o=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1568890737; a=rsa-sha256; cv=none;
 b=qff7BKKpA1KFPYO13F457A408oYfvvGLfPdwECTwoeyums2hiyrm3CWKU1Kz7KnUz4lIl8
 UclehxDGAieCtyBd9k+0fmASwC4FCrNI06R+RPPLxXF/zRvJFIs0SIZXbC3Jinw+WfrArJ
 dVVA4T39oILSMeQg01dMF0EbhLtMab4=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH] util/qemu-option: Document the
 get_opt_value() function
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 9/19/19 12:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Coverity noticed commit 950c4e6c94 introduced a dereference before
> null check in get_opt_value (CID1391003):
>=20
>   In get_opt_value: All paths that lead to this null pointer
>   comparison already dereference the pointer earlier (CWE-476)
>=20
> We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
> 0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
> for the 'value' parameter".
>=20
> Since this function is publicly exposed, it risks new users to do
> the same error again. Avoid that documenting the 'value' argument
> must not be NULL.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qemu/option.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/qemu/option.h b/include/qemu/option.h
> index 844587cab3..141d6a883d 100644
> --- a/include/qemu/option.h
> +++ b/include/qemu/option.h
> @@ -28,6 +28,18 @@
> =20
>  #include "qemu/queue.h"
> =20
> +/**
> + * get_opt_value
> + * @p: a pointer to the option name, delimited by commas
> + * @value: a non-NULL pointer that will received the delimited options
> + *
> + * The @value char pointer will be allocated and filled with
> + * the delimited options.
> + * It is an error to pass a non-NULL @value parameter.

You mean "a NULL @value" I suppose (not a non-NULL).

> + *
> + * Returns the position of the comma delimiter/zero byte after the
> + * option name in @p.
> + */
>  const char *get_opt_value(const char *p, char **value);
> =20
>  void parse_option_size(const char *name, const char *value,
>=20

--
Damien

