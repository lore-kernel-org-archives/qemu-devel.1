Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B62AC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E73235FD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aw+NEmO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E73235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqI5-0007A4-0Q
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLq1Y-0006KW-O6
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLq1X-0001CV-0K
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:52:40 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601049158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qUrDmAgp8Ke12ZhjESYsqsirAxnqCUQ05wga3dHmoAU=;
 b=aw+NEmO2DP0WE3eMvlFTI4jqSj6zRErWmHcmZIf6OR9qsTZxZuu32DhHDkVdw1c193Xf5F
 2EUy6S3AuatPki+3G7hNJ9iyLoMel2WpTzAb2Y+6qp9h769lhyOcMPHF6Cjug63mR4Whum
 K+RyTR6ZYKL/JbsVqEDdZniw6GAGvps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-DZ6pYU5lM96YsXJ-BEUw8Q-1; Fri, 25 Sep 2020 11:52:36 -0400
X-MC-Unique: DZ6pYU5lM96YsXJ-BEUw8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7712E81F02E;
 Fri, 25 Sep 2020 15:52:35 +0000 (UTC)
Received: from work-vm (ovpn-114-177.ams2.redhat.com [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A1E85C1BB;
 Fri, 25 Sep 2020 15:52:18 +0000 (UTC)
Date: Fri, 25 Sep 2020 16:52:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V1 15/32] vl: QEMU_START_FREEZE env var
Message-ID: <20200925155216.GQ2873@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-16-git-send-email-steven.sistare@oracle.com>
 <20200911184927.GU3310@work-vm>
 <104a501f-66dc-bc98-90fb-73599374e4b5@oracle.com>
MIME-Version: 1.0
In-Reply-To: <104a501f-66dc-bc98-90fb-73599374e4b5@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steven Sistare (steven.sistare@oracle.com) wrote:
> On 9/11/2020 2:49 PM, Dr. David Alan Gilbert wrote:
> > * Steve Sistare (steven.sistare@oracle.com) wrote:
> >> For qemu upgrade and restart, we will re-exec() qemu with the same argv.
> >> However, qemu must start in a paused state and wait for the cprload command,
> >> and the original argv might not contain the -S option.  To avoid modifying
> >> argv, provide the QEMU_START_FREEZE environment variable.  If
> >> QEMU_START_FREEZE is set, then set autostart=0, like the -S option.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > What's wrong with modifying the argv?
> > 
> > Note, also the trick -incoming defer uses;  the whole point here is that
> > we start qemu with   -incoming defer     and then we can issue commands
> > to modify the QEMU configuration before we actually reload state.
> > 
> > Note, even without CPR there might be reasons that you need to modify
> > the argv; for example, imagine that since it was originally booted
> > someone had hotplug added an extra CPU or RAM or a disk; the new QEMU
> > must be started in a state that reflects the state in which the VM was
> > at the point when it was saved, not the point at which it was started
> > long ago.
> 
> The code is simpler if we do not need to parse and massage the argv, and that is 
> sufficient for many use cases.  QEMU_START_FREEZE adds only a few lines of code, and 
> it's nice to have that choice.
> 
> For hot plug, we rely on the management layer to know what devices were plugged
> after the initial startup, and re-plug them after restart.  cprsave restarts qemu,
> which creates command-line devices.  At this point the manager would send the hotplug 
> commands (just like -incoming defer), then send cprload. 
> 
> Having said that, if the management layer sometimes performs live migration, and sometimes
> performs cpr restart, then we need to strip out any -incoming args from argv before restart.
> This can be done in the vendor-specific qemu-exec helper (patch 20).

My problem is I can see a whole bunch of places that reusing the
original argv breaks, so I don't think this is a useful general
solution:

   a) The -incoming example
   b) The management app has to reply the hotplug sequence
   c) ...even if it did there's no guarantee that the original
pre-hotplug commandline works:
      i) e.g. an original block device file was deleted
     ii) One of the endpoints for a network device is gone.

  Any part of (c) could cause the exec'd qemu to fail before
it gets as far as allowing you to issue the hotplug commands.
It's also plain dangerous, since the exec'd qemu shouldn't be accessing
a  file or device that has been hot-unplugged and might now be part of
a different VM.

So I think you really should pass another command line option here
rather than setting an environment variable; and then I think you should
consider two separate things:

  a) You could easily strip out options of the form --cpr-freeze
  b) Consider something more general; e.g. allow the management layer to
specify a new set of argv to be used by the exec.

Dave

> - Steve
> 
> >> ---
> >>  softmmu/vl.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/softmmu/vl.c b/softmmu/vl.c
> >> index 951994f..7016e39 100644
> >> --- a/softmmu/vl.c
> >> +++ b/softmmu/vl.c
> >> @@ -4501,6 +4501,11 @@ void qemu_init(int argc, char **argv, char **envp)
> >>          exit(0);
> >>      }
> >>  
> >> +    if (getenv("QEMU_START_FREEZE")) {
> >> +        unsetenv("QEMU_START_FREEZE");
> >> +        autostart = 0;
> >> +    }
> >> +
> >>      if (incoming) {
> >>          Error *local_err = NULL;
> >>          qemu_start_incoming_migration(incoming, &local_err);
> >> -- 
> >> 1.8.3.1
> >>
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


