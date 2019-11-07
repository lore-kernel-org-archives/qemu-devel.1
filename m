Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD3DC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82ACD2187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeruM6HC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ACD2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgTR-0006IK-OW
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSgRe-000557-GF
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSgRc-0002O8-9d
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:59:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSgRc-0002Nw-5i
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573127959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Dv3Lv/FGMLZRyrTrfPXhI8m7bhTpGGzK5dX3LzhsDo=;
 b=TeruM6HCRrU9/2av5joDpLZM/p/H/zdXxm0dpC97X/40dDRD3YkGxTpZLzqrrAlFfJtHDj
 eH/RJq+fetI4jpQlO9A/br5b0WyzkWZJTSG3fFJTzOo+OXVaWatnXHW+7L1K7n9HGwHGwk
 jevCvBNkINVeyRlFmghsYLQKjAQnF2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-em20_29AO4egd02Kp2nYpA-1; Thu, 07 Nov 2019 06:59:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 642748017DD;
 Thu,  7 Nov 2019 11:59:14 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 816995D9CD;
 Thu,  7 Nov 2019 11:59:13 +0000 (UTC)
Date: Thu, 7 Nov 2019 11:59:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 1/2] migration/compress: compress QEMUFile is not writable
Message-ID: <20191107115910.GG2816@work-vm>
References: <20191012023932.1863-1-richardw.yang@linux.intel.com>
 <20191012023932.1863-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191012023932.1863-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: em20_29AO4egd02Kp2nYpA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> We open a file with empty_ops for compress QEMUFile, which means this is
> not writable.

That explanation sounds reasonable; but I'm confused by the history of
this;  the code was added by Liang Li in :

  b3be289 qemu-file: Fix qemu_put_compression_data flaw

  ( https://www.mail-archive.com/qemu-devel@nongnu.org/msg368974.html )

with almost exactly the opposite argument;  can we figure out why?

Dave

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/qemu-file.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>=20
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 26fb25ddc1..f3d99a96ec 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -744,11 +744,8 @@ static int qemu_compress_data(z_stream *stream, uint=
8_t *dest, size_t dest_len,
>  /* Compress size bytes of data start at p and store the compressed
>   * data to the buffer of f.
>   *
> - * When f is not writable, return -1 if f has no space to save the
> - * compressed data.
> - * When f is wirtable and it has no space to save the compressed data,
> - * do fflush first, if f still has no space to save the compressed
> - * data, return -1.
> + * Since the file is dummy file with empty_ops, return -1 if f has no sp=
ace to
> + * save the compressed data.
>   */
>  ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
>                                    const uint8_t *p, size_t size)
> @@ -756,14 +753,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_str=
eam *stream,
>      ssize_t blen =3D IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
> =20
>      if (blen < compressBound(size)) {
> -        if (!qemu_file_is_writable(f)) {
> -            return -1;
> -        }
> -        qemu_fflush(f);
> -        blen =3D IO_BUF_SIZE - sizeof(int32_t);
> -        if (blen < compressBound(size)) {
> -            return -1;
> -        }
> +        return -1;
>      }
> =20
>      blen =3D qemu_compress_data(stream, f->buf + f->buf_index + sizeof(i=
nt32_t),
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


