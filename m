Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC256C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785C82220D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQ93VT0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785C82220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSCS-0003Jq-GZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kLSAc-0001VQ-TO
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kLSAa-0003Qy-2v
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600957462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnUGIOfCzH8dQsGwL9KYk3jPuL+fdtwPch7NM3noSjs=;
 b=SQ93VT0eosN+f6cGFFYy/aKpuQERn/HQ6L9om7w0CGb5m0E8R4VfPUOm5/clPaWJ6ZN1ZA
 2HZesdsDIgwH8x2lHJjd2b8xYAPYbxN6SVNkyEQ5iiL5LYsK9qCKzgiqYQ16NyRSPrKSOW
 87ur9XMP+dUfA5uLjpXdsDg5fTrIKj8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-lS_jYhRhNxGeCSyl9X0Cbw-1; Thu, 24 Sep 2020 10:24:13 -0400
X-MC-Unique: lS_jYhRhNxGeCSyl9X0Cbw-1
Received: by mail-yb1-f199.google.com with SMTP id v106so3055834ybi.6
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 07:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vnUGIOfCzH8dQsGwL9KYk3jPuL+fdtwPch7NM3noSjs=;
 b=hA15jlxk9eddKbgVgTKCeNcSUZG2wOcBZaGnFS/J7yi9xOBlDVAD4fPMrSwUeeY7RU
 biid2d03Qb3Mp+jj8O8g/GROqvXyVxsGlEzqPLJjwQPRtmfE3agZAo+WFaal9o1DP8L7
 P/hUJ2Rlu0yqiQX0virJMwNeSk7hrynENI4YTOUJnjGT+wlvyd3gEMEq+0TwHBRI/BQr
 3tLGpuSoa++U0rfzntnftNnNIbUr4/tSgttBfnIJaObI8+Z0US9hmcD+0Qu9t5OvDWnK
 KW1AdKNKufMGl+39JYXfUmwnY7Bsq0q4z1s5UZX9Ol6Viq0TjUP4txgB0dNm8Ubzxvj5
 EUyw==
X-Gm-Message-State: AOAM531R6EOTqbLcxEzCrwxr2UxKV7dQffO47DWuE8cvvGIUqm2q+elG
 Koytoj4QJ8ZeCtSW2LmrKLo93JIZhzz8ZxkKTw+2LgMZsc2A4JE0kKu/ZEBwR6rE5ufYLVc6xC7
 hERU1ozdp/x013VgsfLyseKCdXSOP3gI=
X-Received: by 2002:a25:5907:: with SMTP id n7mr7441259ybb.324.1600957453348; 
 Thu, 24 Sep 2020 07:24:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYqMT3mbEmgGKoPYEyxKQeMStrC5xy1zDFnNNOHfLZr6oQBQdBMPJCqe2mXZ+AHPIsLrJaTjBN8hW/xBFipN4=
X-Received: by 2002:a25:5907:: with SMTP id n7mr7441218ybb.324.1600957453003; 
 Thu, 24 Sep 2020 07:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-7-jusual@redhat.com>
 <20200924103631.GC2097005@redhat.com>
In-Reply-To: <20200924103631.GC2097005@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Thu, 24 Sep 2020 16:24:02 +0200
Message-ID: <CAMDeoFWYC3aB1M7VwpR0W4YymLr3VF=b3iZot9v_vpKDPBK0aw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/7] hw/acpi/ich9: Set ACPI PCI hot-plug as default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 12:36 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> On Thu, Sep 24, 2020 at 09:00:12AM +0200, Julia Suvorova wrote:
>
> There needs to be a commit message to explain / justify why this change
> is a benefit. You have a nice list of pros/cons in the cover letter
> which could serve as a good commit message here.
>
> The cover letter gets discarded, only the commit message is in git
> history, so its beneficial to capture that info here.

Sure, I'll add it.

> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  hw/acpi/ich9.c | 2 +-
> >  hw/i386/pc.c   | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > index 987f23e388..c67c20de4e 100644
> > --- a/hw/acpi/ich9.c
> > +++ b/hw/acpi/ich9.c
> > @@ -425,7 +425,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMR=
egs *pm)
> >      pm->disable_s3 =3D 0;
> >      pm->disable_s4 =3D 0;
> >      pm->s4_val =3D 2;
> > -    pm->use_acpi_hotplug_bridge =3D false;
> > +    pm->use_acpi_hotplug_bridge =3D true;
> >
> >      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
> >                                     &pm->pm_io_base, OBJ_PROP_FLAG_READ=
);
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index b55369357e..5de4475570 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -101,6 +101,7 @@ GlobalProperty pc_compat_5_1[] =3D {};
> >  const size_t pc_compat_5_1_len =3D G_N_ELEMENTS(pc_compat_5_1);
> >
> >  GlobalProperty pc_compat_5_0[] =3D {
> > +    { "ICH9-LPC", "acpi-pci-hotplug-with-bridge-support", "off" },
> >  };
> >  const size_t pc_compat_5_0_len =3D G_N_ELEMENTS(pc_compat_5_0);
> >
> > --
> > 2.25.4
> >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


