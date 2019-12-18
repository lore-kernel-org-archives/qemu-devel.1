Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4410C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6196D206CB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAEXvkDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6196D206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55811 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihbQp-00076S-Jc
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 10:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ihbQ5-0006Ek-G7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ihbQ4-0008Tc-A3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:39:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ihbQ4-0008Ls-2k
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576683563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYvESkaKA0lzQEATnRzI9E+uExMvyMcc8EERB3dQoZY=;
 b=MAEXvkDLVNF1tBLOMzyQMAkpGvgaO8c4Fr7o0akRzxvz/7BvUUBZSMjg6KB1oOC8HNtyoD
 ///FhkEniNSFIssylCpKJfwXZf0BPs8yi2S6bR6s5G6oVXhQDf74D1Avx9EfSdqNzMKxdM
 ufSQ05fT+JfQRgkrTonTRSkkd++eveM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-FHnoSNlQNJKfpueJzS25nA-1; Wed, 18 Dec 2019 10:39:21 -0500
X-MC-Unique: FHnoSNlQNJKfpueJzS25nA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FB0D90E7EB;
 Wed, 18 Dec 2019 15:39:20 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98B9777EDB;
 Wed, 18 Dec 2019 15:39:18 +0000 (UTC)
References: <20191128104129.250206-1-slp@redhat.com>
 <20191128104129.250206-5-slp@redhat.com>
 <20191209160601.GB6715@linux.fritz.box>
 <7ea304ab-0a4b-8c0a-ae9f-2f6501198840@redhat.com>
 <20191216112914.GB6610@linux.fritz.box>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 4/4] blockdev: honor bdrv_try_set_aio_context() context
 requirements
In-reply-to: <20191216112914.GB6610@linux.fritz.box>
Date: Wed, 18 Dec 2019 16:39:15 +0100
Message-ID: <877e2tzlr0.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Kevin Wolf <kwolf@redhat.com> writes:

> Am 13.12.2019 um 21:59 hat Eric Blake geschrieben:
>> On 12/9/19 10:06 AM, Kevin Wolf wrote:
>> > Am 28.11.2019 um 11:41 hat Sergio Lopez geschrieben:
>> > > bdrv_try_set_aio_context() requires that the old context is held, an=
d
>> > > the new context is not held. Fix all the occurrences where it's not
>> > > done this way.
>> > >=20
>> > > Suggested-by: Max Reitz <mreitz@redhat.com>
>> > > Signed-off-by: Sergio Lopez <slp@redhat.com>
>> > > ---
>>=20
>> > Or in fact, I think you need to hold the AioContext of a bs to
>> > bdrv_unref() it, so maybe 'goto out' is right, but you need to unref
>> > target_bs while you still hold old_context.
>>=20
>> I suspect https://bugzilla.redhat.com/show_bug.cgi?id=3D1779036 is also =
a
>> symptom of this.  The v5 patch did not fix this simple test case:
>
> Speaking of a test case... I think this series should probably add
> something to iotests.

Okay, I'll try to add one.

Thanks,
Sergio.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl36SCMACgkQ9GknjS8M
AjUaSg/+Myd4f8Ld2xpo+p3fdzYrHLGRWKncv2BgtgUl4STUQFzmCxA9N4PiDBwh
eCpIWJz21SYeBnCdmqFUb7qt/1iOMygDlQMrMPOwcaZKWNcIAHnbxlBpirUDWGIE
ggiPvu0XMKnaPjp9IXtp7p96uqXZ7Z9hHJ6i5zgifOLqdWGwSA3FgQovTkGk2Oau
Rr6dHS0qgP5iqqUoFkeeDWVpThBnt1p/Qc4daTYhLnlSVnVFyRXbLjcRnkE5Yq4o
eaBiSA/fTbS/S7ItPHV1dZw87u/vPSECfRXHv8BZc8bmdWV26F6oB6mnUFfTbgvr
uw6tZ1f+t0+BKW4H5M5VGzx1OxHxMDYJsxQSxC1yQ1tof26A/KV2MP+ZUsbMaag3
G8rA/Q2nYLTS+rHNDXvQCLNwfJ/IxmP+2cx5j6P/+0ZwVLoSurHJHf1swycUleF0
UaL+6i7cF5MQvBX7vhzrJ1xZtt4KQd85lqQZWyIo+fEyeNmwDnjtMf1IfpHHTv/Q
CuW66qe/72gIHpIz6/9FtBu6th7I/+8E5ehXxYS2PzGHmX+S7nzTizCEpj9sR8TO
ef/B0V98rXvIgpT9mZoQTTvi7s94KN+2qMO56O6ZMSWYYPXc37Rul0N1ncIvcQse
WPkAoYKVbtYNECFboz7/uoUZHS1qPrhOP0KLRBB5Q3OB32I8Zyw=
=X97p
-----END PGP SIGNATURE-----
--=-=-=--


