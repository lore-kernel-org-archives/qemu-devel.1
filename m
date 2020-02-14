Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6255C3B1B9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2BD2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYXcbPhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2BD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fid-0004Br-Ug
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2fgM-00009X-Bt
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2fgL-0002I3-Cu
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:27:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2fgL-0002Hq-8b
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581704836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kvGx6AZiIIN6mdJ1tTnuo5Mfbn7yLrfD77aEC0rHt0=;
 b=OYXcbPhr0c3wc/G9KHQqwnmb2jPMTFdwawopwelZ3FO1DO0p9lzwjjUgSKjmThRE1EqJLj
 fYdfhXfRnxfNTPtB6edG6m7HSwnfksFPHOt63AQ0ZJymxtOJ2j400JdNHY5lS4/PQ7SCHU
 Lm/RNyjWBDMxqJwOYj/9wNfskwsUNZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-VJK-lqCKPkaCCdSuY3wIjw-1; Fri, 14 Feb 2020 13:27:14 -0500
Received: by mail-wm1-f70.google.com with SMTP id f207so4327596wme.6
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rQf8ZEx16zsohGMPxk+UJc7uxZahmMKptFTQ0vsKCY0=;
 b=nSoDPNHEPclHGi30GocOfjNMoqRV6O/G2lpzc4NP/HVbghbVDojr+A/hv8v6s3Ptoe
 ObIwUkNgSjR0iKyVtBrZC+GwNbKWrYdAif706OzTtJSGUE/8RoikcXkE42qe5tIr9t9E
 Z5ijvedzFHGuNvLtZm5v+xSRBThER/a+fc3m/mUgtm/mLoAKrbDBOyzvOQMoRXu8xszf
 WeyMJCovfRlWD6Qlxpu1ocwRmD1F8lg8ljfYSR3FQgrnHBZhWx6RhsPgV/wV+jidhQJY
 fSLrgwlWLWJp33Hq90LIYm+a60eOOs8LMp2cRoN2cbqwtjuuVNbJ+/SS03nsnayruWqS
 P9KQ==
X-Gm-Message-State: APjAAAUoIHAMdmhCqIvLKVapiwROf/w1Sl9G7H2r84PVUsUsLOkQ7V6C
 skPJcvTim8ZoFX3hO0nF3e6NC0QFkZzlVV9CiCC3WKfXjaM4S7vprfz066KEWSCP/EKDuXOFhN4
 mDHksGrpraXWvrbc=
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr5461206wrs.92.1581704833128;
 Fri, 14 Feb 2020 10:27:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqze/eHUo+mZrokNolpukCvcW2TYD3GcajPvULuqDfvA+UN2pBlfTNwJzTLkU2ri/Vhfs/pHKg==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr5461195wrs.92.1581704832916;
 Fri, 14 Feb 2020 10:27:12 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id j5sm8325497wrw.24.2020.02.14.10.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 10:27:12 -0800 (PST)
Subject: Re: [PATCH v1 2/4] Acceptance test: EXEC migration
To: Oksana Vohchana <ovoshcha@redhat.com>, qemu-devel@nongnu.org
References: <20200214145235.4378-1-ovoshcha@redhat.com>
 <20200214145235.4378-3-ovoshcha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <545474c0-1b28-e830-2601-76a8cbb604b4@redhat.com>
Date: Fri, 14 Feb 2020 19:27:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214145235.4378-3-ovoshcha@redhat.com>
Content-Language: en-US
X-MC-Unique: VJK-lqCKPkaCCdSuY3wIjw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 3:52 PM, Oksana Vohchana wrote:
> Improves EXEC migration to run whole test stage
>=20
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>

Fixes: 2e768cb682bf

> ---
>   tests/acceptance/migration.py | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index e4c39b85a1..8209dcf71d 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -75,3 +75,5 @@ class Migration(Test):
>           """
>           free_port =3D self._get_free_port()
>           dest_uri =3D 'exec:nc -l localhost %u' % free_port
> +        src_uri =3D 'exec:nc localhost %u' % free_port
> +        self.do_migrate(dest_uri, src_uri)
>=20

I was very surprised because commit 2e768cb682bf is not the content I=20
reviewed. Apparently what happened here is you sent 2 different series=20
with the same subject... I got confused while applying I selected the=20
incorrect id:

$ pwclient list 'Acceptance test: provides to use different transport=20
for migration'
ID      State        Name
--      -----        ----
11348377 New          Acceptance test: provides to use different=20
transport for migration
11348719 New          Acceptance test: provides to use different=20
transport for migration
11355797 New          [v2] Acceptance test: provides to use different=20
transport for migration
11358447 New          [v2,REPOST] Acceptance test: provides to use=20
different transport for migration
11362397 New          [v3,1/2] Acceptance test: provides to use=20
different transport for migration
11362399 New          [v3,2/2] Acceptance test: provides to use=20
different transport for migration
11362479 New          [v3,1/2] Acceptance test: provides to use=20
different transport for migration
11362485 New          [v3,2/2] Acceptance test: provides to use=20
different transport for migration

I am sorry I missed that.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


