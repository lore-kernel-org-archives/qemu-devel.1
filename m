Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3613FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDF82078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfad/GZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDF82078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkvuR-0002Wb-4T
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 16:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jkvtF-0001Gu-8x
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:39:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42517
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jkvtD-0000ID-KN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYc7zBg925iLLXxuMTQkUX7GD3ahgBpuRJARONIQ9t4=;
 b=Yfad/GZbtkAOd1U5USYksrLzNJeY68BtaQ4oRE6ZzhrB/at+G+No1eMXZrgDA7XFeY6ACF
 T+v/nbX3b4VymiK0Zwm6bxHmgnHtY4072K7+K4UPh5QOsMh882zhScpix+zJdaNk0b6zEc
 M3kMQ8F/w1eHSG3YgBzzkNYlq1mb/r0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-28st6aurPRqF30I_xOYjWA-1; Mon, 15 Jun 2020 16:39:29 -0400
X-MC-Unique: 28st6aurPRqF30I_xOYjWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20C73803303;
 Mon, 15 Jun 2020 20:39:28 +0000 (UTC)
Received: from [10.3.112.27] (ovpn-112-27.phx2.redhat.com [10.3.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 894DE5C1D2;
 Mon, 15 Jun 2020 20:39:27 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] block: Call attention to truncation of long NBD
 exports
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200610163741.3745251-1-eblake@redhat.com>
 <20200610163741.3745251-3-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9b324e3e-8758-f8d9-7acc-50f118b289b4@redhat.com>
Date: Mon, 15 Jun 2020 15:39:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610163741.3745251-3-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 16:38:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, xuwei@redhat.com, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 11:37 AM, Eric Blake wrote:
> Commit 93676c88 relaxed our NBD client code to request export names up
> to the NBD protocol maximum of 4096 bytes without NUL terminator, even
> though the block layer can't store anything longer than 4096 bytes
> including NUL terminator for display to the user.  Since this means
> there are some export names where we have to truncate things, we can
> at least try to make the truncation a bit more obvious for the user.
> Note that in spite of the truncated display name, we can still
> communicate with an NBD server using such a long export name; this was
> deemed nicer than refusing to even connect to such a server (since the
> server may not be under our control, and since determining our actual
> length limits gets tricky when nbd://host:port/export and
> nbd+unix:///export?socket=/path are themselves variable-length
> expansions beyond the export name but count towards the block layer
> name length).
> 

> +++ b/block/nbd.c

>       } else if (host && !s->export) {
> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                 "nbd://%s:%s", host, port);
> +        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> +                       "nbd://%s:%s", host, port);
> +    }
> +    if (len > sizeof(bs->exact_filename)) {

Max pointed out off-list that this is off-by-one: by not using >=, I am 
failing to detect overflow when exactly one byte is truncated.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


