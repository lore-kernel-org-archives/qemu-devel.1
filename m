Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4D1C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4418220730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpKM/T4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4418220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0jz-0003zn-DV
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iz0j8-0002DA-AR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iz0j4-0004nv-Uz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47349
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iz0j4-0004lL-Qm
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uePp18mCw53bhnoaLgkz1zDxvQx0lc9VQi3iSaCavrM=;
 b=SpKM/T4fku6ykoLWN4lnfOt/hp1VA90axLmgBH8EuBRR5/e/HMX3cERjtL8loqUUVYmQ0F
 baVm8eATF8MPFhvKkhTVPa45LA8OGP8i9+9Qfm3wSGmzQC177YK1SEphX4qEH2MewpvlJp
 XEItuV45C+8C1Z8uN7MwOhH24Wigv0M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-_hf5l7HpMpSxetu6ZaeJ3g-1; Tue, 04 Feb 2020 11:06:42 -0500
Received: by mail-wr1-f72.google.com with SMTP id f10so10563595wro.14
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uO2tNLNQjvNTQibFbidqKHre5h6Xo6FO5reYTPg4ja0=;
 b=bcxRmvv9PQEOoozWjJEseRK54QP012BUjwpiYbpMzgFItPJVJfhW4q1cRfesVXdx/7
 PXsYmUA/BHr9uXIdtfBknYwZD7wpLRPw4WL22Dx0+DIi1xFipGKUquvQ5uz4+StvGrJB
 uE388MmQyIsYikwiX2NOkCKidHf5ogp+m664UzhQpRA9dLVMsxL3SucRm3ntkGs29tot
 fTZt6+V/Bjp3gcNnsLYTG61ol+IktWEfGQPkdlbc7W33KMhuwuWu7Hkw1Qvzo7+OwHTg
 LVayZATDydgODQTHUBnTRNvR5KUUA5uQoi12Lug9CZH3o7yTlBmJwn0gC/NpLFjAJOQt
 Rd2w==
X-Gm-Message-State: APjAAAXKpG1qZa1Y4fn4wt3PSbuFW7aVCZ/HSnoASGlYHgK+Nwr3S7Qh
 GccxalEWPSo7FW1dZ3B2kuf2s6K16pwdi916vV3cHcfXbuccGuilp/YnnBXXalX+HoMsCtusKY9
 yBnpr89awuwtN8xk=
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr12124642wru.391.1580832400684; 
 Tue, 04 Feb 2020 08:06:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsqxSqJ5f4FP8ZEGpsr6vbdyW/x58Gmx4gi3aOH8PTYDIlX3/+a6xhr+yAIln1S5k24i73Mg==
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr12124615wru.391.1580832400442; 
 Tue, 04 Feb 2020 08:06:40 -0800 (PST)
Received: from [192.168.178.40] ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id x7sm30660688wrq.41.2020.02.04.08.06.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 08:06:38 -0800 (PST)
Subject: Re: [PATCH v2 00/12] python: Explicit usage of Python 3
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200130163232.10446-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20cac786-0985-2b20-fe97-a99d9f1d2401@redhat.com>
Date: Tue, 4 Feb 2020 17:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200130163232.10446-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: _hf5l7HpMpSxetu6ZaeJ3g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/20 17:32, Philippe Mathieu-Daud=C3=A9 wrote:
> Hello,
>=20
> These are mechanical sed patches used to convert the
> code base to Python 3, as suggested on this thread:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675024.html
>=20
> Since v1:
> - new checkpatch.pl patch
> - addressed Kevin and Vladimir review comments
> - added R-b/A-b tags

Queued, thanks.

Paolo


