Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA1C47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD78120672
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djWJgzxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD78120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFuZ-0000Ov-P1
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOFtI-0007Wb-LA
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOFtF-0006C4-Oh
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sy/YubXubCrH97bUYG2FeIeSQjThGoTrgLwoHbTb5yU=;
 b=djWJgzxw2J5w5M4L4ydCqcmoLgx3ff5srSQIDyyqEG6REpyUnccXFkCVFArvNe5kp6jA5V
 56uqrXRmO8or+cxHXGsq2tz3C6PC+DPIAqV6zWkWEHn3PsWYwLUZVv3uassNKO3F2cHlP1
 gOkXDidxlM2Xt3FniAi0VOcx2ZbHKFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-DtQBQWevOsSkGtVBVE2iWg-1; Fri, 02 Oct 2020 03:54:03 -0400
X-MC-Unique: DtQBQWevOsSkGtVBVE2iWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 031DE101FFB5;
 Fri,  2 Oct 2020 07:54:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1B7B5C225;
 Fri,  2 Oct 2020 07:53:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37E9C1132784; Fri,  2 Oct 2020 09:53:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 08/13] qapi: Add a 'coroutine' flag for commands
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-9-kwolf@redhat.com>
Date: Fri, 02 Oct 2020 09:53:55 +0200
In-Reply-To: <20200909151149.490589-9-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:44 +0200")
Message-ID: <87sgaxoygc.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Additional nitpick detail on Kevin's request.

Kevin Wolf <kwolf@redhat.com> writes:

> This patch adds a new 'coroutine' flag to QMP command definitions that
> tells the QMP dispatcher that the command handler is safe to be run in a
> coroutine.
>
> The documentation of the new flag pretends that this flag is already
> used as intended, which it isn't yet after this patch. We'll implement
> this in another patch in this series.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
[...]
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index 2942520399..928cd1eb5c 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -88,10 +88,16 @@ def check_flags(expr, info):
>          if key in expr and expr[key] is not False:
>              raise QAPISemError(
>                  info, "flag '%s' may only use false value" % key)
> -    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
> +    for key in ['boxed', 'allow-oob', 'allow-preconfig', 'coroutine']:
>          if key in expr and expr[key] is not True:
>              raise QAPISemError(
>                  info, "flag '%s' may only use true value" % key)
> +    if 'allow-oob' in expr and 'coroutine' in expr:
> +        # This is not necessarily a fundamental incompatibility, but we =
don't
> +        # have a use case and the desired semantics isn't obvious. The s=
implest
> +        # solution is to forbid it until we get a use case for it.
> +        raise QAPISemError(info, "flags 'allow-oob' and 'coroutine' "
> +                                 "are incompatible")

PEP 8: For flowing long blocks of text with fewer structural
restrictions (docstrings or comments), the line length should be limited
to 72 characters.

PEP 8: You should use two spaces after a sentence-ending period in
multi- sentence comments, except after the final sentence.

> =20
> =20
>  def check_if(expr, info, source):
[...]


