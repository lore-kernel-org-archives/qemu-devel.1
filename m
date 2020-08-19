Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A3C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 21:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67331207DE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 21:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Snbh6YNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67331207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8VPq-0002o6-EM
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 17:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8VOz-0001qT-Jy
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 17:13:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20688
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8VOw-0006LP-Ld
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 17:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597871621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PcMDujvVM+ClPd7anBZAwkStrP+c45zdE3mWm5adz4o=;
 b=Snbh6YNji2nuaC0SuCgAHj8PILTvFbhTX0hwYV5ko4hbFi3pCWJMtk7n0WZ4uw334xdpZj
 j+aG2kc6lHnDkB6lF6J6aiaMIi+AGKblYljTJRLF/ec1+L6JUBvO1lyvBdZZKJu4ObC8CC
 zH813FKTyTEzJeGxk9/CvS3xGcX3KPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-JUB-djbTNp6Jjhzp5VGxVQ-1; Wed, 19 Aug 2020 17:13:37 -0400
X-MC-Unique: JUB-djbTNp6Jjhzp5VGxVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7410B425CC;
 Wed, 19 Aug 2020 21:13:36 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DE2210098A7;
 Wed, 19 Aug 2020 21:13:36 +0000 (UTC)
Subject: Re: [RFC PATCH 15/22] block/export: Move device to BlockExportOptions
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-16-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3eaafb76-d8f8-e407-3207-02709ffd7164@redhat.com>
Date: Wed, 19 Aug 2020 16:13:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-16-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 11:29 AM, Kevin Wolf wrote:
> Every block export needs a block node to export, so move the 'device'
> option from BlockExportOptionsNbd to BlockExportOptions.
> 
> To maintain compatibility in nbd-server-add, BlockExportOptionsNbd needs
> to be wrapped by a new type NbdServerAddOptions that adds 'device' back
> because nbd-server-add doesn't use the BlockExportOptions base type.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/qapi/block-export.json
> @@ -62,9 +62,8 @@
>   ##
>   # @BlockExportOptionsNbd:
>   #
> -# An NBD block export.
> -#
> -# @device: The device name or node name of the node to be exported
> +# An NBD block export (options shared between nbd-server-add and the NBD branch
> +# of block-export-add).
>   #
>   # @name: Export name. If unspecified, the @device parameter is used as the
>   #        export name. (Since 2.12)
> @@ -82,8 +81,21 @@
>   # Since: 5.0
>   ##
>   { 'struct': 'BlockExportOptionsNbd',
> -  'data': {'device': 'str', '*name': 'str', '*description': 'str',
> -           '*writable': 'bool', '*bitmap': 'str' } }
> +  'data': { '*name': 'str', '*description': 'str',
> +            '*writable': 'bool', '*bitmap': 'str' } }
> +
> +##
> +# @NbdServerAddOptions:
> +#
> +# An NBD block export.
> +#
> +# @device: The device name or node name of the node to be exported
> +#
> +# Since: 5.0

5.2, now?

> +##
> +{ 'struct': 'NbdServerAddOptions',
> +  'base': 'BlockExportOptionsNbd',
> +  'data': { 'device': 'str' } }

I understand why nbd sticks with device that can name device or node, but...

>   
>   ##
>   # @nbd-server-add:
> @@ -96,7 +108,7 @@
>   # Since: 1.3.0
>   ##
>   { 'command': 'nbd-server-add',
> -  'data': 'BlockExportOptionsNbd', 'boxed': true }
> +  'data': 'NbdServerAddOptions', 'boxed': true }
>   
>   ##
>   # @NbdServerRemoveMode:
> @@ -167,6 +179,8 @@
>   # Describes a block export, i.e. how single node should be exported on an
>   # external interface.
>   #
> +# @device: The device name or node name of the node to be exported
> +#
>   # @writethrough: If true, caches are flushed after every write request to the
>   #                export before completion is signalled. (since: 5.2;
>   #                default: false)
> @@ -175,6 +189,7 @@
>   ##
>   { 'union': 'BlockExportOptions',
>     'base': { 'type': 'BlockExportType',
> +            'device': 'str',

for block export, I'd prefer that we mandate node name only, and naming 
it @node-name (rather than @device) feels nicer, for something that only 
new code will be using (that is, we should be encouraging the use of 
node names, especially now that libvirt has finally made that leap).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


