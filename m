Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF32CC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AEE2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE3cP1Jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AEE2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtUg-0002jV-QF
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHtTn-0001W3-VV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHtTl-0000EJ-Rq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHtTl-0000CO-LP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585332792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkOmjQYazMSwSs0atc9MFIyLa1D9Ojb+vEtUmSJjVUs=;
 b=eE3cP1JcvyV6i2vNo2VLcSsM9ln/96yUP5EmuSFqTK3WwhDrOR2xQOGMgAB+ayFfLdVMrg
 Q71/G+FALq70d00c/8lU9touD3Cl/bh1YMvbvOC59+OE3QIQBzXdcKyzMQSFke2umlskTM
 5OJ+0S8sUOq1Plx9GkeGD4iXrsxc99c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-3TJzslYVPRKIoQRtVJfJbQ-1; Fri, 27 Mar 2020 14:13:07 -0400
X-MC-Unique: 3TJzslYVPRKIoQRtVJfJbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70AA118A6EC1;
 Fri, 27 Mar 2020 18:13:06 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9B001001901;
 Fri, 27 Mar 2020 18:13:04 +0000 (UTC)
Subject: Re: [PATCH v3] qcow2: Forbid discard in qcow2 v2 images with backing
 files
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200327164857.31415-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <abf9a6c8-7b15-b3c1-e26a-f0ffe9523c85@redhat.com>
Date: Fri, 27 Mar 2020 13:13:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327164857.31415-1-berto@igalia.com>
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

On 3/27/20 11:48 AM, Alberto Garcia wrote:
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

> +++ b/tests/qemu-iotests/290

> +
> +echo
> +echo "### Test 'qemu-io -c discard' on a QCOW2 image without a backing file"
> +echo
> +for qcow2_compat in 0.10 1.1; do
> +    echo "# Create an image with compat=$qcow2_compat without a backing file"
> +    _make_test_img -o "compat=$qcow2_compat" 128k
> +
> +    echo "# Fill all clusters with data and then discard them"
> +    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
> +    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
> +
> +    echo "# Read the data from the discarded clusters"
> +    $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
> +done

Should this loop also inspect qemu-img map output?

> +
> +echo
> +echo "### Test 'qemu-io -c discard' on a QCOW2 image with a backing file"
> +echo
> +
> +echo "# Create a backing image and fill it with data"
> +BACKING_IMG="$TEST_IMG.base"
> +TEST_IMG="$BACKING_IMG" _make_test_img 128k
> +$QEMU_IO -c 'write -P 0xff 0 128k' "$BACKING_IMG" | _filter_qemu_io
> +
> +for qcow2_compat in 0.10 1.1; do
> +    echo "# Create an image with compat=$qcow2_compat and a backing file"
> +    _make_test_img -o "compat=$qcow2_compat" -b "$BACKING_IMG"
> +
> +    echo "# Fill all clusters with data and then discard them"
> +    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
> +    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
> +
> +    echo "# Read the data from the discarded clusters"
> +    if [ "$qcow2_compat" = "1.1" ]; then
> +        # In qcow2 v3 clusters are zeroed (with QCOW_OFLAG_ZERO)
> +        $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
> +    else
> +        # In qcow2 v2 if there's a backing image we cannot zero the clusters
> +        # without exposing the backing file data so discard does nothing
> +        $QEMU_IO -c 'read -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
> +    fi
> +
> +    echo "# Output of qemu-img map"
> +    $QEMU_IMG map "$TEST_IMG" | _filter_testdir
> +done

But I agree this was the more interesting one, so we at least have 
decent coverage of the change itself.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


