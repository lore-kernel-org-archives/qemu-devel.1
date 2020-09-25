Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23253C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76042208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYamS/Fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76042208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqwA-0003zQ-Hg
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLqk0-00088B-Pb
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLqjy-0000bD-Ft
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:38:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601051913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qj/m6Py3YcUa8xsvOQrw2tIIOm4lhr23K9JS+VvutwQ=;
 b=bYamS/FnuWY1BzPx5AUXjyMs5Mu40isi32Jmu8lODZkICZPpAkzMxd49Dh03q3OtpM074e
 oCvW84/+SM8hMq0pjmotsjAmthqRlyVZixHBlMv1vT1XYIL8kFTtzf+a6rFBvFd/9BCinB
 ZZiVrC4fH7zPluPcnGv8gAZ6DW4g/DY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-QEIQ6aVdPXqMMphIz6mWdQ-1; Fri, 25 Sep 2020 12:38:28 -0400
X-MC-Unique: QEIQ6aVdPXqMMphIz6mWdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5EA464144;
 Fri, 25 Sep 2020 16:38:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EE7B60C15;
 Fri, 25 Sep 2020 16:38:23 +0000 (UTC)
Date: Fri, 25 Sep 2020 12:38:22 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 16/16] qapi/expr.py: Use an expression checker dispatch
 table
Message-ID: <20200925163822.GA402155@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-17-jsnow@redhat.com>
 <20200925011849.GI368253@localhost.localdomain>
 <5a392d78-cf26-7c75-e00e-bf913607c0ac@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5a392d78-cf26-7c75-e00e-bf913607c0ac@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 09:32:05PM -0400, John Snow wrote:
> On 9/24/20 9:18 PM, Cleber Rosa wrote:
> > I have to say the style of this line bothers me, but it's just that,
> > style. So,
>=20
> What don't you like?

It's the sum of the "private" + "global dictionary" + "its item being
called directly".

But don't bother, this is probably the kind of comment that I should
omit, as I don't want you to, say, create a wrapper function around
the dict, partially defeating the purpose of this patch.

- Cleber.

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9uHPsACgkQZX6NM6Xy
CfNRtw/8Dl3flk8eKAATYvp5jb6JNMuwmxVjBB7bA14+3ZLj6qQysS/hfMzjae3h
ChOrv6EzdFUynaqIM6FmXpqhCJW5rifeUoTHeFcwq2/XgdsnbKkK/51MLEYWLLb8
XAHlkfc6v71Kag/9/foVHb7H2FqmnT4eLTKj71kEdjlsv4yxk2AFI96/gJksZzKH
SkXcYAOYmEq2ccrvY2AV2GS+PcE0LnYtVkgMOfp+Fg5cjATIxUuMUxffQWE27zeo
ORasHXgNYBmjC+r1csdvENJBWTIEqOtIPPiwkATiAp1srqM0AjeL16PJ4Xb9NM5E
PgYLAm0ogj5CWE8N4MF3dwThF1C1g2TGSuLBSG+xA0Og81aBzESXOL9iAOHN3E7R
EN5lv+VtVWXWoZ7ESrRa90TAK5DIiNBo2AxUN017RziecXO6Bmk13N+VGXhHHSuR
0oWmxxc1CBDuc0CHLNSQtwdbt979YrfPeYfXvNZ27v8OGsWyVS4O8GmZUKkTNrht
5b3yGFQ4KvVJAtU66dYuFF6bGSErdZkfEGRkF73bP079FKwK/oXDP3C4WSXJv1VF
vihJJzzt3vwlfxUIlM5VA0Xdfbl3T8uv9qsUxSOY7jrM7QWN9BLY7qoxjlA2Jmz+
wvdoNxsDXrZquTLZSkaFFLHwjqiU2sdiUNRpK02+nEaVnSIuwoc=
=TmqR
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--


