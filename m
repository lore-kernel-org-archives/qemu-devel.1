Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E58C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2238620748
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiGPq0vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2238620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52499 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZYDz-0006zL-R1
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZY4g-0005Pw-AV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZY4e-0004FZ-RS
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:28:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZY4e-0004Dr-Ne
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574764079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lk52ND9z7x1MZHxY1MDZVQbgoF4N7AGoaCb7ZPVnzuc=;
 b=fiGPq0vhIXD9ytW59clhNh/w3bPe4QzoSzP9bfV+yeAbrD6NiBAAFcl790NTs1cmhQxXEB
 ujt/yxK4F+Ucohwx+eNWeVWNNhQCFPGzdQpcRbnMfJ6x7XxcONqhSUbkBBSxtE4PmgdZrG
 KdoL7CEhJoPUMQJVPQpmqUE50Pu4Z5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-QK2Mn6XHOrO5cPRBg4R8yg-1; Tue, 26 Nov 2019 05:27:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E54911801B9E;
 Tue, 26 Nov 2019 10:27:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AEBD7A5D3;
 Tue, 26 Nov 2019 10:27:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89B941138606; Tue, 26 Nov 2019 11:27:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 03/14] util/cutils: refactor do_strtosz() to support
 suffixes list
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-4-tao3.xu@intel.com>
Date: Tue, 26 Nov 2019 11:27:49 +0100
In-Reply-To: <20191122074826.1373-4-tao3.xu@intel.com> (Tao Xu's message of
 "Fri, 22 Nov 2019 15:48:15 +0800")
Message-ID: <87imn77x0a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: QK2Mn6XHOrO5cPRBg4R8yg-1
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> Add do_strtomul() to convert string according to different suffixes.
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>
> No changes in v17.
>
> Changes in v15:
>     - Add a new patch to refactor do_strtosz() (Eduardo)
> ---
>  util/cutils.c | 72 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 30 deletions(-)
>
> diff --git a/util/cutils.c b/util/cutils.c
> index d94a468954..ffef92338a 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -181,41 +181,37 @@ int fcntl_setfl(int fd, int flag)
>  }
>  #endif
> =20
> -static int64_t suffix_mul(char suffix, int64_t unit)
> +static int64_t suffix_mul(const char *suffixes[], int num_suffix,
> +                          const char *endptr, int *offset, int64_t unit)

This function could really use a contract comment now.

>  {
> -    switch (qemu_toupper(suffix)) {
> -    case 'B':
> -        return 1;
> -    case 'K':
> -        return unit;
> -    case 'M':
> -        return unit * unit;
> -    case 'G':
> -        return unit * unit * unit;
> -    case 'T':
> -        return unit * unit * unit * unit;
> -    case 'P':
> -        return unit * unit * unit * unit * unit;
> -    case 'E':
> -        return unit * unit * unit * unit * unit * unit;
> +    int i, suffix_len;
> +    int64_t mul =3D 1;
> +
> +    for (i =3D 0; i < num_suffix; i++) {

Aha: @num_suffix is the number of elements in suffixes[].

I'd put a terminating NULL into suffixes[] and dispense with
@num_suffix:

       for (i =3D 0; suffix[i]; i++) {

> +        suffix_len =3D strlen(suffixes[i]);

@suffix_len should be size_t, because that's what strlen() returns.

> +        if (g_ascii_strncasecmp(suffixes[i], endptr, suffix_len) =3D=3D =
0) {

@endptr is a terrible name: it points to the *beginning* of the suffix.

> +            *offset =3D suffix_len;

@offset is a terrible name: it provides no clue whatsoever on its
meaning.  It's actually for receiving the length of the suffix.

Please replace it by char **end, because that's how the related
functions work.

> +            return mul;
> +    }
> +        mul *=3D unit;
>      }
> +
>      return -1;
>  }
> =20
>  /*
> - * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
> - * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
> - * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
> - * other error.
> + * Convert string according to different suffixes. End pointer will be r=
eturned
> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on othe=
r error.
>   */
> -static int do_strtosz(const char *nptr, const char **end,
> -                      const char default_suffix, int64_t unit,
> +static int do_strtomul(const char *nptr, const char **end,
> +                       const char *suffixes[], int num_suffix,
> +                       const char *default_suffix, int64_t unit,
>                        uint64_t *result)

The function comment is barely adequate before your patch: it doesn't
explain the arguments.  Your patch adds more arguments, thus more
guesswork for the reader.

Again, I'd put a terminating NULL into suffixes[] and dispense with
@num_suffix.

>  {
>      int retval;
>      const char *endptr;
> -    unsigned char c;
>      int mul_required =3D 0;
> +    int offset =3D 0;
>      long double val, mul, integral, fraction;
> =20
>      retval =3D qemu_strtold_finite(nptr, &endptr, &val);
> @@ -226,12 +222,12 @@ static int do_strtosz(const char *nptr, const char =
**end,
>      if (fraction !=3D 0) {
>          mul_required =3D 1;
>      }
> -    c =3D *endptr;
> -    mul =3D suffix_mul(c, unit);
> +
> +    mul =3D suffix_mul(suffixes, num_suffix, endptr, &offset, unit);

@endptr points behind the number, i.e. to the suffix, and @offset is the
length of the suffix.  Suggest to rename @endptr to @suffix, and replace
@offset by @endptr.

>      if (mul >=3D 0) {
> -        endptr++;
> +        endptr +=3D offset;
>      } else {
> -        mul =3D suffix_mul(default_suffix, unit);
> +        mul =3D suffix_mul(suffixes, num_suffix, default_suffix, &offset=
, unit);
>          assert(mul >=3D 0);

Please assert "no trailing crap in @default_suffix".

>      }
>      if (mul =3D=3D 1 && mul_required) {
> @@ -256,19 +252,35 @@ out:
>      return retval;
>  }
> =20
> +/*
> + * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
> + * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
> + * other error.
> + */
> +static int do_strtosz(const char *nptr, const char **end,
> +                      const char *default_suffix, int64_t unit,
> +                      uint64_t *result)
> +{
> +    static const char *suffixes[] =3D { "B", "K", "M", "G", "T", "P", "E=
" };
> +
> +    return do_strtomul(nptr, end, suffixes, ARRAY_SIZE(suffixes),
> +                       default_suffix, unit, result);
> +}
> +
>  int qemu_strtosz(const char *nptr, const char **end, uint64_t *result)
>  {
> -    return do_strtosz(nptr, end, 'B', 1024, result);
> +    return do_strtosz(nptr, end, "B", 1024, result);
>  }
> =20
>  int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *resul=
t)
>  {
> -    return do_strtosz(nptr, end, 'M', 1024, result);
> +    return do_strtosz(nptr, end, "M", 1024, result);
>  }
> =20
>  int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *re=
sult)
>  {
> -    return do_strtosz(nptr, end, 'B', 1000, result);
> +    return do_strtosz(nptr, end, "B", 1000, result);
>  }
> =20
>  /**


