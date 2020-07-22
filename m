Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94120C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 21:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7482071A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 21:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b31XTLMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7482071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyMVN-0006QY-KW
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 17:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyMUb-0005zD-8m
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 17:41:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyMUY-0007HV-6s
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 17:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595454093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XY5E+ZUOUM0g/yi+BzXtFQpa3HZpZElx/2kH2z/qw50=;
 b=b31XTLMeZlAyGV4x1Azt2rwgoURL+PAkESvM0nCKK3vNJvtGF9BEMGxh1Go2aOrQEomygv
 qlVbmCrurMyJLCadYYEjEUjnUN1jdCej2BEY3QRvHOjgKht/aWf1aU//Z0Bk4wquESFxGQ
 KXNRPfI9y/Mrwr0+xQT6cy4srt5LdaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-oUn9lz2cNPyKSz0O4Htb2w-1; Wed, 22 Jul 2020 17:41:28 -0400
X-MC-Unique: oUn9lz2cNPyKSz0O4Htb2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 693738015F3;
 Wed, 22 Jul 2020 21:41:27 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EF9E60C05;
 Wed, 22 Jul 2020 21:41:26 +0000 (UTC)
Subject: Re: [Bug 1884831] Re: qemu-nbd fails to discard bigger chunks
To: Bug 1884831 <1884831@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <159294358125.13789.3860026407311199131.malonedeb@wampee.canonical.com>
 <159294814773.16548.4367549975584519679.malone@chaenomeles.canonical.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2be4be2c-bf5b-439c-a436-b6cb61fb13eb@redhat.com>
Date: Wed, 22 Jul 2020 16:41:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159294814773.16548.4367549975584519679.malone@chaenomeles.canonical.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 4:35 PM, Eric Blake wrote:
> Let's get nbd.ko out of the picture.  The problem can be reproduced in
> user space (here, where I built qemu-nbd to log trace messages to
> stderr):
> 
> $ truncate --size=3G file
> $ qemu-nbd -f raw file --trace=nbd_\*
> $ nbdsh -u nbd://localhost:10810 -c 'h.trim(3*1024*1024*1024,0)'

> nbd.Error: nbd_trim: trim: command failed: Input/output error (EIO)
> 

> 
> so this is definitely a case of qemu as NBD server NOT honoring requests
> between 2G and 4G.  I'll have a patch posted soon.

https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg06592.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


