Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1753C433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96553206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/cyUBnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96553206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Qk7-0002sR-O1
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0Qiy-0001sm-6o
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:37:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0Qiu-0002JX-51
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595947014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEzYu8+zs9PuNDw0do+4Wobp5eGNjzCaJ4NHxcrO+LQ=;
 b=d/cyUBnJPHs+Ji7jg50UYDzimrrdugqOIg1QX04ORI96VpkXKb+vczgMPjvosRyBxKI+4K
 +ArPm5y95g3io/7NB2F7u5HkgkHSykPnR2JUqUgaLXWKQy79N2RVpOQEUTHb/y6koKbAGU
 bAdOgA3MpWU4jftvHrdfb88rnIXqfmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-l7pCi3OOP1GPVd8UJMEMYA-1; Tue, 28 Jul 2020 10:36:53 -0400
X-MC-Unique: l7pCi3OOP1GPVd8UJMEMYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D18CD8017FB;
 Tue, 28 Jul 2020 14:36:51 +0000 (UTC)
Received: from [10.10.118.248] (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBC7D60BF4;
 Tue, 28 Jul 2020 14:36:50 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] iotests: Make qemu_nbd_popen() a contextmanager
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20200727215846.395443-1-nsoffer@redhat.com>
 <20200727215846.395443-3-nsoffer@redhat.com>
 <ac8994e8-7f06-0710-78ce-0596e9538e7d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f36763b6-eac4-abf9-9563-7f8231422486@redhat.com>
Date: Tue, 28 Jul 2020 09:36:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ac8994e8-7f06-0710-78ce-0596e9538e7d@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/28/20 8:42 AM, Vladimir Sementsov-Ogievskiy wrote:
> 28.07.2020 00:58, Nir Soffer wrote:
>> Instead of duplicating the code to wait until the server is ready and
>> remember to terminate the server and wait for it, make it possible to
>> use like this:
>>
>>      with qemu_nbd_popen('-k', sock, image):
>>          # Access image via qemu-nbd socket...
>>
>> Only test 264 used this helper, but I had to modify the output since it
>> did not consistently when starting and stopping qemu-nbd.
>>
>> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
>> ---

>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -28,10 +28,13 @@ import signal
>>   import struct
>>   import subprocess
>>   import sys
>> +import time
>>   from typing import (Any, Callable, Dict, Iterable,
>>                       List, Optional, Sequence, Tuple, TypeVar)
>>   import unittest
>> +from contextlib import contextmanager
>> +
>>   # pylint: disable=import-error, wrong-import-position
>>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 
>> 'python'))
>>   from qemu import qtest
>> @@ -270,9 +273,30 @@ def qemu_nbd_early_pipe(*args):
>>       return subp.returncode, output if subp.returncode else ''
>> +@contextmanager
>>   def qemu_nbd_popen(*args):
>> -    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
>> -    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + 
>> list(args))
>> +    '''Context manager running qemu-nbd within the context'''
> 
> PEP8 (or some another PEP referenced in PEP8) asks to use """ for 
> doc-strings

But at least './check 297' still passes, so we are consistent enough 
with our current set of syntax checks to be acceptable.

> 
>> +    pid_file = file_path("pid")
>> +
>> +    cmd = list(qemu_nbd_args)
>> +    cmd.extend(('--persistent', '--pid-file', pid_file))
>> +    cmd.extend(args)
>> +
>> +    log('Start NBD server')
>> +    p = subprocess.Popen(cmd)
>> +    try:
>> +        while not os.path.exists(pid_file):
>> +            if p.poll() is not None:
>> +                raise RuntimeError(
>> +                    "qemu-nbd terminated with exit code {}: {}"
>> +                    .format(p.returncode, ' '.join(cmd)))
>> +
>> +            time.sleep(0.01)
>> +        yield
>> +    finally:
>> +        log('Kill NBD server')
>> +        p.kill()
>> +        p.wait()
> 
> why do we need try-finally? I think, the only possible exception is your 
> "raise RuntimeError", and in this case the process is alredy dead, no 
> need to kill it (and print the log message)
> 
>>   def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
>>       '''Return True if two image files are identical'''
>>
> 
> anyway:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

Thanks; I trust your python review more than mine.  Queuing for -rc2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


