Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C6C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B73220746
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld2Ic5uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B73220746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVms-0001F0-AN
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYVlX-0000Gx-Rs
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:20:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21811
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYVlW-0004cX-8G
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589293213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sM3pXdBV8FeusjTgMFYAoOJgzgk7HVAGbPhXOjW7BEs=;
 b=Ld2Ic5uUY9B/gzW12cKS9OoQIaJ15zBvfw4UCrLjgboutJBq0ELT1Uxh6NEu/JaPHWXBtH
 zfW8E5dZayjJAxmSzsIIG1aDmKoVmTehMLmPExC7QqodEblv26dUr8zSdHFViLW8cuWjwf
 TpDeHTUulVLrFO2tBwCSN9XtmHzZqXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-Bu85_dmaMHyF_Lolg-nFfQ-1; Tue, 12 May 2020 10:20:04 -0400
X-MC-Unique: Bu85_dmaMHyF_Lolg-nFfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1CB8107ACF3;
 Tue, 12 May 2020 14:20:02 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 013336CA57;
 Tue, 12 May 2020 14:19:55 +0000 (UTC)
Date: Tue, 12 May 2020 15:19:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 21/36] multi-process: PCI BAR read/write
 handling for proxy & remote endpoints
Message-ID: <20200512141954.GK300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <5484f5bc8b9e80d50331b32b971f433b5c062e3a.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5484f5bc8b9e80d50331b32b971f433b5c062e3a.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4wkndigzIeYF6Hbg"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--4wkndigzIeYF6Hbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:56PM -0700, elena.ufimtseva@oracle.com wrote:
> +uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size=
)
> +{
> +    ProxyMemoryRegion *pmr =3D opaque;
> +    uint64_t val;
> +
> +    send_bar_access_msg(pmr->dev, &pmr->mr, false, addr, &val, size,
> +                        pmr->memory);
> +
> +     return val;

Indentation is should be 4 spaces.

> @@ -43,4 +54,9 @@ typedef struct PCIProxyDevClass {
>      char *command;
>  } PCIProxyDevClass;
> =20
> +void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
> +                             unsigned size);
> +
> +uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size=
);

"default" is probably not appropriate here. This isn't a base class'
default implementation that child classes override.

> @@ -114,6 +115,77 @@ exit:
>      notify_proxy(wait, ret);
>  }
> =20
> +/* TODO: confirm memtx attrs. */
> +static void process_bar_write(MPQemuMsg *msg, Error **errp)
> +{
> +    bar_access_msg_t *bar_access =3D &msg->data1.bar_access;
> +    AddressSpace *as =3D
> +        bar_access->memory ? &address_space_memory : &address_space_io;
> +    MemTxResult res;
> +
> +    assert(is_power_of_2(bar_access->size) &&
> +           bar_access->size <=3D sizeof(uint64_t));

Please return an error instead of asserting. At the moment it doesn't
matter much but this will be necessary so that a process hosting remote
devices for multiple guests cannot be killed by one malicious guest.

> +
> +    res =3D address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIE=
D,
> +                           (uint8_t *)&bar_access->val, bar_access->size=
,

Missing uint64_t val to void* conversion code.

For example, if bar_access->size is 1 then this fails on big-endian
hosts because &bar_access->val is the address of the most-significant
byte in uint64_t val:

  uint64_t val =3D 1;

Now we have the following memory layout on big-endian hosts:

  val =3D 00 00 00 00  00 00 00 01
        ^-------------- &val

We actually wanted a 1-byte write of 0x01 and not 0x00.

--4wkndigzIeYF6Hbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66sIoACgkQnKSrs4Gr
c8jPYAf/SDzEgZuJWacocvBP31417PyG9RYjLPdYThFUsNfSaIQz5QC/xfxCq9ii
7Ydap9Sv3gEPdC4DF+i4uE5c55J+IEXPTon6T/s3ETW2u9bImyU8BBrgna1DLaTK
+CBYR7lLLKO9s4EGWwh2NwYzjW9hWm4I1qOVqtEII24ikkVunT2AmNsrNw6hLYvM
EwrAL3ldCJlg6gx4e9Br1olPYvuRf4cougIgjlxnjVNFMNd77cRyBEsca4e88Utl
MVBHR9SIVq/O0n3bELC92iWXgJBnxjyWpj6TCJvNu79wht1IVRokBT6zOlUpKeNp
vrZ6v8HOvUNcCowyips2b25C6pS8RQ==
=S6yh
-----END PGP SIGNATURE-----

--4wkndigzIeYF6Hbg--


