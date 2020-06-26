Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00204C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30C2207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkCRZQ+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30C2207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonMi-0003Zl-2A
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonLm-00034B-On
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:20:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonLj-0000kX-FD
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593174053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXrglhxYL3VNylM3JqLb8n1vwQVKVwBOI/+lpLYszJQ=;
 b=YkCRZQ+Qm3rfq7RpWFm1MoIge/15iJV3eGuB4H1ldRhitlFecwpNkH1wtJPT7RIu6O1wlf
 zCWac0kjbUnQqL7ggfMGTJb0xHMMac3zMcn5zAFbn6I9C1HtbqDZVoAzOhjtfh9MD5oyAU
 ZzzKeR1EKMOMokOIZGh6Q9ntXz+5gKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-J-EdjZyuM2uPp4hwtFqrqA-1; Fri, 26 Jun 2020 08:20:51 -0400
X-MC-Unique: J-EdjZyuM2uPp4hwtFqrqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC8B9EC1A0;
 Fri, 26 Jun 2020 12:20:50 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4070479339;
 Fri, 26 Jun 2020 12:20:50 +0000 (UTC)
Date: Fri, 26 Jun 2020 13:20:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 05/17] block/nvme: Replace qemu_try_blockalign0 by
 qemu_try_blockalign/memset
Message-ID: <20200626122048.GL281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-6-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-6-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:26PM +0200, Philippe Mathieu-Daud=E9 wrote:
> In the next commit we'll get ride of qemu_try_blockalign().

s/ride/rid/

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl716CAACgkQnKSrs4Gr
c8hOTQf/R8bYqdT0kjnIZLcjZZYw19FiwVsFPKN6xMH4h4io//y/kcC7d4f+DKUH
ZwbY/55fAcWSH8yr96QTPig+ZNNvvWM1UbDt8OHl7mvNJeYl9Rrd9bOrrvV8b+uh
w5lQXVT1E5JPbijHIog7n45cSfTlCHFneoH/6001o+Gjizdm1M8sXKbcGeSPpsma
kOCrDd3yJtkjpcT/Hd43Kn1l8e477Hk/z97lMA0RSQffTrWFl9QXOWd00nGMG1Ct
kLkBqchztrQeX+wdmAO/AUgMGGBJpc0CXIpo2dctlA3CSr1dJm9PKYT7jiGwWHH+
SeWOvz3aC0zuF6owZRzwt2E7Q1KdaA==
=Uh1n
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--


