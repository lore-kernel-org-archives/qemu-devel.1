Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC30C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4322064B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoTqg2mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4322064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFoB-0000ZP-Sa
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idEum-00021Z-Ju
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idEul-0005zd-4z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:49:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49161
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idEuk-0005yg-Vb
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMomInCBfwvP6AujEflBTyrGGKLFFe2gc1qzHaavmu0=;
 b=IoTqg2mfHfTkpUGZ4Y6kMLOdSUHGRbavyVq9gfTLPMPYjCb0apeBw3jqIHEnIEXgaI0uCR
 mBHB+ET54F0wSubOo9PwSYzhmMi8b9jXv5rEK+i6RYmWZZRRjpvVFjZ32reFRRBnALB3Z8
 cZH/3PaZqQUTxw4ULcJz7CyYFdDg1P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-ipD46liHOjS3bd5xI6_rug-1; Fri, 06 Dec 2019 02:46:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5FE0DB60;
 Fri,  6 Dec 2019 07:46:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2051E608E5;
 Fri,  6 Dec 2019 07:46:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B69A1138606; Fri,  6 Dec 2019 08:46:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 10/21] hw/core: Fix latent fit_load_fdt() error handling
 bug
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-11-armbru@redhat.com>
 <b42438de-3f05-a949-9304-29c051bc4444@virtuozzo.com>
Date: Fri, 06 Dec 2019 08:46:38 +0100
In-Reply-To: <b42438de-3f05-a949-9304-29c051bc4444@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Dec 2019 16:23:48 +0000")
Message-ID: <87tv6dnbfl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ipD46liHOjS3bd5xI6_rug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 30.11.2019 22:42, Markus Armbruster wrote:
>> fit_load_fdt() recovers from fit_image_addr() failing with ENOENT.
>> Except it doesn't when its @errp argument is &error_fatal or
>> &error_abort, because it blindly passes @errp to fit_image_addr().
>> Messed up in commit 3eb99edb48 "loader-fit: Wean off error_printf()".
>>=20
>> The bug can't bite as no caller actually passes &error_fatal or
>> &error_abort.  Fix it anyway.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Hmm, actually it makes my
> "[PATCH v7 01/21] hw/core/loader-fit: fix freeing errp in fit_load_fdt"
> unnecessary. If you want you may drop my 01 (as it covers less problems),

Yes.

> and in this case you may note in your cover letter, that
> errp =3D NULL is broken here too (may be nobady pass it?),

You're right, null @errp is wrong, too.

> and normal errp is handled wrong, as *errp doesn't set to NULL after
> error_free(*errp)

Yes, that's wrong, too.  fit_load_fdt() itself doesn't use *errp after
freeing it, but it sets a trap for its callers. =20

>                   (still, the only caller rely on return value more than =
on
> err, so the problem can't be triggered with current code)

True.

New commit message (based on v2's):

    hw/core: Fix fit_load_fdt() error API violations

    fit_load_fdt() passes @errp to fit_image_addr(), then recovers from
    ENOENT failures.  Passing @errp is wrong, because it works only as
    long as @errp is neither @error_fatal nor @error_abort.  Error
    recovery dereferences @errp.  That's also wrong; see the big comment
    in error.h.  Error recovery can leave *errp pointing to a freed
    Error object.  Wrong, it must be null on success.  Messed up in
    commit 3eb99edb48 "loader-fit: Wean off error_printf()".

    No caller actually passes such values, or uses *errp on success.

    Fix anyway: splice in a local Error *err, and error_propagate().

    Signed-off-by: Markus Armbruster <armbru@redhat.com>

Okay?

>
>> ---
>>   hw/core/loader-fit.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
>> index 953b16bc82..c465921b8f 100644
>> --- a/hw/core/loader-fit.c
>> +++ b/hw/core/loader-fit.c
>> @@ -178,11 +178,12 @@ static int fit_load_fdt(const struct fit_loader *l=
dr, const void *itb,
>>                           int cfg, void *opaque, const void *match_data,
>>                           hwaddr kernel_end, Error **errp)
>>   {
>> +    Error *err =3D NULL;
>>       const char *name;
>>       const void *data;
>>       const void *load_data;
>>       hwaddr load_addr;
>> -    int img_off, err;
>> +    int img_off;
>>       size_t sz;
>>       int ret;
>>  =20
>> @@ -197,13 +198,13 @@ static int fit_load_fdt(const struct fit_loader *l=
dr, const void *itb,
>>           return -EINVAL;
>>       }
>>  =20
>> -    err =3D fit_image_addr(itb, img_off, "load", &load_addr, errp);
>> -    if (err =3D=3D -ENOENT) {
>> +    ret =3D fit_image_addr(itb, img_off, "load", &load_addr, &err);
>> +    if (ret =3D=3D -ENOENT) {
>>           load_addr =3D ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
>> -        error_free(*errp);
>> -    } else if (err) {
>> -        error_prepend(errp, "unable to read FDT load address from FIT: =
");
>> -        ret =3D err;
>> +        error_free(err);
>> +    } else if (ret) {
>> +        error_propagate_prepend(errp, err,
>> +                                "unable to read FDT load address from F=
IT: ");
>>           goto out;
>>       }
>>  =20
>>=20
>
> So much attention to that function :)
>
> I'd also propose the following:
>
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index c465921b8f..2c9efeef7a 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -180,8 +180,8 @@ static int fit_load_fdt(const struct fit_loader *ldr,=
 const void *itb,
>   {
>       Error *err =3D NULL;
>       const char *name;
> -    const void *data;
> -    const void *load_data;
> +    void *data;
> +    void *load_data;
>       hwaddr load_addr;
>       int img_off;
>       size_t sz;
> @@ -218,9 +218,9 @@ static int fit_load_fdt(const struct fit_loader *ldr,=
 const void *itb,
>
>       ret =3D 0;
>   out:
> -    g_free((void *) data);
> +    g_free(data);
>       if (data !=3D load_data) {
> -        g_free((void *) load_data);
> +        g_free(load_data);
>       }
>       return ret;
>   }
>
>
> Or, even better:
>
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -180,7 +180,8 @@ static int fit_load_fdt(const struct fit_loader *ldr,=
 const void *itb,
>   {
>       Error *err =3D NULL;
>       const char *name;
> -    const void *data;
> +    g_autofree void *data =3D NULL;
> +    g_autofree void *fdt_filter_data =3D NULL;
>       const void *load_data;
>       hwaddr load_addr;
>       int img_off;
> @@ -202,27 +203,23 @@ static int fit_load_fdt(const struct fit_loader *ld=
r, const void *itb,
>       if (ret =3D=3D -ENOENT) {
>           load_addr =3D ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
>           error_free(err);
> +        return 0;
>       } else if (ret) {
>           error_propagate_prepend(errp, err,
>                                   "unable to read FDT load address from F=
IT: ");
> -        goto out;
> +        return ret;
>       }
>
>       if (ldr->fdt_filter) {
> -        load_data =3D ldr->fdt_filter(opaque, data, match_data, &load_ad=
dr);
> +        load_data =3D fdt_filter_data =3D
> +                ldr->fdt_filter(opaque, data, match_data, &load_addr);
>       }
>
>       load_addr =3D ldr->addr_to_phys(opaque, load_addr);
>       sz =3D fdt_totalsize(load_data);
>       rom_add_blob_fixed(name, load_data, sz, load_addr);
>
> -    ret =3D 0;
> -out:
> -    g_free((void *) data);
> -    if (data !=3D load_data) {
> -        g_free((void *) load_data);
> -    }
> -    return ret;
> +    return 0;
>   }

Looks like a sensible separate cleanup patch to me.  Care to post it?

Thanks!


