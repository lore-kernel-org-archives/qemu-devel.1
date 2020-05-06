Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C322C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8052076D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyjKyqU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8052076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWSAr-0002fe-BN
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 18:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWS9o-00020G-C2
 for qemu-devel@nongnu.org; Wed, 06 May 2020 18:04:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46175
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWS9m-00012O-FY
 for qemu-devel@nongnu.org; Wed, 06 May 2020 18:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588802685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcU5heNxCuMY3deTCEGxZl7R1GD2wZ8WfWD2Ae7SOYE=;
 b=SyjKyqU6Ke8eF1aQvQGp5E/SMt4AEMb07BwYVYRnKYDnLvobfl1AUZsHJpzDNXYKldvGWt
 Nkx99vFhKC35W/+9bUhlCxR+faNk3qtU4hi3M0btc2q6tuhFlBdH4U352piE3yOMJIjm+i
 6qJTF0Aee+gMHFmDFuze7rsu61cbJls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-pijZE6EhPteZgt28QZTxow-1; Wed, 06 May 2020 18:04:43 -0400
X-MC-Unique: pijZE6EhPteZgt28QZTxow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28D2E107ACCA;
 Wed,  6 May 2020 22:04:42 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6760C100238A;
 Wed,  6 May 2020 22:04:41 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] qemu-img: Add --start-offset and --max-length to
 map
To: Eyal Moscovici <eyal.moscovici@oracle.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
 <20200506213459.44743-6-eyal.moscovici@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0a3bc115-ea14-4723-2993-6a6c9de12208@redhat.com>
Date: Wed, 6 May 2020 17:04:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506213459.44743-6-eyal.moscovici@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, liran.alon@oracle.com,
 Yoav Elnekave <yoav.elnekave@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 4:34 PM, Eyal Moscovici wrote:
> The mapping operation of large disks especially ones stored over a
> long chain of QCOW2 files can take a long time to finish.
> Additionally when mapping fails there was no way recover by
> restarting the mapping from the failed location.
> 
> The new options, --start-offset and --max-length allows the user to
> divide these type of map operations into shorter independent tasks.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

This patch has some changes from v1.  Among others,...

> @@ -3041,6 +3045,18 @@ static int img_map(int argc, char **argv)
>           case OPTION_OUTPUT:
>               output = optarg;
>               break;
> +        case 's':
> +            start_offset = cvtnum("start offset", optarg);
> +            if (start_offset < 0) {
> +                return 1;
> +            }
> +            break;

the new semantics of cvtnum() in this series is enough of a difference 
that I would have removed R-b to make sure the updated patch gets 
re-reviewed, if it had been me as author.  But in this case, it does 
look like the changes are all addressed to comments I suggested in v1, 
so I'm fine that you left my R-b.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


