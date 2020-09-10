Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87630C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB1A2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+UcpnvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB1A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOnV-0001YF-9p
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kGOls-0000BY-7h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:46:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kGOlo-0002wJ-80
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:45:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AFi2mC170565;
 Thu, 10 Sep 2020 15:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Lt7kstWgBm+pxKlSKx+vKoa7fUNFw1W/H4hLQSjJULU=;
 b=O+UcpnvJiP+IY7f+rjNuvZVh4ePXtZdtitDZnnN7ky4pBKUqIqicb8ZB0P7U9d+J+MQJ
 E/7sX57WKQHoJIMMbxSsInglAZh8JoKP+PobB2NmDBcT1kWqxz6yqg5r+ysoSHz/dDRv
 khKcUaZzKLwfpPrQZcr1uLcA1y5B0vemGcKMpgA3qB8etFhsZq9/qpatLGMpN3DWfmJz
 MRKYcXbZ5qhS1aPKVJpMRLipIAyG2e0XH6ziD65bNsCjGuhXbDoEgZQ/C4raLERXcbb6
 nq63AW+3TQ+KjskH9VxH5DxVSDZBCh4T/kLi7whYfyNeap1d9I3o8RWkq/GJEke+MErM oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 33c3an8vpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Sep 2020 15:45:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AFjX0X194089;
 Thu, 10 Sep 2020 15:45:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 33cmev65pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 15:45:50 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08AFjl4j032346;
 Thu, 10 Sep 2020 15:45:48 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 10 Sep 2020 08:45:47 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id A36AF1463194; Thu, 10 Sep 2020 16:45:45 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH] oss-fuzz: move linker arg to fix coverage-build
In-Reply-To: <20200909220516.614222-1-alxndr@bu.edu>
References: <20200909220516.614222-1-alxndr@bu.edu>
Date: Thu, 10 Sep 2020 16:45:45 +0100
Message-ID: <m2a6xx4ouu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100145
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 11:33:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, bsd@redhat.com, stefanha@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

I'm certainly not an expert in meson, but have some questions below...

On Wednesday, 2020-09-09 at 18:05:16 -04, Alexander Bulekov wrote:
> The order of the add_project_link_arguments calls impacts which
> arguments are placed between --start-group and --end-group.
> OSS-Fuzz coverage builds seem to just add these to CFLAGS:
> -fprofile-instr-generate -fcoverage-mapping pthread -Wl,--no-as-needed
> --Wl,-ldl -Wl,-lm Wno-unused-command-line-argument
>
> for some reason that is enough to shift the fork_fuzz.ld linker-script
> back into the linker group. Move the linker-script meson call before the
> other calls to mitigate this.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  meson.build | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> Good news! Standard oss-fuzz builds are working again:
> https://oss-fuzz-build-logs.storage.googleapis.com/log-2fa5122f-c98c-4e46-b3ff-e6835d9ecda6.txt
>
> Bad news: Coverage builds are still-broken:
> https://oss-fuzz-build-logs.storage.googleapis.com/log-dafece55-81f2-4d1d-a686-c5197cdd15c1.txt
>
> For some reason, just switching around the order of the
> add_project_arguments fixes this (i.e. the order of the calls impacts
> which arguments are placed between --start-group --end-group). I don't
> really like this because it makes this linker-script block even more
> visible in meson.build, by placing it directly beneath the "Compiler
> flags" heading. Paolo, do you have a better suggestion?
>
> diff --git a/meson.build b/meson.build
> index 5421eca66a..2ba1823ca3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -49,6 +49,14 @@ configure_file(input: files('scripts/ninjatool.py'),
>  # Compiler flags #
>  ##################
>  
> +# Specify linker-script with add_project_link_arguments so that it is not placed
> +# within a linker --start-group/--end-group pair
> +if 'CONFIG_FUZZ' in config_host
> +   add_project_link_arguments(['-Wl,-T,',
> +                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],

Why do you use an array here rather than a string concatenation? Looking
at the documentation, it suggests that each arg to
add_project_link_arguments() should be specified separately - and
doesn't mention anything about an argument being a list and what would
happen here.

What I'm wondering is how the array might be handled, as in would it be
like the Python equivalent of:

  "".join(['a', b'])   => 'ab'

or

  " ".join(['a', b'])   => 'a b'

It's not honestly clear, or at least I couldn't find anything that says
clearly what the result would be.

So, would it be more correct as either:

  add_project_link_arguments('-Wl,-T,' + (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld'),

or

  add_project_link_arguments('-Wl,-T,', (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld'),

I'm also wondering if this in any way would affect how meson moves the
linker arguments around later.

Alternatively, there is a link_args argument to the executable()
function, which is being used for adding @qemu.syms and @block.syms
around line 1017.

Would it work to add this linker-script at this point, in a conditional
block for CONFIG_FUZZ here instead?

Thanks,

Darren.

> +                              native: false, language: ['c', 'cpp', 'objc'])
> +endif
> +
>  add_project_arguments(config_host['QEMU_CFLAGS'].split(),
>                        native: false, language: ['c', 'objc'])
>  add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
> @@ -58,13 +66,6 @@ add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
>  add_project_arguments(config_host['QEMU_INCLUDES'].split(),
>                        language: ['c', 'cpp', 'objc'])
>  
> -# Specify linker-script with add_project_link_arguments so that it is not placed
> -# within a linker --start-group/--end-group pair
> -if 'CONFIG_FUZZ' in config_host
> -   add_project_link_arguments(['-Wl,-T,',
> -                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
> -                              native: false, language: ['c', 'cpp', 'objc'])
> -endif
>  
>  link_language = meson.get_external_property('link_language', 'cpp')
>  if link_language == 'cpp'
> -- 
> 2.28.0

