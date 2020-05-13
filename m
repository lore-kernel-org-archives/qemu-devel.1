Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F8DCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6296E20673
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jO3I2pZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6296E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYr3S-0006lo-Jz
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 09:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYr2F-00069J-KV
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:02:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYr2D-0004JD-Ps
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589374970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgOK/t1yGbKjH4hJpEQipRPpCZ0/HnAaH0VptHfbWzU=;
 b=jO3I2pZMsJKqspkrhFpfoFQxJk8zVNBkyMjBZYthMnOa1Fv0cqX+pQHfxqSrHRaHMDL2GK
 IveuZ/ur9MxsnC+/xrdhEy+bJmEoRf8gNSLetXwyejDdgnVfNYeho9AClQaBzHJRq3sCZ6
 u/loYQfUbFY4wY48tSveQhLgkyVq5PM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-vsbJpPQYOxKe1xWk5Qx7Hw-1; Wed, 13 May 2020 09:02:48 -0400
X-MC-Unique: vsbJpPQYOxKe1xWk5Qx7Hw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B6FD80B71B;
 Wed, 13 May 2020 13:02:45 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96E52610AF;
 Wed, 13 May 2020 13:02:44 +0000 (UTC)
Subject: Re: [PATCH] qemu-nbd: Close inherited stderr
To: Raphael Pour <raphael.pour@hetzner.com>, qemu-devel@nongnu.org
References: <ac17fad1-baf1-75ad-843d-cab8d17f1b2e@hetzner.com>
 <fa1525c8-879a-56cd-5585-e855c7c1abce@hetzner.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <090a7294-4f13-dc8b-cfc3-e4e432aa5f2c@redhat.com>
Date: Wed, 13 May 2020 08:02:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fa1525c8-879a-56cd-5585-e855c7c1abce@hetzner.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 2:14 AM, Raphael Pour wrote:
> On 5/12/20 3:57 PM, Eric Blake wrote:
>> Wouldn't it just be simpler to not dup in the first place?
>>
>> diff --git i/qemu-nbd.c w/qemu-nbd.c
>> index 4aa005004ebd..6ba2544feb3a 100644
>> --- i/qemu-nbd.c
>> +++ w/qemu-nbd.c
>> @@ -916,7 +916,9 @@ int main(int argc, char **argv)
>>           } else if (pid == 0) {
>>               close(stderr_fd[0]);
>>
>> -            old_stderr = dup(STDERR_FILENO);
>> +            if (fork_process) {
>> +                old_stderr = dup(STDERR_FILENO);
>> +            }
>>               ret = qemu_daemon(1, 0);
>>
>>               /* Temporarily redirect stderr to the parent's pipe...  */
> 
> Yes, you're right. We tested your patch and it also fixes the unwanted
> open stderr.
> 
> Could you consider this patch in one of the next releases?

Yes, now that we know about it, the bug will be fixed in 5.1; we can 
also cc: qemu-stable to get it backported to the next 5.0.x release 
(downstream developers are also more likely to backport it to their 
ports as well if it lands on qemu-stable).  Would you like to try your 
hand at a v2 patch, or shall I just turn my proposal into a formal patch 
and mention you as the reporter?  Time-wise, it may be faster for me to 
just take over the patch than to spend the time coaching you through to 
the point of your first successful submission, but project-wise, it is 
always better to welcome in new contributors and share the wealth, 
rather than making maintainers become the bottleneck.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


