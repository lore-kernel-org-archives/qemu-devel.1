Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963BFC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5648D246AE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfKEZcQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5648D246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7mho-0005Im-Hw
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 15:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7mgx-0004cV-7J
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7mgv-0005uA-S2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:57:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52956
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7mgv-0005td-Ku
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582923421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXX6ddsvZ1gz/TY0PoLOpQzkYK7r/QX235DuWE626y0=;
 b=LfKEZcQGSj9LCFsNNFe4c9J9whEecIVT2v3RSupnzySC2sPO8ePDHCwsadwrvnudPH6M5p
 gXe9Gqig+E/4l+8d77qU321vz+375HsfR7YQjmgvjFJ7by94S/8xvJ/WLPISIprUlI5AtY
 QRgqX2R6YAm3DWbbUgOOEyEYxx8lHhw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-gIaq8Ef9NiWT2NMspQGtPg-1; Fri, 28 Feb 2020 15:56:58 -0500
X-MC-Unique: gIaq8Ef9NiWT2NMspQGtPg-1
Received: by mail-wm1-f72.google.com with SMTP id z7so1636554wmi.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 12:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=emnBe28UkaPC/x3hJn639CPMVXhGP+Vmjus9jHcYwSk=;
 b=M/HLAlvqZNvo42EvOxqWckDPwPcPN65inzMIVU9Hohz8LIKMqpVgLAbXDKaOT7IwiV
 pOwqXzJoSNFq539IfRAAgAFGyINLqeCCpvQj0FWF8wgeegZtUdndi37H5mBV0h95EoT+
 dTPvMVHded/lNamXd4uPRusMceeKPemYYHY7pGqrSLSAwC7flhgvbkryxfjiysOzObzc
 Tpch/m45t9lwExvJJk0PagzIZcAd1+cFuo9OZQGECAsRdsb3ZfhA4Yq1BFnscRPP1wwd
 RvHgJX8xb6f014PDTOFM+UCy3P3LbGP63SZAWw8rzu0xxmhMUnnz+Avoxe56VVWTAXPk
 J4oQ==
X-Gm-Message-State: APjAAAV9S3kONPB/73D/E1Z7ChgNkgMyJni1ccV9U+gjx6SVsbly2ehg
 982H13ACtPVD519Eo55Cqt215k7PV12SxDxxFy3jthKYOcM++IkinZatt1ezi2bLRmdrDArSoTP
 +92dFbU3p79XItFI=
X-Received: by 2002:adf:e506:: with SMTP id j6mr6265609wrm.309.1582923417345; 
 Fri, 28 Feb 2020 12:56:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgjJBpmVibhIuIHedIGhZUVD4Ti0fhm7bQJd59cZlcnszA5ZePCZl6VFrjK6esPt6xhNC37w==
X-Received: by 2002:adf:e506:: with SMTP id j6mr6265587wrm.309.1582923417074; 
 Fri, 28 Feb 2020 12:56:57 -0800 (PST)
Received: from [192.168.3.122] (p5B0C63F4.dip0.t-ipconnect.de. [91.12.99.244])
 by smtp.gmail.com with ESMTPSA id
 p17sm11558253wre.89.2020.02.28.12.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 12:56:56 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 12/15] util: vfio-helpers: Implement ram_block_resized()
Date: Fri, 28 Feb 2020 21:56:55 +0100
Message-Id: <D5B5CB52-ADCF-4618-A23F-C7219F071AE3@redhat.com>
References: <20200228204934.GC180973@xz-x1>
In-Reply-To: <20200228204934.GC180973@xz-x1>
To: Peter Xu <peterx@redhat.com>
X-Mailer: iPhone Mail (17D50)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 28.02.2020 um 21:49 schrieb Peter Xu <peterx@redhat.com>:
>=20
> =EF=BB=BFOn Fri, Feb 28, 2020 at 03:19:45PM -0500, David Hildenbrand wrot=
e:
>>=20
>>=20
>>>> Am 28.02.2020 um 20:55 schrieb Peter Xu <peterx@redhat.com>:
>>>=20
>>> =EF=BB=BFOn Thu, Feb 27, 2020 at 11:12:02AM +0100, David Hildenbrand wr=
ote:
>>>> +static void qemu_vfio_dma_map_resize(QEMUVFIOState *s, void *host,
>>>> +                                     size_t old_size, size_t new_size=
)
>>>> +{
>>>> +    IOVAMapping *m;
>>>> +    int index =3D 0;
>>>> +
>>>> +    qemu_mutex_lock(&s->lock);
>>>> +    m =3D qemu_vfio_find_mapping(s, host, &index);
>>>> +    if (!m) {
>>>> +        return;
>>>> +    }
>>>> +    assert(m->size =3D=3D old_size);
>>>> +
>>>> +    /* Note: Not atomic - we need a new ioctl for that. */
>>>> +    qemu_vfio_undo_mapping(s, m->iova, m->size);
>>>> +    qemu_vfio_do_mapping(s, host, m->iova, new_size);
>>>=20
>>> Another way to ask my previous question 1 (in the other reply): Can we
>>> simply map/unmap the extra, while keep the shared untouched?
>>=20
>> As far as I understand the kernel implementation, unfortunately no. You =
might be able to grow (by mapping the delta), but shrinking is not possible=
 AFAIR. And I *think* with many resizes, there could be an issue if I remem=
ber correctly.
>=20
> Ah right (and I think the same thing will happen to vfio-pci during
> memory_region_set_size()).  Then please double confirm that virtio-mem
> is disabled for both vfio-helper users and vfio-pci.  Also, would you

Yes, will double check, should have taken care of both.

> mind comment above the unmap+map with more information?  E.g.:
>=20

Sure, will add - thanks!

>  For now, we must unmap the whole mapped range first and remap with
>  the new size.  The reason is that VFIO_IOMMU_UNMAP_DMA might fail
>  with partial unmap of previous mappings, so even we can add extra
>  new mappings to extend the old range, however we still won't able to
>  always success on shrinking memories.  The side effect is that it's
>  never safe to do resizing during VM execution.
>=20
> Or something better.  With an enriched comment, I think it's fine:
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
>=20

Thanks Peter! Have a nice weekend!


