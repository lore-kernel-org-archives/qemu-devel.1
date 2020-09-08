Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B15C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BFD20678
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0weB8Ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BFD20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFgRM-000726-Cz
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFgQg-0006LZ-Rb
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:25:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41379
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFgQd-0008Ou-Pw
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599582304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgyNLHi3NRemLLN4O+QaOvclixLkYB5Y+xpik9DDl8Q=;
 b=T0weB8Ad22b/2wfCLM7Opk6CzE9xxL4tQEyXRqSU7uRRKJjv8M08wGRbrDQhlo44FFIjva
 jzf+F0PJVWW+6kFJhuewCskwEUuApg5EjYYC1F1IDpcaQ1WCTaHwlk7SDY4BqcCZP01SoV
 qW8xugnPbaBpx0jXdTtnv4+pQWWEr8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-v-x2lh7INzemWIZXnvbElA-1; Tue, 08 Sep 2020 12:23:33 -0400
X-MC-Unique: v-x2lh7INzemWIZXnvbElA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAC7E1005504;
 Tue,  8 Sep 2020 16:23:32 +0000 (UTC)
Received: from localhost (ovpn-112-16.ams2.redhat.com [10.36.112.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDDF27C21;
 Tue,  8 Sep 2020 16:23:31 +0000 (UTC)
Date: Tue, 8 Sep 2020 17:23:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jacob Prida <jacob.prida@protonmail.com>
Subject: Re: Question regarding packet sniffing from a guest KVM
Message-ID: <20200908162328.GG7154@stefanha-x1.localdomain>
References: <JAKyy2sEdENiHm11y9YsYIrKKGYoGLfCrQcKqEtfg6hVUr5OSmmzujHFhAdd3tdfqonybfaBzBNf7ZhipGhHpX59Uzr-LwjBwgpqGgt_aGA=@protonmail.com>
MIME-Version: 1.0
In-Reply-To: <JAKyy2sEdENiHm11y9YsYIrKKGYoGLfCrQcKqEtfg6hVUr5OSmmzujHFhAdd3tdfqonybfaBzBNf7ZhipGhHpX59Uzr-LwjBwgpqGgt_aGA=@protonmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "stefanha@gmail.com" <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2020 at 01:37:00PM +0000, Jacob Prida wrote:
> I saw your blog post (http://blog.vmsplice.net/2011/04/how-to-capture-vm-=
network-traffic-using.html) on packet sniffing, and was wondering if I coul=
d get your advice on a problem I'm having.
>=20
> I posted this question to stackexchange as well (https://unix.stackexchan=
ge.com/questions/606722/can-i-sniff-packets-on-a-host-interface-macvtap-thr=
ough-a-guest-os-on-qemu-kvm) but here is my problem:
>=20
> I want to packet sniff a physical NIC from a guest VM. The guest VM is wi=
ndows 10 with Wireshark/npcap. I want to setup the virtual network interfac=
e to enable this packet sniffing. The host OS is RHEL 7. Currently, I have =
the VM connected to a macvtap interface for the physical device I want to s=
niff, but I am not seeing any data on Wireshark.
>=20
> Any help/advice is greatly appreciated.

Hi Jacon,
Sorry for the delay, I was offline and am catching up on emails.

Wireshark in the guest should see all packets sent to the VM's MAC
address.

If you want promiscuous mode then I'm not sure if that's possible.
macvtap works by adding the VM's MAC alongside the physical NIC's MAC.
That means the guest network interface only receives packets with its
destination MAC address. But I'm not very familiar with macvtap, so
maybe someone has a different answer.

Stefan

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9XsAAACgkQnKSrs4Gr
c8jWiwgAv0ReI0gwLfn6Kqs89mYwlWfxNmq1UMXy3SQM+iM+dZsGKiGB1XiSUUUN
Cy0yqqhf8vMhOGHlaBuciNpMhGS2Ty6/l++uuhzm3Y4j9I1KUP4S8p4zWe/9jQPN
SVmiPkP0126OB5OJO7F1pcdygVkuCM65O8Mmowr9UWgl77WdrGtSqbgXFom+f83o
xz+AX3Z5ObZbBNQXrmFL3SkleMIU0fvsxBL2cAp/I1hSRB3+/qkEc6Xo33cfSMH+
DNM6u1cK8RBMdwYHbs+MRA/7U71z2yyLEV/j1+eU+U1DHPesV4RRFxUh4WdBHj+J
NoZ3723ESwfjnJfLbKxZfpnLuO6D8Q==
=1Mjk
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--


