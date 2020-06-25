Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FC2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BC42076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjmyiUzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BC42076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joT53-0004jR-2a
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joT4H-0004HT-Dd
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:41:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joT4F-0003nQ-EP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593096089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyiCndXQ4xUfCSI66t9OM/wHwBbqrpKuJsmtNIW0WPs=;
 b=LjmyiUzHmKQFp2YCa1IbhZmj5FcDrVKGxJAoZt6mKlPGORfRypfPfIeC7qxQKolqI4lRMl
 M4Kn3OI6KRP5P77mGCEcHgwzTGJ56oRx9oDvp9poTsIeQ1IkSup/rMQtJk01U6nHJAomPV
 NHei9Gxv4+++gsyVKeMjuzdRgcj1JJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-ca_VDb40N2-UrO2xvh2fHg-1; Thu, 25 Jun 2020 10:41:21 -0400
X-MC-Unique: ca_VDb40N2-UrO2xvh2fHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88274A0BF6;
 Thu, 25 Jun 2020 14:41:11 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8FB95DAA0;
 Thu, 25 Jun 2020 14:41:10 +0000 (UTC)
Subject: Re: [PATCH 07/46] error: Avoid more error_propagate() when error is
 not used here
To: Markus Armbruster <armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-8-armbru@redhat.com>
 <88bc4c25-4a47-4c28-4b96-b7ea6c14173d@redhat.com>
 <87h7uz1f8d.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3370c2f8-3579-7900-3f7b-f1e0930d1c0f@redhat.com>
Date: Thu, 25 Jun 2020 09:41:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87h7uz1f8d.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 7:50 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 6/24/20 11:43 AM, Markus Armbruster wrote:
>>> When all we do with an Error we receive into a local variable is
>>> propagating to somewhere else, we can just as well receive it there
>>> right away.  The previous commit did that for simple cases with
>>> Coccinelle.  Do it for a few more manually.
>>>

>>>          if (!bus && qdev_hotplug &&
>>> !qdev_get_machine_hotplug_handler(dev)) {
>>>            /* No bus, no machine hotplug handler --> device is not hotpluggable */
>>> -        error_setg(&err, "Device '%s' can not be hotplugged on this machine",
>>> +        error_setg(errp, "Device '%s' can not be hotplugged on this machine",
>>
>> Should we s/can not/cannot/ while touching this?
> 
> The longer and the more mechanical the patch, the less willing I am to
> include "while we're there" improvements.  This one may still be okay.
> But you pointed out a few more error message improvements in later
> reviews.  Perhaps collecting them all into an omnibus error message
> patch would be better.

Yes, collecting a single followup patch for grammar/spelling fixes found 
throughout the series is a good idea.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


