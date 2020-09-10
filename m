Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C30C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB9E206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB9E206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPaO-0000FL-Ms
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kGPZf-00086C-MF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:37:27 -0400
Received: from relay68.bu.edu ([128.197.228.73]:37106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kGPZd-0001KF-E9
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:37:26 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 08AGaqSO026544
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 10 Sep 2020 12:36:56 -0400
Date: Thu, 10 Sep 2020 12:36:52 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] oss-fuzz: move linker arg to fix coverage-build
Message-ID: <20200910163652.xveuge4b5zlywcpe@mozz.bu.edu>
References: <20200909220516.614222-1-alxndr@bu.edu> <m2a6xx4ouu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2a6xx4ouu.fsf@oracle.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 10:49:07
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.768, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, bsd@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200910 1645, Darren Kenny wrote:
> Hi Alex,
> 
> I'm certainly not an expert in meson, but have some questions below...
> 
> On Wednesday, 2020-09-09 at 18:05:16 -04, Alexander Bulekov wrote:
> > The order of the add_project_link_arguments calls impacts which
> > arguments are placed between --start-group and --end-group.
> > OSS-Fuzz coverage builds seem to just add these to CFLAGS:
> > -fprofile-instr-generate -fcoverage-mapping pthread -Wl,--no-as-needed
> > --Wl,-ldl -Wl,-lm Wno-unused-command-line-argument
> >
> > for some reason that is enough to shift the fork_fuzz.ld linker-script
> > back into the linker group. Move the linker-script meson call before the
> > other calls to mitigate this.
> >
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  meson.build | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > Good news! Standard oss-fuzz builds are working again:
> > https://oss-fuzz-build-logs.storage.googleapis.com/log-2fa5122f-c98c-4e46-b3ff-e6835d9ecda6.txt
> >
> > Bad news: Coverage builds are still-broken:
> > https://oss-fuzz-build-logs.storage.googleapis.com/log-dafece55-81f2-4d1d-a686-c5197cdd15c1.txt
> >
> > For some reason, just switching around the order of the
> > add_project_arguments fixes this (i.e. the order of the calls impacts
> > which arguments are placed between --start-group --end-group). I don't
> > really like this because it makes this linker-script block even more
> > visible in meson.build, by placing it directly beneath the "Compiler
> > flags" heading. Paolo, do you have a better suggestion?
> >
> > diff --git a/meson.build b/meson.build
> > index 5421eca66a..2ba1823ca3 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -49,6 +49,14 @@ configure_file(input: files('scripts/ninjatool.py'),
> >  # Compiler flags #
> >  ##################
> >  
> > +# Specify linker-script with add_project_link_arguments so that it is not placed
> > +# within a linker --start-group/--end-group pair
> > +if 'CONFIG_FUZZ' in config_host
> > +   add_project_link_arguments(['-Wl,-T,',
> > +                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
>

Hi Darren,

> Why do you use an array here rather than a string concatenation? Looking
> at the documentation, it suggests that each arg to
> add_project_link_arguments() should be specified separately - and
> doesn't mention anything about an argument being a list and what would
> happen here.
> 
> What I'm wondering is how the array might be handled, as in would it be
> like the Python equivalent of:
> 
>   "".join(['a', b'])   => 'ab'
> 
> or
> 
>   " ".join(['a', b'])   => 'a b'
> 
> It's not honestly clear, or at least I couldn't find anything that says
> clearly what the result would be.
> 
> So, would it be more correct as either:
> 
>   add_project_link_arguments('-Wl,-T,' + (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld'),
> 
> or
> 
>   add_project_link_arguments('-Wl,-T,', (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld'),
> 
> I'm also wondering if this in any way would affect how meson moves the
> linker arguments around later.

Good point. I tried that out, and everything still works.
Functionality-wise, I don't think it makes a big difference (for example
look at the other calls to add_project*arguments, which all pass in
arrays returned by split()), but its probably better to stick with what
is written in the official docs. I ran oss-fuzz builds with this change
and, unfortunately, the order of the calls to add_project_link_arguments
still makes a difference.

> 
> Alternatively, there is a link_args argument to the executable()
> function, which is being used for adding @qemu.syms and @block.syms
> around line 1017.
> 
> Would it work to add this linker-script at this point, in a conditional
> block for CONFIG_FUZZ here instead?
> 

I tried that when I was attempting to fix the original build-issue, but
to no avail... I don't have a good explanation. On one hand, the problem
was related to the fact that we were linking in libqos.a. Renaming it to
libqos.fa was part of the fix. On the other hand, we also needed to
specify the arguments as part of global project link arguments, rather
than the proper way with executable() link_args.

I think Paolo had a better understanding of the actual issue, and some
ideas about how to fix this within meson, rather than with the hacks
exemplified by this patch.

-Alex

> Thanks,
> 
> Darren.
> 
> > +                              native: false, language: ['c', 'cpp', 'objc'])
> > +endif
> > +
> >  add_project_arguments(config_host['QEMU_CFLAGS'].split(),
> >                        native: false, language: ['c', 'objc'])
> >  add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
> > @@ -58,13 +66,6 @@ add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
> >  add_project_arguments(config_host['QEMU_INCLUDES'].split(),
> >                        language: ['c', 'cpp', 'objc'])
> >  
> > -# Specify linker-script with add_project_link_arguments so that it is not placed
> > -# within a linker --start-group/--end-group pair
> > -if 'CONFIG_FUZZ' in config_host
> > -   add_project_link_arguments(['-Wl,-T,',
> > -                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
> > -                              native: false, language: ['c', 'cpp', 'objc'])
> > -endif
> >  
> >  link_language = meson.get_external_property('link_language', 'cpp')
> >  if link_language == 'cpp'
> > -- 
> > 2.28.0
> 

