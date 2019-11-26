Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2E1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FE020748
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlhOotyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FE020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZW0N-0002l8-K8
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 03:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iZVyX-00010e-F0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iZVqF-0007Zf-Vc
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:05:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38430
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iZVqE-0007YT-34
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574755496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OocC0c5wslOwiYz6IocVy6ppWzC6vzZESCVP1N/6eU=;
 b=GlhOotyiDTp8RyJkEugAnasluar7CeKCj1oXCemvK6N+bC+M/2rRXZpEFvexBCMn01WY1k
 NP2LzC5HjuiTU3BOPJL6WwzCZeubPPDkt9BJZlhV51NmyrDl2MBUdAPs1KvdmH4h1PuZmQ
 prRlDuub1J2rj5B9D0D/cG43JgqedAY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-WuADmeE_PYKYvQMJWew0ag-1; Tue, 26 Nov 2019 03:04:53 -0500
Received: by mail-wr1-f72.google.com with SMTP id c16so10147828wro.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=GIc9HWNo9Nrssc61hVMLmZQ7BZDrsw8Id82kiJul6y8=;
 b=pEgQvJeN64p7OGMCcP5llUfrNUgAEc1f5odQeIzn9x2wY3I3eniU9yaE95CFQYwuIK
 ngoJHUxZPGABYEGomh61bvBvXB7nNiUHqMX0gtTYiB+/elN/pRyzFhMbTc252Bhzih8N
 ydsDFr4/Zb1wKF+sTYDzXSUucP7PtUM/MyKp8scCeQ5p9bxi+ekJVWkEq4kktCgiNNSu
 yKMK+1nSADtJa1KB/E+fBhh0D5B7VSQuAZYsaVjIaZskQ+hYxXcywvvtYDGvqnNmtu4K
 WZjLXkwvuvqcl/dZazHKVp6HHOp3EfzkCHpNto/1kqqa4BmjCLn+In58fAXyVCazq8Fx
 1NVg==
X-Gm-Message-State: APjAAAUFRBoqJxJBjDhEvivlMgiz7FeYXD1fshptNHcsxfemzI4WWYBu
 W2KrMlOecAh/tA3/EJN6O7vmymsCGSsj6gVCWPByDbVkfQeJRXybc8mvk72/Kx4C4EixEl0XfDM
 d1hONBrJPZ1eIoMA=
X-Received: by 2002:a1c:a906:: with SMTP id s6mr2916951wme.125.1574755492516; 
 Tue, 26 Nov 2019 00:04:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6+q/zUeEXazM52s0ccc4v3Fvvk9BKS1xTAj7HNWyH3atmlg7nMsnCacGSytniIP1oBDrHmA==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr2916924wme.125.1574755492287; 
 Tue, 26 Nov 2019 00:04:52 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6171.dip0.t-ipconnect.de. [91.12.97.113])
 by smtp.gmail.com with ESMTPSA id
 b14sm2135659wmj.18.2019.11.26.00.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 00:04:51 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/2] s390x/cpumodel: Introduce dynamic feature groups
Date: Tue, 26 Nov 2019 09:04:50 +0100
Message-Id: <C829F458-099D-4E95-B835-67F008E60B13@redhat.com>
References: <b062f580-d664-f68c-2364-1f65df6ee265@de.ibm.com>
In-Reply-To: <b062f580-d664-f68c-2364-1f65df6ee265@de.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: WuADmeE_PYKYvQMJWew0ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 26.11.2019 um 08:54 schrieb Christian Borntraeger <borntraeger@de.ibm.=
com>:
>=20
> =EF=BB=BF
>=20
>> On 25.11.19 18:20, David Hildenbrand wrote:
>>=20
>> As soon as dynamic feature groups are used, the CPU model becomes
>> migration-unsafe. Upper layers can expand these models to migration-safe
>> and static variants, allowing them to be migrated.
>=20
> I really dislike that. I am trying to get rid of the unsafe variants (e.g=
. now
> defaulting to host-model instead of host-passthrough). I do not want to g=
ive
> users new ways of hurting themselves.
>=20

Please note that this is just on the bare command line. Libvirt and friends=
 will expand the model and have proper migration in place. What exactly is =
your concern in that regard?

> Unless I misunderstood Eduardo, I think his versioning approach is actual=
ly better
> in regard to migration, no?
> I z terms, you can still say -cpu z13  which is just an alias to z13v1 z1=
3v2 etc.
> Assuming that the version is checked this will be safe.
>=20

It=E2=80=98s even worse AFAIKS. A =E2=80=9E-cpu z13=E2=80=9C would dynamica=
lly map to whatever is best on the host.


