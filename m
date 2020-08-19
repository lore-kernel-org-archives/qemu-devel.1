Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B16020738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwGZD8bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B16020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Kg7-00088y-H3
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 05:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8KfP-0007gm-53
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:45:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34899
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8KfN-0003WI-4R
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597830355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MARuY4kLnUtSw0LwUB4fJ6RAbbPVRCHQx+PnovYyUFw=;
 b=KwGZD8bRGcAFeBTZefeckRrRSUq07mwepExqEiJNRl9d86oBdFNkYo5121BDdKGFlowDy9
 FNs+hJWtC4yG16R6Xqs+TXzGgtsihP8tAiUgqGYUVj7k4MemzSCY22oijaI/8/65klmIHM
 57olnX1s7+GqPBMWEUFpv29g/sAYDjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-chuyhwN4PV6EnjIKaLAGZw-1; Wed, 19 Aug 2020 05:45:52 -0400
X-MC-Unique: chuyhwN4PV6EnjIKaLAGZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 423071007466;
 Wed, 19 Aug 2020 09:45:51 +0000 (UTC)
Received: from gondolin (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 127297DFDD;
 Wed, 19 Aug 2020 09:45:49 +0000 (UTC)
Date: Wed, 19 Aug 2020 11:45:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH] pc-bios: s390x: Only set lowcore iplb address on
 list-directed IPL
Message-ID: <20200819114538.7485d580.cohuck@redhat.com>
In-Reply-To: <173257e9-a6cb-48a5-62ed-794c060e3900@linux.ibm.com>
References: <20200817141734.5109-1-jjherne@linux.ibm.com>
 <20200817183048.30cb6f9e.cohuck@redhat.com>
 <f232a187-c989-cf77-52e5-2e31678e5bed@linux.ibm.com>
 <173257e9-a6cb-48a5-62ed-794c060e3900@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/40ylJyRkN/1PHPk7RIdXZjn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
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
Cc: jjherne@linux.ibm.com, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/40ylJyRkN/1PHPk7RIdXZjn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2020 11:32:34 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 8/17/20 7:51 PM, Jason J. Herne wrote:
> > On 8/17/20 12:30 PM, Cornelia Huck wrote: =20
> >> On Mon, 17 Aug 2020 10:17:34 -0400
> >> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> >> =20
> >>> The POP states that the IPLB location is only written to 0x14 for
> >>> list-directed IPL. Some operating systems expect 0x14 to not change o=
n
> >>> boot and will fail IPL if it does change.
> >>>
> >>> Fixes: 9bfc04f9ef6802fff0 =20
> >>
> >> Should be
> >>
> >> Fixes: 9bfc04f9ef68 ("pc-bios: s390x: Save iplb location in lowcore")
> >> =20
> >>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >>> Reviewed-by: Janosch Frank <frankja@de.ibm.com>
> >>> ---
> >>>   pc-bios/s390-ccw/jump2ipl.c | 5 ++++-
> >>>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.=
c
> >>> index 767012bf0c..5e3e13f4b0 100644
> >>> --- a/pc-bios/s390-ccw/jump2ipl.c
> >>> +++ b/pc-bios/s390-ccw/jump2ipl.c
> >>> @@ -33,7 +33,10 @@ void jump_to_IPL_code(uint64_t address)
> >>>   {
> >>>       /* store the subsystem information _after_ the bootmap was load=
ed */
> >>>       write_subsystem_identification();
> >>> -    write_iplb_location();
> >>> +
> >>> +    if (iplb.pbt !=3D S390_IPL_TYPE_CCW) {
> >>> +            write_iplb_location();
> >>> +    } =20
> >>
> >> What happens for ipl types other than CCW and FCP? IOW, should that
> >> rather be a positive check for S390_IPL_TYPE_FCP?
> >> =20
> >>>  =20
> >>>       /* prevent unknown IPL types in the guest */
> >>>       if (iplb.pbt =3D=3D S390_IPL_TYPE_QEMU_SCSI) { =20
> >> =20
> >=20
> > Based on my (admittedly limited) understanding of the architecture and
> > code, I believe write_iplb_location() should be called at least for
> > S390_IPL_TYPE_FCP but I'm not 100% sure on S390_IPL_TYPE_QEMU_SCSI.
> > Perhaps Janosch has an idea?
> >=20
> > It was originally unconditional, and my new conditional excludes vfio
> > CCW which is definitely a step in the right direction, in any case :). =
=20
>=20
> If I remember correctly the problem was that ZIPL used the IPLB lowcore
> ptr without checking how it was booted (CCW or FCP). That was fixed in
> mid of July by testing if diag308 gives back a config or not.

So we have the problem that old zipl relies on the presence of a value
that must not be there if you follow the architecture? Nasty.

(Is it really "must not change" vs "don't expect anything here"? Not
sure if I'm looking at the right part of the documentation.)

> So we might have a deadlock situation here which I need to think about
> for a bit. I'm setting Viktor CC to get a bit more information about the
> state of the zipl backports into the distros.

Changing this is problematic unless everything we support as a guest is
fixed. Does the guest go boom in a way that it is at least easy to
figure out what went wrong? What breaks when the value continues to be
set?

--Sig_/40ylJyRkN/1PHPk7RIdXZjn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl889MMACgkQ3s9rk8bw
L69UDA/9EGJcW+k216aRadEt1YOWH4XdjdJM/7LokHSujkjw6ezfCdoDtzee7uq8
COWnzLqjftEWOqsPgqJ9WQhv72RDRXXoezrxT4W4CoW4f8nBpCsOZGZFxbwJgOBN
TsMI3LjOVhLJsO2+HU1X4H2Fhk9k8dtlmirOhNv0wxR3OGjqi+u70cNgoBIaC38y
ziSCDb9iCl4nQrMT3mWUNhZCOpH0ijoWs/zJO/jIDKjr5maj/+puuiwJgyI6dYhL
O/9sQpR3OnrAia1BShFCBs0Kmg2iJwMpAsME5dWN9z0dTkzk46ztDDmm0buVeNl3
9dL6QWjiZnWwbvaHKqvmIF1qPXTCf+rs8lx3pHbcxPyvPMCWeA9ZN0wVgJvKsE51
3ezBk5RarxupbOJTAH9v70p+jBwlgBUMLQobPY0I/4ZIKLIac4OPDr9dtkLR4GwG
XNAaMFGfHqFjx7Gu5MHmSh3adK+e1qBhQy4e0HxiSUFsWZ4r27gEyX3bBE1BMMTt
Krm6SmzO9Uob5XvGW5h5+dB6wwelZ9KIwRYtRSQ6MwLiqKGVo7W2/9qp8EAL5xxo
rdpv8Ww/ods+w2lNYJG+yrULvIdB+GwyY7pcz6cX36g5RWPNlr5gtXMgK0L/8tV2
lGCOz/sOkRZpb8wNuB8O7YLxCTLxO54szVm5NZK8codW58kcpbM=
=CzcB
-----END PGP SIGNATURE-----

--Sig_/40ylJyRkN/1PHPk7RIdXZjn--


