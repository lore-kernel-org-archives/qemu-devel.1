Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E20C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A77920674
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM5NZ4Dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A77920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXklV-0007KY-Rr
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXkic-0004Nj-Sr
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXkib-0005Gi-Fx
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:33:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXkib-0005Dr-6k
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:33:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id s5so3993923wrw.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=l0OE2eqViPqQ5Z0rsDdwoMDnSSrTQc2OGVSxzFi6JNk=;
 b=kM5NZ4DlKcwY27kkaYRWxhvj5YVmAv9294uQno3o/zIlocFhPOyC1EQILFoMFLk9Sp
 dz5crnXniZBdPf+qIwamGumGv7OkKuj9wyaeCNLnmByA3/DIPoMMmIDK1K576vpn8Bu+
 LjyoZ/p+NEPoLxuReVKJ9VJJqVwqj+Y+ReecNB5vhFbkH8yEShkGnL5GxM/Zp8WjZlXz
 ERj9ZLBhQ14mmIq8TkpALy50fC0BRVQYZ3A+F/m3l1H7S55UIMuPaPWr8MUA0nEO/WgI
 EEUn/f1FHTQK2yRntaQMkT0RamdU4kniwCOCdsiyrRqBK9Lfx+vEauPxNyZo4gOc80I2
 z3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=l0OE2eqViPqQ5Z0rsDdwoMDnSSrTQc2OGVSxzFi6JNk=;
 b=qwTjzQgJ/aHymgdxUbthC+b2k3ngHaw9Xm1hvtJs10Ux6XH654FQb0n0Xk/XZrf6Pz
 sZvCNbLAsP/ZT0qiYuUukysqEYZ90iQp1HgMf7MR7AcrKrMnX4kkZ9o2NKq7uxtJh4qQ
 qvk9d3Uq8hHhsIrl34Ouqsp3IgnOEWxBzaRcjVGxJRIWvGNyq1mFBcjhdKHLlyWUqaHx
 C0wwVHCEmMtKlpBYPS2KvyvNd5b7m02pTrFeSW/jWJIYkl1hM7tRlvmk/t7VXoVU4xCg
 E7MZPncKEfEZ8KDL+bSIHWSRNhxdBKEC1OlKIFXhYT5CcDo7qiUFi6VpU+ac5bLU5LYp
 eCUg==
X-Gm-Message-State: APjAAAXBhMlDP8ZpkXrNX3V+He8nZ31LwQX7rfJUfvyGP/yQu9OEcHdv
 rGmRkSb6WdJ5d/Vc37al7Jk=
X-Google-Smtp-Source: APXvYqwVCon0DbgxR7oxBs3oMsnNo1Ucde0JFTbfZto2L2MCrhlRnEgiMRgmWHVClzoZ3r6tTgeBpg==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr8365314wro.310.1574336027761; 
 Thu, 21 Nov 2019 03:33:47 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u13sm2378335wmm.45.2019.11.21.03.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 03:33:46 -0800 (PST)
Date: Thu, 21 Nov 2019 11:33:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 15/49] multi-process: PCI BAR read/write handling
 for proxy & remote endpoints
Message-ID: <20191121113345.GJ439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <91343147552944eb67fbb98bf619e7eeb98fe324.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
Content-Disposition: inline
In-Reply-To: <91343147552944eb67fbb98bf619e7eeb98fe324.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:08:56AM -0400, Jagannathan Raman wrote:
> +const MemoryRegionOps proxy_default_ops =3D {

Unused.  Please structure patch series so that each patch is a
self-contained logical change.  It should be possible to review the
series in order from start to finish.

If there is no user yet and this is a public API then there need to be
doc comments describing the API.

> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index 7ef8207..89f04c5 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -52,6 +52,8 @@
>   * CONF_READ        PCI config. space read
>   * CONF_WRITE       PCI config. space write
>   * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
> + * BAR_WRITE        Writes to PCI BAR region
> + * BAR_READ         Reads from PCI BAR region

Is it possible to generalize this to memory regions instead of PCI BARs?
That way non-PCI devices will be able to use the same protocol messages
and code.  VFIO describes BARs generically too for the same reason, see
<linux/vfio.h> struct vfio_region_info.

>   *
>   * proc_cmd_t enum type to specify the command to be executed on the rem=
ote
>   * device.
> @@ -61,6 +63,8 @@ typedef enum {
>      CONF_READ,
>      CONF_WRITE,
>      SYNC_SYSMEM,
> +    BAR_WRITE,
> +    BAR_READ,
>      MAX,
>  } mpqemu_cmd_t;
> =20
> @@ -84,6 +88,13 @@ typedef struct {
>  } sync_sysmem_msg_t;
> =20
>  typedef struct {
> +    hwaddr addr;
> +    uint64_t val;
> +    unsigned size;
> +    bool memory;

Why is this field necessary?  Whether this is a memory access or not
should be implicit from the address/BAR we are accessing.

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WdhkACgkQnKSrs4Gr
c8g1AAf/UkvnOhs8yFfIFJOBW/YJDFbjwovrYhPzrh4UJjoLHsCqPPBN2YV+o7lO
oulWqYThwHyn8mQ4kX5goIbtrL2N+2Cyz5evRmcGsRP1sCNoTXt2jTsaNUY/qNqJ
E+QwNhQSYyggGVFebrC1zqxKyikX60jwHib6Xrh/KsXmn6vHjGjkwl6IvO1xnvU9
oMvCMVzMRZd30xgNsPd8aL+UQqPF9xNyB94xdi+Tgnk5jjR/DlGaGtqJTI1USWNo
5urEUjwQu7DVVaqQ4vOunS1JOIfUxHGynfjwWyHMKHrioc1cahERBoR/npkKOvI0
uVXoT/RtnYqCv7wcwRgAHl47Wil0lw==
=DoOg
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--

