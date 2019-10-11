Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B2CC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C5E206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C5E206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIzB6-0000IQ-UW
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 13:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iIxqH-0003b9-TJ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iIxqG-00052m-Qp
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:32:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iIxqE-00050j-DE; Fri, 11 Oct 2019 12:32:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B90D18C426E;
 Fri, 11 Oct 2019 16:32:33 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2590719C58;
 Fri, 11 Oct 2019 16:32:33 +0000 (UTC)
Subject: Re: [PATCH v3 14/16] qcow2: Fix v3 snapshot table entry compliancy
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191011152814.14791-1-mreitz@redhat.com>
 <20191011152814.14791-15-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <87e6790e-885d-9bd7-b64f-45eee715d05b@redhat.com>
Date: Fri, 11 Oct 2019 11:32:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011152814.14791-15-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 11 Oct 2019 16:32:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 10:28 AM, Max Reitz wrote:
> qcow2 v3 images require every snapshot table entry to have at least 16
> bytes of extra data.  If they do not, let qemu-img check -r all fix it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   block/qcow2-snapshot.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index dac8a778e4..5ab64da1ec 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -516,6 +516,24 @@ int coroutine_fn qcow2_check_read_snapshot_table(BlockDriverState *bs,
>           result->corruptions -= nb_clusters_reduced;
>       }
>   
> +    /*
> +     * All of v3 images' snapshot table entries need to have at least
> +     * 16 bytes of extra data.
> +     */
> +    if (s->qcow_version >= 3) {
> +        int i;
> +        for (i = 0; i < s->nb_snapshots; i++) {
> +            if (s->snapshots[i].extra_data_size <
> +                sizeof_field(QCowSnapshotExtraData, vm_state_size_large) +
> +                sizeof_field(QCowSnapshotExtraData, disk_size))
> +            {

Another stylistic place where sizeof(QCowSnapshotExtraData) would be 
more compact.  Doesn't change R-b

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

