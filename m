Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F51C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15FE214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmApgjvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15FE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3Pu-0003s4-UT
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1if3P5-0003QI-Uv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1if3P3-0007Em-RP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:55:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1if3P3-0007Bw-6E
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576076147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgq1HIOyFB6ymXEP11sJs/vCEyNbaHMMlSu3uC4hDJs=;
 b=QmApgjvfkE7k2O3yUbo6yUduNKwmn+ww2se74NhBNzaAfaYKbSxmnL7NMJcUJNbtdBC6jV
 ejHsJTVxjbx1q0khv4hcgs6waoP12htGoV6qO6mmvTQadI2aTDg/TzTq3eeWiOo8ql3ayP
 zmXHvmY8m7yH4Le6REqjazcgbsxrIq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-XEeQFIBJPP-YmepfpfK2nQ-1; Wed, 11 Dec 2019 09:55:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 080D18005BF
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-129.rdu2.redhat.com
 [10.10.122.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23A791001938;
 Wed, 11 Dec 2019 14:55:40 +0000 (UTC)
Subject: Re: [PATCH 1/2] python/qemu: Add set_qmp_monitor() to QEMUMachine
To: Cleber Rosa <crosa@redhat.com>
References: <20191112135801.854-1-wainersm@redhat.com>
 <20191112135801.854-2-wainersm@redhat.com>
 <20191210051717.GG31990@localhost.localdomain>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <5de9a058-fbe1-21e3-c506-2c42ee6bfa4b@redhat.com>
Date: Wed, 11 Dec 2019 12:55:39 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191210051717.GG31990@localhost.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: XEeQFIBJPP-YmepfpfK2nQ-1
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


On 12/10/19 3:17 AM, Cleber Rosa wrote:
> On Tue, Nov 12, 2019 at 08:58:00AM -0500, Wainer dos Santos Moschetta wrote:
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
>> ---
>>   python/qemu/machine.py | 68 ++++++++++++++++++++++++++++--------------
>>   1 file changed, 45 insertions(+), 23 deletions(-)
>>
>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>> index a4631d6934..04ee86e1ba 100644
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
>> -        else:
>> -            moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
>> -        args = ['-chardev', moncdev,
>> -                '-mon', 'chardev=mon,mode=control',
>> -                '-display', 'none', '-vga', 'none']
>> +            else:
>> +                moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
>> +            args.extend(['-chardev', moncdev, '-mon',
>> +                         'chardev=mon,mode=control'])
>>           if self._machine is not None:
>>               args.extend(['-machine', self._machine])
>>           if self._console_set:
>> @@ -255,20 +257,21 @@ class QEMUMachine(object):
>>   
>>       def _pre_launch(self):
>>           self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
>> -        if self._monitor_address is not None:
>> -            self._vm_monitor = self._monitor_address
>> -        else:
>> -            self._vm_monitor = os.path.join(self._sock_dir,
>> -                                            self._name + "-monitor.sock")
>> -            self._remove_files.append(self._vm_monitor)
>>           self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
>>           self._qemu_log_file = open(self._qemu_log_path, 'wb')
>>   
>> -        self._qmp = qmp.QEMUMonitorProtocol(self._vm_monitor,
>> -                                            server=True)
>> +        if self._qmp_set:
>> +            if self._monitor_address is not None:
>> +                self._vm_monitor = self._monitor_address
>> +            else:
>> +                self._vm_monitor = os.path.join(self._sock_dir,
>> +                                                self._name + "-monitor.sock")
>> +                self._remove_files.append(self._vm_monitor)
>> +            self._qmp = qmp.QEMUMonitorProtocol(self._vm_monitor, server=True)
>>   
>>       def _post_launch(self):
>> -        self._qmp.accept()
>> +        if self._qmp:
>> +            self._qmp.accept()
>>   
>>       def _post_shutdown(self):
>>           if self._qemu_log_file is not None:
>> @@ -330,7 +333,8 @@ class QEMUMachine(object):
>>           Wait for the VM to power off
>>           """
>>           self._popen.wait()
>> -        self._qmp.close()
>> +        if self._qmp:
>> +            self._qmp.close()
>>           self._load_io_log()
>>           self._post_shutdown()
>>   
>> @@ -346,12 +350,13 @@ class QEMUMachine(object):
>>               self._console_socket = None
>>   
>>           if self.is_running():
>> -            try:
>> -                if not has_quit:
>> -                    self._qmp.cmd('quit')
>> -                self._qmp.close()
>> -            except:
>> -                self._popen.kill()
>> +            if self._qmp:
>> +                try:
>> +                    if not has_quit:
>> +                        self._qmp.cmd('quit')
>> +                    self._qmp.close()
>> +                except:
>> +                    self._popen.kill()
>>               self._popen.wait()
>>   
>>           self._load_io_log()
>> @@ -368,6 +373,23 @@ class QEMUMachine(object):
>>   
>>           self._launched = False
>>   
>> +    def set_qmp_monitor(self, disabled=False, monitor_address=None):
>> +        """
>> +        Set the QMP monitor.
>> +
>> +        @param disabled: if True, qmp monitor options will be removed from the
>> +                         base arguments of the resulting QEMU command line.
> I personally tend avoid double negatives as long as I'm aware of them.
> Wouldn't "enabled=True" be more straightforward?  Just my personal
> preference though.

I don't have a strong opinion about double negatives. So I'm fine with 
use 'enabled' instead. Besides make you happier. ;)

>
>> +        @param monitor_address: address for the QMP monitor.
> Do you have a use case for passing the monitor address here too, in
> addition to also being available as a parameter to __init__()?  In the
> next patch, I don't see it being used (or here for that matter).

I thought it would be useful in case an acceptance test needs to set the 
monitor address. And because avocado_qemu transparently creates the 
QEMUMachine instance, the test doesn't have access to the constructor. 
But no, I don't have a concrete case. I'm just being overcareful, so I 
don't mind to remove that parameter.

Good catch. Thanks!

- Wainer

>
>> +        @note: call this function before launch().
>> +        """
>> +        if disabled:
>> +            self._qmp_set = False
>> +            self._qmp = None
>> +        else:
>> +            self._qmp_set = True
>> +            if monitor_address:
>> +                self._monitor_address = monitor_address
>> +
>>       def qmp(self, cmd, conv_keys=True, **args):
>>           """
>>           Invoke a QMP command and return the response dict
>> -- 
>> 2.18.1
>>
> Other than those comments, it LGTM.
>
> - Cleber.


