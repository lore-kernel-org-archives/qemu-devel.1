Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9580DC35280
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 22:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E025207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 22:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/AYajLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E025207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWooE-0007IB-Gz
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 18:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jWonV-0006cv-SQ
 for qemu-devel@nongnu.org; Thu, 07 May 2020 18:15:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jWonV-00047X-66
 for qemu-devel@nongnu.org; Thu, 07 May 2020 18:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588889712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cg/8AGlXX13xa2Zkuncfu8JNRZjWe9Zo4dYGYRe8qFM=;
 b=L/AYajLgsieIf+TMG2TdJJO0r2Ymc8bytpydwIkID+6r4wKr7NIIueLQCQFOK6g/bwDv5a
 iW8vUtE7yPees1x4LfUd3SDCdy4JG74MIRC359XX4Vx3cKzenr2KxQIOcRc+UgxK0wjSHT
 HYdxCKMahh0jTut5m4qYy+OVYcVgqeM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-tYKXZn96Mm-BQHU6NUnSZw-1; Thu, 07 May 2020 18:15:11 -0400
X-MC-Unique: tYKXZn96Mm-BQHU6NUnSZw-1
Received: by mail-wm1-f70.google.com with SMTP id f17so3237193wmm.5
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 15:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bMSoiKbm38zk0epjaywYb7btv2d9NkRVI7hZYXJEkn8=;
 b=m6/MoKKpGUqLhlyqPW/5H3g6w0/TH0SDbmAkDFinggOxi79q/8Fb2i5SDXEiXTIOQC
 b+AJ6upZ1NilERtFw6xKKS2IPKjonz0FHU+umt7WF6qr6kr++o6zhH6VDwNE4bYqGoCv
 nItB0fDHL8LJanpAt0MSctAE6DR0f8H/8WzuNcCfXcG5I/i5AJq2nCI+CXJ6aljhs5A0
 XEM7B+lTicNMSJuGs2k86jbMxa8JAGW751opSbZYyuImSnDEUHubC4eV+zUMDzaaIy1h
 BJoANp7w3LRDYjqrbEBcvH+ExH17CugogUbcaYcDvMQyWwCp4tf2Qhm9jtfwW3bsKEwc
 6xmA==
X-Gm-Message-State: AGi0PualtmOzD9ExMjYyQy3a2d+8R968l+HyHlqvzgjJZlkifAIAdOHw
 32W+aFYP9nvzG/Gv2uTjvFQ9S8dXM3ubJUaS2mL0S0wngGrAKQk9ECYObo2sGK4d1o7+bsmLpdI
 g3lueFu/8jl/XHOc=
X-Received: by 2002:adf:ef48:: with SMTP id c8mr17041992wrp.140.1588889709984; 
 Thu, 07 May 2020 15:15:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKBkig6uqriOebmMJ7yyy9N0gzDYSyNQHDXiTyBJGu7kHFqCpfbJqTzIUeMlUK941QzQ8Ib8Q==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr17041948wrp.140.1588889709676; 
 Thu, 07 May 2020 15:15:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc?
 ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
 by smtp.gmail.com with ESMTPSA id 60sm11242388wrr.7.2020.05.07.15.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 15:15:08 -0700 (PDT)
Subject: Re: [PATCH 00/10] exec: Shear 'exec/ram_addr.h' and make NVMe device
 target-agnostic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200507173958.25894-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6109af19-24d0-1fdc-4f5c-772cfe9ec087@redhat.com>
Date: Fri, 8 May 2020 00:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 18:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/20 19:39, Philippe Mathieu-Daud=C3=A9 wrote:
> Stefan suggested to make qemu_ram_writeback() target agnostic,
> Paolo to add memory_region_msync(), and Peter to remove
> "exec/ram_addr.h" [*].
>=20
> I let a single function in this file,
> cpu_physical_memory_sync_dirty_bitmap(), to let the maintainer
> have the pleasure to remove this header definitively himself :)

I don't think this is a good idea. :)

"exec/ram_addr.h" is a good place for functions that work on ram-addr_t
and/or RAMBlock data.  There should very few of these, since these are
mostly an internal concept that should only be used for live migration.
 You could:

- figure out which files actually need to include exec/ram_addr.h.
There's already very few of them.

- move the large functions to a new .c file, ramblock.c.  Figure out
which can be static, move the declarations for the others to ramblock.h

- kill ram_addr.h and include ramblock.h instead.

Not coincidentially, qemu_ram_writeback() takes a RAMBlock*, and it ends
up in ramblock.h.

Also, this is orthogonal to adding the wrapper memory_region_msync.

Thanks,

Paolo


