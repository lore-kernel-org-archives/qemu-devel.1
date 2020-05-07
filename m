Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC9C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B5B208D6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3OcdVVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B5B208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWltu-0001mq-5e
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jWltA-0000tk-Fz
 for qemu-devel@nongnu.org; Thu, 07 May 2020 15:08:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54059
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jWlt8-0003tf-6v
 for qemu-devel@nongnu.org; Thu, 07 May 2020 15:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588878532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKUfXf6svS03ruepvUhRcAo5bD+YpA1evE4D6OGUmJc=;
 b=G3OcdVVyHcC/W/hrE4aUq6Uh1nsuBc4BGVuC9mbJj2a29o9MtKqjF2Lg4jDipuFhHSXw1F
 9Ta6/HC86T+5QQam9ASK3jLIsYoKdnQa94ax/bI1gVEW85aZEiIsRorpLDX88a6hwbo8uX
 xGi03duMG1BeYhXFXuwyRavvCdVq8cg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-WYAH5WU4NdaW6gvbnp2ugg-1; Thu, 07 May 2020 15:08:51 -0400
X-MC-Unique: WYAH5WU4NdaW6gvbnp2ugg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 397C580183C;
 Thu,  7 May 2020 19:08:50 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF4C25D9CA;
 Thu,  7 May 2020 19:08:47 +0000 (UTC)
Message-ID: <e0d49e617fb3b78d7701a747d0250fd4ec392d07.camel@redhat.com>
Subject: Re: [PATCH v5 01/14] qcrypto/core: add generic infrastructure for
 crypto options amendment
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 07 May 2020 22:08:46 +0300
In-Reply-To: <08257b8a-ed70-1a6d-ffb9-20441b5af91f@redhat.com>
References: <20200507125414.2151-1-mlevitsk@redhat.com>
 <20200507125414.2151-2-mlevitsk@redhat.com>
 <08257b8a-ed70-1a6d-ffb9-20441b5af91f@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-05-07 at 11:09 -0500, Eric Blake wrote:
> On 5/7/20 7:54 AM, Maxim Levitsky wrote:
> > This will be used first to implement luks keyslot management.
> >=20
> > block_crypto_amend_opts_init will be used to convert
> > qemu-img cmdline to QCryptoBlockAmendOptions
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> > +++ b/qapi/crypto.json
> > @@ -309,3 +309,19 @@
> >     'base': 'QCryptoBlockInfoBase',
> >     'discriminator': 'format',
> >     'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> > +
> > +
> > +
> > +##
> > +# @QCryptoBlockAmendOptions:
> > +#
> > +# The options that are available for all encryption formats
> > +# when amending encryption settings
> > +#
> > +# Since: 5.0
>=20
> Looks like our mail crossed, my v4 review landed after you sent v5.=20
> We'll still have to scrub this series for s/5.0/5.1/

Yea, I totally forgot about this :-(
I''l do this now.

Best regards,
=09Maxim Levitsky

>=20
> > +##
> > +{ 'union': 'QCryptoBlockAmendOptions',
> > +  'base': 'QCryptoBlockOptionsBase',
> > +  'discriminator': 'format',
> > +  'data': {
> > +            } }
> >=20
>=20
>=20



