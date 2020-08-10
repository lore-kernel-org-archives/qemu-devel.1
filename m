Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B1DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7696522D06
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOCGLx4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7696522D06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59jk-0006tl-NC
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k59id-0005zz-Pk
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:28:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k59ia-0007Bo-7d
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597073287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrpsLEhuZ2KmeHpr/0FHwzpbJlrl9yKwIh93XpK3npM=;
 b=SOCGLx4x+BFj6cGc9DdwZI58YdZmfas73zYxAKpONcpi9ifRWFsijzXu687hCAJETKoDgW
 MVkGLOtLQE5hb7/oUX37xwBd+WqlJzrn12bVOLPWAAQHKwz0hcSC9nSUlCUI2uZSlplojX
 bmT46273S2ljGRo6Oyu0NukAq/gTCOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-_h7Kh6UnM5CXIqCxbTItpg-1; Mon, 10 Aug 2020 11:28:03 -0400
X-MC-Unique: _h7Kh6UnM5CXIqCxbTItpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A7B801504;
 Mon, 10 Aug 2020 15:28:01 +0000 (UTC)
Received: from localhost (ovpn-114-132.ams2.redhat.com [10.36.114.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6498687D60;
 Mon, 10 Aug 2020 15:27:48 +0000 (UTC)
Date: Mon, 10 Aug 2020 16:27:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 10/20] multi-process: setup memory manager for remote
 device
Message-ID: <20200810152745.GA66474@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <2bebe51b049f2f6583c5227fc12a60c63229a2f6.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <2bebe51b049f2f6583c5227fc12a60c63229a2f6.1596217462.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 02:20:17PM -0400, Jagannathan Raman wrote:
> +    QTAILQ_FOREACH_SAFE(subregion, &sysmem->subregions, subregions_link, next) {
> +        if (subregion->ram) {
> +            memory_region_del_subregion(sysmem, subregion);
> +            object_unparent(OBJECT(subregion));
> +        }
> +    }

Where is g_free(subregion) called?

> +
> +    for (region = 0; region < msg->num_fds; region++) {
> +        subregion = g_new(MemoryRegion, 1);
> +        name = g_strdup_printf("remote-mem-%u", suffix++);
> +        memory_region_init_ram_from_fd(subregion, NULL,
> +                                       name, sysmem_info->sizes[region],
> +                                       RAM_SHARED, msg->fds[region],
> +                                       sysmem_info->offsets[region],
> +                                       &local_err);
> +        g_free(name);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            break;

Where is g_free(subregion) called?

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8xZ3EACgkQnKSrs4Gr
c8jVeAf/Rhz5a7F1ySiRx3jaZc8AGsHXI93d+xdlwLN/0qJw3JBrqQ6LjQLPAJCX
/yFz8WDGF4R2eF6PPdcyD4uhRkuzveYTGWE8f+X/Syp5+tY21ftW5RIIpIBIyOTF
H5uqbe1SIy1hTPbE9PtmhI79WZgwCPWemhvL1IgSpRTLmO3ibDhUwSi5RKLh5hWD
NmnIGRQHVN68Jw2bb2yym+dxIaQTjzIgiLQL3kX9TOik0Et4U4LPPqQwYy+3pDhx
apxMLQ2mCMysJjHLRqXLXHNavQgcT/NN+YaMl2osyFfpefOHYAobc2G4hCLXY4Uz
3eOkFrkci2rvleDM7xEmMF/844zR0Q==
=nhHw
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


