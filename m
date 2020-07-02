Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F48C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A78E20885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2IljLCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A78E20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqz8M-0000iw-9N
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqz7W-0000Dz-RS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:19:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqz7V-0000q1-8s
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593695956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iTWRl6i8uFwFGmngnxKrMocz5M+NTDvNvXjuttqT7+s=;
 b=V2IljLCjqw2z3qQAc5frhKZtKTu9gVf2JcpuDU+Hde7iKYRZJoVmevX2WwWrNjAYidtIp6
 +5IAoqPXRJ6co1sKIQWrRZC4A1pmVXIRYTO2PsR//N4kTjaN+iRP6tgJVKT6foHIhvyo8w
 O8TpQlEFoTgNfqTIijcFUbX75H2XlbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-E3KYITnONNe-TDB_Jubu0g-1; Thu, 02 Jul 2020 09:19:14 -0400
X-MC-Unique: E3KYITnONNe-TDB_Jubu0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D627B19253C0;
 Thu,  2 Jul 2020 13:19:12 +0000 (UTC)
Received: from localhost (ovpn-114-216.ams2.redhat.com [10.36.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7AB35C1C5;
 Thu,  2 Jul 2020 13:19:02 +0000 (UTC)
Date: Thu, 2 Jul 2020 14:19:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 19/21] multi-process: perform device reset in the
 remote process
Message-ID: <20200702131901.GD152912@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <609039447d2d5dc85f47a34c906e416b54341998.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <609039447d2d5dc85f47a34c906e416b54341998.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:41AM -0700, elena.ufimtseva@oracle.com wrote:
> @@ -283,3 +288,14 @@ static void process_proxy_ping_msg(QIOChannel *ioc)
> =20
>      mpqemu_msg_send(&ret, ioc);
>  }
> +
> +static void process_device_reset_msg(QIOChannel *ioc)
> +{
> +    MPQemuMsg ret =3D { 0 };
> +
> +    qemu_devices_reset();

Why are all devices reset globally instead of just the PCIDevice in
question?

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl793sUACgkQnKSrs4Gr
c8h6fwf/eX7B1QFQTvrzur/gkd/nRx82zvFZQfN4S9o7IWh3928hzOPqrWldEOKJ
VfOt/kosrfqZuOdNOwRSzLX4+YR98M5kb6hBZ2Ay+chcJDyZu42am0ZrGUCbadt2
u9vQN60A8gR1NAXlOT9zBWeAfyBFY5P1A4R3/hWGTIS07gjnALI3XsyLX8huZqRL
7MM+i5p5mJL5Hz+khc5y6dTqDoO85GxFcxscr5LefziV3cmrwzNAQHkXekrDirNB
E26RbjIVEXqjYz1HIQgAEsJ4AtvL4nbvohXDtMTOujDfx8JPW3Ly3A0sbh0FBYWl
mPz0Xk0Q1U4X5ooDfxuBPPAyXvVE1A==
=NQHl
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--


