Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26977C43141
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9347E20637
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzWYHweQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9347E20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvgg-0006d4-Et
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUvfQ-00057D-PX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUvfO-0004s8-RD
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:38:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUvfL-0004rv-7t
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573663126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7K9qbPjJBUGQ9+IZ6IoeTgUCn0urUOjgPIFUaEJjzjs=;
 b=gzWYHweQbqlOXo7WC7uRG1XoWfcPlvq9kD6NkjejiIsvwaEKfVWXKwPyJ0HVbjDNkjJSN3
 LgBNDjppkKfsMbgVLtHZViP7u3skSF7nJyzaiv8Hw9d/YhM2dIfz9H6Jn4MBOj63kVcFBl
 f+GK7jxEe4B37/1E9rxVTUtsfNIILD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-DTqf8iamNPipA6f9AsqgCA-1; Wed, 13 Nov 2019 11:38:42 -0500
X-MC-Unique: DTqf8iamNPipA6f9AsqgCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 183781015E6F;
 Wed, 13 Nov 2019 16:38:41 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D2735F76F;
 Wed, 13 Nov 2019 16:38:35 +0000 (UTC)
Date: Wed, 13 Nov 2019 16:38:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 12/49] multi-process: remote process initialization
Message-ID: <20191113163834.GG563983@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <a0550c5a6df8f294528393cfe3c031e194ba2188.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <a0550c5a6df8f294528393cfe3c031e194ba2188.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pE2VAHO2njSJCslu"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pE2VAHO2njSJCslu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:08:53AM -0400, Jagannathan Raman wrote:
>  int main(int argc, char *argv[])
>  {
> +    Error *err =3D NULL;
> +
>      module_call_init(MODULE_INIT_QOM);
> =20
> +    bdrv_init_with_whitelist();
> +
> +    if (qemu_init_main_loop(&err)) {
> +        error_report_err(err);
> +        return -EBUSY;
> +    }
> +
> +    qemu_init_cpu_loop();
> +
> +    page_size_init();
> +
>      current_machine =3D MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MA=
CHINE)));
> =20
> +    mpqemu_link =3D mpqemu_link_create();
> +    if (!mpqemu_link) {
> +        printf("Could not create MPQemu link\n");
> +        return -1;
> +    }
> +
> +    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
> +    mpqemu_link_set_callback(mpqemu_link, process_msg);
> +
> +    mpqemu_start_coms(mpqemu_link);

Can you use util/main-loop.c instead of an mpqemu-specific event loop?
I think that file is needed anyway because lots of QEMU code depends on
it.

--pE2VAHO2njSJCslu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3MMYoACgkQnKSrs4Gr
c8jFwgf/cp/YFcGf+fWF6uuDb6t0lFeTLR4iZwWoF59WCBGaaUlyYquP8EoT9rPY
m9FrlvURkNl2IhGSiwyh+Mkj18wPTjHoD6849edPKordSe5nOYFfdgCe6OV8+Ni3
9E9udLUHQlOEeyrqyHvRuX2RUcFh39EKb4Xa/+W8rtXY6cw5PsDu3OeM5zChaJ0g
YM4veidnLy61kT+PCCij932mhn0TCJgutfMa7qZAP7NpOYpDFokTO1FwRY9yAus2
/SZhufBie7UExgQh+/IL1qoxw9QcGCfae3HT2BSeUTVJw2hIt7Gl1pRb9vZ/68zn
5vIKeqiWwGVQuAB8P9cpTtP0QGgSJw==
=iEWJ
-----END PGP SIGNATURE-----

--pE2VAHO2njSJCslu--


