Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D21C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D7020721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMHIqi/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D7020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZBl-0001GJ-Ny
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVZBD-0000qr-2v
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:22:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVZBB-0003lt-HR
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588591351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4QkSkCZhT007oepdnGEGcjmt7Unv98VVYP46zdu1tI=;
 b=BMHIqi/Xzov3LWQ+HCbjiRwv+Q52SDoMy5bFYXCqTVylIFOcMopuwg7brZXkr68ql/WyU6
 4WfKpipGDNUDOfJc19VxK+lzbzRGvHHwJ7HnJvucTcQn+ig5E5sLeuzv0+HlJCGJBvUEnk
 I/SscjxyWG4GxZVjPDnycNW6C0hhw8A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-BknWDE8CMJ-W1Kijb2xoNQ-1; Mon, 04 May 2020 07:22:29 -0400
X-MC-Unique: BknWDE8CMJ-W1Kijb2xoNQ-1
Received: by mail-wr1-f72.google.com with SMTP id f2so10617478wrm.9
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 04:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=3s10PlI48a/YyYMbXCWij3It/RZzI/wKC+nIDSIa9iU=;
 b=Jx9rcGn2gUUBuRqx/TrdkUPCPzYTbG2OOdMkRhM53jU3pYblbCjuDlgXsLWPdTa0Qw
 /GCpJRuC/PX6ADzFBmGeYsiLmn+E1jNfiISP7SVDT4BbhMWPGNn8Z5lp0CBdS42DrdS1
 ZBF3nvhkg3PXjTDnsuegY0jnHYHre+Ki7mo7iqYbZwqWH3E0tZCD73k84d86sO98cRC5
 2AhlBgl0XAW6hP8T3Uo9yo7TmX+O/Ejsz5ieqXkTr6bMT5Lj/+8cnPn+EuHtJZJ1qA++
 S8LMMmyvjVoNBpo6sfPvjvLUnciS/64vhZLz/i8NUHLIMyRBaR6Yc5WEcEU2Ew9vYUqS
 rUSA==
X-Gm-Message-State: AGi0Puby2qkXcDBSgMG0sJ5B1ApPdNzQxksog1omZM8eIxobmNr3eoiC
 Mb1w/F6MQUoQ7aVyikF/uBSD6xr4XxtpghBdk+PV6Z2ieIJ28JszgV5+qgFR1PK26xg8ailpPbj
 MXK3nYeX4yMN4xz8=
X-Received: by 2002:adf:e74a:: with SMTP id c10mr11665615wrn.109.1588591348393; 
 Mon, 04 May 2020 04:22:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHMTc0uMI6AtknV71bOe2B9wQKwa2FydOr5oV2tiRPVEQoo9r0oua48Aah0QeUoDNrBNoY2Q==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr11665591wrn.109.1588591348133; 
 Mon, 04 May 2020 04:22:28 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
 by smtp.gmail.com with ESMTPSA id x23sm12419338wmj.6.2020.05.04.04.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 04:22:27 -0700 (PDT)
Subject: Re: [PATCH 3/4] device-core: use atomic_set on .realized property
To: Stefan Hajnoczi <stefanha@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200416203624.32366-4-mlevitsk@redhat.com>
 <20200504104538.GC354891@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b265d4ee-400e-bb80-cc37-e89c5dab2a8c@redhat.com>
Date: Mon, 4 May 2020 13:22:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200504104538.GC354891@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SkUB8P0FvnuBsr2YQb4Ok9z5epKVOVYvc"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SkUB8P0FvnuBsr2YQb4Ok9z5epKVOVYvc
Content-Type: multipart/mixed; boundary="ZtsKTcY7bzRRVmkISPJIjEkQOiuCpioXb"

--ZtsKTcY7bzRRVmkISPJIjEkQOiuCpioXb
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/05/20 12:45, Stefan Hajnoczi wrote:
>> @@ -983,7 +983,7 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
>>      }
>> =20
>>      assert(local_err =3D=3D NULL);
>> -    dev->realized =3D value;
>> +    atomic_set(&dev->realized, value);
> A memory barrier is probably needed so that the atomic_read() thread
> sees up-to-date dev fields.

Yes, it should be a store-release for the false->true case.  The
true->false case probably doesn't matter as much.

Paolo


--ZtsKTcY7bzRRVmkISPJIjEkQOiuCpioXb--

--SkUB8P0FvnuBsr2YQb4Ok9z5epKVOVYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl6v+vIACgkQv/vSX3jH
roNhpgf7Bez+H8OJtgY7fBicFyQj3laZuRPJBmy26r364YsEl5V7ttdiHaz4xhyz
shBr/3FtETtlcg55oqutSPwm+fv2VHsfjhqvUX+2qO0u+0Mte0TtbileBWAndY47
SNTDhFMy8Te5itf882vrVoWXwPcqHRvRV0KNDtz7ZbOxDK3a0pkWjsefPHQsVznh
/s7MDp/fTEZ7/wisDSwCZ/btMPsbblGZqE6Wv/iIjAzr+aROFwA4Z0DCUHv6KHgU
HV/GnDxJAZ6P80qZUfWXQJT59d4Q9WripUnlll3gT3y8VHuBI9Yeiuc2fSmi78hK
kDcBM3aWaTYOTToQvirMCqXjCN+BtQ==
=6b1n
-----END PGP SIGNATURE-----

--SkUB8P0FvnuBsr2YQb4Ok9z5epKVOVYvc--


