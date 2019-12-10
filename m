Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBFEC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 20:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD56A24656
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 20:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaDfZgJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD56A24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ielho-0005at-OT
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 15:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ielh6-00058I-MO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 15:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ielh5-0001Aq-Nl
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 15:01:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ielh5-0001AV-Jd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 15:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576008075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEAUEOB7LB+RypVO7eHlN1fn53tR2X/eYnhGrNV5zco=;
 b=YaDfZgJXDj7TOihObgZRRJ2o/sUb1EReOEA1kFnKpaut5/OT/u7Z0BZyoVh3eqI4pQKjDb
 QcML1bL5AlCtSt0l47JsQpORctwQ17FFUR8EZihbRvZzLT1Iy0CPbFUDMcwsuWO4Gqi68g
 Zl2+yeKdgw58GQPJycwiKBxcl697xkk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-JRDL4i87NXqszYlCN3FJmA-1; Tue, 10 Dec 2019 15:01:13 -0500
Received: by mail-qt1-f197.google.com with SMTP id e37so2738175qtk.7
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 12:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qmighPdvFfuz6us6owSwdskxRzaylH0auzyFxMqRTtU=;
 b=srM7/Cwoqp4gOuAbxcBCuuMZuY32W5dvvKMzjkZDIYqoOtnzzgTDDYfXkRZ8hYC0lg
 B2wQ5AkBNs8mwOkifSMg6Ocs4lxzrdfRl6Ah5Eg/bk6zCfKYs1w+1zQiPIPxd9rq7hnU
 XoQrc/rZU1uUVJcg2/G6jspaKwqKpRa/NV1V4vTLPBWzsM2mzEJjjwWo4ONTpGRP0GYG
 NaT06/8wTtXBJOfYixa2nLzqREa1GqXqIKWzVwME6UrK7avmkcVkHF+yMZV4sE5i4foT
 IhlBwVukIFkuqPDkd2hPJtJw6u0bNbtvChydxmNkLI0ZycOrdalfFfaI0GBJtyajmw1e
 d1rQ==
X-Gm-Message-State: APjAAAWExiavQ/Cl4SIKAH5MOcgPbebIpE8HFse8yT/SkT+sPRWt5FcS
 FlFDDsFoU5EC3kXThua5O9X0q0nc4NXBuBuuWDvlcBKMKmxaC959AsaiTdl+fl/4f/3NCAnd/0D
 Q24Pcj2AovCaLcDI=
X-Received: by 2002:a37:b883:: with SMTP id i125mr35081945qkf.64.1576008073409; 
 Tue, 10 Dec 2019 12:01:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpKHR7Ukvyt8IrO1Iy5+7e6MLiWMUJIH4b7HaDp6iANDVzOuauwL4uTfz72zlcCOaj76dxxA==
X-Received: by 2002:a37:b883:: with SMTP id i125mr35081915qkf.64.1576008073111; 
 Tue, 10 Dec 2019 12:01:13 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id t11sm1219316qkm.92.2019.12.10.12.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 12:01:12 -0800 (PST)
Date: Tue, 10 Dec 2019 15:01:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 18/20] virtio-iommu: Support migration
Message-ID: <20191210200110.GM3352@xz-x1>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-19-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-19-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: JRDL4i87NXqszYlCN3FJmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:41PM +0100, Eric Auger wrote:
> +static const VMStateDescription vmstate_virtio_iommu_device =3D {
> +    .name =3D "virtio-iommu-device",
> +    .minimum_version_id =3D 1,
> +    .version_id =3D 1,
> +    .post_load =3D iommu_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 1,
> +                                   &vmstate_domain, viommu_domain),
> +        VMSTATE_GTREE_DIRECT_KEY_V(endpoints, VirtIOIOMMU, 1,
> +                                   &vmstate_endpoint, viommu_endpoint),

IIUC vmstate_domain already contains all the endpoint information (in
endpoint_list of vmstate_domain), but here we migrate it twice.  I
suppose that's why now we need reconstruct_ep_domain_link() to fixup
the duplicated migration?

Then I'll instead ask whether we can skip migrating here?  Then in
post_load we simply:

  foreach(domain)
    foreach(endpoint in domain)
      g_tree_insert(s->endpoints);

It might help to avoid the reconstruct_ep_domain_link ugliness?

And besides, I also agree with Jean that the endpoint data structure
could be reused with IOMMUDevice somehow.

Thanks,

--=20
Peter Xu


