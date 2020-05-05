Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDF6C47257
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2E720836
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHY8nYA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2E720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyL6-00064b-Ub
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVyKV-0005dT-DD
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:13:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVyKT-0001Zn-9B
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588688028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ZLJsPZJUxlX6BspXV3q5JnAXHAsEkxILwP3db+PDaU=;
 b=SHY8nYA3C+g1vmPNplvjBHCWLfMZLUqVjh87dc55pvgAO3CqbOkeuhkXN+NmNqsDxOqgO9
 pSceYn0/9zRewvZ5TEyniwtJU5p8psK+no5p7TSYDnee1nrLSVAQcBBgHsqshpt6CmbJ2d
 x1BKHcWhgXMW1B5J4Y/o3/jGkVvkoA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-LSUm_ORwNoSo_diMeY-iGw-1; Tue, 05 May 2020 10:13:45 -0400
X-MC-Unique: LSUm_ORwNoSo_diMeY-iGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73E3A18FF666;
 Tue,  5 May 2020 14:13:43 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A59E62482;
 Tue,  5 May 2020 14:13:29 +0000 (UTC)
Subject: Re: [PATCH v18 QEMU 18/18] qapi: Add VFIO devices migration stats in
 Migration stats
To: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com,
 cjia@nvidia.com
References: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
 <1588632293-18932-19-git-send-email-kwankhede@nvidia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <630eb2d9-ed8c-3b10-cee4-a1a907f8b00c@redhat.com>
Date: Tue, 5 May 2020 09:13:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588632293-18932-19-git-send-email-kwankhede@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 5:44 PM, Kirti Wankhede wrote:
> Added amount of bytes transferred to the target VM by all VFIO devices
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---

Reviewing just the UI:

> +++ b/qapi/migration.json
> @@ -144,6 +144,18 @@
>               'active', 'postcopy-active', 'postcopy-paused',
>               'postcopy-recover', 'completed', 'failed', 'colo',
>               'pre-switchover', 'device', 'wait-unplug' ] }
> +##
> +# @VfioStats:
> +#
> +# Detailed VFIO devices migration statistics
> +#
> +# @bytes: amount of bytes transferred to the target VM by VFIO devices
> +#
> +# Since: 5.0

s/5.0/5.1/

> +#
> +##
> +{ 'struct': 'VfioStats',
> +  'data': {'bytes': 'int' } }
>   
>   ##
>   # @MigrationInfo:
> @@ -205,6 +217,10 @@
>   #
>   # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
>   #
> +# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
> +#        only returned if VFIO device is present, migration is supported by all
> +#         VFIO devices and status is 'active' or 'completed' (since 5.0)

here too

> +#
>   # Since: 0.14.0
>   ##
>   { 'struct': 'MigrationInfo',
> @@ -220,7 +236,8 @@
>              '*postcopy-blocktime' : 'uint32',
>              '*postcopy-vcpu-blocktime': ['uint32'],
>              '*compression': 'CompressionStats',
> -           '*socket-address': ['SocketAddress'] } }
> +           '*socket-address': ['SocketAddress'],
> +           '*vfio': 'VfioStats' } }
>   
>   ##
>   # @query-migrate:
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


