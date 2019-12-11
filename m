Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5219EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFF42465A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCmGtzKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFF42465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3bj-0003Eq-Th
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1if3Zt-0001Zb-MM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1if3Zr-0002ns-VK
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:07:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1if3Zr-0002n8-R5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576076819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOCUVHiwbRRSxonJiaLVp/nyDhsQwBM7qpLWA2sm4EE=;
 b=CCmGtzKwpAgXafJwvlljq7RaZUPOV2LrsevLXTO6Or9Piqbu3g6ZujNA72GKhiyHgGKSP+
 BmSJ/oGqQbdxbxE+o/zzvyj8rS74+JAC/mmQslYvEIlF5JENfZ0WA2OcRD+MK7O0dE5nC9
 m4VZALL6N/tcFHZDKMj103E3xYg8rQ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-qWFj4lN9PRygtgvGW5wyxQ-1; Wed, 11 Dec 2019 10:06:55 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so10498826wrm.18
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 07:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2fX08xYAujcxdg2yTAv/a6NcZVRY2wBEL3Fj4xtuYqQ=;
 b=K/KOfTr1IPU1VZh+TIlsKDnFBe/SdFyzQ9Yw2c3AEedC0dX5RfTU8QIxlkZHEMkrRL
 3Z5NkdgYO8QkfUo1YwDJpLb8Od4GnUBQAlY40WLgv5m7QfMok1jyPDvkxKpZqXtDO5Gz
 tjcXy9szAX4ikUATuqIWHYc/VIpUyPLh/EFlDPEEriB2K3VakNqos7FZFbsWVPv42dnv
 Hea+IngHXhvsORVQDMkosxmFwfJpsHfMz0YNP1GFqQIQeMP5CdPa7U3DGiLCGwc1fexJ
 wj0hFYczqZEK4XLN8qymaCUfAeW3SS+GY620vjWGV2SAIO04Ae7fvhT+Zoceq3geaQj7
 kpcA==
X-Gm-Message-State: APjAAAU0fb+aAZe+4xlzq4D53wrR2U0Qce1eqzVMuAQYzlI0hM7FEeMI
 kVZ9WSF+YnuMpoINHBvU4nB9dj2HEKJ0xYwSMtI3dMbeLequEVJwzxVAuqf1ZqPBkVuHMy5t/PL
 RyivhA/MOHjZxNgc=
X-Received: by 2002:a1c:5451:: with SMTP id p17mr252349wmi.57.1576076814651;
 Wed, 11 Dec 2019 07:06:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyivH70pAdc03UL33RQQXzdiX+EMpl/0pXjgYTqr0KmdkR5sdjkfaKKrQx4xKGjj9NZU7DHLQ==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr252326wmi.57.1576076814334;
 Wed, 11 Dec 2019 07:06:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id z12sm2577734wmd.16.2019.12.11.07.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 07:06:53 -0800 (PST)
Subject: Re: [PATCH] build-sys: do not include Windows SLIRP dependencies in
 $LIBS
To: Samuel Thibault <samuel.thibault@gnu.org>
References: <1576074210-52834-2-git-send-email-pbonzini@redhat.com>
 <20191211143722.a4co5wi53gylo2sr@function>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81150fb4-5a6b-d27d-ee6f-53fcdc5b93d0@redhat.com>
Date: Wed, 11 Dec 2019 16:06:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211143722.a4co5wi53gylo2sr@function>
Content-Language: en-US
X-MC-Unique: qWFj4lN9PRygtgvGW5wyxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 15:37, Samuel Thibault wrote:
> Paolo Bonzini, le mer. 11 d=C3=A9c. 2019 15:23:23 +0100, a ecrit:
>> When including the internal SLIRP library, we should add all the librari=
es that
>> it needs for the build.  Right now they are all included by QEMU, but -l=
iphlpapi
>> is not needed without slirp.  Move it from LIBS to slirp_libs.
>>
>> Based on a patch by Marc-Andr=C3=A9 Lureau.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Ok, I'll queue it.  But you could use "make docker-test-mingw@fedora". :)

Paolo

> (I don't have a win environment to test this)
>=20
>> ---
>>  configure | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 6099be1..d16dad2 100755
>> --- a/configure
>> +++ b/configure
>> @@ -926,7 +926,7 @@ if test "$mingw32" =3D "yes" ; then
>>    DSOSUF=3D".dll"
>>    # MinGW needs -mthreads for TLS and macro _MT.
>>    QEMU_CFLAGS=3D"-mthreads $QEMU_CFLAGS"
>> -  LIBS=3D"-lwinmm -lws2_32 -liphlpapi $LIBS"
>> +  LIBS=3D"-lwinmm -lws2_32 $LIBS"
>>    write_c_skeleton;
>>    if compile_prog "" "-liberty" ; then
>>      LIBS=3D"-liberty $LIBS"
>> @@ -6069,6 +6069,9 @@ case "$slirp" in
>>      mkdir -p slirp
>>      slirp_cflags=3D"-I\$(SRC_PATH)/slirp/src -I\$(BUILD_DIR)/slirp/src"
>>      slirp_libs=3D"-L\$(BUILD_DIR)/slirp -lslirp"
>> +    if test "$mingw32" =3D "yes" ; then
>> +      slirp_libs=3D"$slirp_libs -lws2_32 -liphlpapi"
>> +    fi
>>      ;;
>> =20
>>    system)
>> --=20
>> 1.8.3.1
>>
>>
>=20


