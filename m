Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CEBC17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA23621783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7vcbcyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA23621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUW6r-0001Qe-0z
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 08:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iUW6A-0000z8-EJ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iUW68-0001xM-DP
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:20:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iUW68-0001x7-8r
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573564843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlG5O2hVJ20iW9wms5ZsUSA77BRb1fC28njHMoqPd1Q=;
 b=A7vcbcyXJoekNmwQ5QZDOQSXvMIWWIscxO5UwPqGUN+g2wLmHBX3ACiIo344a2ceGFVeSp
 2+XVaqHluOsjKftDVhedJa03RNsjqfRpPM4Sd4n4+tP8CkeizzoBz33cku4IlZNLlDRr8A
 u8ePKOdZXkDgJBIwnyq4i8xpxlCYFn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-CR1zzPs1NGi0y74tbx0mDg-1; Tue, 12 Nov 2019 08:20:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 105E7107ACC5;
 Tue, 12 Nov 2019 13:20:39 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A43E310027B3;
 Tue, 12 Nov 2019 13:20:31 +0000 (UTC)
Date: Tue, 12 Nov 2019 14:20:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 028/126] s390x: introduce ERRP_AUTO_PROPAGATE
Message-ID: <20191112142029.48de0602.cohuck@redhat.com>
In-Reply-To: <20191011160552.22907-29-vsementsov@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-29-vsementsov@virtuozzo.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: CR1zzPs1NGi0y74tbx0mDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, armbru@redhat.com,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 19:04:14 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp =3D=3D &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>=20
> If we want to check error after errp-function call, we need to
> introduce local_err and than propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>    &error_fatel, this means that we don't break error_abort

s/fatel/fatal/ :)

>    (we'll abort on error_set, not on error_propagate)
>=20
> This commit (together with its neighbors) was generated by
>=20
> for f in $(git grep -l errp \*.[ch]); do \
>     spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>     --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff $f;=
 \
> done;
>=20
> then fix a bit of compilation problems: coccinelle for some reason
> leaves several
> f() {
>     ...
>     goto out;
>     ...
>     out:
> }
> patterns, with "out:" at function end.

I think you missed one of those...

>=20
> then
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>=20
> (auto-msg was a file with this commit message)
>=20
> Still, for backporting it may be more comfortable to use only the first
> command and then do one huge commit.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  hw/intc/s390_flic_kvm.c    |  9 ++++-----
>  hw/s390x/3270-ccw.c        | 13 ++++++-------
>  hw/s390x/css-bridge.c      |  7 +++----
>  hw/s390x/css.c             |  7 +++----
>  hw/s390x/s390-skeys.c      |  7 +++----
>  hw/s390x/s390-virtio-ccw.c | 11 +++++------
>  hw/s390x/sclp.c            | 15 ++++++---------
>  hw/s390x/tod-kvm.c         | 14 ++++++--------
>  hw/vfio/ccw.c              | 24 +++++++++++-------------
>  target/s390x/cpu.c         | 26 ++++++++++++--------------
>  10 files changed, 59 insertions(+), 74 deletions(-)
>=20
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index cedccba8a9..5550cecef8 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -578,14 +578,14 @@ typedef struct KVMS390FLICStateClass {
> =20
>  static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      KVMS390FLICState *flic_state =3D KVM_S390_FLIC(dev);
>      struct kvm_create_device cd =3D {0};
>      struct kvm_device_attr test_attr =3D {0};
>      int ret;
> -    Error *errp_local =3D NULL;
> =20
> -    KVM_S390_FLIC_GET_CLASS(dev)->parent_realize(dev, &errp_local);
> -    if (errp_local) {
> +    KVM_S390_FLIC_GET_CLASS(dev)->parent_realize(dev, errp);
> +    if (*errp) {
>          goto fail;
>      }
>      flic_state->fd =3D -1;
> @@ -593,7 +593,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, E=
rror **errp)
>      cd.type =3D KVM_DEV_TYPE_FLIC;
>      ret =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
>      if (ret < 0) {
> -        error_setg_errno(&errp_local, errno, "Creating the KVM device fa=
iled");
> +        error_setg_errno(errp, errno, "Creating the KVM device failed");
>          trace_flic_create_device(errno);
>          goto fail;
>      }
> @@ -605,7 +605,6 @@ static void kvm_s390_flic_realize(DeviceState *dev, E=
rror **errp)
>                                              KVM_HAS_DEVICE_ATTR, test_at=
tr);
>      return;
>  fail:
> -    error_propagate(errp, errp_local);

...namely, here. (You probably did not compile on a s390x, so this file
was not built.)

>  }
> =20
>  static void kvm_s390_flic_reset(DeviceState *dev)

The rest of the transformations look sane.


