Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E10D20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcIFGMO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E10D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3pW-0004Ed-Vl
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr3oS-0003N0-EV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:19:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48094
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr3oL-0007Kv-4S
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593713988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQI2kkbf1wkwpH8XwyRiQ7Gmpubb3ZrCQiBP/uUDyAk=;
 b=JcIFGMO4xtFWx77QfbfwkEJ/Np/wc5RRpBtAlfzqUnNFhrS1QMp5S+uy4KMVXckhqWE60n
 3SuSpShShcZEnnbtOC7TOXQR7CMuY5pOfPjk7To4lttL52zlUz37ywKD+fru3d1uLI/1w4
 ANskxGjoYbZ9j5BiHQr2XitdylV5n4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13--obEwZIsNpubSCT967TDIw-1; Thu, 02 Jul 2020 14:19:46 -0400
X-MC-Unique: -obEwZIsNpubSCT967TDIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BD17107ACF2;
 Thu,  2 Jul 2020 18:19:45 +0000 (UTC)
Received: from [10.3.112.202] (ovpn-112-202.phx2.redhat.com [10.3.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79A1979250;
 Thu,  2 Jul 2020 18:19:44 +0000 (UTC)
Subject: Re: [PATCH 6/6] migration: support picking vmstate disk in QMP
 snapshot commands
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-7-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a4aacccc-3761-591c-637d-1e0110a6c337@redhat.com>
Date: Thu, 2 Jul 2020 13:19:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702175754.2211821-7-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:
> This wires up support for a new "vmstate" parameter to the QMP commands
> for snapshots (savevm, loadvm). This parameter accepts block driver
> state node name.
> 
> One use case for this would be a VM using OVMF firmware where the
> variables store is the first snapshottable disk image. The vmstate
> snapshot usually wants to be stored in the primary root disk of the
> VM, not the firmeware varstore. Thus there needs to be a mechanism

firmware

> to override the default choice of disk.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

> +++ b/qapi/migration.json
> @@ -1630,6 +1630,7 @@
>   # @tag: name of the snapshot to create. If it already
>   # exists it will be replaced.
>   # @exclude: list of block device node names to exclude
> +# @vmstate: block device node name to save vmstate to
>   #
>   # Note that execution of the VM will be paused during the time
>   # it takes to save the snapshot
> @@ -1641,6 +1642,7 @@
>   # -> { "execute": "savevm",
>   #      "data": {
>   #         "tag": "my-snap",
> +#         "vmstate": "disk0",
>   #         "exclude": ["pflash0-vars"]
>   #      }
>   #    }
> @@ -1650,6 +1652,7 @@
>   ##
>   { 'command': 'savevm',
>     'data': { 'tag': 'str',
> +            '*vmstate': 'str',
>               '*exclude': ['str'] } }

During save, the list of block devices is obvious: everything that is 
not excluded.  But,

>   
>   ##
> @@ -1659,6 +1662,7 @@
>   #
>   # @tag: name of the snapshot to load.
>   # @exclude: list of block device node names to exclude
> +# @vmstate: block device node name to load vmstate from
>   #
>   # Returns: nothing
>   #
> @@ -1667,6 +1671,7 @@
>   # -> { "execute": "loadvm",
>   #      "data": {
>   #         "tag": "my-snap",
> +#         "vmstate": "disk0",
>   #         "exclude": ["pflash0-vars"]
>   #      }
>   #    }
> @@ -1676,6 +1681,7 @@
>   ##
>   { 'command': 'loadvm',
>     'data': { 'tag': 'str',
> +            '*vmstate': 'str',
>               '*exclude': ['str'] } }

...now that we support exclusion during saving, or even without 
exclusion but when the user has performed hotplug/unplug operations in 
the meantime from when the snapshot was created, isn't load better off 
listing all devices which SHOULD be restored, rather than excluding 
devices that should NOT be restored?  (After all, libvirt knows which 
disks existed at the time of the snapshot, which may be different than 
the set of disks that exist now even though we are throwing out the 
state now to go back to the state at the time of the snapshot)

Then there's the question of symmetry: if load needs an explicit list of 
blocks to load from (rather than the set of blocks that are currently 
associated with the machine), should save also take its list by positive 
inclusion rather than negative exclusion?

And why does delvm not need to specify which block is the vmstate? 
delvm is in the same boat as loadvm - the set of blocks involved at the 
time of the snapshot creation may be different than the set of blocks 
currently associated with the guest at the time you run load/delvm.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


