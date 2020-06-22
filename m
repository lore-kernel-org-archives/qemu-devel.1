Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3370C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2A620716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwtK6AzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2A620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIwW-0000YI-Tz
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnIvY-00085T-Pk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:39:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31765
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnIvX-0003O4-47
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592818781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWWD5IXSzuJBI3h2g4CCfFMs4rBKDwBSUiAax9/SRnU=;
 b=CwtK6AzWVoBl8P1rgWnGA7VWeLE8YklCR6Fhsn38Jr5c13adXmnwui236AaXflt0G8PY1k
 7f/FXrdouXOFrCfeDmRrTVE4l+ULjCeGdJ+W/+Gp4lWayBgyS6hwmXS7ca5ScUXE29cvgJ
 8pEa9q4Kn9pdTFNLW+gJMhTnVLsqjUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-psArI4JOPBuif8A3WXlMmA-1; Mon, 22 Jun 2020 05:39:34 -0400
X-MC-Unique: psArI4JOPBuif8A3WXlMmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB86F108BD0C;
 Mon, 22 Jun 2020 09:39:32 +0000 (UTC)
Received: from localhost (unknown [10.40.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A658610013D7;
 Mon, 22 Jun 2020 09:39:19 +0000 (UTC)
Date: Mon, 22 Jun 2020 11:39:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v4 1/5] acpi: Convert build_tpm2() to build_append* API
Message-ID: <20200622113915.1dce2989@redhat.com>
In-Reply-To: <ce60f439-fd2a-a72b-f004-44a01f4c5bdf@linux.ibm.com>
References: <20200611135917.18300-1-eric.auger@redhat.com>
 <20200611135917.18300-2-eric.auger@redhat.com>
 <20200616143327.2ee38a48@redhat.com>
 <3c3b466a-c965-e3f6-9bd6-74fce9c424c8@linux.ibm.com>
 <ed1b453d-2568-2134-3e86-c268e82a90f8@redhat.com>
 <ded58c6b-dcea-67ef-4f3c-b8af9f149ae8@redhat.com>
 <44663542-8352-2398-a297-3e1fe7f4bfd5@redhat.com>
 <ce60f439-fd2a-a72b-f004-44a01f4c5bdf@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, mst@redhat.com,
 philmd@redhat.com, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org,
 Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, Laszlo Ersek <lersek@redhat.com>, ardb@kernel.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 07:19:51 -0400
Stefan Berger <stefanb@linux.ibm.com> wrote:

> On 6/19/20 5:43 AM, Auger Eric wrote:
> > Hi Laszlo,
> >
> > On 6/19/20 11:38 AM, Laszlo Ersek wrote: =20
> >> On 06/18/20 09:50, Auger Eric wrote: =20
> >>> Hi Stefan, Igor,
> >>>
> >>> On 6/16/20 4:11 PM, Stefan Berger wrote: =20
> >>>> On 6/16/20 8:33 AM, Igor Mammedov wrote: =20
> >>>>> nevertheless looks like faithfull conversion,
> >>>>> btw why you didn't drop Acpi20TPM2 structure definition?
> >>>>> =20
> >>>> If we get rid of the table we should keep a reference to this docume=
nt,
> >>>> table 7: "TCG ACPI Specification; Family 1.2 and 2.0; Level 00 Revis=
ion
> >>>> 00.37, December 19, 2014"
> >>>>
> >>>> https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneral=
Specification_1-10_0-37-Published.pdf
> >>>>
> >>>>
> >>>> =20
> >>> Further looking at this spec, the log_area_minimum_length and
> >>> log_area_start_address only are described in
> >>> - Table 2 (TCG Hardware InterfaceDescription Table Format for TPM 1.2
> >>> Clients)
> >>> - Table 4 (TCG Hardware Interface Description Table Format for TPM 1.=
2
> >>> Servers)
> >>> but not in Table 7, ie. not for TPM 2.0.
> >>>
> >>> Are they really needed for TPM2 or what do I miss? =20
> >> (side comment:
> >>
> >> LASA and LAML are optional with TPM-2.0. From the discussion at
> >> <https://bugzilla.tianocore.org/show_bug.cgi?id=3D978>. =20
>=20
>=20
> They are needed for (x86) BIOS, such as SeaBIOS, not for UEFI, though. I=
=20
> do not know about ARM.
>=20
>=20
> > Thank you for the pointer and info. I failed to find this info in the
> > spec. Given the risk of confusion, I would personally keep struct
> > Acpi20TPM2 and maybe add a comment. Stefan? =20
>=20
> Either way is fine with me for as long as we know where to find the=20
> layout of the structure.
I'd remove Acpi20TPM2 as it hardly documents anything, and add a comment
pointing to the concrete spec that has these fields.

TCGTCG ACPI SpecificationFamily =E2=80=9C1.2=E2=80=9D and =E2=80=9C2.0=E2=
=80=9DVersion 1.2,Revision 8

>=20
>  =C2=A0 Stefan
>=20
> >
> > Thanks
> >
> > Eric =20
> >> )
> >>
> >> Thanks
> >> Laszlo
> >> =20
>=20


