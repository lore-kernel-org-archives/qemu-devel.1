Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C019C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AADE2076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLPxUP2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AADE2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJb4-00024X-8Q
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 13:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNJYg-00018z-MO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNJYd-0005vR-6j
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:36:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601401013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KrR/Gc2Jhq8hrrExwgHJtt2fUz9+jwBgbPBvSWPZAbY=;
 b=eLPxUP2qtQYUEcR4Ygys/tBw0Ypk7x08kNsw+WNwkkPDbWrNdqXRX6n0kkSloPovPmP6qw
 1u/lhOOdzyezjsmGxMgrUNEnAlIUWpWMdeV0TXNcG1TRPoLwAHQ4jH7IsV/TcQH8qXEqT2
 xEbyxjpeDIuh8NFu2PPK1A1v0IT03no=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-e46zvTScNpydT_7xFCsbBQ-1; Tue, 29 Sep 2020 13:36:45 -0400
X-MC-Unique: e46zvTScNpydT_7xFCsbBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDDD4109B9F2;
 Tue, 29 Sep 2020 17:36:12 +0000 (UTC)
Received: from [10.3.112.208] (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E3465579A;
 Tue, 29 Sep 2020 17:36:11 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] block: move block exports to libblockdev
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200929125516.186715-1-stefanha@redhat.com>
 <20200929125516.186715-4-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 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
Organization: Red Hat, Inc.
Message-ID: <846a3c67-33eb-f694-d9ed-9c4318e10eab@redhat.com>
Date: Tue, 29 Sep 2020 12:36:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929125516.186715-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mrS7AfmHYtK4FMvREJRDIU5peHQ41bveL"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mrS7AfmHYtK4FMvREJRDIU5peHQ41bveL
Content-Type: multipart/mixed; boundary="0lIoHeyMJoUQdCFeFmO79Zb9ZJS2QjpaE";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 qemu-block@nongnu.org
Message-ID: <846a3c67-33eb-f694-d9ed-9c4318e10eab@redhat.com>
Subject: Re: [PATCH v2 3/4] block: move block exports to libblockdev
References: <20200929125516.186715-1-stefanha@redhat.com>
 <20200929125516.186715-4-stefanha@redhat.com>
In-Reply-To: <20200929125516.186715-4-stefanha@redhat.com>

--0lIoHeyMJoUQdCFeFmO79Zb9ZJS2QjpaE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/29/20 7:55 AM, Stefan Hajnoczi wrote:
> Block exports are used by softmmu, qemu-storage-daemon, and qemu-nbd.
> They are not used by other programs and are not otherwise needed in
> libblock.
>=20
> Undo the recent move of blockdev-nbd.c from blockdev_ss into block_ss.
> Since bdrv_close_all() (libblock) calls blk_exp_close_all()
> (libblockdev) a stub function is required..
>=20
> Make qemu-ndb.c use signal handling utility functions instead of
> duplicating the code. This helps because os-posix.c is in libblockdev
> and it depends on a qemu_system_killed() symbol that qemu-nbd.c lacks.
> Once we use the signal handling utility functions we also end up
> providing the necessary symbol.

Hmm. I just stumbled on a long-standing bug in qemu-nbd - it installs a
SIGTERM handler, but not a SIGINT or SIGHUP handler.  This matters in
the following sequence:

qemu-nbd -f qcow2 -B bitmap image   # Ctrl-C
qemu-nbd -f qcow2 -B bitmap image

because the first instance dies with SIGINT but there is no handler
installed, qemu-nbd does not release the bitmap from being marked
in-use, and the second instance then fails with:

qemu-nbd: Bitmap 'b0' is inconsistent and cannot be used

And to my surprise, while I was trying to find the root cause to fixing
the bug I just found, I noticed that your patch happens to fix that...

> +++ b/qemu-nbd.c

> @@ -581,20 +586,12 @@ int main(int argc, char **argv)
>      const char *pid_file_name =3D NULL;
>      BlockExportOptions *export_opts;
> =20
> +    os_setup_early_signal_handling();
> +
>  #if HAVE_NBD_DEVICE
> -    /* The client thread uses SIGTERM to interrupt the server.  A signal
> -     * handler ensures that "qemu-nbd -v -c" exits with a nice status co=
de.
> -     */
> -    struct sigaction sa_sigterm;
> -    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
> -    sa_sigterm.sa_handler =3D termsig_handler;
> -    sigaction(SIGTERM, &sa_sigterm, NULL);
> +    os_setup_signal_handling();

...by installing a SIGINT handler.

Is HAVE_NBD_DEVICE really the best gate for this code, or is it really
whether we are compiling for mingw?  At any rate, you may want to add a
link to https://bugzilla.redhat.com/show_bug.cgi?id=3D1883608 in the
commit message, and/or separate the bug fix out into a separate commit.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--0lIoHeyMJoUQdCFeFmO79Zb9ZJS2QjpaE--

--mrS7AfmHYtK4FMvREJRDIU5peHQ41bveL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl9zcIoACgkQp6FrSiUn
Q2o2Wwf7BV5My2s3ec1aTyt3AiNWnXZYqD+wZ1dcSvOP1jzcXwwXl7q3dMFsGaNB
N3YgdePzaW/yXEyMqqqwFLIM0p9jMdOATG2G0tkQgTtb1tgz2H1W3wubEjd25Py3
aP5cQravUtuyKChQovNR0FiNaEsjl48zixkYbPebkNH+LpVYc5rSBWmsH97gHMSA
XgU5N1q/ybFUxfWBkvB+wZNsRQiLLdU5fb+zE066TCEKxXnz0KpJdW8948gVOMXi
+5RKUWIJtSNPXDUBBQw8S+OnQeOW/mJZ/7FlwR2vgU+cCSMm69ue2qjRFl9xBeAK
NwI5NDgnWEcoEr5UrHXwAvgZkR870Q==
=C9CG
-----END PGP SIGNATURE-----

--mrS7AfmHYtK4FMvREJRDIU5peHQ41bveL--


