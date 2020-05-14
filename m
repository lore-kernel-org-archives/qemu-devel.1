Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994B8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67913206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0BELmHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67913206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFS6-0005D0-Ib
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZF9I-0000D0-5b
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:47:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZF9D-0003Xy-SN
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589467660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQfClqm0smAUWZ337Wx2mF2VirSOze6414ZxiW+dNP0=;
 b=Z0BELmHVmn/elsHAw5iYVPvFs3y12CTKckPVU1SBjNj28vPMsMHC+70490V52vU8RMgbOv
 BvBLM2pk6S8wl0aDHSqQhhwXJpWjNCGzbR7ESTeWvyMNX2HUUuAVrcfilnkHIPM2XNARgx
 IHVHGyshF5jlLWS9cX1L3gAoxdH/LVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-T6tdF1OzMSG-0Y4mOh3uVw-1; Thu, 14 May 2020 10:47:38 -0400
X-MC-Unique: T6tdF1OzMSG-0Y4mOh3uVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A5911009440;
 Thu, 14 May 2020 14:47:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 363301001B07;
 Thu, 14 May 2020 14:47:34 +0000 (UTC)
Date: Thu, 14 May 2020 16:47:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 1/3] qmp.py: change event_wait to use a dict
Message-ID: <20200514144732.GJ5518@linux.fritz.box>
References: <20200514022536.2568-1-jsnow@redhat.com>
 <20200514022536.2568-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200514022536.2568-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 04:25 hat John Snow geschrieben:
> It's easier to work with than a list of tuples, because we can check the
> keys for membership.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py        | 10 +++++-----
>  tests/qemu-iotests/040        | 12 ++++++------
>  tests/qemu-iotests/260        |  5 +++--
>  tests/qemu-iotests/iotests.py | 16 ++++++++--------
>  4 files changed, 22 insertions(+), 21 deletions(-)

I think you need to convert scripts/simplebench/bench_block_job.py, too.

> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index b9a98e2c86..eaedc25172 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -478,21 +478,21 @@ def event_wait(self, name, timeout=60.0, match=None):
>          timeout: QEMUMonitorProtocol.pull_event timeout parameter.
>          match: Optional match criteria. See event_match for details.
>          """
> -        return self.events_wait([(name, match)], timeout)
> +        return self.events_wait({name: match}, timeout)
>  
>      def events_wait(self, events, timeout=60.0):
>          """
>          events_wait waits for and returns a named event from QMP with a timeout.
>  
> -        events: a sequence of (name, match_criteria) tuples.
> +        events: a mapping containing {name: match_criteria}.
>                  The match criteria are optional and may be None.
>                  See event_match for details.  timeout:
>                  QEMUMonitorProtocol.pull_event timeout parameter.
>                  """
>          def _match(event):
> -            for name, match in events:
> -                if event['event'] == name and self.event_match(event, match):
> -                    return True
> +            name = event['event']
> +            if name in events:
> +                return self.event_match(event, events[name])

This part confused me a bit for a second. Of course, that's probably
mostly just me, but I feel 'events' isn't a good name any more when the
values of the dict are match strings rather than events.

>              return False
>  
>          # Search cached events
> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index 32c82b4ec6..90b59081ff 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -485,12 +485,12 @@ class TestErrorHandling(iotests.QMPTestCase):
>  
>      def run_job(self, expected_events, error_pauses_job=False):
>          match_device = {'data': {'device': 'job0'}}
> -        events = [
> -            ('BLOCK_JOB_COMPLETED', match_device),
> -            ('BLOCK_JOB_CANCELLED', match_device),
> -            ('BLOCK_JOB_ERROR', match_device),
> -            ('BLOCK_JOB_READY', match_device),
> -        ]
> +        events = {
> +            'BLOCK_JOB_COMPLETED': match_device,
> +            'BLOCK_JOB_CANCELLED': match_device,
> +            'BLOCK_JOB_ERROR': match_device,
> +            'BLOCK_JOB_READY': match_device,
> +        }
>  
>          completed = False
>          log = []
> diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
> index 804a7addb9..729f031122 100755
> --- a/tests/qemu-iotests/260
> +++ b/tests/qemu-iotests/260
> @@ -67,8 +67,9 @@ def test(persistent, restart):
>  
>      vm.qmp_log('block-commit', device='drive0', top=top,
>                 filters=[iotests.filter_qmp_testfiles])
> -    ev = vm.events_wait((('BLOCK_JOB_READY', None),
> -                         ('BLOCK_JOB_COMPLETED', None)))
> +    ev = vm.events_wait({
> +        'BLOCK_JOB_READY': None,
> +        'BLOCK_JOB_COMPLETED': None })

So, I'm not sure if this is nitpicking or rather bikeshedding, but
having the closing brackets on the next line would be more consistent
with the other instances in this patch.

>      log(filter_qmp_event(ev))
>      if (ev['event'] == 'BLOCK_JOB_COMPLETED'):
>          vm.shutdown()

Kevin


