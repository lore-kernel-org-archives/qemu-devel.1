Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E837820679
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLCkKvYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E837820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTGQ-0006dl-8I
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jlTFp-00063s-3L
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:17:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33088
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jlTFn-0002vh-Bz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592381822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qX7FRGOLmQPjFthRAzqhwS9iQ8b8Bw8fri0fRI6YG0=;
 b=jLCkKvYEhJhOInWFbV3fynuRQzSlI5vtBNp34N8Sa4op4MlduW3oM7DBox3xoRwnPAy0ZC
 EECQQ8dVSsjju7F4RpBTyqxPDJCTrDTVHn7X0zHBb9dYlyCqGBiBsmR2/JTyFPaWUew3Rl
 S48k/1dz6QfzBzPkvRuos3ZhlJsb524=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-CrXKUfJNOJO5dyHVHenWZg-1; Wed, 17 Jun 2020 04:17:00 -0400
X-MC-Unique: CrXKUfJNOJO5dyHVHenWZg-1
Received: by mail-wm1-f71.google.com with SMTP id j128so555245wmj.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 01:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=RQE3qr+i9KA9NdRERAA4oMJfUAguGYLBBuwjiMeYm80=;
 b=CcUvx024wo2pEV1Q7ulENvg77Csl1QaQA1bP8Fw7nMrmH2haIHJZ/KOLhMN/mu/MCZ
 uzP+DCWmruMowwbvCm+EFprSrslRg4CYRNE2LHmvCssnYZqUnlAgpvMFP7v38ADYuAld
 KTNcx8ylnLTzRiPL7kxEpUuBFP7Z9UB8h6O9fvb4dlQ15nmE32EgC4kf5UoxZIz5eJQr
 kOthZn18oDE9teXV9FmgZTAJk/D3JehTIpvz6qfnmYuk6fdgJAKRdyZNkWxtbwHpoXqy
 6rhsKVFt6teJWx7Sj1pWrGEpUZbHp5ChuNt52inAADMeeH+elHq14DQR/7vkx21GP+BD
 tVWw==
X-Gm-Message-State: AOAM533s1OvOefag5aJnmJTQfg5TTuekOfseAl5SPDA7QkaZmIV+S/D0
 rADQy+suUeLM773cbk6kymtnecWLDuIm5Bxvp5GrTsP4lj3UZzYZ1NB1GrEPef4Ot+LDkMb+8Mi
 /eewNbyL6vzbEhBk=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr7703858wru.124.1592381819219; 
 Wed, 17 Jun 2020 01:16:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTW1TgDieQJ2o+ezSlHjc7JAr6F1u0lNTBzV1a4GsOk09QpX6YyH4rbq9ymSru97L9tihqBg==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr7703831wru.124.1592381818940; 
 Wed, 17 Jun 2020 01:16:58 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:466:71c0:703f:24ee:3c57:e184?
 ([2a01:e0a:466:71c0:703f:24ee:3c57:e184])
 by smtp.gmail.com with ESMTPSA id v7sm5815129wrp.45.2020.06.17.01.16.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jun 2020 01:16:58 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
From: Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
Date: Wed, 17 Jun 2020 10:16:55 +0200
Message-Id: <97D6912A-C840-4723-A32F-7B05FF827EB8@redhat.com>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cdupontd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: pedro.principeza@canonical.com, ehabkost@redhat.com,
 dann.frazier@canonical.com, "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
 qemu-devel@nongnu.org, christian.ehrhardt@canonical.com, dgilbert@redhat.com,
 lersek@redhat.com, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Le 16 Jun 2020 =C3=A0 18:50, Gerd Hoffmann <kraxel@redhat.com> a =C3=A9cr=
it :
>=20
>  Hi,
>=20
>> (a) We could rely in the guest physbits to calculate the PCI64 aperture.
>=20
> I'd love to do that.  Move the 64-bit I/O window as high as possible and
> use -- say -- 25% of the physical address space for it.
>=20
> Problem is we can't.

Is the only reason unreliable guest physbits?

>=20
>> failure. Also, if the users are not setting the physbits in the guest,
>> there must be a default (seems to be 40bit according to my experiments),
>> seems to be a good idea to rely on that.
>=20
> Yes, 40 is the default, and it is used *even if the host supports less
> than that*.  Typical values I've seen for intel hardware are 36 and 39.
> 39 is used even by recent hardware (not the xeons, but check out a
> laptop or a nuc).
>=20
>> If guest physbits is 40, why to have OVMF limiting it to 36, right?
>=20
> Things will explode in case OVMF uses more physbits than the host
> supports (host physbits limit applies to ept too).  In other words: OVMF
> can't trust the guest physbits, so it is conservative to be on the safe
> side.
>=20
> If we can somehow make a *trustable* physbits value available to the
> guest, then yes, we can go that route.  But the guest physbits we have
> today unfortunately don't cut it.

What is the rationale for ever allowing guest physbits > host physbits?

>=20
> take care,
>  Gerd
>=20
>=20


