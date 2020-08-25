Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC6DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAA020665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCit8xXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAA020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZbd-0002v1-5w
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kAZb2-0002VU-J1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kAZb0-0001gY-64
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598364401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSGhv7Dx4k0wiP+T1OGVi+0yw20I3uX/s5oDHa/lG98=;
 b=UCit8xXbkLW5JtHfZWuDI2SLZNkTyO2Y/yP9bWkmNkDlzXDOCSQUouX7en3Gjk2xLsFwPd
 LZYwp8EnaBv6QyvJBPOaST1/7LjOz+cEI+7AscNyJQHWYTs2L8zLdTeaPKGPbZXExbDjVn
 uPbyUbo4z9Fpw4/sfdLsCI/BLiwGpOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-DJEr3GQ6MuS_WcRZXRBX8A-1; Tue, 25 Aug 2020 10:06:39 -0400
X-MC-Unique: DJEr3GQ6MuS_WcRZXRBX8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF8C4427FC;
 Tue, 25 Aug 2020 14:06:34 +0000 (UTC)
Received: from [10.3.112.126] (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96B5C1045E95;
 Tue, 25 Aug 2020 14:06:34 +0000 (UTC)
Subject: Re: [PATCH 1/4] configure: Use discovered make for in-source build
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200822212129.97758-1-r.bolshakov@yadro.com>
 <20200822212129.97758-2-r.bolshakov@yadro.com>
 <0d4354b5-87bc-ee2b-a028-bc9e64baf4f0@redhat.com>
 <20200824220755.GC41106@SPB-NB-133.local>
 <20200825101649.GC38400@SPB-NB-133.local>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f6e1ceb5-2508-7d82-bb9c-71cc11ea4bb3@redhat.com>
Date: Tue, 25 Aug 2020 09:06:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825101649.GC38400@SPB-NB-133.local>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 5:16 AM, Roman Bolshakov wrote:

> 
> Hi Eric,
> 
> What if we just print an error if build/config-host.mak can't be found?
> 
> ifeq ($(wildcard build/config-host.mak),)
> $(error "Incomplete configuration. Please run ./configure")
> endif
> 
> IMO this is more sane approach than proceeding with partially-configured
> not working build without a Makefile in proper place.

Yes, that is definitely a better approach.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


