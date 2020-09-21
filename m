Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B23C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B052193E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ty4J3FZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B052193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKIbf-0000PS-2d
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKIZo-0007WE-0d
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:57:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30070
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKIZl-0004kl-6p
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600682255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7QkMGbEDI0WD941tQiZUc1lhZ7YCrJQ0gVRGM7T8cc=;
 b=Ty4J3FZMGcBk/INvoyejVL5T7mHbKbwWKwsHG+jXyXDEjuy6xYwRihiirRLpo4QTsWUWyz
 4lwH9SA7I4itgcc8r/yUdl+RGvQjK3Vy3vrTWi6J/jvQc0l/hlpPAbyDNagwgNfY+JRbpt
 XZxGonPR0kr9N0QH8WhUqykTzdy3nEY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-TP_A6UnyMhalOXHjX5A1Ag-1; Mon, 21 Sep 2020 05:57:33 -0400
X-MC-Unique: TP_A6UnyMhalOXHjX5A1Ag-1
Received: by mail-wm1-f69.google.com with SMTP id s24so2323582wmh.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 02:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=L7QkMGbEDI0WD941tQiZUc1lhZ7YCrJQ0gVRGM7T8cc=;
 b=Z5Pp5aW5X+9dkQmyP1ElaTBtPB9nuNl38ckKpzCz1et8+BclVRuRmb6hHmAIdC93N9
 VN9f+9hZJUEG25ioCqg/pgZHzRNURa0iOIzNfUubc5IinnobSvORiDb4lVyjHw1382se
 OEMvG44LYLoT2mv1mH2Z+2VsoYX72I1zMtwwEJGhW+MlC0sFkQ8dwWqChAIcQQcuS/Yu
 fUD0nNkD6XR6fyYZCtMk53VbR2LPcTm40eYg4wNqncEUA6CaWUzO0/5cWTOVgXlGRJpK
 i1NdRSkmTY26KwXk1eVVQqVVS3RMCZWSvmR04/3P2Nmp1UlnnApggycX+jjoZmQYJ+Ix
 AW3A==
X-Gm-Message-State: AOAM531DwM8uCd7e2zZt4Es8TmtiaptKDVhoLqlRdg1Yq3mGBik00m75
 NYqrPEpOopGTSw61OUp0D8+V4SlTU6yLbAx/iAbQ1Qzx+usBXeUfkdU3ucORSoLYx+mz4RRYXlY
 8ZI6dUL0j+ycnKvg=
X-Received: by 2002:a1c:bdc4:: with SMTP id
 n187mr29156274wmf.109.1600682252725; 
 Mon, 21 Sep 2020 02:57:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0L3uT0NnctiJdOssrwS2Iix91pUjXBspOETW30vEcI/xerBuPhjvuQ/8HAWyk4AaXBiJyNw==
X-Received: by 2002:a1c:bdc4:: with SMTP id
 n187mr29156246wmf.109.1600682252484; 
 Mon, 21 Sep 2020 02:57:32 -0700 (PDT)
Received: from steredhat (host-79-13-204-53.retail.telecomitalia.it.
 [79.13.204.53])
 by smtp.gmail.com with ESMTPSA id l17sm18696916wme.11.2020.09.21.02.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 02:57:31 -0700 (PDT)
Date: Mon, 21 Sep 2020 11:57:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 2/4] vhost-vsock-pci: force virtio version 1
Message-ID: <20200921095729.pqgxh4zcbwisscw5@steredhat>
References: <20200921083807.48380-1-sgarzare@redhat.com>
 <20200921083807.48380-3-sgarzare@redhat.com>
 <20200921114602.46372eb4.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921114602.46372eb4.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Qian Cai <caiqian@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 11:46:02AM +0200, Cornelia Huck wrote:
> On Mon, 21 Sep 2020 10:38:05 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > Commit 9b3a35ec82 ("virtio: verify that legacy support is not
> > accidentally on") added a safety check that requires to set
> > 'disable-legacy=on' on vhost-vsock-pci device:
> > 
> >     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
> >         qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
> >         device is modern-only, use disable-legacy=on
> > 
> > virtio-vsock was introduced after the release of VIRTIO 1.0
> > specifications, so it should be 'modern-only'.
> > In addition Cornelia verified that forcing a legacy mode on
> > vhost-vsock-pci device using x86-64 host and s390x guest, so with
> > different endianness, produces strange behaviours.
> > 
> > This patch forces virtio version 1 and removes the 'transitional_name'
> > property removing the need to specify 'disable-legacy=on' on
> > vhost-vsock-pci device.
> > 
> > To avoid migration issues, we force virtio version 1 only when
> > legacy check is enabled in the new machine types (>= 5.1).
> 
> Maybe add
> 
> "As the transitional device name is not commonly used, we do not
> provide compatibility handling for it." ?

Yes, I'll add in v5.

> 
> > 
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Qian Cai <caiqian@redhat.com>
> > Reported-by: Qinghua Cheng <qcheng@redhat.com>
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1868449
> > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v3:
> >  - forced virtio version 1 only with new machine types
> > v2:
> >  - fixed commit message [Cornelia]
> > ---
> >  hw/virtio/vhost-vsock-pci.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks,
Stefano


