Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC0BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 21:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E112067B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 21:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddG2CJL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E112067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgxqY-0002Q8-Ed
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 17:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgxpX-0001Mc-Je
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 17:55:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26739
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgxpU-0000ta-13
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 17:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591307714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdXXWjoY5/iTvsd9MYNX1eirF9T4vt02eSPP3jxJc/w=;
 b=ddG2CJL8+7OOwRLF2nMe9lSwYFOQ4XaSaCJSWdFFk2U4t2bWSUOr2f+qEamRy5yuq5YdFb
 VbS37azbwhcJA1Y/fEh87fIbP6lmDoJoOdP+bP3Lj+ZQCN0dLTdwvDm+gmV3pDLeOwF1mP
 Bgw3dnSSVmjnGEa5CfOZzQCg6jfBRDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-JIPMmbwbPzWkpj4HQTSATw-1; Thu, 04 Jun 2020 17:55:07 -0400
X-MC-Unique: JIPMmbwbPzWkpj4HQTSATw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 637E2835B40;
 Thu,  4 Jun 2020 21:55:06 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6056810013D7;
 Thu,  4 Jun 2020 21:55:02 +0000 (UTC)
Subject: Re: [PATCH v4] osdep: Make MIN/MAX evaluate arguments only once
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200604215236.2798244-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7233fccd-aaff-d705-0746-99648c61a15c@redhat.com>
Date: Thu, 4 Jun 2020 16:55:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604215236.2798244-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, quintela@redhat.com,
 crosthwaite.peter@gmail.com, dgilbert@redhat.com, f4bug@amsat.org,
 kraxel@redhat.com, dirty.ice.hu@gmail.com, pbonzini@redhat.com,
 Max Reitz <mreitz@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 4:52 PM, Eric Blake wrote:
> I'm not aware of any immediate bugs in qemu where a second runtime
> evalution of the arguments to MIN() or MAX() causes a problem, but

evaluation

> proactively preventing such abuse is easier than falling prey to an
> unintended case down the road.  At any rate, here's the conversation
> that sparked the current patch:
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05718.html
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


