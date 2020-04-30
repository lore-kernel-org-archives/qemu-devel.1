Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BAAC83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC10206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XONTHIr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC10206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUA5i-0006Dh-CW
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:23:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUA1T-0000VH-OK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUA1S-0000sQ-69
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:18:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUA1R-0000mR-O6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588256321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Z1bnnSEYLtcwpR42A1RtF6kCDrzCdSSabVg25DE3M4=;
 b=XONTHIr7qKr45+kMFINGhQOC/YOKbeyMjWMGW1e4Vl+L24gXM7TQgu/15/jtZul4b+rKSN
 bHddb20CyfH1LvdmxnVXdQDcL/iDLLjTooua8NO5K0NvjOjt90RB/JTUiKNtImEkQSnZm3
 KCOmS7m1NX6xZUZ2CSg4b7RUfoDjgz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-J5AF9y7TP7KwLy8-LFRpGQ-1; Thu, 30 Apr 2020 10:18:38 -0400
X-MC-Unique: J5AF9y7TP7KwLy8-LFRpGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D36C0835B49;
 Thu, 30 Apr 2020 14:18:37 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 779FB60C87;
 Thu, 30 Apr 2020 14:18:32 +0000 (UTC)
Subject: Re: [PATCH 5/6] vmdk: Flush only once in vmdk_L2update()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200430133007.170335-1-kwolf@redhat.com>
 <20200430133007.170335-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <aa7db1b1-8376-eeae-dbe7-29768fbc30fc@redhat.com>
Date: Thu, 30 Apr 2020 09:18:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430133007.170335-6-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 8:30 AM, Kevin Wolf wrote:
> If we have a backup L2 table, we currently flush once after writing to
> the active L2 table and again after writing to the backup table. A
> single flush is enough and makes things a little less slow.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/vmdk.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index dcd30f1419..d3eb9a5cdc 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1435,7 +1435,7 @@ static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
>       offset = cpu_to_le32(offset);
>       /* update L2 table */
>       BLKDBG_EVENT(extent->file, BLKDBG_L2_UPDATE);
> -    if (bdrv_pwrite_sync(extent->file,
> +    if (bdrv_pwrite(extent->file,
>                   ((int64_t)m_data->l2_offset * 512)
>                       + (m_data->l2_index * sizeof(offset)),
>                   &offset, sizeof(offset)) < 0) {

Worth reindenting ther est of the function call?

> @@ -1444,13 +1444,16 @@ static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
>       /* update backup L2 table */
>       if (extent->l1_backup_table_offset != 0) {
>           m_data->l2_offset = extent->l1_backup_table[m_data->l1_index];
> -        if (bdrv_pwrite_sync(extent->file,
> +        if (bdrv_pwrite(extent->file,
>                       ((int64_t)m_data->l2_offset * 512)
>                           + (m_data->l2_index * sizeof(offset)),
>                       &offset, sizeof(offset)) < 0) {
>               return VMDK_ERROR;
>           }
>       }
> +    if (bdrv_flush(extent->file->bs) < 0) {
> +        return VMDK_ERROR;
> +    }

But indentation doesn't affect correctness.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


