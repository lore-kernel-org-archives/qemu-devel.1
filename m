Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8BEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 23:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5ADA20787
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 23:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGpurkQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ADA20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJQ0B-0002Y2-4E
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 19:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jJPyy-0001ZV-LZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 19:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jJPyw-0005aP-Bc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 19:07:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jJPyv-0005XT-Pi
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 19:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585696060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BY6kYp8UaAOQuyeoeWB01pQYjs/qw5L1NWanDyPeaqk=;
 b=aGpurkQaB3hpd1/fKsKoLZNvnOQ8Si6t3Y/CB/YSfgvBPgOEvxcza4CUDjlmtzOt+qQ2Eb
 3m0eJ8EO8Z86gcIbF3BtRdSjJmTkbWXP85F5oxphZLZiB8HJ/oXYWLkIXUVXku7lwfm0xp
 khVvekEAbU4w/d6dazQyCKcaGeJNVCw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-Z4HNh64LPuGHktJHKWnxew-1; Tue, 31 Mar 2020 19:07:38 -0400
X-MC-Unique: Z4HNh64LPuGHktJHKWnxew-1
Received: by mail-wr1-f72.google.com with SMTP id f15so13736877wrt.4
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 16:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g53URwRcc278md8QOVmfSTaHlJ99DbuB0689tOUVhes=;
 b=qUYXFun2IiU6hA4kY4BUYE7/WkH2ISuphCemZTU0H/vjYYN9vQDOZBBkz9Z4ZmQbkZ
 ttXyTF33DnBtj5zlT8kJZd5lFZMRguiaydt9hsMsz2Md694f7fmOIG12i+jLRNKUx18o
 vI/P+KVaUda3Q8ELZDSTiQWqBMYDZhSvY5gVdlJnpYqCR0OeGYZxNxcjtzNi/XyZx32o
 STl7pciVKX6SNBmhFmWb48rkBAHjRCzaQpCqQfbBHzJmxa3562YnPxdp0GxvuERd70cn
 qdvkXOYUtuBIHtw9eH626L8yxskyfHQRcAgqmQIuPfY05vWg4yMHd65q0acRWvndKqU3
 i5pw==
X-Gm-Message-State: AGi0PuZgg2fMaW4wL/WiJja4vW0GHUTHbv/U//3GXOyNVfrEN+6dBO9H
 epa68WnrVX496EdlpytboTrD6AiB/awa5s8lw9/bwWVYB0WJ2FXI8VeyggeHGuzQ0d6RHd+qcvo
 dBFwWRNb3m32DTOI=
X-Received: by 2002:adf:de82:: with SMTP id w2mr2356653wrl.92.1585696057644;
 Tue, 31 Mar 2020 16:07:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJPdP7WAtWcKPK0VBz4caID6Z05gp56Ex0PN94cVwqoiaNNdoNO+gCXxSWMmTw5ePQVYKf9cQ==
X-Received: by 2002:adf:de82:: with SMTP id w2mr2356633wrl.92.1585696057463;
 Tue, 31 Mar 2020 16:07:37 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id r11sm355843wrn.24.2020.03.31.16.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 16:07:36 -0700 (PDT)
Date: Tue, 31 Mar 2020 19:07:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v4 0/5] vfio/pci: Fix up breakage against split irqchip
 and INTx
Message-ID: <20200331230733.GC648829@xz-x1>
References: <20200318145204.74483-1-peterx@redhat.com>
 <20200331163245.74e81595@w520.home>
MIME-Version: 1.0
In-Reply-To: <20200331163245.74e81595@w520.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 04:32:45PM -0600, Alex Williamson wrote:
> On Wed, 18 Mar 2020 10:51:59 -0400
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > v4:
> > - pick r-b and a-b for Alex without patch 4
> > - only kick resamplefd for level triggered irq (as 3.1 change on patch
> >   4) [Alex]
> > - fix mingw build error with below squashed into patch 4:
>=20
> IMO, it'd be nice to get this in for QEMU 5.0, were others thinking
> something different?  I provided acks thinking Paolo might take it, but
> I can send a pull request for it if Paolo wants to ack instead.  Thanks,

I didn't ask because I thought it has already missed 5.0 (/me didn't
watch the schedule before hand, softfreeze Mar 17).  It would be
definitely good if this can still make it somehow.

Thanks,

--=20
Peter Xu


