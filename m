Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8823BC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F712082E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DE8e0MhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F712082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipzvb-0004a6-E7
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipzuD-0003D8-Mr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipzuC-0001xn-3x
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:25:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipzuB-0001oZ-TR
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578684310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmGMVj9WkB2aI4YQ8s6w1lx0NEjTJ/fIdwKYa6Rybe0=;
 b=DE8e0MhQzrpFl8WwUBBW1SSAnBO1wGUev4mWKLV76w9+7l2o+Px/WQ9eifXWiP6UyYpMaY
 VhQHut8GX3cu5OyFRFa/DMWIABnbZXROF5+yNDnQ5HFnnCR/m4FrLdzcqNfy//iJiwwPrp
 LukJVRaqJtBiKgW5IoAmGhEL6uGlwCk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-7PcOCX8bNdCOw5r3Cdd8Mg-1; Fri, 10 Jan 2020 14:25:07 -0500
Received: by mail-wr1-f70.google.com with SMTP id k18so1354544wrw.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 11:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ObmTuvPAGMPmfGVQVlRZEL3brP9c9SjTrt90+K4EBFk=;
 b=uYNIB/+IR6c8VFKrcGBqJoV4VHcS5bmPKxA25L1P4dviLgjSdiPt57MQawQ0YdqBcg
 Svrpt98lVspZFxKFCH0Qfg7oX0B7yWZWtiM38sSknuqlKAmbqX/q0LZBIBjaiJ8Lvlhs
 D4xxtaChvAMZDyUO6mfte0/NozF1brdORKT8HggzwFcaNne0bD/jW/f6ePc9Wu2TVlrs
 WeXuQwnP5HmYA2nzAewQCRut9LWqlCTOdppLn6VpJqXA5cEMr5M+U+/FsD0hgwN+hvC/
 gJ7mSwfdhN/5xlunZ2tqzJicwfY/svd57l1DZ7+t1mdcN4QvolDB17Z2LsM67fDnfo62
 DyXA==
X-Gm-Message-State: APjAAAXCcmsaeDoTNk8PKsmepetYCsGQ8z/Ha3hGfggWUDi9NAc9CBs0
 BJuFgz4pla1NpvC3MZdqUaS1PqxzT4UO48JIaRgNWH0QxskXoLj37o5UM++OqPPYs+/ty6aLy3u
 qOZNGGVqLzWTlNfU=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr5751589wmb.73.1578684306165;
 Fri, 10 Jan 2020 11:25:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIbab0F8I0jwbl49XxqKV1Ostcqju0z3PQDkYmWJE1q3lFsXSNUmAptiZci4LSLsxFBH1VUw==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr5751574wmb.73.1578684305987;
 Fri, 10 Jan 2020 11:25:05 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id y6sm3168845wrl.17.2020.01.10.11.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 11:25:05 -0800 (PST)
Subject: Re: [PATCH 18/26] object: return self in object_ref()
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
 <20200110153039.1379601-19-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae10fca3-74d7-51e4-b39f-f568a64bcac1@redhat.com>
Date: Fri, 10 Jan 2020 20:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110153039.1379601-19-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: 7PcOCX8bNdCOw5r3Cdd8Mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 4:30 PM, Marc-Andr=C3=A9 Lureau wrote:
> This allow for simpler assignment with ref: foo =3D object_ref(bar)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/qom/object.h | 3 ++-
>   qom/object.c         | 5 +++--
>   2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index ead9129ac8..933e5c6cb9 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1013,8 +1013,9 @@ GSList *object_class_get_list_sorted(const char *im=
plements_type,
>    *
>    * Increase the reference count of a object.  A object cannot be freed =
as long
>    * as its reference count is greater than zero.
> + * Returns: @obj
>    */
> -void object_ref(Object *obj);
> +Object *object_ref(Object *obj);
>  =20
>   /**
>    * object_unref:
> diff --git a/qom/object.c b/qom/object.c
> index 3924678ec3..9f76a330ff 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1098,12 +1098,13 @@ GSList *object_class_get_list_sorted(const char *=
implements_type,
>                           object_class_cmp);
>   }
>  =20
> -void object_ref(Object *obj)
> +Object *object_ref(Object *obj)
>   {
>       if (!obj) {
> -        return;
> +        return NULL;
>       }
>       atomic_inc(&obj->ref);
> +    return obj;
>   }
>  =20
>   void object_unref(Object *obj)
>=20


