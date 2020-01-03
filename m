Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F0FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1396220672
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaresJnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1396220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inJjH-0004L7-6W
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 04:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inJih-0003uY-74
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inJig-0004ad-8Q
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:58:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inJig-0004YC-2Z
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578045493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDV6JdK52Bthz4Xz0NJNuYqMf0ub+ILXENGu09wJAj8=;
 b=RaresJnO3BjnJkwI7Rn/hPEQWA4KPSsfX88eXa78Y4xiLoFm6F9YzDL7ecgXNGxzwnwCwU
 KSxCrZcyUSm08bokk0JXw7J0jzvuY1MdiLn+hxailxtBaqYuQu/RAngMDOGGaEWMdYjYgo
 256ZttvSwxbOxyZHRcRGKoveuSRo1WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-PeK9deH7O8ag_dmSHrGOfw-1; Fri, 03 Jan 2020 04:58:10 -0500
X-MC-Unique: PeK9deH7O8ag_dmSHrGOfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75463185432C;
 Fri,  3 Jan 2020 09:58:09 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B9ED10013A1;
 Fri,  3 Jan 2020 09:58:06 +0000 (UTC)
Date: Fri, 3 Jan 2020 09:58:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 01/21] softmmu: split off vl.c:main() into main.c
Message-ID: <20200103095804.GB130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-2-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-2-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:36PM +0000, Oleinik, Alexander wrote:
> @@ -3853,7 +3834,7 @@ int main(int argc, char **argv, char **envp)
>      set_memory_options(&ram_slots, &maxram_size, machine_class);
> =20
>      os_daemonize();
> -    rcu_disable_atfork();
> +    /* rcu_disable_atfork(); */
> =20
>      if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
>          error_reportf_err(err, "cannot create PID file: ");

Did you find a solution for this?

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PECwACgkQnKSrs4Gr
c8hLhwf+OlNbm/hpgg4cmPLfF34S42Igu1HV+gReTkETVADEw4R9nZn7pXGCBTA9
t/DkQBe9hfkPiB4FIConGWin9uwoxC2bny7/zEqtY2t5gYvQiFE1Hh3BgBWmMFrg
xNHTKYtj3XXW38ex2qFY0EonTgjeGjjQibaTny7rUB5vAgo8hdTSQDBUCb4j82ZA
Xzaw1yH6iT0pSTSFySf+dIg8zrMN0mQKEyFRh0K0uJWIF6UszjgzSrY+4U/Z6aio
IfutmMd/6KmYmLyiHH/MMc2RPClOuli9qxBcRSjn2DxUZg+c4itBk0sWXAxCSBrs
cybugTeGcXZE8FzoE1wuaay3s7O/1w==
=6+wl
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--


