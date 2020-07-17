Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A7FC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B22206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B22206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwTo7-0000kj-Is
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 13:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwTnL-0000DB-JW
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:05:11 -0400
Received: from relay68.bu.edu ([128.197.228.73]:56819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwTnI-0002jb-JA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:05:10 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 06HH4nid025144
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 17 Jul 2020 13:04:53 -0400
Date: Fri, 17 Jul 2020 13:04:49 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] fuzz: Fix leak when assembling datadir path string
Message-ID: <20200717170444.oljxfcl74mu35wer@mozz.bu.edu>
References: <20200717163523.1591-1-alxndr@bu.edu>
 <1d2f13f1-d467-0616-8ea4-9254e1c4b855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2f13f1-d467-0616-8ea4-9254e1c4b855@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 13:05:07
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200717 1847, Thomas Huth wrote:
> On 17/07/2020 18.35, Alexander Bulekov wrote:
> > We freed the string containing the final datadir path, but did not free
> > the path to the executable's directory that we get from
> > g_path_get_dirname(). Fix that.
> > 
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> > 
> > I ran it with Thomas' fixed build-oss-fuzz job:
> > https://gitlab.com/a1xndr/qemu/-/jobs/644463736
> 
> Looks like the fuzzer triggered a crash there, see line 5850 ...
> shouldn't the job fail in that case? ... i.e. is the fuzzer still
> exiting with return code 0?

Ah. We run each input in a forked process. If the child crashes, the
parent can continue forking+fuzzing, as if nothing happened. This also
unfortunately means that the job might succeed even if there is a crash
in the actual fuzz target code, as long as the error only happens in the
child processes. Maybe we could add an env variable to have the parent
exit -1 if the child crashes, but then the job would fail even for
non-fuzzer issues (such as this virtio-net crash).

-Alex

> 
> > diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> > index 6bc17ef313..031594a686 100644
> > --- a/tests/qtest/fuzz/fuzz.c
> > +++ b/tests/qtest/fuzz/fuzz.c
> > @@ -143,7 +143,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
> >  {
> >  
> >      char *target_name;
> > -    char *dir;
> > +    char *bindir, *datadir;
> >      bool serialize = false;
> >  
> >      /* Initialize qgraph and modules */
> > @@ -164,11 +164,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
> >           * location of the executable. Using this we add exec_dir/pc-bios to
> >           * the datadirs.
> >           */
> > -        dir = g_build_filename(g_path_get_dirname(**argv), "pc-bios", NULL);
> > -        if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> > -            qemu_add_data_dir(dir);
> > +        bindir = g_path_get_dirname(**argv);
> > +        datadir = g_build_filename(bindir, "pc-bios", NULL);
> > +        g_free(bindir);
> > +        if (g_file_test(datadir, G_FILE_TEST_IS_DIR)) {
> > +            qemu_add_data_dir(datadir);
> >          }
> > -        g_free(dir);
> > +        g_free(datadir);
> >      } else if (*argc > 1) {  /* The target is specified as an argument */
> >          target_name = (*argv)[1];
> >          if (!strstr(target_name, "--fuzz-target=")) {
> > 
> 
> Patch looks fine, thanks!
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

