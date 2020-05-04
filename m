Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A391FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 20:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E23524963
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 20:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYpo/k6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E23524963
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVhJq-0006mt-KT
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 16:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVhJ2-0005t3-Dc
 for qemu-devel@nongnu.org; Mon, 04 May 2020 16:03:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVhJ0-0001DY-AT
 for qemu-devel@nongnu.org; Mon, 04 May 2020 16:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588622588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDF43Z4FLXi8e1HZuy5LY23O2j3hhNZwxpNtDNrsTS4=;
 b=UYpo/k6NMWtyrIar0Wim9VmP9vt3iSRCLPz4BQ2DzDrBwqRSLshNi5i3fFMS+zi95mDi1t
 em/pCuEgLmArUAVOlHlsse5/1AlMKmoRAp8gLu671eW2GICPEY0Le1ihKWiY0dFIc3XFAu
 aFzU7AGroP5ygtLlTC/tMF1/MIzwFeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-wCFVPDgHOSK0DyBDBbH_VA-1; Mon, 04 May 2020 16:03:04 -0400
X-MC-Unique: wCFVPDgHOSK0DyBDBbH_VA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA63410082EA;
 Mon,  4 May 2020 20:03:03 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44A6B63F74;
 Mon,  4 May 2020 20:03:00 +0000 (UTC)
Subject: Re: [PATCH v5 for-5.0? 0/7] Tighten qemu-img rules on missing backing
 format
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200403175859.863248-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <311bb693-4705-b18a-cc92-5865359abaa5@redhat.com>
Date: Mon, 4 May 2020 15:02:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200403175859.863248-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 16:03:08
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 12:58 PM, Eric Blake wrote:
> v4 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg03775.html
> In v5:
> - fix 'qemu-img convert -B' to actually warn [Kashyap]
> - squash in followups
> - a couple more iotest improvements
> 
> If we decide this is not 5.0 material, then patches 4 and 7 need a
> tweak to s/5.0/5.1/ as the start of the deprecation clock.

Ping.  I've already made the 5.1 change in my local tree, does anyone 
want to review the rest of this series before I post a v6?

> 
> Eric Blake (7):
>    sheepdog: Add trivial backing_fmt support
>    vmdk: Add trivial backing_fmt support
>    qcow: Tolerate backing_fmt=, but warn on backing_fmt=raw
>    qcow2: Deprecate use of qemu-img amend to change backing file
>    iotests: Specify explicit backing format where sensible
>    block: Add support to warn on backing file change without format
>    qemu-img: Deprecate use of -b without -F
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


