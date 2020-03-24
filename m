Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FD3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41ACE20774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4LF26vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ACE20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkpr-0007c7-Dj
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGkoo-0006OH-Ec
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGkon-0005Dw-7v
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:46:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45061)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGkon-0005DT-39
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585061172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/JS4XRB7wgrmi4hF7t/5YtDt8GYkKhrsykPbvNcCq0=;
 b=d4LF26voUhqb2eWzL7nEyG3Szol/IlOLlQ3jc1T5mb1SMK3JKKnrTGEipWBtomLWb7kdz9
 gnNu0ClDWc2+ItLc7dxsWh2/gtL1QmaAJ3pcV6hjN/mZTllqmti/ozntxSi9z/R9pnGk88
 evjYH617tVlc1FPUnVuoTDU41W5ZncI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-2kmK-zO-PSWlhQvLM7jhKg-1; Tue, 24 Mar 2020 10:46:11 -0400
X-MC-Unique: 2kmK-zO-PSWlhQvLM7jhKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29C53800D48;
 Tue, 24 Mar 2020 14:46:09 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BE5C10016EB;
 Tue, 24 Mar 2020 14:46:08 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Forbid discard in qcow2 v2 images with backing
 files
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200323194429.1717-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5bcf1bf6-4375-afe6-bd6c-dedbd06d136d@redhat.com>
Date: Tue, 24 Mar 2020 09:46:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323194429.1717-1-berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On 3/23/20 2:44 PM, Alberto Garcia wrote:
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
>   block/qcow2.c              |  6 +++
>   tests/qemu-iotests/060     |  5 ++-
>   tests/qemu-iotests/060.out |  2 -
>   tests/qemu-iotests/289     | 90 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/289.out | 52 ++++++++++++++++++++++
>   tests/qemu-iotests/group   |  1 +
>   6 files changed, 152 insertions(+), 4 deletions(-)
>   create mode 100755 tests/qemu-iotests/289
>   create mode 100644 tests/qemu-iotests/289.out

The actual fix is much smaller than the iotest fallout ;)

> +++ b/tests/qemu-iotests/060
> @@ -167,9 +167,10 @@ _make_test_img -o 'compat=0.10' -b "$BACKING_IMG" 1G
>   # Write two clusters, the second one enforces creation of an L2 table after
>   # the first data cluster.
>   $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_io
> -# Discard the first cluster. This cluster will soon enough be reallocated and
> +# Free the first cluster. This cluster will soon enough be reallocated and
>   # used for COW.
> -$QEMU_IO -c 'discard 0k 64k' "$TEST_IMG" | _filter_qemu_io
> +poke_file "$TEST_IMG" '262144' "\x00\x00\x00\x00\x00\x00\x00\x00" # 0x40000 - L2 entry
> +poke_file "$TEST_IMG" '131082' "\x00\x00" # 0x2000a - Refcount entry

Instead of writing '262144' ... # 0x40000, you could write $((0x40000)) 
in-place.  Similarly for 131082 vs. 0x2000a.

Also, Max has pending patches for adding poke_file_be; if those land 
first, this becomes simpler as:

poke_file_be "$TEST_IMG" $((0x40000)) 8 0 # L2 entry
poke_file_be "$TEST_IMG" $((0x2000a)) 2 0 # Refcount entry

> +++ b/tests/qemu-iotests/289
> @@ -0,0 +1,90 @@
> +#!/usr/bin/env bash
> +#
> +# Test how 'qemu-io -c discard' behaves on v2 and v3 qcow2 images
At any rate, the new test looks reasonable to me. I see you have other 
review comments for improving it, with thos in, you can add

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


