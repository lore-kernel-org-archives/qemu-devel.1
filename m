Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A2DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71562075A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tsr76kv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71562075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPcm-0002pA-QL
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kGPc4-0002MV-0U
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:39:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kGPc1-000230-DP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:39:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AGdSSG074622;
 Thu, 10 Sep 2020 16:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Qz1QQcX/lBU9Vt/A3vo31FRa5/kLoZxLWaxetGC/uTM=;
 b=Tsr76kv2EvG6Nl+VsSOKeB/dwsbXVp4fWjRd4dNzD4HSc9clb6SLTIa3ZtOshu4/YxVw
 oiPALZeFzxvREjaLzWwsRjQHpRVwPFNYAg+OfrG3yi6lcz83GinVvaj4wzKOI+7czko+
 0HZcY2AJteaMFzDmuU8x5E+OVRNtGMj4nEb4mBMyhSsZ8RaY0syhwX6UOctwami0fRbv
 +hzk5qxjUtxOW8FjdGiZeupGDSEYFBDXnt+4iKoQr2nD2fSlrk6Lx72/IvWpfCGYvwXZ
 EVqQu9k7/E2PSib+nYmtBbQKkFEFDKwK76WLw2yP+Q2EsZZsiw8u10ciWOb2z96nX+J7 UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 33c23r9c7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Sep 2020 16:39:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AGZXNL175145;
 Thu, 10 Sep 2020 16:39:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 33cmev8hhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 16:39:50 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08AGdnlq032607;
 Thu, 10 Sep 2020 16:39:49 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 10 Sep 2020 09:39:49 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 23A9C1464ED6; Thu, 10 Sep 2020 17:39:46 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH] oss-fuzz: move linker arg to fix coverage-build
In-Reply-To: <20200910163652.xveuge4b5zlywcpe@mozz.bu.edu>
References: <20200909220516.614222-1-alxndr@bu.edu>
 <m2a6xx4ouu.fsf@oracle.com> <20200910163652.xveuge4b5zlywcpe@mozz.bu.edu>
Date: Thu, 10 Sep 2020 17:39:45 +0100
Message-ID: <m2ft7p4mcu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100154
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 12:39:52
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
Cc: pbonzini@redhat.com, bsd@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-09-10 at 12:36:52 -04, Alexander Bulekov wrote:
> On 200910 1645, Darren Kenny wrote:
>> Hi Alex,
>> 
>> I'm certainly not an expert in meson, but have some questions below...
>> 
>> On Wednesday, 2020-09-09 at 18:05:16 -04, Alexander Bulekov wrote:
>> > The order of the add_project_link_arguments calls impacts which
>> > arguments are placed between --start-group and --end-group.
>> > OSS-Fuzz coverage builds seem to just add these to CFLAGS:
>> > -fprofile-instr-generate -fcoverage-mapping pthread -Wl,--no-as-needed
>> > --Wl,-ldl -Wl,-lm Wno-unused-command-line-argument
>> >
>> > for some reason that is enough to shift the fork_fuzz.ld linker-script
>> > back into the linker group. Move the linker-script meson call before the
>> > other calls to mitigate this.
>> >
>> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> > ---
>> >  meson.build | 15 ++++++++-------
>> >  1 file changed, 8 insertions(+), 7 deletions(-)
>> >
>> > Good news! Standard oss-fuzz builds are working again:
>> > https://oss-fuzz-build-logs.storage.googleapis.com/log-2fa5122f-c98c-4e46-b3ff-e6835d9ecda6.txt
>> >
>> > Bad news: Coverage builds are still-broken:
>> > https://oss-fuzz-build-logs.storage.googleapis.com/log-dafece55-81f2-4d1d-a686-c5197cdd15c1.txt
>> >
>> > For some reason, just switching around the order of the
>> > add_project_arguments fixes this (i.e. the order of the calls impacts
>> > which arguments are placed between --start-group --end-group). I don't
>> > really like this because it makes this linker-script block even more
>> > visible in meson.build, by placing it directly beneath the "Compiler
>> > flags" heading. Paolo, do you have a better suggestion?
>> >
>> > diff --git a/meson.build b/meson.build
>> > index 5421eca66a..2ba1823ca3 100644
>> > --- a/meson.build
>> > +++ b/meson.build
>> > @@ -49,6 +49,14 @@ configure_file(input: files('scripts/ninjatool.py'),
>> >  # Compiler flags #
>> >  ##################
>> >  
>> > +# Specify linker-script with add_project_link_arguments so that it is not placed
>> > +# within a linker --start-group/--end-group pair
>> > +if 'CONFIG_FUZZ' in config_host
>> > +   add_project_link_arguments(['-Wl,-T,',
>> > +                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
>>
>
> Hi Darren,
>
>> Why do you use an array here rather than a string concatenation? Looking
>> at the documentation, it suggests that each arg to
>> add_project_link_arguments() should be specified separately - and
>> doesn't mention anything about an argument being a list and what would
>> happen here.
>> 
>> What I'm wondering is how the array might be handled, as in would it be
>> like the Python equivalent of:
>> 
>>   "".join(['a', b'])   => 'ab'
>> 
>> or
>> 
>>   " ".join(['a', b'])   => 'a b'
>> 
>> It's not honestly clear, or at least I couldn't find anything that says
>> clearly what the result would be.
>> 
>> So, would it be more correct as either:
>> 
>>   add_project_link_arguments('-Wl,-T,' + (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld'),
>> 
>> or
>> 
>>   add_project_link_arguments('-Wl,-T,', (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld'),
>> 
>> I'm also wondering if this in any way would affect how meson moves the
>> linker arguments around later.
>
> Good point. I tried that out, and everything still works.
> Functionality-wise, I don't think it makes a big difference (for example
> look at the other calls to add_project*arguments, which all pass in
> arrays returned by split()), but its probably better to stick with what
> is written in the official docs. I ran oss-fuzz builds with this change
> and, unfortunately, the order of the calls to add_project_link_arguments
> still makes a difference.
>
>> 
>> Alternatively, there is a link_args argument to the executable()
>> function, which is being used for adding @qemu.syms and @block.syms
>> around line 1017.
>> 
>> Would it work to add this linker-script at this point, in a conditional
>> block for CONFIG_FUZZ here instead?
>> 
>
> I tried that when I was attempting to fix the original build-issue, but
> to no avail... I don't have a good explanation. On one hand, the problem
> was related to the fact that we were linking in libqos.a. Renaming it to
> libqos.fa was part of the fix. On the other hand, we also needed to
> specify the arguments as part of global project link arguments, rather
> than the proper way with executable() link_args.
>
> I think Paolo had a better understanding of the actual issue, and some
> ideas about how to fix this within meson, rather than with the hacks
> exemplified by this patch.

Fair enough, guess we'll see if Paolo has any better suggestions then :)

Thanks,

Darren.


