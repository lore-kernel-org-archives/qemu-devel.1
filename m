Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ACEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E8E20706
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx9Y6qOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E8E20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHk5-0001qB-IQ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHjS-0001PF-VW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:23:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43801
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHjR-0007tX-Ee
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592814188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YTQYxwR23NJVNpU9ATdOG6Wg7zHLA4HTU8kDiazvMWc=;
 b=Tx9Y6qOGXiol7SlgDlt+myejCqjtIqxV3Sark1XBN6LQV+NiPPShDj2QdzLUcm5CtkpAOf
 QY2gtDXYy7DMIdO9KmCa/obZYL/7+1X5aeG/xAHGJMpWWuKaix3CUkYFZQrNB1Odm6Dvxd
 y2r60JB8Vr72DZBELUklKL4wyybogP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-aWBdsMt8MAyPXYTk5XouBA-1; Mon, 22 Jun 2020 04:23:07 -0400
X-MC-Unique: aWBdsMt8MAyPXYTk5XouBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2083107ACCA;
 Mon, 22 Jun 2020 08:23:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC5A75BAEB;
 Mon, 22 Jun 2020 08:23:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 08775113846D; Mon, 22 Jun 2020 10:23:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: Memory leak in transfer_memory_block()?
References: <87h7v9szpe.fsf@dusky.pond.sub.org>
 <8562bcb768514568b14788e801aee681@huawei.com>
Date: Mon, 22 Jun 2020 10:23:01 +0200
In-Reply-To: <8562bcb768514568b14788e801aee681@huawei.com> (Zhanghailiang's
 message of "Thu, 18 Jun 2020 06:49:51 +0000")
Message-ID: <87bllbpl0a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhanghailiang <zhang.zhanghailiang@huawei.com> writes:

>> -----Original Message-----
>> From: Markus Armbruster [mailto:armbru@redhat.com]
>> Sent: Thursday, June 18, 2020 1:36 PM
>> To: Zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Cc: qemu-devel@nongnu.org; Michael Roth <mdroth@linux.vnet.ibm.com>
>> Subject: Memory leak in transfer_memory_block()?
>> 
>> We appear to leak an Error object when ga_read_sysfs_file() fails with
>> errno != ENOENT unless caller passes true @sys2memblk:
>> 
>>     static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool
>> sys2memblk,
>>                                       GuestMemoryBlockResponse
>> *result,
>>                                       Error **errp)
>>     {
>>         [...]
>>         if (local_err) {
>> 
>> We have an Error object.
>> 
>>             /* treat with sysfs file that not exist in old kernel */
>>             if (errno == ENOENT) {
>> 
>> Case 1: ENOENT; we free it.  Good.
>> 
>>                 error_free(local_err);
>>                 if (sys2memblk) {
>>                     mem_blk->online = true;
>>                     mem_blk->can_offline = false;
>>                 } else if (!mem_blk->online) {
>>                     result->response =
>> 
>> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
>>                 }
>>             } else {
>> 
>> Case 2: other than ENOENT
>> 
>>                 if (sys2memblk) {
>> 
>> Case 2a: sys2memblk; we pass it to the caller.  Good.
>> 
>>                     error_propagate(errp, local_err);
>>                 } else {
>> 
>> Case 2b: !sys2memblk; ???
>> 
>
> Good catch!  I think we should pass the error info back to the caller,
> Let's record this error for debug when it happens.

I'll post a minimal fix to plug the leak, cc'ing you.  I'll gladly
replace it by a patch that does more.  Thanks!

>>                     result->response =
>> 
>> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
>>                 }
>>             }
>>             goto out2;
>>         }
>>         [...]
>>     out2:
>>         g_free(status);
>>         close(dirfd);
>>     out1:
>>         if (!sys2memblk) {
>>             result->has_error_code = true;
>>             result->error_code = errno;
>>         }
>>     }
>> 
>> What is supposed to be done with @local_err in case 2b?


