Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D0AC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4668920838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMrBRlPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4668920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j074A-0004gF-FV
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j06zf-0005J7-Af
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j06zd-0003mg-I1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:00:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58097
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j06zd-0003lI-DO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581094836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t72mgmiL/Qj1q/rEiZeORO8Fy8Obi+8E0bh7zz3LHag=;
 b=fMrBRlPhwmzkjB1moDpC/Nktt7FUDTDD29dhmrWa8jljqYMKcD5IDusHFMvUbkw+TnXuTZ
 Py4zVimtN38BST0QxG2BFtNifg279pO2Lv3Oibhmznhdq+ue5N3E2TFZSuY2Yezx92gYT0
 5/En00y8Bw7F+vLXlGRS+yWa1XulW5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-P-5mC0wPMvizeFsgKcPnuQ-1; Fri, 07 Feb 2020 12:00:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DAB88010F1;
 Fri,  7 Feb 2020 17:00:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF40560BEC;
 Fri,  7 Feb 2020 17:00:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CBC711386A7; Fri,  7 Feb 2020 18:00:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 00/29] Convert QAPI doc comments to generate rST instead
 of texinfo
References: <20200206173040.17337-1-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 18:00:26 +0100
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:11 +0000")
Message-ID: <877e0ynxhx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: P-5mC0wPMvizeFsgKcPnuQ-1
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> This series switches all our QAPI doc comments over from
> texinfo format to rST.
>
> The basic approach is somewhat similar to how we deal with kerneldoc
> and hxtool: we have a custom Sphinx extension which is passed a
> filename which is the json file it should run the QAPI parser over and
> generate documentation for. Unlike 'kerneldoc' but somewhat like
> hxtool, I have chosed to generate documentation by generating a tree
> of docutils nodes, rather than by generating rST source that is then
> fed to the rST parser to generate docutils nodes.  Individual lumps of
> doc comment go to the rST parser, but the structured parts we render
> directly. This makes it easier to get the structure and heading level
> nesting correct.
>
> Rather than trying to exactly handle all the existing comments I have
> opted (as Markus suggested) to tweak them where this seemed more
> sensible than contorting the rST generator to deal with
> weirdnesses. The principal changes are:
>  * whitespace is now significant, and multiline definitions must have
>    their second and subsequent lines indented to match the first line
>  * general rST format markup is permitted, not just the small set of
>    markup the old texinfo generator handled. For most things (notably
>    bulleted and itemized lists) the old format is the same as rST was.
>  * Specific things that might trip people up:
>    - instead of *bold* and _italic_ rST has **bold** and *italic*

Actually, qapi-code-gen.txt documents and doc.py implements *strong* and
_emphasis_.  Texinfo commonly renders them as bold and italic when the
output format supports that.  rST has **strong** and *emphasis*.

Your series adjusts emphasis markup for rST [PATCH 18].  Since it
doesn't touch strong markup, strong silently becomes emphasis.  I guess
that's okay, perhaps even an improvement, but double-checking the actual
uses of this markup wouldn't hurt.

>    - lists need a preceding and following blank line
>    - a lone literal '*' will need to be backslash-escaped to
>      avoid a rST syntax error
>  * the old leading '|' for example (literal text) blocks is replaced
>    by the standard rST '::' literal block.
>  * headings and subheadings must now be in a freeform documentation
>    comment of their own

Can we simply use rST instead?  See my review of PATCH 18.

>  * we support arbitrary levels of sub- and sub-sub-heading, not just a
>    main and sub-heading like the old texinfo generator
>  * as a special case, @foo is retained and is equivalent to ``foo``

Apart from these remarks, your changes look sensible to me right now.  I
hope they'll still look that way when I'm done reviewing :)

[...]


