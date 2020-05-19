Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F113120709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L25oLa1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F113120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2bq-0003aP-1o
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jb2bH-000324-LU
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:48:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25466
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jb2bG-0004V8-I5
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589896085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PXU77jPjsHL8dTlKJ37ZZdVKMps/bICX6dHsnVES1pw=;
 b=L25oLa1AR4kOxU7OKC0QBT8pbCh7rxlaRkzShA6mcPcxivsSGG2rDXAuHTghYZ0dpGm2Iv
 Zc9aEFPmtK/Aj/ZowRsZZj8+CisWV5OZwQEw1NuyduvzKM1oJcQgM0i4K3PJzj+FfZyZBT
 IUufQa551N9PxYE5g9nVHVm1XFFJ7y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-txTpTH6tMxCGVfWWB3P53w-1; Tue, 19 May 2020 09:48:01 -0400
X-MC-Unique: txTpTH6tMxCGVfWWB3P53w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D15F51800D42;
 Tue, 19 May 2020 13:47:58 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB1156297D;
 Tue, 19 May 2020 13:47:50 +0000 (UTC)
Date: Tue, 19 May 2020 15:47:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
Message-ID: <20200519154739.0cd48192.cohuck@redhat.com>
In-Reply-To: <d72f56c0-fed0-12ea-dfa6-f3441952a30e@linux.ibm.com>
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-7-walling@linux.ibm.com>
 <d72f56c0-fed0-12ea-dfa6-f3441952a30e@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/+BTsv7=p11yznsl7hpVUNDx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Collin Walling <walling@linux.ibm.com>, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, thuth@redhat.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/+BTsv7=p11yznsl7hpVUNDx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2020 10:55:24 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 5/16/20 12:20 AM, Collin Walling wrote:
> > As more features and facilities are added to the Read SCP Info (RSCPI)
> > response, more space is required to store them. The space used to store
> > these new features intrudes on the space originally used to store CPU
> > entries. This means as more features and facilities are added to the
> > RSCPI response, less space can be used to store CPU entries.
> >=20
> > With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
> > the RSCPI command and determine if the SCCB is large enough to store a
> > complete reponse. If it is not large enough, then the required length
> > will be set in the SCCB header.
> >=20
> > The caller of the SCLP command is responsible for creating a
> > large-enough SCCB to store a complete response. Proper checking should
> > be in place, and the caller should execute the command once-more with
> > the large-enough SCCB.
> >=20
> > This facility also enables an extended SCCB for the Read CPU Info
> > (RCPUI) command.
> >=20
> > When this facility is enabled, the boundary violation response cannot
> > be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
> >=20
> > In order to tolerate kernels that do not yet have full support for this
> > feature, a "fixed" offset to the start of the CPU Entries within the
> > Read SCP Info struct is set to allow for the original 248 max entries
> > when this feature is disabled.
> >=20
> > Additionally, this is introduced as a CPU feature to protect the guest
> > from migrating to a machine that does not support storing an extended
> > SCCB. This could otherwise hinder the VM from being able to read all
> > available CPU entries after migration (such as during re-ipl).
> >=20
> > Signed-off-by: Collin Walling <walling@linux.ibm.com>
> > ---
> >  hw/s390x/sclp.c                     | 21 ++++++++++++++++++++-
> >  include/hw/s390x/sclp.h             |  1 +
> >  target/s390x/cpu_features_def.inc.h |  1 +
> >  target/s390x/gen-features.c         |  1 +
> >  target/s390x/kvm.c                  |  4 ++++
> >  5 files changed, 27 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> > index 755f5f3fab..bde4c5420e 100644
> > --- a/hw/s390x/sclp.c
> > +++ b/hw/s390x/sclp.c
> > @@ -56,6 +56,18 @@ static bool sccb_has_valid_boundary(uint64_t sccb_ad=
dr, uint32_t code,
> >      uint64_t allowed_len =3D (sccb_addr & PAGE_MASK) + PAGE_SIZE;
> > =20
> >      switch (code & SCLP_CMD_CODE_MASK) {
> > +    case SCLP_CMDW_READ_SCP_INFO:
> > +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
> > +    case SCLP_CMDW_READ_CPU_INFO:
> > +        /*
> > +         * An extended-length SCCB is only allowed for RSCPI and RSCPU=
 and is

Nit: I had to stare at this for a bit before I figured out what the
acronyms refer to.

> > +         * allowed to exceed the 4k boundary. The respective commands =
will
> > +         * set the length field to the required length if an insuffici=
ent
> > +         * SCCB length is provided.
> > +         */
> > +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
> > +            return true;
> > +        }
> >      default:
> >          if (current_len <=3D allowed_len) {
> >              return true;

(...)

> > diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> > index 8ddeebc544..6857f657fb 100644
> > --- a/target/s390x/gen-features.c
> > +++ b/target/s390x/gen-features.c
> > @@ -522,6 +522,7 @@ static uint16_t full_GEN12_GA1[] =3D {
> >      S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
> >      S390_FEAT_AP_FACILITIES_TEST,
> >      S390_FEAT_AP,
> > +    S390_FEAT_EXTENDED_LENGTH_SCCB,
> >  };
> > =20
> >  static uint16_t full_GEN12_GA2[] =3D {
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index 69881a0da0..380fb81822 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -2456,6 +2456,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *m=
odel, Error **errp)
> >          KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
> >          set_bit(S390_FEAT_AP, model->features);
> >      }
> > +
> > +    /* Extended-Length SCCB is handled entirely within QEMU */
> > +    set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
> > + =20
>=20
> We need to fence this for secure guests as the SIDA is only 4k at the
> moment.
>=20
> Do we need to take extra steps for migration safety?
> I guess this is only available with host-passthrough or -model?

What do you mean with '-model'? I think it can be added manually
everywhere? But I'm always a bit confused by cpu models.

>=20
> >      /* strip of features that are not part of the maximum model */
> >      bitmap_and(model->features, model->features, model->def->full_feat=
,
> >                 S390_FEAT_MAX);
> >  =20
>=20
>=20


--Sig_/+BTsv7=p11yznsl7hpVUNDx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl7D43sACgkQ3s9rk8bw
L69LTw/+LR9+ujJTuWh0vtYN+HBDUjbVF78aFgv0KiL1XOViEPDSAaPAgOvEJS70
ucJB+3Z5U2W4m8tCKax6cUQELuZ088z6ZeAltXUFzI7aifBD9fOMAAljqK6ACgyv
DnZ8JME0y8fE2kj07VBAtsek/GGrLZwYRfe9lTVsPttYNAn36LfcCtmkN73wwLnV
lT+lfmwgaFldZNZk5SiAQrEAn6Ywfk0gJ5YVXKpoYQO99e3N9sGdv0HHVNDeA81Y
CWyAwuRZf/0SwF0Rf4nGWPdE4awQcgaA1fCfiaNZyM5UofFhQCWrhCQRKhhfIm8z
sI2gahaSgAGKbZVe5LRBbjc3zXHconVJmuolfd8Z6LWAn/X8NfOtSBmX1JaBKv1W
QOFLMX0B9Mrs6Nw4vCkoDBcujYk9P99hj7r/V9nrbXZmRYqwZklIviAOBAD+NlXX
eXQpyQVUbG9oYnWxUToec8iQ3A8dE3vuFV1ZuK0AFy0v/8ooXtURgRMYP5pTxLff
O4FFk+nhLRxr2WT93AIm2bbkWxnZWqMNPbShEK/6tgc7ioEOUa2PEuMb+xKz3gRs
ydMqe502CsSkjkqKhNb1gRuKMz1OnrtUs4PcN5k51jC9I2E/vi/Bqu1DYaIvGuU9
0jFIVAQjs7DIdYtucTYxFQ6cgHY/duuTXstTjx6qVHSX27F2jbo=
=Sw2j
-----END PGP SIGNATURE-----

--Sig_/+BTsv7=p11yznsl7hpVUNDx--


