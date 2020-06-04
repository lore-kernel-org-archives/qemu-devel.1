Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9F6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807102063A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7hERcHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807102063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpBi-0002Ra-O3
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jgp9i-00089O-SG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:39:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51946
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jgp9g-0001iH-Rv
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591274371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7jvOOxTK8bCohiwVvxochZNE0up0QJofGpeLnUE403s=;
 b=O7hERcHHfBj0vszre5ryRXNlK7PxsnLx3LJvEjtcY4vB93q/3ilUaQ2YlkozXYrqcFbyF2
 uCTFvR+bgu5OcXzMimNHDmr0V0l1FFNPRmUrsqob0BCNrglFf3qsNJFJt4EtK8wvmfHMVY
 2Xfw5ybjVSKjc9MWyEmZL3lQvr5eYFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-pQva1r9vMXm8GPijaJh2Lw-1; Thu, 04 Jun 2020 08:39:27 -0400
X-MC-Unique: pQva1r9vMXm8GPijaJh2Lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D57AEC1AA
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 12:39:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AE727BA00;
 Thu,  4 Jun 2020 12:39:17 +0000 (UTC)
Date: Thu, 4 Jun 2020 14:39:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 1/1] python/machine.py: refactor shutdown
Message-ID: <20200604123916.GF4512@linux.fritz.box>
References: <20200602194844.15258-1-jsnow@redhat.com>
 <20200602194844.15258-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200602194844.15258-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
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
Cc: Cleber Rosa <crosa@redhat.com>, philmd@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.06.2020 um 21:48 hat John Snow geschrieben:
> This is done primarily to avoid the 'bare except' pattern, which
> suppresses ALL exceptions and not just ones that we are anticipating to
> see.
> 
> Replace this with a pattern that isolates the different kind of shutdown
> paradigms and a new fallback shutdown handler that gracefully attempts
> one before the other.
> 
> Move all of the post-shutdown code into _post_shutdown, and adjust the
> main shutdown() function to ALWAYS call the post_shutdown logic no
> matter what kind of error we encountered: An expected one (subprocess
> wait timeout) or an unexpected one (Everything else).
> 
> In cases where we encounter an expected error in the graceful shutdown
> timeout, we will not re-raise an exception above shutdown(). Otherwise,
> after post_shutdown cleanup, we will.
> 
> I anticipate that this WILL lead to additional bug reports filed against
> this module, but that is unfortunately somewhat the point: This code
> shouldn't be hiding failures that exist elsewhere within the python
> code.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 93 +++++++++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 28 deletions(-)
> 
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 041c615052e..a2abd2c35e3 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -283,6 +283,8 @@ def _post_launch(self):
>              self._qmp.accept()
>  
>      def _post_shutdown(self):
> +        self._load_io_log()
> +
>          if self._qemu_log_file is not None:
>              self._qemu_log_file.close()
>              self._qemu_log_file = None
> @@ -296,6 +298,17 @@ def _post_shutdown(self):
>          while len(self._remove_files) > 0:
>              self._remove_if_exists(self._remove_files.pop())
>  
> +        exitcode = self.exitcode()
> +        if exitcode is not None and exitcode < 0:
> +            msg = 'qemu received signal %i; command: "%s"'
> +            if self._qemu_full_args:
> +                command = ' '.join(self._qemu_full_args)
> +            else:
> +                command = ''
> +            LOG.warning(msg, -int(exitcode), command)
> +
> +        self._launched = False

It would have been a little easier to review if this code motion to
_post_shutdown() were a separate patch. It looks mostly independent of
the other changes.

The big change here is that we now log warnings for exit due to a signal
for QEMUMachine.wait(), too. I assume this is okay.

>      def launch(self):
>          """
>          Launch the VM and make sure we cleanup and expose the
> @@ -344,12 +357,53 @@ def wait(self):
>          self._popen.wait()
>          if self._qmp:
>              self._qmp.close()
> -        self._load_io_log()
>          self._post_shutdown()
>  
> -    def shutdown(self, has_quit=False, hard=False):
> +    def _hard_shutdown(self) -> None:
>          """
> -        Terminate the VM and clean up
> +        Kill the VM if it is running.
> +        """
> +        if not self.is_running():
> +            return
> +
> +        self._popen.kill()
> +        self._popen.wait(timeout=60)
> +
> +    def _soft_shutdown(self, has_quit: bool = False, timeout: int = 3) -> None:
> +        """
> +        Attempt to shutdown the VM gracefully if it is running.
> +
> +        :param has_quit: When True, don't attempt to issue 'quit' QMP command
> +        :param timeout: Timeout for graceful shutdown. Default 3 seconds.
> +        """
> +        if not self.is_running():
> +            return
> +
> +        if self._qmp is not None:
> +            if not has_quit:
> +                self._qmp.cmd('quit')
> +            self._qmp.close()
> +
> +        self._popen.wait(timeout=timeout)
> +
> +    def _do_shutdown(self, has_quit: bool = False, timeout: int = 3) -> None:
> +        """
> +        Attempt to shutdown the VM gracefully; fallback to a hard shutdown.
> +
> +        :param has_quit: When True, don't attempt to issue 'quit' QMP command
> +        :param timeout: Timeout for graceful shutdown. Default 3 seconds.
> +        """
> +        try:
> +            self._soft_shutdown(has_quit, timeout)
> +        except subprocess.TimeoutExpired:
> +            self._hard_shutdown()
> +        except:
> +            self._hard_shutdown()
> +            raise
> +
> +    def shutdown(self, has_quit: bool = False, hard: bool = False) -> None:
> +        """
> +        Terminate the VM (gracefully if possible) and perform cleanup.
>          """
>          # If we keep the console socket open, we may deadlock waiting
>          # for QEMU to exit, while QEMU is waiting for the socket to
> @@ -358,35 +412,18 @@ def shutdown(self, has_quit=False, hard=False):
>              self._console_socket.close()
>              self._console_socket = None
>  
> -        if self.is_running():
> +        try:
>              if hard:
> -                self._popen.kill()
> -            elif self._qmp:
> -                try:
> -                    if not has_quit:
> -                        self._qmp.cmd('quit')
> -                    self._qmp.close()
> -                    self._popen.wait(timeout=3)
> -                except:
> -                    self._popen.kill()
> -            self._popen.wait()
> -
> -        self._load_io_log()
> -        self._post_shutdown()
> -
> -        exitcode = self.exitcode()
> -        if exitcode is not None and exitcode < 0 and \
> -                not (exitcode == -9 and hard):

The condition in the second line went away without a replacement. This
means that previously, intentionally killing a VM with hard=True would
not log a warning (which makes sense to me), but now it does.

On the other hand, I couldn't find a single user of hard=True or the
kill() method in the whole tree. So I guess it doesn't matter anyway?

> -            msg = 'qemu received signal %i: %s'
> -            if self._qemu_full_args:
> -                command = ' '.join(self._qemu_full_args)
> +                self._hard_shutdown()
>              else:
> -                command = ''
> -            LOG.warning(msg, -int(exitcode), command)
> -
> -        self._launched = False
> +                self._do_shutdown(has_quit)
> +        finally:
> +            self._post_shutdown()
>  
>      def kill(self):
> +        """
> +        Terminate the VM forcefully and perform cleanup.
> +        """
>          self.shutdown(hard=True)
>  
>      def set_qmp_monitor(self, enabled=True):

In the end, while the new behaviour is a bit different in details, it's
not unreasonable, and if it does cause any problems, we can still change
it back.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


