Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB42AC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702102311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLWdGIEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702102311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTxO-0005GI-8H
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLTfI-0007Uz-I5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLTfF-00022I-62
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAMK/dB8jZthQoTWM/mw6JbrxdBvg45iuh/fuNz1PYI=;
 b=HLWdGIEl+j24M3VntThozK+D8E5zaFV9aY6ml30QYvlnUHWghuPaFkjjW+A34vSWW6ZUQW
 anhcZwc4wd75r0LmNwEGIp7FefCECfs1vLbUlAHDRBj5SSKlqObVZSl5m7LbPTH8pipy66
 WMUuM7+eOCvQ5U24owJoUjX6vwmdsO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-lHjE8xA4M3Gv9c0_5ZQGSw-1; Thu, 24 Sep 2020 12:00:04 -0400
X-MC-Unique: lHjE8xA4M3Gv9c0_5ZQGSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 884981021209;
 Thu, 24 Sep 2020 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8FBA55771;
 Thu, 24 Sep 2020 16:00:01 +0000 (UTC)
Date: Thu, 24 Sep 2020 11:59:59 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 28/38] qapi/gen.py: update write() to be more idiomatic
Message-ID: <20200924155959.GC191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-29-jsnow@redhat.com>
 <20200923152624.GO3312949@habkost.net>
 <c0b8ed9e-c66a-a6fa-43e1-c3c61581d928@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c0b8ed9e-c66a-a6fa-43e1-c3c61581d928@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IdQYvU5iz1n5pUC3"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IdQYvU5iz1n5pUC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 02:37:27PM -0400, John Snow wrote:
> On 9/23/20 11:26 AM, Eduardo Habkost wrote:
> > On Tue, Sep 22, 2020 at 05:00:51PM -0400, John Snow wrote:
> > > Make the file handling here just a tiny bit more idiomatic.
> > > (I realize this is heavily subjective.)
> > >=20
> > > Use exist_ok=3DTrue for os.makedirs and remove the exception,
> > > use fdopen() to wrap the file descriptor in a File-like object,
> > > and use a context manager for managing the file pointer.
> > >=20
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> >=20
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >=20
> > I really miss a comment below explaining why we use
> > open(os.open(pathname, ...), ...) instead of open(pathname, ...).
> >=20
>=20
> Not known to me. It was introduced in 907b846653 as part of an effort to
> reduce rebuild times. Maybe this avoids a modification time change if the
> file already exists?
>=20
> Markus?

AFACIT the change on 907b846653 is effective because of the "is new
text different from old text?" conditional.  I can not see how the
separate/duplicate open/fdopen would contribute to that.

But, let's hear from Markus.

- Cleber.

--IdQYvU5iz1n5pUC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9swn0ACgkQZX6NM6Xy
CfPHeQ//VDqVs1/tGbNS6xgRfNFBSXp85lh3WadXpt0BSeoDpn7vHW+7aU0eY7jA
oJQQ0eAIQ38cP+3bwUNO9BDbNCrZnc7Ldw/1ndBiMvjrpp6r3AgYp3XUXZeyeppl
8kcY5FuM92K9br1JtwPukoLuWgegCje130dAY2z3Qx2ea3MVmYc5mPWn6AjvRQFQ
La3w8f9PptiC4VnuP+zPMMyE5NY6qbM3pahI7dpXX8JVCYOskK9NnhNTDdtmEixw
6nbIVClEJ9G6cs5qNEFf/yXt6YBARL0Mo3UpYFONtr7pWmpFVfBb1p7syVhBvMX7
pQ5lrUQweHWPLcv0Ig5Bm8V/S8ZNiyfD8VrbNdfgjWzkD8oLBd/EyiexlgkvAB+a
CqjQBV8gFp90U8ht7gtomG9yzPUcvJOqJcHiUrrej56t6H77ekh2RUAf/N4f6h2Z
Ys0P7HHsx5coDcmxdY/WKB8R1CicaURsVZLMsmJURIYRAvNcaSxivzStAMumvWUU
lkZgVqRdkKz/Z7koWUe8tGxvWiWf0oRHvqBVzv0scO2PENn5579fu78zoHdPddXE
M5xO9p65TBK6+4+PHIO44FxlPvD78U39yiLwN0W8sguxWUZpqtQL5BR2CeHoHRmg
S6dZ96Bn1gNFNVOMTL2JksAF7aU/+oiP53QBgfmqc+vCFhFCZng=
=53aw
-----END PGP SIGNATURE-----

--IdQYvU5iz1n5pUC3--


