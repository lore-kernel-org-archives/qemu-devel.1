Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B135C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A45A2067B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSn4RXFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A45A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgvB1-0003nN-Io
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 15:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgvAM-0003F4-76
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:04:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgvAK-0005jS-Fy
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591297475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U0BdiSqMatfVVIrpYJqKnOo7NCiTZVL1/48JtK2h7tM=;
 b=XSn4RXFOdaLjK6/+kFuUCpEC8OqUMqGFVNlQwa6tLdWESbJMZca39YZ4DgWtjt9xYc/8Os
 xdRu+brOTKD354isy9b/T2nKJUkSFiM+Ixv3DW4yBJ2k7+sHF6L6SOGEXzMoSmgKUPnJeQ
 tBFc08QUjloj9OXYodLrXoYzanEsCyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-6gP9eZ4ONZ-yJ6X4HOl4aQ-1; Thu, 04 Jun 2020 15:04:34 -0400
X-MC-Unique: 6gP9eZ4ONZ-yJ6X4HOl4aQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0158101A845
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 19:03:58 +0000 (UTC)
Received: from [10.10.117.188] (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAC7B7B613;
 Thu,  4 Jun 2020 19:03:57 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] python/machine.py: refactor shutdown
To: Kevin Wolf <kwolf@redhat.com>
References: <20200602194844.15258-1-jsnow@redhat.com>
 <20200602194844.15258-2-jsnow@redhat.com>
 <20200604123916.GF4512@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1a02be9a-0a7c-fedb-2139-e79095b201dd@redhat.com>
Date: Thu, 4 Jun 2020 15:03:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200604123916.GF4512@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:58:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, philmd@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/4/20 8:39 AM, Kevin Wolf wrote:
> Am 02.06.2020 um 21:48 hat John Snow geschrieben:
>> This is done primarily to avoid the 'bare except' pattern, which
>> suppresses ALL exceptions and not just ones that we are anticipating to
>> see.
>>
>> Replace this with a pattern that isolates the different kind of shutdown
>> paradigms and a new fallback shutdown handler that gracefully attempts
>> one before the other.
>>
>> Move all of the post-shutdown code into _post_shutdown, and adjust the
>> main shutdown() function to ALWAYS call the post_shutdown logic no
>> matter what kind of error we encountered: An expected one (subprocess
>> wait timeout) or an unexpected one (Everything else).
>>
>> In cases where we encounter an expected error in the graceful shutdown
>> timeout, we will not re-raise an exception above shutdown(). Otherwise,
>> after post_shutdown cleanup, we will.
>>
>> I anticipate that this WILL lead to additional bug reports filed against
>> this module, but that is unfortunately somewhat the point: This code
>> shouldn't be hiding failures that exist elsewhere within the python
>> code.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  python/qemu/machine.py | 93 +++++++++++++++++++++++++++++-------------
>>  1 file changed, 65 insertions(+), 28 deletions(-)
>>
>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>> index 041c615052e..a2abd2c35e3 100644
>> --- a/python/qemu/machine.py
>> +++ b/python/qemu/machine.py
>> @@ -283,6 +283,8 @@ def _post_launch(self):
>>              self._qmp.accept()
>>  
>>      def _post_shutdown(self):
>> +        self._load_io_log()
>> +
>>          if self._qemu_log_file is not None:
>>              self._qemu_log_file.close()
>>              self._qemu_log_file = None
>> @@ -296,6 +298,17 @@ def _post_shutdown(self):
>>          while len(self._remove_files) > 0:
>>              self._remove_if_exists(self._remove_files.pop())
>>  
>> +        exitcode = self.exitcode()
>> +        if exitcode is not None and exitcode < 0:
>> +            msg = 'qemu received signal %i; command: "%s"'
>> +            if self._qemu_full_args:
>> +                command = ' '.join(self._qemu_full_args)
>> +            else:
>> +                command = ''
>> +            LOG.warning(msg, -int(exitcode), command)
>> +
>> +        self._launched = False
> 
> It would have been a little easier to review if this code motion to
> _post_shutdown() were a separate patch. It looks mostly independent of
> the other changes.
> 

That was hasty of me, you're right.

> The big change here is that we now log warnings for exit due to a signal
> for QEMUMachine.wait(), too. I assume this is okay.
> 

My assumption is that it's never wrong to see that QEMU was killed
instead of shut down gracefully.

>>      def launch(self):
>>          """
>>          Launch the VM and make sure we cleanup and expose the
>> @@ -344,12 +357,53 @@ def wait(self):
>>          self._popen.wait()
>>          if self._qmp:
>>              self._qmp.close()
>> -        self._load_io_log()
>>          self._post_shutdown()
>>  
>> -    def shutdown(self, has_quit=False, hard=False):
>> +    def _hard_shutdown(self) -> None:
>>          """
>> -        Terminate the VM and clean up
>> +        Kill the VM if it is running.
>> +        """
>> +        if not self.is_running():
>> +            return
>> +
>> +        self._popen.kill()
>> +        self._popen.wait(timeout=60)
>> +
>> +    def _soft_shutdown(self, has_quit: bool = False, timeout: int = 3) -> None:
>> +        """
>> +        Attempt to shutdown the VM gracefully if it is running.
>> +
>> +        :param has_quit: When True, don't attempt to issue 'quit' QMP command
>> +        :param timeout: Timeout for graceful shutdown. Default 3 seconds.
>> +        """
>> +        if not self.is_running():
>> +            return
>> +
>> +        if self._qmp is not None:
>> +            if not has_quit:
>> +                self._qmp.cmd('quit')
>> +            self._qmp.close()
>> +
>> +        self._popen.wait(timeout=timeout)
>> +
>> +    def _do_shutdown(self, has_quit: bool = False, timeout: int = 3) -> None:
>> +        """
>> +        Attempt to shutdown the VM gracefully; fallback to a hard shutdown.
>> +
>> +        :param has_quit: When True, don't attempt to issue 'quit' QMP command
>> +        :param timeout: Timeout for graceful shutdown. Default 3 seconds.
>> +        """
>> +        try:
>> +            self._soft_shutdown(has_quit, timeout)
>> +        except subprocess.TimeoutExpired:
>> +            self._hard_shutdown()
>> +        except:
>> +            self._hard_shutdown()
>> +            raise
>> +
>> +    def shutdown(self, has_quit: bool = False, hard: bool = False) -> None:
>> +        """
>> +        Terminate the VM (gracefully if possible) and perform cleanup.
>>          """
>>          # If we keep the console socket open, we may deadlock waiting
>>          # for QEMU to exit, while QEMU is waiting for the socket to
>> @@ -358,35 +412,18 @@ def shutdown(self, has_quit=False, hard=False):
>>              self._console_socket.close()
>>              self._console_socket = None
>>  
>> -        if self.is_running():
>> +        try:
>>              if hard:
>> -                self._popen.kill()
>> -            elif self._qmp:
>> -                try:
>> -                    if not has_quit:
>> -                        self._qmp.cmd('quit')
>> -                    self._qmp.close()
>> -                    self._popen.wait(timeout=3)
>> -                except:
>> -                    self._popen.kill()
>> -            self._popen.wait()
>> -
>> -        self._load_io_log()
>> -        self._post_shutdown()
>> -
>> -        exitcode = self.exitcode()
>> -        if exitcode is not None and exitcode < 0 and \
>> -                not (exitcode == -9 and hard):
> 
> The condition in the second line went away without a replacement. This
> means that previously, intentionally killing a VM with hard=True would
> not log a warning (which makes sense to me), but now it does.
> 
> On the other hand, I couldn't find a single user of hard=True or the
> kill() method in the whole tree. So I guess it doesn't matter anyway?
> 

I was thinking that it was never wrong to log a warning when QEMU ends
non-gracefully, but I suppose this is indeed not for exclusive use of
iotests and I should not question a user command to kill QEMU.

I addressed this in the commit message, but now I'm thinking I actually
should reinstate this logic.

>> -            msg = 'qemu received signal %i: %s'
>> -            if self._qemu_full_args:
>> -                command = ' '.join(self._qemu_full_args)
>> +                self._hard_shutdown()
>>              else:
>> -                command = ''
>> -            LOG.warning(msg, -int(exitcode), command)
>> -
>> -        self._launched = False
>> +                self._do_shutdown(has_quit)
>> +        finally:
>> +            self._post_shutdown()
>>  
>>      def kill(self):
>> +        """
>> +        Terminate the VM forcefully and perform cleanup.
>> +        """
>>          self.shutdown(hard=True)
>>  
>>      def set_qmp_monitor(self, enabled=True):
> 
> In the end, while the new behaviour is a bit different in details, it's
> not unreasonable, and if it does cause any problems, we can still change
> it back.
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 

I'll touch this up based on your feedback before taking your RB. Thank
you for the reviews so far! Our python cleaned up a lot faster and more
easily than I had expected.

I know we shouldn't over-focus on making tests beautiful, but I
perceived a real problem with script rot that I wanted to address.

Thanks for all of your help,
--js


