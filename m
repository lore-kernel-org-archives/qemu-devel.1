Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89FBC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734C8207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zs04LEXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734C8207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWy5t-0003Ae-KU
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWy4b-0001XI-Br
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:09:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26243
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWy4a-0001jp-4o
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588925371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oX/UTFDoFq2xilmT5mQ3wHoTb7H1sD2yz5pYFLm5wvI=;
 b=Zs04LEXJdS6IxWAfeakpVtkI2VWSrAfFzpER6TVGl23NTsJICFl0Lhd7nFSc1ol6gQnLuh
 R0+wG/q8n9X80qaQybVmVmkFew34S8U0Gj9HCwnsj2GaQJzuwz5NTq3kVLKnEoo89ZJ7JL
 7KXlkVWnjLHwKNyi4wdepe6Px8qUkko=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-z2AKT7GHPS2OxR8JOGXI7w-1; Fri, 08 May 2020 04:09:24 -0400
X-MC-Unique: z2AKT7GHPS2OxR8JOGXI7w-1
Received: by mail-wr1-f70.google.com with SMTP id y4so522925wrt.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oX/UTFDoFq2xilmT5mQ3wHoTb7H1sD2yz5pYFLm5wvI=;
 b=fUA9Lg4yQa/GxqSzqGrBZ5TON6xoaCImtp6h0tQqK8sXZbTZxH6qgtTKHzy0EEsn3Z
 OpdK8Bo0tRphMlAN2g/1UedcRg/8P4JCySdszPopGBw0mdENv9vjCPyKN12BaGqdOmvS
 pSy1RHlzh1dr56A0DGVj6FR1pn/phUUTacRZvrpyHFf9hnjXKRRNbG0SMhD9C/tTKoUC
 LukBzq/VHWsGO9jymiIWSQ93JOg3v20GFCfQaPnqY9z4hQQE46hbe+vjGKB+xpNuz4eF
 dkxk6+J3lwpvJOa34Q9jDPmH+ZaiurOpJZuxc/gKQm5rlaYaXYLXwfRQaZOmWMrWF4bs
 r2SA==
X-Gm-Message-State: AGi0PuakRGU5TwwFsPul+dvT4qpZehyzCkMWTrq9oALFdDO5G9xkq0so
 pgEqxo6jpX0O+TZjNhKUtb+QVOMCJEEmhTJPkYLw7AXG/XRVWFnxtm9L8xirlsOoackrMPkPYor
 3ja+hEuesdxzAqDk=
X-Received: by 2002:a05:600c:4013:: with SMTP id
 i19mr7964324wmm.71.1588925362529; 
 Fri, 08 May 2020 01:09:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJG6RJSOyv396s8s2+8n0ipFN2UscfyyVhf1hHc0lUCk28q5UY+7qDJkv0m7anKVQiKS7UFCg==
X-Received: by 2002:a05:600c:4013:: with SMTP id
 i19mr7964306wmm.71.1588925362371; 
 Fri, 08 May 2020 01:09:22 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id r11sm516796wrv.14.2020.05.08.01.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:09:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 08/10] hw/block: Let the NVMe emulated device be
 target-agnostic
In-Reply-To: <20200507173958.25894-9-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 May 2020 19:39:56
 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-9-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 10:09:20 +0200
Message-ID: <87a72ig85r.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:25
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
Reply-To: quintela@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> Now than qemu_ram_msync() has been ...
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


