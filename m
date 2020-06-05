Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B744AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8354C2065C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEL7hLhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8354C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBmW-0008Px-RA
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhBlg-0007yT-Es
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:48:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23622
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhBle-00050c-Oi
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591361289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wt6vWuNzLbwNPkjZe+fQZRTdJHXe1m4gHmuHX7KDIao=;
 b=iEL7hLhkCvVU8armCwlGHR5kQn6mmapSGZbIbMhwuPpWMQU9isBSboZzTasQHTcUKO9MmA
 BaZa0wF47EBS/LYjOSdKMQlL5qZxS3hvqKdGU6ghNxfRIQanSfrJjQGL1LxwiFj3CIFzp6
 j4qlteJxFQdLFGiAvTg7jjiywDvN9cg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-12JDK_YCMpWCeW1_Cf28bg-1; Fri, 05 Jun 2020 08:48:07 -0400
X-MC-Unique: 12JDK_YCMpWCeW1_Cf28bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28491107B288;
 Fri,  5 Jun 2020 12:48:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB13A7B609;
 Fri,  5 Jun 2020 12:48:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 64D6011385C2; Fri,  5 Jun 2020 14:48:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 04/11] rules.mak: Add strequal() and startwith() and
 rules
References: <20200605073953.19268-1-philmd@redhat.com>
 <20200605073953.19268-5-philmd@redhat.com>
Date: Fri, 05 Jun 2020 14:48:00 +0200
In-Reply-To: <20200605073953.19268-5-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 5 Jun 2020 09:39:46
 +0200")
Message-ID: <87eeqt3chr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Add a rule to test if two strings are equal,
> and another to test if a string starts with a substring,
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  rules.mak | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/rules.mak b/rules.mak
> index 694865b63e..ccc1c49604 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -191,6 +191,20 @@ ne =3D $(if $(subst $2,,$1)$(subst $1,,$2),y,n)
>  isempty =3D $(if $1,n,y)
>  notempty =3D $(if $1,y,n)
> =20
> +# strequal
> +# Usage: $(call strequal, str1, str2)
> +#
> +# This macro returns a string (TRUE) when @str1 and @str2
> +# are equal, else returns the empty string (FALSE)
> +strequal =3D $(if $(subst $2,,$1)$(subst $1,,$2),,$1)
> +
> +# startwith
> +# Usage: $(call startwith, startstr, fullstr)
> +#
> +# This macro returns a string (TRUE) when @fullstr starts with
> +# @startstr, else returns the empty string (FALSE)
> +startwith =3D $(findstring :$1,:$2)
> +
>  # Generate files with tracetool
>  TRACETOOL=3D$(PYTHON) $(SRC_PATH)/scripts/tracetool.py

Should this be spelled startswith?


