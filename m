Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A301C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A152080A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMIEvGxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A152080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM4im-0002f9-Oi
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 03:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kM4hu-0002A1-HP
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 03:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kM4hq-0005KN-GR
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 03:33:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601105596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PmoNjyaK9tpDhf/KhMkCfWhxEMHld6bXwpO0w+er9cI=;
 b=VMIEvGxy88n9GjW1y9geuQxAf4kUzhcgAwzd5br7ug9+gp0AK122JjKN7FszPrV5+tPJH+
 NaRRDw1sHK/blDl/KjOF/QB84Ho578EDli+EEDLgZ2CGyEu6aNHhH9ex3DfKhAbh/zaL5o
 RM2YVj722ZEa3GVGqiXBj5FJAu9cOOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-C1NHxeslPXKmWgVi9MP2dA-1; Sat, 26 Sep 2020 03:33:11 -0400
X-MC-Unique: C1NHxeslPXKmWgVi9MP2dA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79878107464A;
 Sat, 26 Sep 2020 07:33:10 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C39F5D9DC;
 Sat, 26 Sep 2020 07:33:09 +0000 (UTC)
Date: Sat, 26 Sep 2020 08:33:08 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/3] nbd: Add new qemu:allocation-depth metacontext
Message-ID: <20200926073308.GV3888@redhat.com>
References: <20200925203249.155705-1-eblake@redhat.com>
 <20200925203249.155705-3-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925203249.155705-3-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 03:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 25, 2020 at 03:32:48PM -0500, Eric Blake wrote:
> +The second is related to exposing the source of various extents within
> +the image, with a single context named:
> +
> +    qemu:allocation-depth
> +
> +In the allocation depth context, bits 0 and 1 form a tri-state value:
> +
> +    bits 0-1 clear: NBD_STATE_DEPTH_UNALLOC, means the extent is unallocated
> +    bit 0 set: NBD_STATE_DEPTH_LOCAL, the extent is allocated in this image
> +    bit 1 set: NBD_STATE_DEPTH_BACKING, the extent is inherited from a
> +               backing layer

From the cover description I imagined it would show the actual depth, ie:

         top -> backing -> backing -> backing
 depth:   1        2         3   ....          (0 = unallocated)

I wonder if that is possible?  (Perhaps there's something I don't
understand here.)

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


