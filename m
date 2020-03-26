Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B3C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B19520737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AF3Hy8+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B19520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSgE-0002yt-9E
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHSet-00017L-Fq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHSeo-0007n4-EQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:34:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59355)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHSeo-0007mf-Ad
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEx5lo7AnKOVZdlQj5u7/JO/5SOchGzF2wcu0fH/Aro=;
 b=AF3Hy8+NF7PyrrFKkbk/mB5ADWiTgcfATEjoJc6tUItmoKnHrNz4LHDb9mzHm44gduN1wH
 3n6yWzgre77jKoXFBUoObWzbJZFekEiKqBKAA/6ATCRMPEe5F1y24FDCDxMLgtQ0MnnYYb
 98QNXr8TpqPMzFjm9SIRjklNuKcRGUk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-qTD5U8a_OfO_IhMqPRBrMg-1; Thu, 26 Mar 2020 09:34:47 -0400
X-MC-Unique: qTD5U8a_OfO_IhMqPRBrMg-1
Received: by mail-wr1-f69.google.com with SMTP id w12so3028762wrl.23
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 06:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZBC3o5iU4QnpxJstW4KGp+u4ZwJO5yw3GYUegt5m+xY=;
 b=nNbTUG8Q2W5IvXggQbAOEHQxChBaZFO9Zhg9Iknt/JyXVYBUFW0EzNXhWx3BbNJrqs
 GMRTpreUKj2a2/445aUuOwMBs5QZWUVyTgLgXnDg8P1s+ncIe8j22XIy/4KboDy9sHod
 6EtGLB6zpAveqX83KojlCVcCg9tWENBeHgtmOr1Xc4mn8rCUD6Jn5aCwf4wErtWovqv2
 sllJU4BWuqIixynoCgcv8HKtT/fp8JSetFQeaq5Esscb7Jr0CtdVDiA7aI295J/PxAWp
 uGVdHEHSoonpM4EO7Zn/czJpj73/G7FlbP+legPrEcqp4DQs4yuXGxx25DefpcSkk9iE
 CU4Q==
X-Gm-Message-State: ANhLgQ3EPnQa8fmAw7n/Uzjlqb38/oF7Jusnv2diX/7I/KAl6J2YkE1K
 JQWg7iWtBvtmN0LEy9jlyfCcxbkROwOtFzZ8kOtPK6wafOmgr7zLINeSstHdGmTT3IeHnRzpP6j
 8lbMFizyp4fJVpC0=
X-Received: by 2002:a05:600c:2051:: with SMTP id
 p17mr3085086wmg.153.1585229681959; 
 Thu, 26 Mar 2020 06:34:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vscmdSRcufsba3YUuNncAMSG+Yr5JaAlgwVmxyu/K4kGgPrdfJw3pmiBXlHIn5XYWVW4fbGOQ==
X-Received: by 2002:a05:600c:2051:: with SMTP id
 p17mr3085052wmg.153.1585229681606; 
 Thu, 26 Mar 2020 06:34:41 -0700 (PDT)
Received: from redhat.com (bzq-109-67-62-195.red.bezeqint.net. [109.67.62.195])
 by smtp.gmail.com with ESMTPSA id t81sm3646606wmb.15.2020.03.26.06.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 06:34:41 -0700 (PDT)
Date: Thu, 26 Mar 2020 09:34:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 0/7] reference implementation of RSS and hash report
Message-ID: <20200326093346-mutt-send-email-mst@kernel.org>
References: <20200320115751.19446-1-yuri.benditovich@daynix.com>
 <158471152973.13259.2630724408322668674@39012742ff91>
MIME-Version: 1.0
In-Reply-To: <158471152973.13259.2630724408322668674@39012742ff91>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: yan@daynix.com, yuri.benditovich@daynix.com, jasowang@redhat.com,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 06:38:51AM -0700, no-reply@patchew.org wrote:
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D8831=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on address=
 0x7ffc0dacbe80 at pc 0x55ee01d9e92a bp 0x7ffc0dac7080 sp 0x7ffc0dac6830
> READ of size 1518 at 0x7ffc0dacbe80 thread T0
>     #0 0x55ee01d9e929 in __asan_memcpy (/tmp/qemu-test/build/x86_64-softm=
mu/qemu-system-x86_64+0x1acb929)
>     #1 0x55ee04694dad in iov_from_buf_full /tmp/qemu-test/src/util/iov.c:=
33:13

Hmm this seems to be iov related so could be triggered by the new
patches. Could you investigate pls?

--=20
MST


