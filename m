Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58168C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310BB2083B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOaFEn/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310BB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQGlw-00017Y-TU
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 17:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQGkh-0000VT-VX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 17:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQGke-0006gO-UQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 17:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602105209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8t6RVEQHS5j5UY7NHrIgkPIeY1qrgrCA6NhqbbgbI5g=;
 b=HOaFEn/eo2XnleJ1UjgJXYDwPffDXJh0iVxDJvhOY9cde355aem28VHrJRXAunBEg3ajnL
 6XhvmvAIQzxr8/swt+aHu2tdWK4rngk06QIC9AdgMtXXnGaIZjMtXDV011Sh4JvB4pfTfA
 K+bYV4gqkMKz2S05s5wBro57RRZ6akg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-ngBrmctxNv2NyFq0bQfopg-1; Wed, 07 Oct 2020 17:13:27 -0400
X-MC-Unique: ngBrmctxNv2NyFq0bQfopg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12BD61019625;
 Wed,  7 Oct 2020 21:13:26 +0000 (UTC)
Received: from [10.3.113.66] (ovpn-113-66.phx2.redhat.com [10.3.113.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9588060BFA;
 Wed,  7 Oct 2020 21:13:22 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] qemu-nbd: Honor SIGINT and SIGHUP
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-2-eblake@redhat.com>
 <224e825c-a3f8-00a9-0add-88fd13cebab7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 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
Organization: Red Hat, Inc.
Message-ID: <fbcffefe-b93c-788e-85e4-363807489411@redhat.com>
Date: Wed, 7 Oct 2020 16:13:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <224e825c-a3f8-00a9-0add-88fd13cebab7@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nml4tqox2zhl8TeNIjJ5ATMbSHqPDXYyJ"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com,
 rjones@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nml4tqox2zhl8TeNIjJ5ATMbSHqPDXYyJ
Content-Type: multipart/mixed; boundary="hFyVD8A9SbgxhfgiveNNTVAFM6h96eDu9";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <fbcffefe-b93c-788e-85e4-363807489411@redhat.com>
Subject: Re: [PATCH v2 1/5] qemu-nbd: Honor SIGINT and SIGHUP
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-2-eblake@redhat.com>
 <224e825c-a3f8-00a9-0add-88fd13cebab7@virtuozzo.com>
In-Reply-To: <224e825c-a3f8-00a9-0add-88fd13cebab7@virtuozzo.com>

--hFyVD8A9SbgxhfgiveNNTVAFM6h96eDu9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/7/20 5:32 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.09.2020 15:11, Eric Blake wrote:
>> Honoring just SIGTERM on Linux is too weak; we also want to handle
>> other common signals, and do so even on BSD.=C2=A0 Why?=C2=A0 Because at=
 least
>> 'qemu-nbd -B bitmap' needs a chance to clean up the in-use bit on
>> bitmaps when the server is shut down via a signal.
>=20
> Probably not bad to update a comment [*] if you have a good wording in
> mind.
>=20
>>
>> See also: http://bugzilla.redhat.com/1883608
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>> ---
>> =C2=A0 qemu-nbd.c | 6 +++---
>> =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>> index bacb69b0898b..e7520261134f 100644
>> --- a/qemu-nbd.c
>> +++ b/qemu-nbd.c
>> @@ -581,7 +581,7 @@ int main(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *pid_file_name =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockExportOptions *export_opts;
>>
>> -#if HAVE_NBD_DEVICE
>> +#ifdef CONFIG_POSIX
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The client thread uses SIGTERM to inte=
rrupt the server.=C2=A0 A
>> signal
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * handler ensures that "qemu-nbd -v=
 -c" exits with a nice
>> status code.
>=20
> [*]
>=20

Sure, I went with:

diff --git i/qemu-nbd.c w/qemu-nbd.c
index e7520261134f..c731dda04ec0 100644
--- i/qemu-nbd.c
+++ w/qemu-nbd.c
@@ -582,8 +582,9 @@ int main(int argc, char **argv)
     BlockExportOptions *export_opts;

 #ifdef CONFIG_POSIX
-    /* The client thread uses SIGTERM to interrupt the server.  A signal
-     * handler ensures that "qemu-nbd -v -c" exits with a nice status code=
.
+    /*
+     * Exit gracefully on various signals, which includes SIGTERM used
+     * by 'qemu-nbd -v -c'.
      */
     struct sigaction sa_sigterm;
     memset(&sa_sigterm, 0, sizeof(sa_sigterm));

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hFyVD8A9SbgxhfgiveNNTVAFM6h96eDu9--

--nml4tqox2zhl8TeNIjJ5ATMbSHqPDXYyJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl9+L3EACgkQp6FrSiUn
Q2rXRwgAkqzO6lBrC9ADd3VLYsAgCu0IBM/NquE7iIQqBlG6TSyruVMv6Cydgh2U
Got68BrWL82PDrSN1/hWYTQpMJkkjHWFpPtkHa5STl+jvr1HbYwAGc5jbwrmu1jt
zTxvFQ/7d1AnrluQHEAu3UEjrk5nBW9lJAPm548Y+Fg6iXwEnvO20aXZLtsDAfQf
/MQYFVm6CsdUKV6aGxnTccP4skJzsHD7Ii4JwEjCVKRZI0CF5RxtVHMis+p1uR6C
0r8YGyTSGLabWFnWFWW8yq9AODhcZ+Mwe2rZSo6W4cnMI4xO3lglQStCGXzSIdTT
ya9pNq2iPQMtMWUX1VCkRhl3KJLXdA==
=N/jb
-----END PGP SIGNATURE-----

--nml4tqox2zhl8TeNIjJ5ATMbSHqPDXYyJ--


