Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D873C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7E42075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgOQ7dly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7E42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xJX-0003Pp-9M
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 09:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2xIZ-0002yg-V1
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 09:48:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31392
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2xIX-0001SJ-2S
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 09:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596548887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lisIFbOrqHaQV6esO90yIz2L4nwf41tIafLQuqsM3Dk=;
 b=XgOQ7dlyJNQgWLZCplf3E1qJrf22fgbtrK520nlmV9tekMnvcQOHxu6KEWy0S+NWhQ5guO
 tIJhdly8KNGxKhizA0L6feUpGAzASXcXCkGzAUtodOMsGI0zz1v02hOg9VnAJIej+DkFVL
 TGKD1P9Rm4U1VqcCFjB9RVSFzy1pqII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-S2WUEY79MuyMU4sWA3A8VA-1; Tue, 04 Aug 2020 09:48:03 -0400
X-MC-Unique: S2WUEY79MuyMU4sWA3A8VA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D843C8B1087;
 Tue,  4 Aug 2020 13:48:01 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43C945C6DD;
 Tue,  4 Aug 2020 13:47:58 +0000 (UTC)
Date: Tue, 4 Aug 2020 14:47:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/3] memory: add readonly support to
 memory_region_init_ram_from_file()
Message-ID: <20200804134756.GA1287869@stefanha-x1.localdomain>
References: <20200804101244.1283503-1-stefanha@redhat.com>
 <20200804101244.1283503-2-stefanha@redhat.com>
 <febc6361-1c62-bc3e-7924-bbd19711b5df@redhat.com>
 <1240d81b-7ac5-d06d-671a-70614004a721@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1240d81b-7ac5-d06d-671a-70614004a721@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2020 at 02:26:22PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 8/4/20 2:25 PM, Philippe Mathieu-Daud=E9 wrote:
> > Hi Stefan,
> >=20
> > On 8/4/20 12:12 PM, Stefan Hajnoczi wrote:
> >> There is currently no way to open(O_RDONLY) and mmap(PROT_READ) when
> >> creating a memory region from a file. This functionality is needed sin=
ce
> >> the underlying host file may not allow writing.
> >>
> >> Add a bool readonly argument to memory_region_init_ram_from_file() and
> >> the APIs it calls.
> >>
> >> Extend memory_region_init_ram_from_file() rather than introducing a
> >> memory_region_init_rom_from_file() API so that callers can easily make=
 a
> >> choice between read/write and read-only at runtime without calling
> >> different APIs.
> >=20
> > What happens if we call:
> >=20
> >  memory_region_init_ram_from_file(mr, ..., readonly=3Dfalse, ...);
> >  memory_region_set_readonly(mr, false);
>=20
> In case my error is not obvious, I meant:
>=20
>    memory_region_init_ram_from_file(mr, ..., readonly=3Dtrue, ...);
>    memory_region_set_readonly(mr, false);

Since the mmap was made using PROT_READ any store instructions to the
memory will fault.

Is there some scenario where memory_region_set_readonly() is called? I
can't find one.

Stefan

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8pZwwACgkQnKSrs4Gr
c8iuAgf/dIhTTvN0xgDmmVf64MAxEPDRcGvG4RLXAlNikSH9OYEB5iVOD174fZo6
bK9h1FRhthDGeK98DM8o9VsLFCNhPne60hEiG5CftIrztHrpDwADH6Ia2Ot3PVXA
tecdFE5JOggvtbenjGxALLmz70tK5EI8eL7fSEQGBFTbSZrkP/LGWm76LzHOLRKR
yA3j4Yx9Dir0BvGhR/ief7ChKp7RRJRvwiMCoTaD672eGWxLykHyiJjmWyLpop25
7EvAfNz559AfSj7sVuPlH6Lsx7HNNNE1KdiBpG3hGDXlnr3cm2kbmvtWxIBXALyD
3JdpOB9xdRSOrbs8Pd6/3l9V6XdtpQ==
=pumo
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--


