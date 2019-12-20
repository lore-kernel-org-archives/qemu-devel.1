Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F27C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4284821655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9+tRm9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4284821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPR2-0005E3-Dg
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iiPQ1-0004Q7-DP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iiPPx-0000z7-RC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:02:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iiPPx-0000oB-82
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576875755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpj7ab5HpL0o7Zc+OKjOIu1vs2B2A8vw4kk+6RTdY+w=;
 b=M9+tRm9lR/PM1psHSD7eSlOu0qe9ODC7U4KSwcZ4a2zuyFQEXR4E2UVXhkMzXqnmwPzEST
 GRws7SXkmcARF+wgnAwVZabkgw72+oznVLm5C0e+rBsE+i12Ot2dBwUjrAK6wB0M5udiHm
 78BKVt4r5r77mPsNZeWs31XDlQ77FHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-w3E_xrdLNGOmSaRb8NSdnQ-1; Fri, 20 Dec 2019 16:02:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A7771951261;
 Fri, 20 Dec 2019 21:02:33 +0000 (UTC)
Received: from [10.3.116.246] (ovpn-116-246.phx2.redhat.com [10.3.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 183D25DA32;
 Fri, 20 Dec 2019 21:02:30 +0000 (UTC)
Subject: Re: [PATCH] block/rbd: Add support for ceph namespaces
To: Florian Florensa <fflorensa@online.net>, qemu-devel@nongnu.org
References: <20191219133416.671431-1-fflorensa@online.net>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1625c5ab-e65f-68b7-a35c-9370cca5494e@redhat.com>
Date: Fri, 20 Dec 2019 15:02:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219133416.671431-1-fflorensa@online.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: w3E_xrdLNGOmSaRb8NSdnQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, dillaman@redhat.com, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 7:34 AM, Florian Florensa wrote:
> Starting from ceph Nautilus, RBD has support for namespaces, allowing
> for finer grain ACLs on images inside a pool, and tenant isolation.
> 
> In the rbd cli tool documentation, the new image-spec and snap-spec are :
>   - [pool-name/[namespace-name/]]image-name
>   - [pool-name/[namespace-name/]]image-name@snap-name
> 
> When using an non namespace's enabled qemu, it complains about not
> finding the image called namespace-name/image-name, thus we only need to
> parse the image once again to find if there is a '/' in its name, and if
> there is, use what is before it as the name of the namespace to later
> pass it to rados_ioctx_set_namespace.
> rados_ioctx_set_namespace if called with en empty string or a null
> pointer as the namespace parameters pretty much does nothing, as it then
> defaults to the default namespace.
> 
> The namespace is extracted inside qemu_rbd_parse_filename, stored in the
> qdict, and used in qemu_rbd_connect to make it work with both qemu-img,
> and qemu itself.
> 
> Signed-off-by: Florian Florensa <fflorensa@online.net>
> ---

> +++ b/qapi/block-core.json
> @@ -3657,6 +3657,8 @@
>   #
>   # @pool:               Ceph pool name.
>   #
> +# @nspace:             Rados namespace name in the Ceph pool.
> +#

Needs a '(since 5.0)' tag.

>   # @image:              Image name in the Ceph pool.
>   #
>   # @conf:               path to Ceph configuration file.  Values
> @@ -3683,6 +3685,7 @@
>   ##
>   { 'struct': 'BlockdevOptionsRbd',
>     'data': { 'pool': 'str',
> +            'nspace': 'str',

This makes a new argument mandatory, which breaks expectations of older 
clients that failed to provide it. You probably want to make it 
'*nspace', and have a sane default when the argument is not present.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


