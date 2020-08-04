Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19311C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF7121744
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVLdi1y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF7121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2yjf-0004E1-3w
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2yin-0003Ql-SA
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:19:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38252
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2yim-0005WW-AS
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596554359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=aC+I3FdCEEo98QKMWZaYXrwwNn9gBWONBSHaFVs+1YM=;
 b=AVLdi1y3+RhRspxwwqmPmKpNN+46tx8UepxKmHyv0krdGEnMozvkmYhwxiQrdril/zMoFm
 YwxIx1ZrDbVRg9eJ8P4mHTiqd/xTUcKEWjPx5PA+MBiX2RPllijldKLZgQ9wEU4KAEcFNB
 9GulOradV1uM7JW3xaAEr/xeWmhcLTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-G6DifntEMBm2JSSSyYrxzg-1; Tue, 04 Aug 2020 11:19:16 -0400
X-MC-Unique: G6DifntEMBm2JSSSyYrxzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1477800473;
 Tue,  4 Aug 2020 15:19:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-162.ams2.redhat.com [10.36.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 017D47B906;
 Tue,  4 Aug 2020 15:19:11 +0000 (UTC)
Subject: Re: [PATCH for-5.2 0/6] Continue booting in case the first device is
 not bootable
To: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20200728183734.7838-1-thuth@redhat.com>
 <8875c71e-4203-2342-2460-29e2079c8a51@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <17bf61e4-3358-9293-9e3f-30582fcc9737@redhat.com>
Date: Tue, 4 Aug 2020 17:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8875c71e-4203-2342-2460-29e2079c8a51@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GSbDIPHRnN143TA6yU0gOQLV0zcLzqhhS"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GSbDIPHRnN143TA6yU0gOQLV0zcLzqhhS
Content-Type: multipart/mixed; boundary="EGK7XhKcV2u2L2pXWeHJqpKy8Dsvea8I1";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <17bf61e4-3358-9293-9e3f-30582fcc9737@redhat.com>
Subject: Re: [PATCH for-5.2 0/6] Continue booting in case the first device is
 not bootable
References: <20200728183734.7838-1-thuth@redhat.com>
 <8875c71e-4203-2342-2460-29e2079c8a51@linux.ibm.com>
In-Reply-To: <8875c71e-4203-2342-2460-29e2079c8a51@linux.ibm.com>

--EGK7XhKcV2u2L2pXWeHJqpKy8Dsvea8I1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/08/2020 16.49, Janosch Frank wrote:
> On 7/28/20 8:37 PM, Thomas Huth wrote:
>> If the user did not specify a "bootindex" property, the s390-ccw bios
>> tries to find a bootable device on its own. Unfortunately, it alwasy
>> stops at the very first device that it can find, no matter whether it's
>> bootable or not. That causes some weird behavior, for example while
>>
>>  qemu-system-s390x -hda bootable.qcow2
>>
>> boots perfectly fine, the bios refuses to work if you just specify
>> a virtio-scsi controller in front of it:
>>
>>  qemu-system-s390x -device virtio-scsi -hda bootable.qcow2
>>
>> Since this is quite uncomfortable and confusing for the users, and
>> all major firmwares on other architectures correctly boot in such
>> cases, too, let's also try to teach the s390-ccw bios how to boot
>> in such cases.
>>
>> For this, we have to get rid of the various panic()s and IPL_assert()
>> statements at the "low-level" function and let the main code handle
>> the decision instead whether a boot from a device should fail or not,
>> so that the main code can continue searching in case it wants to.
>=20
> Are you planning to add a/re-use an existing test for this?

Not yet, but maybe the cdrom-test could be used for testing some
scenarios. I'll have a look...

 Thomas


--EGK7XhKcV2u2L2pXWeHJqpKy8Dsvea8I1--

--GSbDIPHRnN143TA6yU0gOQLV0zcLzqhhS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl8pfG0ACgkQLtnXdP5w
LbWRZw/+InPPmhym44RMPp3Tk894kolmQSrXmFAEFOpzGAiqfbtQ7zHT1pqkTMSi
UibANst5LbtHJEmWh4bftOHdJba+588TlHtDoW3XpVrCQR9EeNz1M3BPafQe4ptk
oxAfKFUtCCgYo1DxHaLjPVd06QkpDPyZ3tUYLDXgZ8G8DphDAI4wdrWqeBAeYqVw
lvZ/6N/1ewnhkb2uAPDTXMXT7gkGiopmMpUS95Ze/9UreL0czhofZN8cRMwqXQz7
LapJM2E0i8DEhyWe1TKh94MySrBNreCo2DXP0Axjnweg/7OlUDAU+VPpibPxNoME
u7AdXdevHkZWy6V1XjH7W3s747oXEP98/5f+XDTWWpcg5EJEcCtULBxLunEYXbz2
5Zvut51NBpkd38T+7jNv5a7Dj4AdjmHxFsKoCjf968wPMI5UXSDHOFPYQTatSUUj
wORmWsvV3ex6vXylNX6iDdFv51NcFxQrQhSi5zCc8z2atibYsp+MOGZ5TPv48zLG
cIT3PC+xcNfhJnf1J3ag9JlIPhaTWTVSAIxTNncRLD0TX/kWtMjmCCqZROE2FT93
aKpIFZxIllWZGt9/ZrFFkKp7dC6nGfgvY1ZtldXKsBDADUYyJqas9OqdBc6n7xLW
/ZNWs270Iap5bIuh3LnrxaG02cVi5HTbVAkApaKGKq0iaY3ydG0=
=nfzI
-----END PGP SIGNATURE-----

--GSbDIPHRnN143TA6yU0gOQLV0zcLzqhhS--


