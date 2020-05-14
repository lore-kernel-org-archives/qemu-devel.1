Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52C1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF16206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MN/YHZUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF16206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZGJ4-0006qU-GJ
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 12:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZGHF-0004eN-0n
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:00:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZGHD-0000tm-IH
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589472002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tdqPuzOMIV3lv0o4WuAQ1ck34/Tc7usfLK5nja0NhAk=;
 b=MN/YHZUUFFgCONmPXquCFj+Ys+s3oRrNHJANHyaiGWGgUs49+5bB1OgzNkee+nmTohM9uT
 uwcVlo+YAE2hczFYJAQ8wRdRJhTyCDg5xwUaOFQE3Cw7MxKwzRPRO8JaoZTQHXJwMmQ4fN
 VhHEDXumo93B/YQ+8TG6Rke1QOz9P/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-sFKg1nBLNOKjFg6HBfBmuA-1; Thu, 14 May 2020 11:59:58 -0400
X-MC-Unique: sFKg1nBLNOKjFg6HBfBmuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C846681CBE3;
 Thu, 14 May 2020 15:59:57 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C146C5C662;
 Thu, 14 May 2020 15:59:53 +0000 (UTC)
Date: Thu, 14 May 2020 17:59:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 1/3] qmp.py: change event_wait to use a dict
Message-ID: <20200514155952.GM5518@linux.fritz.box>
References: <20200514022536.2568-1-jsnow@redhat.com>
 <20200514022536.2568-2-jsnow@redhat.com>
 <20200514144732.GJ5518@linux.fritz.box>
 <de1026e4-9815-f89c-4cfd-6da35ac23197@redhat.com>
MIME-Version: 1.0
In-Reply-To: <de1026e4-9815-f89c-4cfd-6da35ac23197@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:41:05
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 17:07 hat John Snow geschrieben:
> 
> 
> On 5/14/20 10:47 AM, Kevin Wolf wrote:
> > Am 14.05.2020 um 04:25 hat John Snow geschrieben:
> >> It's easier to work with than a list of tuples, because we can check the
> >> keys for membership.
> >>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  python/qemu/machine.py        | 10 +++++-----
> >>  tests/qemu-iotests/040        | 12 ++++++------
> >>  tests/qemu-iotests/260        |  5 +++--
> >>  tests/qemu-iotests/iotests.py | 16 ++++++++--------
> >>  4 files changed, 22 insertions(+), 21 deletions(-)
> > 
> > I think you need to convert scripts/simplebench/bench_block_job.py, too.
> 
> Oh, right -- that one is new since I did this. A lot of these scripts
> need to be moved over into the python/ directory and managed under the
> same pylint/mypy regime as everything else.
> 
> A *ton* of our scripts are in various states of disrepair.

Is python/ actually supposed to have executable files in it? I thought
it was more for libraries.

> > 
> >> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> >> index b9a98e2c86..eaedc25172 100644
> >> --- a/python/qemu/machine.py
> >> +++ b/python/qemu/machine.py
> >> @@ -478,21 +478,21 @@ def event_wait(self, name, timeout=60.0, match=None):
> >>          timeout: QEMUMonitorProtocol.pull_event timeout parameter.
> >>          match: Optional match criteria. See event_match for details.
> >>          """
> >> -        return self.events_wait([(name, match)], timeout)
> >> +        return self.events_wait({name: match}, timeout)
> >>  
> >>      def events_wait(self, events, timeout=60.0):
> >>          """
> >>          events_wait waits for and returns a named event from QMP with a timeout.
> >>  
> >> -        events: a sequence of (name, match_criteria) tuples.
> >> +        events: a mapping containing {name: match_criteria}.
> >>                  The match criteria are optional and may be None.
> >>                  See event_match for details.  timeout:
> >>                  QEMUMonitorProtocol.pull_event timeout parameter.
> >>                  """
> >>          def _match(event):
> >> -            for name, match in events:
> >> -                if event['event'] == name and self.event_match(event, match):
> >> -                    return True
> >> +            name = event['event']
> >> +            if name in events:
> >> +                return self.event_match(event, events[name])
> > 
> > This part confused me a bit for a second. Of course, that's probably
> > mostly just me, but I feel 'events' isn't a good name any more when the
> > values of the dict are match strings rather than events.
> > 
> 
> This is honestly a really bad function. When I was trying to type
> everything, this one was at the bottom of the pile and it was the worst.
> 
> It needs an overhaul.
> 
> In my 32 patch series, I left the "match" types as "Any" pretty much
> everywhere, because it's such a laissez-faire series of functions.

It would require recursive types, which aren't supported yet. So I guess
Any is the best we can do at the moment.

> I'll keep the feedback in mind.
> 
> >>              return False
> >>  
> >>          # Search cached events
> >> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> >> index 32c82b4ec6..90b59081ff 100755
> >> --- a/tests/qemu-iotests/040
> >> +++ b/tests/qemu-iotests/040
> >> @@ -485,12 +485,12 @@ class TestErrorHandling(iotests.QMPTestCase):
> >>  
> >>      def run_job(self, expected_events, error_pauses_job=False):
> >>          match_device = {'data': {'device': 'job0'}}
> >> -        events = [
> >> -            ('BLOCK_JOB_COMPLETED', match_device),
> >> -            ('BLOCK_JOB_CANCELLED', match_device),
> >> -            ('BLOCK_JOB_ERROR', match_device),
> >> -            ('BLOCK_JOB_READY', match_device),
> >> -        ]
> >> +        events = {
> >> +            'BLOCK_JOB_COMPLETED': match_device,
> >> +            'BLOCK_JOB_CANCELLED': match_device,
> >> +            'BLOCK_JOB_ERROR': match_device,
> >> +            'BLOCK_JOB_READY': match_device,
> >> +        }
> >>  
> >>          completed = False
> >>          log = []
> >> diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
> >> index 804a7addb9..729f031122 100755
> >> --- a/tests/qemu-iotests/260
> >> +++ b/tests/qemu-iotests/260
> >> @@ -67,8 +67,9 @@ def test(persistent, restart):
> >>  
> >>      vm.qmp_log('block-commit', device='drive0', top=top,
> >>                 filters=[iotests.filter_qmp_testfiles])
> >> -    ev = vm.events_wait((('BLOCK_JOB_READY', None),
> >> -                         ('BLOCK_JOB_COMPLETED', None)))
> >> +    ev = vm.events_wait({
> >> +        'BLOCK_JOB_READY': None,
> >> +        'BLOCK_JOB_COMPLETED': None })
> > 
> > So, I'm not sure if this is nitpicking or rather bikeshedding, but
> > having the closing brackets on the next line would be more consistent
> > with the other instances in this patch.
> > 
> 
> Nah, it's fine. I'll clean it up. This is pretty close to an RFC series
> anyway, so I didn't really polish it.
> 
> (Or, I will try to clean it up. I probably won't work on it again in the
> near term. I think I just wanted to see if this seemed useful in general
> to people.

Ah, there isn't much missing for this series, though. We don't have to
wait for a fix-the-world series when we can incrementally improve
things.

> As part of maybe moving the python library onto a package, I thought
> that maybe developing a JobRunner tool would be useful to have in that
> library. As you can see, I nestled it into iotests.py, though.)

Let's just do that now, we can always move it somewhere else later.

Kevin


