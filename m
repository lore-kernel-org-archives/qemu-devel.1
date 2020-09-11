Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F81C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335E220770
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ga6ZZFc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335E220770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnLx-00080j-Ug
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGnL4-0007Td-VC
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:59:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGnL3-0004lh-Ak
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599847196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iek6tYQQw5s6JKqqRLifBEyJCPDsPA0JJc0ey7d3Q90=;
 b=ga6ZZFc1RfmnfuOoUxBFJvoTj/0Djxl0hTPNXJgrttYahtukJEz9ftZa3WbjsZfBTQH/Ij
 fRubqcIlauIUlEivKh+IOS3mLWZNpRMBMCxKyO8h7U9cMHLT3qOUVEfDiM4EB/337qhNoj
 asJ3XxR8O/XlT1NEXuRNDWJIB5epfhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-k7IWXnoJPTG4YCfvqp8jMw-1; Fri, 11 Sep 2020 13:59:52 -0400
X-MC-Unique: k7IWXnoJPTG4YCfvqp8jMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E3A1393B6;
 Fri, 11 Sep 2020 17:59:51 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4720F60C11;
 Fri, 11 Sep 2020 17:59:37 +0000 (UTC)
Date: Fri, 11 Sep 2020 18:59:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 12/32] vl: pause option
Message-ID: <20200911175934.GR3310@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
 <87r1stdjes.fsf@linaro.org>
 <b18f2181-902b-a091-9711-93d49ab8aec8@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b18f2181-902b-a091-9711-93d49ab8aec8@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> On 7/30/2020 1:03 PM, Alex Bennée wrote:
> > 
> > Steve Sistare <steven.sistare@oracle.com> writes:
> > 
> >> Provide the -pause command-line parameter and the QEMU_PAUSE environment
> >> variable to briefly pause QEMU in main and allow a developer to attach gdb.
> >> Useful when the developer does not invoke QEMU directly, such as when using
> >> libvirt.
> > 
> > How does this differ from -S?
> 
> The -S flag runs qemu to the main loop but does not start the guest.  Lots of code
> that you may need to debug runs before you get there.

You might try the '--preconfig' option - that's pretty early on.
The other one is adding a chardev and telling it to wait for a server;
that'll wait until you telnet to the port.

(Either way, this patch shouldn't really be part of this series, it's a
separate discussion)

Dave

> - Steve
> >> Usage:
> >>   qemu -pause <seconds>
> >>   or
> >>   export QEMU_PAUSE=<seconds>
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  qemu-options.hx |  9 +++++++++
> >>  softmmu/vl.c    | 15 ++++++++++++++-
> >>  2 files changed, 23 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/qemu-options.hx b/qemu-options.hx
> >> index 708583b..8505cf2 100644
> >> --- a/qemu-options.hx
> >> +++ b/qemu-options.hx
> >> @@ -3668,6 +3668,15 @@ SRST
> >>      option is experimental.
> >>  ERST
> >>  
> >> +DEF("pause", HAS_ARG, QEMU_OPTION_pause, \
> >> +    "-pause secs    Pause for secs seconds on entry to main.\n", QEMU_ARCH_ALL)
> >> +
> >> +SRST
> >> +``--pause secs``
> >> +    Pause for a number of seconds on entry to main.  Useful for attaching
> >> +    a debugger after QEMU has been launched by some other entity.
> >> +ERST
> >> +
> > 
> > It seems like having an option to race with the debugger is just asking
> > for trouble.
> > 
> >>  DEF("S", 0, QEMU_OPTION_S, \
> >>      "-S              freeze CPU at startup (use 'c' to start execution)\n",
> >>      QEMU_ARCH_ALL)
> >> diff --git a/softmmu/vl.c b/softmmu/vl.c
> >> index 8478778..951994f 100644
> >> --- a/softmmu/vl.c
> >> +++ b/softmmu/vl.c
> >> @@ -2844,7 +2844,7 @@ static void create_default_memdev(MachineState *ms, const char *path)
> >>  
> >>  void qemu_init(int argc, char **argv, char **envp)
> >>  {
> >> -    int i;
> >> +    int i, seconds;
> >>      int snapshot, linux_boot;
> >>      const char *initrd_filename;
> >>      const char *kernel_filename, *kernel_cmdline;
> >> @@ -2882,6 +2882,13 @@ void qemu_init(int argc, char **argv, char **envp)
> >>      QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
> >>      int mem_prealloc = 0; /* force preallocation of physical target memory */
> >>  
> >> +    if (getenv("QEMU_PAUSE")) {
> >> +        seconds = atoi(getenv("QEMU_PAUSE"));
> >> +        printf("Pausing %d seconds for debugger. QEMU PID is %d\n",
> >> +               seconds, getpid());
> >> +        sleep(seconds);
> >> +    }
> >> +
> >>      os_set_line_buffering();
> >>  
> >>      error_init(argv[0]);
> >> @@ -3204,6 +3211,12 @@ void qemu_init(int argc, char **argv, char **envp)
> >>              case QEMU_OPTION_gdb:
> >>                  add_device_config(DEV_GDB, optarg);
> >>                  break;
> >> +            case QEMU_OPTION_pause:
> >> +                seconds = atoi(optarg);
> >> +                printf("Pausing %d seconds for debugger. QEMU PID is %d\n",
> >> +                            seconds, getpid());
> >> +                sleep(seconds);
> >> +                break;
> >>              case QEMU_OPTION_L:
> >>                  if (is_help_option(optarg)) {
> >>                      list_data_dirs = true;
> > 
> > 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


