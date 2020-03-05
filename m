Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8745DC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 11:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517A1208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 11:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4e+ZeUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517A1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9oXD-00048D-FA
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 06:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j9oWY-0003XI-GO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 06:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j9oWW-0000zq-RL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 06:18:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52314
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j9oWW-0000yu-JZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 06:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583407119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrVtzktr0qiOU8ITwSEN0ihc/kYonAkgE5cdM+DSZys=;
 b=A4e+ZeUgCQCiAp4VIy3DPwwjsC5eRXeeMACFZZUfL3bMWKjSCjdwQR496Ar7iyRtfHg/k/
 WMzSH8y0Bxfp/sqgs1w3cXxacARjV+yZxFwvG7ZmI4Vh7E6w3X0iew9iZCZcGk7+44nMRa
 hvximOBae+VEdAxHFoT6UnBCLoNs/T8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-JuADljUGNQuzlqslGqaiEA-1; Thu, 05 Mar 2020 06:18:38 -0500
X-MC-Unique: JuADljUGNQuzlqslGqaiEA-1
Received: by mail-qk1-f199.google.com with SMTP id q123so3567944qkb.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 03:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kLQGRxKT3nC1QBPHTb+Z4AYfSERnI81tpjagDVFshsw=;
 b=UO3EXlLre9HIbiMXDl/+e662bhqMPRJ+FUIBup8We8OyNO7sC1fQTTnL6L5kzcbyJu
 NXCUDuB7ZrtzLbqGc2lBMvqgAnptVHAmKYW+KKucM0BYLMy29Oetn/EBG3FOKs3NmKxq
 2TDl0IK4PJn3BzlojULIoZ3v/BMsG7uaQXBOv3FLKDTAomeDZBar358Pcc/pKIwKA3Yk
 5iB9GwoVA8/nbVy5U/VIeH3l0SgjmBOujyKHqhW0D2No9GTZuvM5zTZZr2jwQMs8/0V+
 m5DoRQB43K70OBuKPXo59WaZBHFHqDcczN01/DFfuCFiSbR6BSROQiY0LNSaI/FvMGK8
 T1Gw==
X-Gm-Message-State: ANhLgQ2ZjbJaR5X6RZYlvvZgs9zLjTOSy9jRWHtj5xCVLQNP7xeWY7aL
 SXV0SkV7+fLqZ3l8oNuIMEK3myDPOpSxi7hR3vN1Uuvk9RbzRqNGJWiqUF0pmEbcNLN6K7KY1ZW
 bmoAVrG+HuteDhKo=
X-Received: by 2002:a37:b304:: with SMTP id c4mr7630518qkf.348.1583407117830; 
 Thu, 05 Mar 2020 03:18:37 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvi89OFp9a1bai4JatJvF/e2yckl006J6IaXUvmNHMnL2IjmZPTdRCi47N2iNcXyBf2+hK5hw==
X-Received: by 2002:a37:b304:: with SMTP id c4mr7630490qkf.348.1583407117532; 
 Thu, 05 Mar 2020 03:18:37 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id 69sm535439qki.131.2020.03.05.03.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 03:18:36 -0800 (PST)
Date: Thu, 5 Mar 2020 06:18:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v4] hw/i386/intel_iommu: Simplify
 vtd_find_as_from_bus_num() logic
Message-ID: <20200305061809-mutt-send-email-mst@kernel.org>
References: <20200305102702.31512-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200305102702.31512-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Liu Yi L <yi.l.liu@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 11:27:02AM +0100, Philippe Mathieu-Daud=E9 wrote:
> The vtd_find_as_from_bus_num() function was introduced (in commit
> dbaabb25f) in a code format that could return an incorrect pointer,
> which was later fixed by commit a2e1cd41ccf.
> We could have avoided this by writing the if() statement differently.
> Do it now, in case this function is re-used. The code is easier to
> review (harder to miss bugs).
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I'll queues this.

> ---
> Since v1: Re-worded commit description, patch sent without -w.
> Since v2: patch send without diff
> Since v3: Fix typo in description and comment (Eric Auger)
>=20
> This patch is easier to review with 'git-diff -w' (--ignore-all-space)
> ---
>  hw/i386/intel_iommu.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6258c58ac9..204b6841ec 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -987,24 +987,26 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, =
uint32_t level)
>  static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_=
num)
>  {
>      VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
> -    if (!vtd_bus) {
> -        /*
> -         * Iterate over the registered buses to find the one which
> -         * currently hold this bus number, and update the bus_num
> -         * lookup table:
> -         */
> -        GHashTableIter iter;
> +    GHashTableIter iter;
> =20
> -        g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> -        while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
> -            if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> -                s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
> -                return vtd_bus;
> -            }
> -        }
> -        vtd_bus =3D NULL;
> +    if (vtd_bus) {
> +        return vtd_bus;
>      }
> -    return vtd_bus;
> +
> +    /*
> +     * Iterate over the registered buses to find the one which
> +     * currently holds this bus number and update the bus_num
> +     * lookup table.
> +     */
> +    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> +    while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
> +        if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> +            s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
> +            return vtd_bus;
> +        }
> +    }
> +
> +    return NULL;
>  }
> =20
>  /* Given the @iova, get relevant @slptep. @slpte_level will be the last =
level
> --=20
> 2.21.1


