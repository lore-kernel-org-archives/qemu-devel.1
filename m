Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72002C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E121221D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVphYr1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E121221D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpVK-0001Fl-PX
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMpU6-0000Yg-BI
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMpU4-00049G-Kj
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:30:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601285411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b2UAvGXo06NJb+lyRKiai5JPEiDc+8iAGjTtXZnC1fI=;
 b=GVphYr1HjrcHF/aXF9p0J6oxMYEZWGDLQL/8YMZsRXiQGdej19C3WV6GoS2LM4JtbT0u3O
 V7pbgkWeGWMKuhhzKbUiCW58tP1/s4YeEIIMckuY+nTJZmUVnkn2t55Uwyt58N4EVCPrcA
 O37ZpYmTP/Pfzb+KAbiCylooSz3aJ90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-G6vagvQ6M4ijh-aOzB7kdA-1; Mon, 28 Sep 2020 05:30:09 -0400
X-MC-Unique: G6vagvQ6M4ijh-aOzB7kdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CD6BEDA61
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 09:30:08 +0000 (UTC)
Received: from localhost (ovpn-114-195.ams2.redhat.com [10.36.114.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8A0155798;
 Mon, 28 Sep 2020 09:30:07 +0000 (UTC)
Date: Mon, 28 Sep 2020 10:30:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/10] qdev: add "check if address free" callback for buses
Message-ID: <20200928093006.GB44353@stefanha-x1.localdomain>
References: <20200925172604.2142227-1-pbonzini@redhat.com>
 <20200925172604.2142227-2-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925172604.2142227-2-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2020 at 01:25:55PM -0400, Paolo Bonzini wrote:
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 72064f4dd4..e62da68a26 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -217,6 +217,7 @@ struct BusClass {
>       */
>      char *(*get_fw_dev_path)(DeviceState *dev);
>      void (*reset)(BusState *bus);
> +    bool (*check_address)(BusState *bus, DeviceState *dev, Error **errp);

Please document this function.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9xrR4ACgkQnKSrs4Gr
c8hnOgf/VDYmwybqAonJRBJem1z2yZ3xY2TIqXQgsFTnUqfjLcy+2CDhPK9x+IyO
ztyPGyh2dSbclP8lG39uneBkgOKNApKD2uN5KB5uGJqwaZ94X/l+75PkLb/jQX8v
XVCHPXD/nQ7kQye4V/cdUW/sCxfyo8BWl8FQ2OM+Mi2jiGt/kZ0aTgGeftsC1eZX
94SyM8fZyLc8O1LjWk9Bqd5i7K0hdqZW1O7vybXBgJIN2+TaWfUhAWYV8ThMjzQm
b1Y6AZZW2YTXg/kWmNioUfMXH+N/t4ExeweOagfRUMxqLfFvKdpqqOZ1a9jOaeKK
RRkzAgbvxxShshsrwxz8fDvbGIImuA==
=xmGv
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--


