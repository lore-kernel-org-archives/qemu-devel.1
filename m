Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F218C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F27207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adEBqPfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F27207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHkb-00021D-P2
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJHij-0000Py-Vk
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJHii-0007NN-Us
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:18:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJHii-0007N9-QE
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585664304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTlOsDpYk9K4CCyKC/PHiJOVkImHO3u7FyPoS+CwZL4=;
 b=adEBqPfSFkUOVo51T5hlXLA9kSMnnmM6arLLORsOYKmvXpNDMFcr/gBEvokHY+Li4JPT4J
 MtolCHC4uOmRFFPWcpWIRcpt2ynG694/JwNzw5mKnHd60pruHPBgrxBBBj9HmLgE8sZtNc
 GyI1P8RhlAE52Qfb3sk38uCSUSRVS7s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-fSLTNaa2O4qpzjiQGT-S6g-1; Tue, 31 Mar 2020 10:18:22 -0400
X-MC-Unique: fSLTNaa2O4qpzjiQGT-S6g-1
Received: by mail-wr1-f69.google.com with SMTP id q14so3445369wro.7
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=utmX18W31kXsBfpUq9t9FaLAztm0XHtfHqqaTLE/HnI=;
 b=cZlmAQWzqAroQfpnWB70pZ4b2IqVgn1zK7Rx6YamIQRR2eQOoU7mI1Oi+JxiSpeeK5
 vUErjqzPqcBufh4LlRbbg5TvsuoyIUriugEmRbybQyxf7Jv6wdlOsoRSQnYsdccHJEbn
 KWxZ/7ocg/sN0kU6c5Q+40WLx1xwH/lWm71q4GrVLr9OMiTOzeM4zADMt+h6HKJCj0YN
 6INRqSUymHGgRJTS4l3grXMmn4Mp+vj0wli7AFt0WZawT/ltTEO6hm+/igZKzUMaGvsY
 wyk8A85HpAtF1vwBzqGCoGxZ3QnkjH97Qd8+Xa8No486252rgXtbUH2c4Esygd8VDr4G
 uryw==
X-Gm-Message-State: ANhLgQ2c7cCNVmRJZg4/DxosoqXVKF8R9Xlx9zH3tDfzW+bGrWHzqnLj
 zD7VmkbKuns9vJIBCt1WTI6Q/T0REuoa8TCCWvThZu445hWWAAGnPpel3E3XjwBI3EyNPEy0TnG
 QLUhKgYlVjb7l4PI=
X-Received: by 2002:adf:904a:: with SMTP id h68mr19456926wrh.291.1585664301564; 
 Tue, 31 Mar 2020 07:18:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtmKByeMbL7IF4Va4byN+91sp3eGql6iIZ+hxW44PDFMJBJ+l8uaRXS9tqFA+dHHnZNvwqR7w==
X-Received: by 2002:adf:904a:: with SMTP id h68mr19456901wrh.291.1585664301366; 
 Tue, 31 Mar 2020 07:18:21 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id z19sm28466709wrg.28.2020.03.31.07.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:18:20 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:18:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200331101117-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
MIME-Version: 1.0
In-Reply-To: <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
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
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 04:09:59PM +0200, David Hildenbrand wrote:

...

> >>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>>>>>> Along the lines of
> >>>>>>>>>>>
> >>>>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_=
order,
> >>>>>>>>>>>                    unsigned int max_order, unsigned int *orde=
r)
> >>>>>>>>>>>
> >>>>>>>>>>> the idea would then be to return at a number of pages in the =
given
> >>>>>>>>>>> range.
> >>>>>>>>>>>
> >>>>>>>>>>> What do you think? Want to try implementing that?

..

> I expect the whole "steal huge pages from your guest" to be problematic,
> as I already mentioned to Alex. This needs a performance evaluation.
>=20
> This all smells like a lot of workload dependent fine-tuning. :)


So that's why I proposed the API above.

The idea is that *if we are allocating a huge page anyway*,
rather than break it up let's send it whole to the device.
If we have smaller pages, return smaller pages.

That seems like it would always be an improvement, whatever the
workload.

--=20
MST


