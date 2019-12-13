Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812BEC00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FC92465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxICbOo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FC92465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkMa-0004Ka-43
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ifkL1-0002qA-NM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ifkKz-0007BJ-P2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:46:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43950
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ifkKz-000775-IT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576241187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zSAHbW23ClFS7rdYRjFwzBhWL3r8xN1a79vFgLmDplE=;
 b=NxICbOo11jSRTDLlig7nUlvyLC+3VSnX/+FeeENacztrJHhAO0M1MiM469l9i1KkRUEHb/
 3i8M0SNh+mXtC/3Ka/QNjqlJA9dkWvty403ov7bqO2gcwstj/WhEq2uhZfzaH90GCM22rB
 P/8RcScDqp/gsJY7Q+/ClmXhYSKyCVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-Y6zA9-vHNkO4S_1hyv8KJQ-1; Fri, 13 Dec 2019 07:46:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F899800D4E
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-49.gru2.redhat.com
 [10.97.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5232060BF3;
 Fri, 13 Dec 2019 12:46:18 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] python/qemu: Add set_qmp_monitor() to QEMUMachine
To: Cleber Rosa <crosa@redhat.com>
References: <20191211185536.16962-1-wainersm@redhat.com>
 <20191211185536.16962-2-wainersm@redhat.com>
 <20191212141342.GA26584@localhost.localdomain>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <cfae5351-ec67-53a3-b945-5300cb834d37@redhat.com>
Date: Fri, 13 Dec 2019 10:46:17 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191212141342.GA26584@localhost.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Y6zA9-vHNkO4S_1hyv8KJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/12/19 12:13 PM, Cleber Rosa wrote:
> On Wed, Dec 11, 2019 at 01:55:35PM -0500, Wainer dos Santos Moschetta wrote:
>> The QEMUMachine VM has a monitor setup on which an QMP
>> connection is always attempted on _post_launch() (executed
>> by launch()). In case the QEMU process immediatly exits
>> then the qmp.accept() (used to establish the connection) stalls
>> until it reaches timeout and consequently an exception raises.
>>
>> That behavior is undesirable when, for instance, it needs to
>> gather information from the QEMU binary ($ qemu -cpu list) or a
>> test which launches the VM expecting its failure.
>>
>> This patch adds the set_qmp_monitor() method to QEMUMachine that
>> allows turn off the creation of the monitor machinery on VM launch.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   python/qemu/machine.py | 66 +++++++++++++++++++++++++++---------------
>>   1 file changed, 43 insertions(+), 23 deletions(-)
>>
>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>> index a4631d6934..7d4d621a42 100644
>> --- a/python/qemu/machine.py
>> +++ b/python/qemu/machine.py
>> @@ -104,6 +104,7 @@ class QEMUMachine(object):
>>           self._events = []
>>           self._iolog = None
>>           self._socket_scm_helper = socket_scm_helper
>> +        self._qmp_set = True   # Enable QMP monitor by default.
>>           self._qmp = None
>>           self._qemu_full_args = None
>>           self._test_dir = test_dir
>> @@ -228,15 +229,16 @@ class QEMUMachine(object):
>>                   self._iolog = iolog.read()
>>   
>>       def _base_args(self):
>> -        if isinstance(self._monitor_address, tuple):
>> -            moncdev = "socket,id=mon,host=%s,port=%s" % (
>> +        args = ['-display', 'none', '-vga', 'none']
>> +        if self._qmp_set:
>> +            if isinstance(self._monitor_address, tuple):
>> +                moncdev = "socket,id=mon,host=%s,port=%s" % (
>>                   self._monitor_address[0],
>>                   self._monitor_address[1])
> One thing I missed in my review on v1 was this now became badly
> indented.  No worries, it's a minor issue that I can fix on my side
> when queueing this patch.

Good catch. Thanks!

- Wainer

>
> - Cleber.


