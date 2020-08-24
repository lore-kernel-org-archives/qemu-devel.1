Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FB3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2DB2078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAUXBDlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2DB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kACPH-0004pV-B7
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 09:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kACNs-00031T-2Y
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:19:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kACNp-0001XL-8a
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598275172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cwcmf6RGARuQm6Q+F6dx49uJHb/LtQLsuGaB/JL+iWE=;
 b=YAUXBDlv2CvjH5R7ETEHqbXbb64e7mdufRvDPwvoUxAgl6BSTQlRmz74p1KoBv8+B4zlmb
 RuYtY7Wqu4Y14bb3mjxqvbS3RpDIIDhZ8gw9At3vCc35iL4BginOobPjZ0e1RP3EiZgW/Q
 LUC6+CQpiU//lDFvn2utt4bNqp8aWYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-vFMfjiLMO-a1CGIpz7YCBg-1; Mon, 24 Aug 2020 09:19:30 -0400
X-MC-Unique: vFMfjiLMO-a1CGIpz7YCBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 542321009441;
 Mon, 24 Aug 2020 13:19:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 488471C4;
 Mon, 24 Aug 2020 13:19:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C87DD1138648; Mon, 24 Aug 2020 15:19:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Edmondson <david.edmondson@oracle.com>
Subject: Re: [RFC PATCH 5/9] block/curl: Allow the blocksize to be specified
 by the user
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
 <20200818110845.3825105-6-david.edmondson@oracle.com>
Date: Mon, 24 Aug 2020 15:19:24 +0200
In-Reply-To: <20200818110845.3825105-6-david.edmondson@oracle.com> (David
 Edmondson's message of "Tue, 18 Aug 2020 12:08:41 +0100")
Message-ID: <87a6ykqizn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Edmondson <david.edmondson@oracle.com> writes:

> Rather than a fixed 256kB blocksize, allow the user to specify the
> size used. It must be a non-zero power of two, defaulting to 256kB.

Nitpick: any power of two is non-zero.  Scratch "non-zero".

> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
[...]
> diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
> index bc38b9df38..ee504ee41a 100644
> --- a/docs/system/device-url-syntax.rst.inc
> +++ b/docs/system/device-url-syntax.rst.inc
> @@ -194,6 +194,13 @@ These are specified using a special URL syntax.
>        Add an offset, in bytes, to all range requests sent to the
>        remote server.
>  
> +   ``blocksize``
> +      The size of all IO requests sent to the remote server. This
> +      value may optionally have the suffix 'T', 'G', 'M', 'K', 'k' or
> +      'b'. If it does not have a suffix, it will be assumed to be in
> +      bytes. The value must be a non-zero power of two.  It defaults
> +      to 256kB.
> +
>     Note that when passing options to qemu explicitly, ``driver`` is the
>     value of <protocol>.
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d6f5e91cc3..cd16197e1e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3764,10 +3764,14 @@
>  # @proxy-password-secret: ID of a QCryptoSecret object providing a password
>  #                         for proxy authentication (defaults to no password)
>  #
> +# @blocksize: Size of all IO requests sent to the remote server; must
> +#             be a non-zero power of two (defaults to 1 256kB)

Scratch "non-zero".

"(defaults to 1 256kB)" confuses me.  Do you mean "(defaults to 256kB)"?

Please add "(since 5.2)".

> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsCurlBase',
>    'data': { 'url': 'str',
> +            '*blocksize': 'int',

Should we use 'size' rather than 'int'?

>              '*timeout': 'int',
>              '*username': 'str',
>              '*password-secret': 'str',


