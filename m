Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD0FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57255206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHOKtDtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57255206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnKBe-0000Pj-Hw
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 07:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnJvP-000822-Ks
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:43:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnJvK-0005SV-RD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592822614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8jroUMTtqHgyfj6zDgLfj7JEy6m2gxBWWnqpZyXCGM=;
 b=MHOKtDtk/z2YrCdkFUO/ZOw0XKjbT/EQaYuJyqpekA97DUL9GRnT0BXG3GztTRaTa7aQiP
 Zczr5z/R1YZ6WWLxtEA56QdbweiD3PPVBgH/ObpOwystQjByLeAlOMp92UDwMypSF3DZhh
 xNXwptfQhTHvg7Mo8oghiExfjTYiiPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-HcCQDzt-OgihJduhhATavQ-1; Mon, 22 Jun 2020 06:43:30 -0400
X-MC-Unique: HcCQDzt-OgihJduhhATavQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3955B1005513;
 Mon, 22 Jun 2020 10:43:29 +0000 (UTC)
Received: from gondolin (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46FA37167B;
 Mon, 22 Jun 2020 10:43:21 +0000 (UTC)
Date: Mon, 22 Jun 2020 12:43:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 3/8] s390/sclp: rework sclp boundary and length checks
Message-ID: <20200622124309.62c5bfb3.cohuck@redhat.com>
In-Reply-To: <afb07359-bfaf-90ee-f68b-9b31e6a7445e@linux.ibm.com>
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-4-walling@linux.ibm.com>
 <afb07359-bfaf-90ee-f68b-9b31e6a7445e@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/qMY4.gWpLFqevOO+wE1EhxE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: Collin Walling <walling@linux.ibm.com>, david@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, thuth@redhat.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/qMY4.gWpLFqevOO+wE1EhxE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2020 12:50:11 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 6/19/20 12:22 AM, Collin Walling wrote:
> > Rework the SCLP boundary check to account for different SCLP commands
> > (eventually) allowing different boundary sizes.
> >=20
> > Move the length check code into a separate function, and introduce a
> > new function to determine the length of the read SCP data (i.e. the siz=
e
> > from the start of the struct to where the CPU entries should begin).
> >=20
> > The format of read CPU info is unlikely to change in the future,
> > so we do not require a separate function to calculate its length.
> >=20
> > Signed-off-by: Collin Walling <walling@linux.ibm.com> =20
>=20
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>=20
> > --- =20
> [...]
> > +/*
> > + * The data length denotes the start of the struct to where the first
> > + * CPU entry is to be allocated. This value also denotes the offset_cp=
u
> > + * field.
> > + */
> > +static inline int get_read_scp_info_data_len(void)
> > +{
> > +    return offsetof(ReadInfo, entries);
> > +}
> > +
> >  /* Provide information about the configuration, CPUs and storage */
> >  static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
> >  {
> > @@ -74,17 +112,16 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *=
sccb)
> >      int cpu_count;
> >      int rnsize, rnmax;
> >      IplParameterBlock *ipib =3D s390_ipl_get_iplb();
> > +    int data_len =3D get_read_scp_info_data_len(); =20
>=20
> Does somebody have a better name than data_len at hand?

I could not come up with anything better, either :(

(...)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

--Sig_/qMY4.gWpLFqevOO+wE1EhxE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl7wiz0ACgkQ3s9rk8bw
L6+RWQ//YzOSCM3+QNfvTY9C0iVNWLXaBccDeJOc4vv3jgUzVxj6LKU3koYAhtCb
StC5cuoySvXPwdQzmWcoXdg+0LlocxhOiMUzP/J8jTROwesyZ9bCJ1QqbC4zxbqp
fVriB1juSo8ZRNbRI8H6gsbL7KTjFiOXGx6k2AKnXsC/CWrzpXzjpmTKk9kokWg6
I8XQaNUCqnOxqFRvqJGMpIPfTq2nNRva6RYbkPH6XcVtjAesLNasjr4CHvOnfbYT
jzIbJo51cBDsxkl5eOCTcDGJPZPJ1Tsy47qBaB8eSNvILNvjDJy83ToVKj2nNCgV
u61d/fZ7T5/AD+Uq8taL+5ZQGOkpgj7hHmO50b5iMDQuZ6v49G3wPWy/Zod1GZO6
4PNYUjnhzTsXqjf/M71xTtWtkPo5wwX4rVrfUkdFbthIwjBxvB+FhmNZm2/wfuAG
URXngfh0t9n2EJeVRD9hGZTwsFRLdjEfEcmRsoIVxjI2eCPt2Jf//5L2mxrrYz0N
lIgO5qPp/lJBXJZs4UTa/uIyLl1/2aRKWExVIvDOmnkPCwNDj87qyz9nuqFD3SZM
7XudvDedFMKeJgKS5MDFAinAmqQ9We0JN3sByJKPS2Tu/UEjjFiNpUh+ZhfBWKsl
hyHXRHFwf7mUrnSmavW9op1THd7IBJYWUJdnJfW32bpUROrr/zo=
=GSva
-----END PGP SIGNATURE-----

--Sig_/qMY4.gWpLFqevOO+wE1EhxE--


