Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8418CC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28504206F8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqPpuiK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28504206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJgNW-0000hM-AC
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jJgMJ-0007wf-0i
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jJgMI-0008MR-2h
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:36:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35355
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jJgMH-0008LA-Uz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585759013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Im73kI7kPbUsUdGTNn7/Q62xkcO7MaqecscvF5H6F3Y=;
 b=fqPpuiK89ia5Clafdin8S9pVCMULbQP/Sfh2r60YhwUoEJaDSukhr0yH9XfEd+n2vi6L9v
 Y96WER+l35ujVDhWwlioel2brw9p0jhAU6F8BOqr2F602+TxGs99fSLXwQwl73TsLIf0JR
 EHbUL+qNTXD/Yl3ikZxmrEcGts6iYOY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-Y5N5r5tOP46QIBRYO9pJhQ-1; Wed, 01 Apr 2020 12:36:49 -0400
X-MC-Unique: Y5N5r5tOP46QIBRYO9pJhQ-1
Received: by mail-wr1-f70.google.com with SMTP id w12so80950wrl.23
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 09:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=Im73kI7kPbUsUdGTNn7/Q62xkcO7MaqecscvF5H6F3Y=;
 b=mTjt+iKfwKGxsxjjGZpu4pRkDrxxOqpmyVoVfipiFg6DZxs6eATh5xOshswGPxT4UN
 IM/22JM/eZ8M2Sf8JauIq3krvbDZlIX2aqeUu5525RYt/wBVqdyKa0Q/4M+qW+DCymI0
 2hQmArRaFUeXCpfgNY4R0xOK24juZUI44dwUO55IK1oYEwNGjR4J6OowCHQoS2QIhVkE
 0pgAAN0fNMXb/obhsgGAz5vzGmS0dg5INwE0sjaC5BrZwPMW87QRnJd+as6yxYju+cTa
 BBVU9S3s8FMTDXMY9/JQyOqKK51FE5RiRNkbUAHSsD0+Bq74kwr6/aKiocx6LCx41h2v
 qaFw==
X-Gm-Message-State: AGi0PuYXyOR8BJ7wD/l5mT4kN0FDw7jIqA4QuUKJ+X3ha8HUz9TVQng4
 5VArPoK5t8quioa9/5GD90mT9BI9/3Y62bwOD5Q/xZUE8ogc6AKrbQBA68bZB/zzFSLywYsUGe3
 dh+2a3cIEPglNkKM=
X-Received: by 2002:a7b:c144:: with SMTP id z4mr2716088wmi.128.1585759008150; 
 Wed, 01 Apr 2020 09:36:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKGMynmKcsozJ5m4y78UJpiUnXKYFHaZ+UigiS9h7RXJEEGo5i9cGOzPz/tdbjeNjsR42Z8QQ==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr2716071wmi.128.1585759007909; 
 Wed, 01 Apr 2020 09:36:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1868:42dd:216c:2c09?
 ([2001:b07:6468:f312:1868:42dd:216c:2c09])
 by smtp.gmail.com with ESMTPSA id t12sm3717887wrm.0.2020.04.01.09.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2020 09:36:47 -0700 (PDT)
Subject: Re: Question about scsi device hotplug (e.g scsi-hd)
To: Stefan Hajnoczi <stefanha@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>
References: <7302c0b9f2327b9b61b4adb465f166e339e46ac1.camel@redhat.com>
 <20200401150944.GA4500@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4bc42bf2-939f-f6c4-ea45-0d08eb42fc2b@redhat.com>
Date: Wed, 1 Apr 2020 18:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401150944.GA4500@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UcfgEs0VPjkQkY8BBKbA1OjyVC8mwByVM"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UcfgEs0VPjkQkY8BBKbA1OjyVC8mwByVM
Content-Type: multipart/mixed; boundary="YwSUJQaqmEjFH8dUoH8jlhMDWoqxctMd7"

--YwSUJQaqmEjFH8dUoH8jlhMDWoqxctMd7
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01/04/20 17:09, Stefan Hajnoczi wrote:
>> What do you think about it?
>
> Maybe aio_disable_external() is needed to postpone device emulation
> until after realize has finished?
>=20
> Virtqueue kick ioeventfds are marked "external" and won't be processed
> while external events are disabled.  See also
> virtio_queue_aio_set_host_notifier_handler() ->
> aio_set_event_notifier().

Yes, I think Stefan is right.

Paolo


--YwSUJQaqmEjFH8dUoH8jlhMDWoqxctMd7--

--UcfgEs0VPjkQkY8BBKbA1OjyVC8mwByVM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl6Ewx4ACgkQv/vSX3jH
roM8pAgAm1tShPusIagqcjgw8/a2r7G6QgCNvhkXoLskJyI1Q8R78axIvmZEMPcZ
xwI1lP7RwC8MiPtIwWGy1E1IvSrEDphMmYzkIH6khKss/cSByZmG1JufbW2D3RfI
+V6NOB6sJLnzKXXspg/ZMYKDhQnhYEDz4PDAVzT+CVmcBBGityprX7mInmPrRHxd
kl73z+VB8coz7Gbu4KzdC22pXyLvSNDcCuu2uGrLL5pJrnYnBRWXgsVmRfIXBT+u
WDyb3fFlznEFNDclW86vG69wEsYxLW4PVH2+VJaM+15ovWoIUHZbZf8s5yCL43lR
IGZE7+vbrVcDTYEwthsqgtyICKO+nA==
=8REo
-----END PGP SIGNATURE-----

--UcfgEs0VPjkQkY8BBKbA1OjyVC8mwByVM--


