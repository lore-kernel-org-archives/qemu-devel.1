Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C71C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D7320936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbgbCInv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D7320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrAl-0007gg-31
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLr8i-0006GP-HT
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLr8g-0004AA-SK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:04:08 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601053446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=II7xjF9cO1bR8fZp6L5+oo2lkIm6DzRIqnLJzy2SA/U=;
 b=LbgbCInv8rm/ONeqoh5Ql8HOqfhEILk9yWktDLSCqmrrZd2YDIJtqO37IoB//5lmXCX5OS
 eQ6zHpKo++FLHBdVF/1mEtkaFWjMOQva7eweab3DU3xDRchSPihGDV7er29rbKawL0eEvR
 F8WyYrqiXUP1pZT6GJMh0LhC14rfL4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-zhAzIqu9O2OOFwCtddRgoA-1; Fri, 25 Sep 2020 13:04:04 -0400
X-MC-Unique: zhAzIqu9O2OOFwCtddRgoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3764C64091;
 Fri, 25 Sep 2020 17:04:03 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A574E73667;
 Fri, 25 Sep 2020 17:04:02 +0000 (UTC)
Subject: Re: [PATCH 16/16] qapi/expr.py: Use an expression checker dispatch
 table
To: Cleber Rosa <crosa@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-17-jsnow@redhat.com>
 <20200925011849.GI368253@localhost.localdomain>
 <5a392d78-cf26-7c75-e00e-bf913607c0ac@redhat.com>
 <20200925163822.GA402155@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <2ea6b0b6-6f54-fa67-9f1f-ba3eb9f020a3@redhat.com>
Date: Fri, 25 Sep 2020 13:04:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925163822.GA402155@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:38 PM, Cleber Rosa wrote:
> On Thu, Sep 24, 2020 at 09:32:05PM -0400, John Snow wrote:
>> On 9/24/20 9:18 PM, Cleber Rosa wrote:
>>> I have to say the style of this line bothers me, but it's just that,
>>> style. So,
>>
>> What don't you like?
> 
> It's the sum of the "private" + "global dictionary" + "its item being
> called directly".
> 
> But don't bother, this is probably the kind of comment that I should
> omit, as I don't want you to, say, create a wrapper function around
> the dict, partially defeating the purpose of this patch.
>

ACK, just wanted to know what the style nit was. Thanks :)

--js


