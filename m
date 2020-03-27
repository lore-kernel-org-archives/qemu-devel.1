Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECE0C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 19:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D77B20663
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 19:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8024E9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D77B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHuWc-0003vq-FB
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 15:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHuW2-0003Ig-QX
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 15:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHuW1-0004GB-Bj
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 15:19:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHuW1-0004Ep-7e
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 15:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585336776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5hYChqO8eGC5sfVCJjjy436q22PU8/2zpkmxNP5mhE=;
 b=d8024E9p0EccAln+CTIEI1IQrITUoeb8jQRv1Z0fvqRJTFH71TEgFBQ5DVDdDqicS0ETlT
 aOi3G44Gj7pI06HqnAf9l3IXTuCRL4Fv72d3Dv90MWMwUKltX6NQHII91nP1LujgGJAA/C
 BhTJKGj39APJ2yq6kPpHhiBxvXRMZJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-HyPp0aNpMrmnN4TlVaFMSQ-1; Fri, 27 Mar 2020 15:19:32 -0400
X-MC-Unique: HyPp0aNpMrmnN4TlVaFMSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40BE98017CC;
 Fri, 27 Mar 2020 19:19:31 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A524960BF3;
 Fri, 27 Mar 2020 19:19:30 +0000 (UTC)
Subject: Re: [PATCH v4] qcow2: Forbid discard in qcow2 v2 images with backing
 files
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200327185930.19493-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fcbe8039-2320-da99-d125-cf3d43928039@redhat.com>
Date: Fri, 27 Mar 2020 14:19:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327185930.19493-1-berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 1:59 PM, Alberto Garcia wrote:
> A discard request deallocates the selected clusters so they read back
> as zeroes. This is done by clearing the cluster offset field and
> setting QCOW_OFLAG_ZERO in the L2 entry.
> 
> This flag is however only supported when qcow_version >= 3. In older
> images the cluster is simply deallocated, exposing any possible stale
> data from the backing file.
> 
> Since discard is an advisory operation it's safer to simply forbid it
> in this scenario.
> 
> Note that we are adding this check to qcow2_co_pdiscard() and not to
> qcow2_cluster_discard() or discard_in_l2_slice() because the last
> two are also used by qcow2_snapshot_create() to discard the clusters
> used by the VM state. In this case there's no risk of exposing stale
> data to the guest and we really want that the clusters are always
> discarded.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> v4:
> - Show output of qemu-img map when there's no backing file [Eric]

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


