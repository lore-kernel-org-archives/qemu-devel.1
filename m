Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D9C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F12424655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+GgilMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F12424655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdC1-0001qC-Je
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBdBG-0000wp-Qm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBdBF-000070-6z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:36:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBdBF-0008Uk-0N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/QeWrjew5MHdadd6HKuGQhvDOqE3u+1grfRaYM/OUE=;
 b=H+GgilMOVHUgvL1LMXkuGtjOeFYaW8OHGUgWVl4tKU2p2drE3BQw63qEHyJuv5IIsQ7T7w
 gi5lzAuL+wRr3xhHSu3ya7vJeP+wtxFZYRiquGFSmVml+/rCDwUKYdeS610X8vEzcwZKvz
 jsbUvJcMEeR9J/t+S6X1sWN8KGmAgdo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-3OekMIbUNYeJoZFh66J-1w-1; Tue, 10 Mar 2020 07:36:08 -0400
X-MC-Unique: 3OekMIbUNYeJoZFh66J-1w-1
Received: by mail-qk1-f197.google.com with SMTP id e13so9430836qkm.23
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q6NI13VfXDngwTrU0FSZRrix51orGlo5LGRIo9tsQDA=;
 b=J4Q4DaHCc+yhtM51xDtkgcBHhk/KN5ndo6ozR08U8C27vMpwXFfbS0aMU72alTgthC
 ffBdrI5u23aL4goDK81uf2ks7COEYDy03PHxC6BUCbDg9dPUzUmhUCiYKX2LwZ4w6DDV
 m8iMPWK/Fkjdiw5GyRdus1bz+ZWZVjVFj3Yt4ZyMPQtN/qYrJCgDML06Eb9mvdlNe1/+
 PRbkUDRZVatGMAfngInKKFeD58SJQVjZfw6B9qbTFJWeffoR2Zk1YG0QBpIzGEaIvoLb
 ysgt3P7nOzU92FYHWGjPALOCdKXOzLHslJI4amE++frzr8npoHVpWUCILTyfowk4rOVv
 YuZQ==
X-Gm-Message-State: ANhLgQ1RonHtIGNqOUkWGWOrOrRdxlBLJvqgTld36VoEDHFDIJWMfmff
 JXjyEjOEQeN0f3UUranQ4OL7/DNNDwB/KtbxF86SjgJchDYccbeiqcYaO8VOjNSGZgLEwaN0Ihs
 vl/wKcW24zJpNZ78=
X-Received: by 2002:a05:620a:10b3:: with SMTP id
 h19mr19521789qkk.440.1583840167964; 
 Tue, 10 Mar 2020 04:36:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvk0ZlXePUE2YzaJdn9B0/2uS9Lqul9oFJgi2ubEYsnnAtW5fffw3Us1YHo1bSOpDz9X5mWQA==
X-Received: by 2002:a05:620a:10b3:: with SMTP id
 h19mr19521755qkk.440.1583840167651; 
 Tue, 10 Mar 2020 04:36:07 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id i11sm9996184qka.92.2020.03.10.04.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:36:06 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:36:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 2/7] hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM
 output buffer length
Message-ID: <20200310072644-mutt-send-email-mst@kernel.org>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <20200117174522.22044-3-shameerali.kolothum.thodi@huawei.com>
 <20200206170604.12899caf@redhat.com>
 <feb0b61b1bf741219e08b8c2dc6260f8@huawei.com>
MIME-Version: 1.0
In-Reply-To: <feb0b61b1bf741219e08b8c2dc6260f8@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 11:22:05AM +0000, Shameerali Kolothum Thodi wrote:
>=20
>=20
> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: 06 February 2020 16:06
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org;
> > xiaoguangrong.eric@gmail.com; mst@redhat.com; Linuxarm
> > <linuxarm@huawei.com>; xuwei (O) <xuwei5@huawei.com>;
> > shannon.zhaosl@gmail.com; lersek@redhat.com
> > Subject: Re: [PATCH v2 2/7] hw/acpi/nvdimm: Fix for NVDIMM incorrect DS=
M
> > output buffer length
> >=20
> > On Fri, 17 Jan 2020 17:45:17 +0000
> > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> >=20
> > > As per ACPI spec 6.3, Table 19-419 Object Conversion Rules, if the
> > > Buffer Field <=3D to the size of an Integer (in bits), it will be
> > > treated as an integer. Moreover, the integer size depends on DSDT
> > > tables revision number. If revision number is < 2, integer size is 32
> > > bits, otherwise it is 64 bits. Current NVDIMM common DSM aml code
> > > (NCAL) uses CreateField() for creating DSM output buffer. This create=
s
> > > an issue in arm/virt platform where DSDT revision number is 2 and
> > > results in DSM buffer with a wrong
> > > size(8 bytes) gets returned when actual length is < 8 bytes.
> > > This causes guest kernel to report,
> > >
> > > "nfit ACPI0012:00: found a zero length table '0' parsing nfit"
> > >
> > > In order to fix this, aml code is now modified such that it builds th=
e
> > > DSM output buffer in a byte by byte fashion when length is smaller
> > > than Integer size.
> > >
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com=
>
> > > ---
> > > Please find the previous discussion on this here,
> > > https://patchwork.kernel.org/cover/11174959/
> > >
> > > ---
> > >  hw/acpi/nvdimm.c                            | 36
> > +++++++++++++++++++--
> > >  tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
> > >  2 files changed, 35 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c index
> > > 9fdad6dc3f..5e7b8318d0 100644
> > > --- a/hw/acpi/nvdimm.c
> > > +++ b/hw/acpi/nvdimm.c
> > > @@ -964,6 +964,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
> > >      Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem,
> > *elsectx2;
> > >      Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_inva=
lid;
> > >      Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf,
> > > *dsm_out_buf_size;
> > > +    Aml *whilectx, *offset;
> > >      uint8_t byte_list[1];
> > >
> > >      method =3D aml_method(NVDIMM_COMMON_DSM, 5,
> > AML_SERIALIZED); @@
> > > -1117,13 +1118,42 @@ static void nvdimm_build_common_dsm(Aml *dev)
> > >      /* RLEN is not included in the payload returned to guest. */
> > >      aml_append(method,
> > aml_subtract(aml_name(NVDIMM_DSM_OUT_BUF_SIZE),
> > >                 aml_int(4), dsm_out_buf_size));
> > > +
> > > +    /*
> > > +     * As per ACPI spec 6.3, Table 19-419 Object Conversion Rules, i=
f
> > > +     * the Buffer Field <=3D to the size of an Integer (in bits), it=
 will
> > > +     * be treated as an integer. Moreover, the integer size depends =
on
> > > +     * DSDT tables revision number. If revision number is < 2, integ=
er
> > > +     * size is 32 bits, otherwise it is 64 bits.
> > > +     * Because of this CreateField() canot be used if RLEN < Integer=
 Size.
> > > +     * Hence build dsm_out_buf byte by byte.
> > > +     */
> > > +    ifctx =3D aml_if(aml_lless(dsm_out_buf_size,
> > > + aml_sizeof(aml_int(0))));
> >=20
> > this decomplies into
> >=20
> >  If (Local1 < SizeOf ())
> >=20
> > which doesn't look right
>=20
> Ok. I tried printing the value returned(SizeOf) and that looks alright.

Well it's illegal in ACPI, it's possible that OSPMs handle it the way
you want them to, but it's probably not a good idea to assume they will
always do.

The spec says:

DefSizeOf :=3D SizeOfOp SuperName



> Anyway, changed it into aml_int(1) which decompiles to
>=20
>    If (Local1 < SizeOf (One))
>=20
> Hope this is acceptable.
>=20
> Thanks,
> Shameer

I suspect it doesn't. And going into semantics, since they are set by
ASL:


19.6.125 SizeOf (Get Data Object Size)
Syntax
SizeOf (ObjectName) =3D> Integer
Arguments
ObjectName must be a buffer, string or package object.
Description
Returns the size of a buffer, string, or package data object.
For a buffer, it returns the size in bytes of the data. For a string, it re=
turns the size in bytes of the
string, not counting the trailing NULL. For a package, it returns the numbe=
r of elements. For an
object reference, the size of the referenced object is returned. Other data=
 types cause a fatal run-time
error.


Bottom line, I don't think you can figure out the integer size like this.
What's wrong with just assuming 8 byte integers? I guess sizes 5 to 8
will be slower with a 32 bit DSDT but why is that a problem?

--=20
MST


