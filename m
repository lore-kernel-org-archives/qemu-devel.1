Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CE9C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6E2207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/Ofgd/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6E2207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNbf-0004gN-LN
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 03:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kDNb6-00046R-Hi
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:54:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50816
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kDNb5-0008I7-0m
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599033262;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOA20L0iSMPYexLO/OU8ZL9jAdX526i29iU+udPXTyw=;
 b=g/Ofgd/4CiyvE8WA/ILk+thruCUqzl4IzD6DA/RgdwlBjoDEghi628c2QIjZ+6y1mWGnA5
 jFHCIr2WVI+/9vXvybzTy3bJ6GIbz8EmKwg/5XXZMyw6Kzf+IQsDhJyXglvqyrvhtAj9qv
 LZmnt+vmY7+IW4FthU+0GqHhMUb8s1U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-RTWhNIoEMXynQBhsFlBDiA-1; Wed, 02 Sep 2020 03:54:20 -0400
X-MC-Unique: RTWhNIoEMXynQBhsFlBDiA-1
Received: by mail-wr1-f71.google.com with SMTP id g6so1632754wrv.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 00:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OjnHSDu0G6t4PQwW9qrNEegf66R8/fX12d8ERs6/4aM=;
 b=BM/loJ/UoDOdIHl8HY573VNyJKoYXgafYu1aoL2UEd1mKa5dPI9AgqjpWQDzavHLKj
 jubJzFmqjyBsTsDh+t25EdbJSU/8QBNEyKmi2kOXn6byemeZXB86g9rjhOCGgqCM6h5n
 ykWzhP96z4y2oyvqnVS+D6LST2NyoVRXihG2RgxAMkvZYCy27ODiQKCEOOsqmpHKdcm0
 bnpQWbxODnyrj4TGast4zMsjxL7mhBfqagtj8pQYxlFG48s2kog/SPYyaVeqcsusw5XV
 Y3Jva8bijy/CvX+ulRH4epItJPKmJ601kRDTWoZiuCDZRUBxORZbe66x/vMTnvrNV2zX
 kpyw==
X-Gm-Message-State: AOAM532C6mvRCOC9PtPawIeAV8cP34RWT4ySL4eMd2u/TQ6UTPa3yZyn
 QqQ0pb5lVjUJN8tzU4MeOqumGDES7P+rBqP7SPzTKluf2yEUbP9j8w52TaNcBRy90rthmYhXSbM
 i1zuaLtlpqU20PaE=
X-Received: by 2002:a1c:9a8c:: with SMTP id c134mr5252365wme.136.1599033259730; 
 Wed, 02 Sep 2020 00:54:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI+Uwixu/K6txf27R6OnTA2nnWFilXaCpEEcvZsHjPiDFT4k/VbZrmSsZE12fJahRJ2HdWSQ==
X-Received: by 2002:a1c:9a8c:: with SMTP id c134mr5252332wme.136.1599033259472; 
 Wed, 02 Sep 2020 00:54:19 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id c4sm5996242wrp.85.2020.09.02.00.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 00:54:19 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v8 2/5] memory: Add IOMMUTLBEvent
In-Reply-To: <20200901142608.24481-3-eperezma@redhat.com> ("Eugenio
 =?utf-8?Q?P=C3=A9rez=22's?=
 message of "Tue, 1 Sep 2020 16:26:05 +0200")
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-3-eperezma@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 02 Sep 2020 09:54:18 +0200
Message-ID: <87a6y8r4ut.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:
> This way we can tell between regulars IOMMURLBEntries (entry of IOMMU
> hardware) and notifications.
>
> In the notifications, we set explicitly if it is a MAPs or an UNMAP,
> instead of trusting in entry permissions to differenciate them.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

if you have to respin for whatever other reasons, two suggestions.


> @@ -1430,10 +1435,10 @@ static int vtd_dev_to_context_entry(IntelIOMMUSta=
te *s, uint8_t bus_num,
>      return 0;
>  }
> =20
> -static int vtd_sync_shadow_page_hook(IOMMUTLBEntry *entry,
> +static int vtd_sync_shadow_page_hook(IOMMUTLBEvent *event,
>                                       void *private)
>  {
> -    memory_region_notify_iommu((IOMMUMemoryRegion *)private, 0, *entry);
> +    memory_region_notify_iommu((IOMMUMemoryRegion *)private, 0, *event);

I know that it already was there, but if you respin, you can remove the cas=
t.



> @@ -1281,12 +1286,12 @@ void memory_region_notify_iommu(IOMMUMemoryRegion=
 *iommu_mr,
>   * notifies a specific notifier, not all of them.
>   *
>   * @notifier: the notifier to be notified
> - * @entry: the new entry in the IOMMU translation table.  The entry
> - *         replaces all old entries for the same virtual I/O address ran=
ge.
> - *         Deleted entries have .@perm =3D=3D 0.
> + * @event: TLB event with the new entry in the IOMMU translation table.
> + *         The entry replaces all old entries for the same virtual I/O a=
ddress
> + *         range.
>   */
>  void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> -                              IOMMUTLBEntry *entry);
> +                                    IOMMUTLBEvent *event);

I didn't catch the missing of indentation on the previous patch ....
O:-)


