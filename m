Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B601C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D667320706
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUSUt1um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D667320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxs4-0007Tv-SH
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRxqZ-0005hm-0L
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRxqY-0000Bf-Dq
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:54:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49375
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRxqX-0008Rp-UX
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587732860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cv9/+7707yOPIZraynEeuoO6ni4JU/aGxeHm81XsaGY=;
 b=QUSUt1umLDzqs8m2J9d1QTA1wlNd//BhmMhX7lDc1hVnMeKrf2APLoi9/SfM0PxzLu57Nn
 ZeEWk7wcEybxaIE4lEE1uwZ/XgQ3L3DkKFhKRPkKx8Fwx/dU7zVZ2zUYL+qBA/8+87awE3
 O0WwCPPHYWECDuXuFnQ4lQvlmOSZWao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-H84gPvgXOuuRaKenTpdF1Q-1; Fri, 24 Apr 2020 08:54:14 -0400
X-MC-Unique: H84gPvgXOuuRaKenTpdF1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4B2C100CCC1;
 Fri, 24 Apr 2020 12:54:12 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C17CB6084A;
 Fri, 24 Apr 2020 12:54:00 +0000 (UTC)
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
To: Stefan Hajnoczi <stefanha@redhat.com>, elena.ufimtseva@oracle.com
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <20200424124823.GC189569@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <00786792-33e1-38cc-3d4c-1cee1e786c9e@redhat.com>
Date: Fri, 24 Apr 2020 07:53:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424124823.GC189569@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 Max Reitz <mreitz@redhat.com>, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 7:48 AM, Stefan Hajnoczi wrote:
> On Wed, Apr 22, 2020 at 09:13:35PM -0700, elena.ufimtseva@oracle.com wrote:
>> There is an error in travis-ci build test which does not get reproduced.
>>
>>   TEST    iotest-qcow2: 041 [fail]
>> QEMU          -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults -display none -accel qtest

>> +Traceback (most recent call last):
>> +  File "041", line 1049, in test_with_other_parent
>> +    self.assert_qmp(result, 'return', {})
>> +  File "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-iotests/iotests.py", line 821, in assert_qmp
>> +    result = self.dictpath(d, path)
>> +  File "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-iotests/iotests.py", line 797, in dictpath
>> +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
>> +AssertionError: failed path traversal for "return" in "{'error': {'class': 'GenericError', 'desc': "UNIX socket path '/home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/scratch/nbd.sock' is too long"}}"
> 
> UNIX Domain Socket paths have to be 108 characters or less.  The path in
> the failed test case is 110 characters long.  You could rename your
> branch to "mpqemu" to solve this failure.

We recently fixed the iotests to prefer sticking NBD sockets under 
$SOCK_DIR (see commits f0e24942 and friends); did we miss test 41?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


