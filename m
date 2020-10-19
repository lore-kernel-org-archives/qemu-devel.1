Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BE9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BBD22246
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/UKvSBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BBD22246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUce7-0006FY-QW
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 17:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUcdC-0005ZC-9J
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUcd9-0001vq-FS
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603142625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VK/c3/693p5oMW5BQ4Os20x2LkxSmVUm5fCvEM+JoM=;
 b=I/UKvSBi/Do+wXmwiape6y1sMKFs8CDPabhvCHFKs+t4c7PELgMPaGoW+2bMfyMs3VpMpU
 1rqZhy9LYBT+6S0vwIR5u2FQjaiig/mukytGlxn05j90bEfRG8ihphkwGau61uDRGbzNKO
 rAyGEO6pBVlvZbz00PmMf7VnDuC7ny8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-TtF7BGfaM7OcThXmli0ocg-1; Mon, 19 Oct 2020 17:23:44 -0400
X-MC-Unique: TtF7BGfaM7OcThXmli0ocg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF0018049C8;
 Mon, 19 Oct 2020 21:23:42 +0000 (UTC)
Received: from [10.3.112.28] (ovpn-112-28.phx2.redhat.com [10.3.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D280E5576F;
 Mon, 19 Oct 2020 21:23:39 +0000 (UTC)
Subject: Re: [PATCH v6 03/10] block: add ability to specify list of blockdevs
 during snapshot
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201008155001.3357288-1-berrange@redhat.com>
 <20201008155001.3357288-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3700c010-8c21-efa5-3809-6ab61048761e@redhat.com>
Date: Mon, 19 Oct 2020 16:23:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008155001.3357288-4-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 10:49 AM, Daniel P. Berrangé wrote:
> When running snapshot operations, there are various rules for which
> blockdevs are included/excluded. While this provides reasonable default
> behaviour, there are scenarios that are not well handled by the default
> logic. Some of the conditions do not have a single correct answer.
> 
> Thus there needs to be a way for the mgmt app to provide an explicit
> list of blockdevs to perform snapshots across. This can be achieved
> by passing a list of node names that should be used.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

> +static int bdrv_all_get_snapshot_devices(bool has_devices, strList *devices,
> +                                         GList **all_bdrvs,
> +                                         Error **errp)
> +{
> +    g_autoptr(GList) bdrvs = NULL;
> +
> +    if (has_devices) {
> +        if (!devices) {
> +            error_setg(errp, "At least one device is required for snapshot");
> +            return -1;
> +        }
> +
> +        while (devices) {
> +            BlockDriverState *bs = bdrv_find_node(devices->value);
> +            if (!bs) {
> +                error_setg(errp, "No block device node '%s'", devices->value);
> +                return -1;
> +            }
> +            bdrvs = g_list_append(bdrvs, bs);
> +            devices = devices->next;
> +        }

Do we care if the user passes the same device more than once in their 
list?  (If so, a hash table might be better than g_list)

Otherwise, looks good to me.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


