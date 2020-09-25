Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB439C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5139620738
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBKMT6dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5139620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLk1Z-0005bv-33
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLk0j-00058q-Lz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLk0h-0001Pi-44
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:27:25 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601026041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gCMKGuTE6PcZO8/83g5jmu+aGRLEBRLlLisNEjQRXt0=;
 b=UBKMT6dAnC9/+Zx4x9lkhtRbE4pzr/1OlVwKDmeieiZG+Px5yBrtUymmP+ms4AfluWPDsr
 GEGouO+CJNfzjrjpMZb62Hb8geTXizYY4A6agLVaMHabx/+kGZxZL7AxtPrNT37aLX/eKe
 YeOCZCMeFr+TwxxftaKNSpNB7fOHKwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-0ARrmVpgOTaYZLHckhaYJg-1; Fri, 25 Sep 2020 05:27:20 -0400
X-MC-Unique: 0ARrmVpgOTaYZLHckhaYJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 043CF800E23;
 Fri, 25 Sep 2020 09:27:19 +0000 (UTC)
Received: from work-vm (ovpn-114-177.ams2.redhat.com [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDD895D9FC;
 Fri, 25 Sep 2020 09:26:57 +0000 (UTC)
Date: Fri, 25 Sep 2020 10:26:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 04/32] savevm: HMP Command for cprsave
Message-ID: <20200925092655.GF2873@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-5-git-send-email-steven.sistare@oracle.com>
 <20200911165716.GL3310@work-vm>
 <ae5bf659-c25e-8af4-ba14-a5a21476758f@oracle.com>
MIME-Version: 1.0
In-Reply-To: <ae5bf659-c25e-8af4-ba14-a5a21476758f@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
> On 9/11/2020 12:57 PM, Dr. David Alan Gilbert wrote:
> > * Steve Sistare (steven.sistare@oracle.com) wrote:
> >> Enable HMP access to the cprsave QMP command.
> >>
> >> Usage: cprsave <filename> <mode>
> >>
> >> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > I realise that the current mode is currently only 'reboot' - can you
> > please give us a clue as to why you've got a mode argument that's
> > currently only got one mode?
> 
> Patch 14 adds the restart mode.
> I factored the patches by capability to make the review easier, first
> presenting the reboot patches, then the restart patches.

OK, but just add a comment here saying that you'll add another mode
later; otherwise it looks a bit weird.

Dave

> - Steve
> 
> >> ---
> >>  hmp-commands.hx       | 18 ++++++++++++++++++
> >>  include/monitor/hmp.h |  1 +
> >>  monitor/hmp-cmds.c    | 10 ++++++++++
> >>  3 files changed, 29 insertions(+)
> >>
> >> diff --git a/hmp-commands.hx b/hmp-commands.hx
> >> index 60f395c..c8defd9 100644
> >> --- a/hmp-commands.hx
> >> +++ b/hmp-commands.hx
> >> @@ -354,6 +354,24 @@ SRST
> >>  ERST
> >>  
> >>      {
> >> +        .name       = "cprsave",
> >> +        .args_type  = "file:s,mode:s",
> >> +        .params     = "file 'reboot'",
> >> +        .help       = "create a checkpoint of the VM in file",
> >> +        .cmd        = hmp_cprsave,
> >> +    },
> >> +
> >> +SRST
> >> +``cprsave`` *tag*
> >> +  Stop VCPUs, create a checkpoint of the whole virtual machine and save it
> >> +  in *file*.
> >> +  If *mode* is 'reboot', the checkpoint can be cprload'ed after a host kexec
> >> +  reboot.
> >> +  exec() /usr/bin/qemu-exec if it exists, else exec /usr/bin/qemu-system-x86_64,
> >> +  passing all the original command line arguments.  The VCPUs remain paused.
> >> +ERST
> >> +
> >> +    {
> >>          .name       = "delvm",
> >>          .args_type  = "name:s",
> >>          .params     = "tag",
> >> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> >> index c986cfd..af8ee23 100644
> >> --- a/include/monitor/hmp.h
> >> +++ b/include/monitor/hmp.h
> >> @@ -59,6 +59,7 @@ void hmp_balloon(Monitor *mon, const QDict *qdict);
> >>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
> >>  void hmp_savevm(Monitor *mon, const QDict *qdict);
> >>  void hmp_delvm(Monitor *mon, const QDict *qdict);
> >> +void hmp_cprsave(Monitor *mon, const QDict *qdict);
> >>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
> >>  void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
> >>  void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
> >> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> >> index ae4b6a4..59196ed 100644
> >> --- a/monitor/hmp-cmds.c
> >> +++ b/monitor/hmp-cmds.c
> >> @@ -1139,6 +1139,16 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
> >>      qapi_free_AnnounceParameters(params);
> >>  }
> >>  
> >> +void hmp_cprsave(Monitor *mon, const QDict *qdict)
> >> +{
> >> +    Error *err = NULL;
> >> +
> >> +    qmp_cprsave(qdict_get_try_str(qdict, "file"),
> >> +                qdict_get_try_str(qdict, "mode"),
> >> +                &err);
> >> +    hmp_handle_error(mon, err);
> >> +}
> >> +
> >>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
> >>  {
> >>      qmp_migrate_cancel(NULL);
> >> -- 
> >> 1.8.3.1
> >>
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


