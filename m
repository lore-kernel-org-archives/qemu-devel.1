Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170F6C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD8924677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYFXjBbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD8924677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7m4f-0007p6-17
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 15:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7m3n-0007Bm-08
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7m3l-0007mJ-8k
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:16:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7m3l-0007ly-4w
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582920992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWeAMVLwexTEDylD/I1OaGXJg9uRuYXpQmRy7qrnv3Q=;
 b=GYFXjBbnbNXwXcBW49dX2527aoCcjckNmk4OeU767N6PgXP6uCr1hlI/3xsUFLg11m2hS6
 fJqJFn74HaOSPp2sgQjSuJYConpXKVlUR9TXJme7W7vbrhjPdiQ2QBewL0+VowcdUrwe3u
 CTso11HRwjc0qFhTWQxH8JXHwfJx6zE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-fV_yp1aiNpiQv4br2TYDQg-1; Fri, 28 Feb 2020 15:16:31 -0500
X-MC-Unique: fV_yp1aiNpiQv4br2TYDQg-1
Received: by mail-wr1-f70.google.com with SMTP id c6so1792363wrm.18
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 12:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=5gIHon/Cze1m6tA77oA6PcIhazn7/0ZFRGGHLxnwgRg=;
 b=raESVrGrdgYl7vMne2lVRju98MgIqw4jQY4+2Qm9OBD9SIwkmOS6JUmUK23GFW12yU
 +54dPkli1n6E2OGLPSWT/gkiKOXLOuDAB0qN3yLkpx1O1MecCJ+KZtbnc2981xAvtKL2
 HN3RPE0JLNpxpSyKSP2KSInLVD419ZB3YR1m8I2ZJXA/LuaeP4zO/2Mf62uI2e8JOjHq
 ykjg7lydJ/9RQHwk1btG2XLmG0nf9DFVXZp3VCzOVI85HxnNW718cJ2KG3u5tavReyb7
 GFrS/D5RQGSVXmGDCuF9LkoMC5x5VT1jUhezKsmrBGFjLznEz5AeGSGwABOG0CH90vBh
 wIDA==
X-Gm-Message-State: APjAAAUNWM6JbiUJT0cHJOtfOyZ1NmbbD4R1OLhsg5GXpsj3poTSmsqA
 7DHP3FRKLaIXCJtjMm3P6G2vzEhIEKPXq9TA2BktVaNZzk1RzdfcHyNG1owbHltCtBKmZwz7+1Q
 hfvr+q/KCEi7UqlQ=
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr6162182wro.310.1582920990159; 
 Fri, 28 Feb 2020 12:16:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVui5rZCr1F1Awb7biaApEjB3ilD7wbqUsJhT/231uDRre75IJzFSbk+abaNkJBwGNp2cjjg==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr6162153wro.310.1582920989928; 
 Fri, 28 Feb 2020 12:16:29 -0800 (PST)
Received: from [192.168.3.122] (p5B0C63F4.dip0.t-ipconnect.de. [91.12.99.244])
 by smtp.gmail.com with ESMTPSA id
 s139sm3636105wme.35.2020.02.28.12.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 12:16:29 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 12/15] util: vfio-helpers: Implement ram_block_resized()
Date: Fri, 28 Feb 2020 21:16:28 +0100
Message-Id: <509A885B-055F-4EEF-96FA-2EDA759F4F2C@redhat.com>
References: <20200228194257.GV180973@xz-x1>
In-Reply-To: <20200228194257.GV180973@xz-x1>
To: Peter Xu <peterx@redhat.com>
X-Mailer: iPhone Mail (17D50)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



> Am 28.02.2020 um 20:43 schrieb Peter Xu <peterx@redhat.com>:
>=20
> =EF=BB=BFOn Thu, Feb 27, 2020 at 11:12:02AM +0100, David Hildenbrand wrot=
e:
>> Let's implement ram_block_resized(), allowing resizeable mappings.
>>=20
>> For resizeable mappings, we reserve $max_size IOVA address space, but on=
ly
>> map $size of it. When resizing, unmap the old part and remap the new
>> part. We'll need a new ioctl to do this atomically (e.g., to resize
>> while the guest is running - not allowed for now).
>=20
> Curious: I think it's true for now because resizing only happens
> during reboot or destination VM during migration (but before
> switching).  However is that guaranteed too in the future?
>=20

E.g., virtio-mem will run mutual exclusive with vfio until vfio won=E2=80=
=98t pin all guest memory anymore blindly (iow, is compatible with memory o=
vercommit and discarding of ram blocks).

> [...]
>=20
>> @@ -631,7 +658,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, =
size_t size,
>>                 qemu_vfio_remove_mapping(s, mapping);
>>                 goto out;
>>             }
>> -            s->low_water_mark +=3D size;
>> +            s->low_water_mark +=3D max_size;
>=20
> I think it's fine to only increase the low water mark here, however
> imo it would be better to also cache the max size in IOVAMapping too,
> then in resize() we double check new_size <=3D max_size?  It also makes
> IOVAMapping more self contained.
>=20

I=E2=80=98ll have a look how much additional code that will imply - if it=
=E2=80=98s simple, I=E2=80=98ll do it.

Thanks!

> Thanks,
>=20
> --=20
> Peter Xu
>=20


