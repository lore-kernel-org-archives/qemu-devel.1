Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ACBC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF70A214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQIQ+YP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF70A214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS21V-0003rj-0t
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iS1zm-0003Gq-1e
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iS1zg-0001tP-4J
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:47:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iS1zf-0001sb-P3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:47:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5GixPh096170;
 Tue, 5 Nov 2019 16:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to : content-transfer-encoding; s=corp-2019-08-05;
 bh=SaOb1cjdeINtih8ZD70en0plrJRSLnQp+alrflXrcqw=;
 b=LQIQ+YP5fXhPZcX/RmrGeBep57Iuzgf3G2IqngBOMnPKuVyijo1uv5ZVhxn9eWUd1fR/
 2RJoK7705oRmc6yNztc9c2parPaOSz1ZCVRwRlqUvO03wpElAImwhOROGrPYaV59HyJm
 4MbCfuR38yjVlDHhwXAk9BCXfXEkFDf1NTSR/Lan4o9U8yJ3iVDtfZ9Y8VCVthqJ3uji
 qg1bK5Av1mZEuUFrNVk9XmmH/PnlonjEmbT5mQh/yosbeCaT6DWCzqSKRDYAptpGR0S6
 0dP900ZAB3e8SnCETWVsukCcEmXeCfvshCxOs6PgRcHv0o0It3iU0IBSqTkS3LfiJ8Ne nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2w12er7qe3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Nov 2019 16:47:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5GiDtc105181;
 Tue, 5 Nov 2019 16:47:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2w35pp7ma3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Nov 2019 16:47:44 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA5GlhVc028161;
 Tue, 5 Nov 2019 16:47:44 GMT
Received: from starbug-mbp.localdomain (/10.175.184.49)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 05 Nov 2019 08:47:43 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with ESMTP id 3579B4AA6815;
 Tue,  5 Nov 2019 16:47:40 +0000 (GMT)
Date: Tue, 5 Nov 2019 16:47:39 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Oleinik <alxndr@bu.edu>
Subject: Re: [PATCH v4 00/20] Add virtual device fuzzing support
Message-ID: <20191105164739.np6lmlnfqyrnqfnv@starbug-mbp>
Mail-Followup-To: Alexander Oleinik <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191105135711.lld344zgbin2tz72@starbug-mbp>
 <6b127ec9-e9aa-ac27-5db9-bb731ae0eec0@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <6b127ec9-e9aa-ac27-5db9-bb731ae0eec0@bu.edu>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050138
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 11:28:59AM -0500, Alexander Oleinik wrote:
>On 11/5/19 8:57 AM, Darren Kenny wrote:
>>Hi Alexander,
>>
>>I've been trying out these patches, and I'm seeing a high volume of
>>crashes - where for v3, there were none in a run of over 3 weeks -
>>so it was a bit of a surprise :)
>>
>>The question is what may have changed that is causing that level of
>>crashes - are you seeing this for the virtio-net-fork-fuzz tests?
>Good question - my guess is that it may have to do with the change in=20
>how we run the main loop. I have not looked into it in much detail,=20
>but the crash below is likely triggered only after running the=20
>main_loop several times (the events handled in the first loop,=20
>schedule additional BHs). In v3, I believe the main_loop only ran once=20
>before the forked process exited. There are also changes to the=20
>linker-script used to facilitate communication between the forked=20
>process and the parent, but I think that would only impact the=20
>coverage information passed back to the parent.

OK, sounds like this is a genuine issue then - great :)

>>But also, I've been trying to debug some of these crashes - and the
>>expectation is that you pass the crash-XXXX file as an argument to
>>the qemu-fuzz-* binary - and when I do, I see the crash - but when I
>>try to debug it, it ends up running through and exiting
>>My assumption is that because of the fork in the test, the crash is
>>in one of the children.
>Right! Seems you are already using the follow-fork-mode option.

Yup

>
>>(ASIDE: I think it might be worth adding a debugging/analysing
>>section to the documentation you've added to help people debug such
>>crashes)
>Will do. Although it did not make it into v4, I am also working on an=20
>option to dump a trace of the qtest commands leading to a crashing=20
>input, which can then be replayed with a standard qtest program=20
>"replay.c". This seems like a good way to provide a reproducer to the=20
>device developers who may not be familiar with the fuzzer, or have=20
>time to build it.

That would be great!

For me the biggest problem was that I didn't have a version of clang
new enough (OL7/RHEL7) to have Libfuzzer, so if people don't have
it, then building with it's support is a bit more involved since you
also need to build clang, etc.

>>Setting follow-fork-mode to child does get me there, and each crash
>>seems, at least in the samples that I've taken, to be in iov_copy:
>Yes - this is what I have been using as well.
>
>> =C2=A0#0=C2=A0 0x00007ffff4cff377 in raise () from /lib64/libc.so.6
>> =C2=A0#1=C2=A0 0x00007ffff4d00a68 in abort () from /lib64/libc.so.6
>> =C2=A0#2=C2=A0 0x00007ffff4cf8196 in __assert_fail_base () from
>> =C2=A0/lib64/libc.so.6
>> =C2=A0#3=C2=A0 0x00007ffff4cf8242 in __assert_fail () from /lib64/libc=
.so.6
>> =C2=A0#4=C2=A0 0x00005555574d4026 in iov_copy ()
>> =C2=A0#5=C2=A0 0x000055555640dbd8 in virtio_net_flush_tx ()
>> =C2=A0#6=C2=A0 0x000055555640c8ef in virtio_net_tx_bh ()
>> =C2=A0#7=C2=A0 0x00005555574a05bb in aio_bh_call ()
>> =C2=A0#8=C2=A0 0x00005555574a0a34 in aio_bh_poll ()
>> =C2=A0#9=C2=A0 0x00005555574b1687 in aio_dispatch ()
>> =C2=A0#10 0x00005555574a35f9 in aio_ctx_dispatch ()
>> =C2=A0#11 0x00007ffff5e5d099 in g_main_context_dispatch () from
>> =C2=A0/lib64/libglib-2.0.so.0
>> =C2=A0#12 0x00005555574ae9fd in glib_pollfds_poll ()
>> =C2=A0#13 0x00005555574ad972 in os_host_main_loop_wait ()
>> =C2=A0#14 0x00005555574ad62c in main_loop_wait ()
>> =C2=A0#15 0x000055555736c653 in flush_events ()
>> =C2=A0#16 0x00005555573710a4 in virtio_net_fork_fuzz ()
>> =C2=A0#17 0x000055555736cb85 in LLVMFuzzerTestOneInput ()
>> =C2=A0...
>>
>>Have you seen these kind of crashes, or is this just me?
>Not just you :) I posted a fix for this, but it may have not been=20
>complete. I think the fuzzer found it before we added forking, just by=20
>doing reboots in between runs:
>https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04882.html

Ah! So I guess this hasn't been pulled into master yet (or at least
wasn't when I pulled from there yesterday.

Thanks,

Darren.

>
>>Just wondering if I should dig into it as a real issue, or some
>>mis-merge I've done (not all the patches were cleanly applied for
>>me when I cloned from master).
>
>>Thanks,
>>
>>Darren.
>>
>>On Wed, Oct 30, 2019 at 02:49:47PM +0000, Oleinik, Alexander wrote:
>>>This series adds a framework for coverage-guided fuzzing of
>>>virtual-devices. Fuzzing targets are based on qtest and can make use o=
f
>>>the libqos abstractions.
>>>
>>>V4:
>>>* add/transfer license headers to new files
>>>* restructure the added QTestClientTransportOps struct
>>>* restructure the FuzzTarget struct and fuzzer skeleton
>>>* fork-based fuzzer now directly mmaps shm over the coverage bitmaps
>>>* fixes to i440 and virtio-net fuzz targets
>>>* undo the changes to qtest_memwrite
>>>* possible to build /fuzz and /all in the same build-dir
>>>* misc fixes to address V3 comments
>>>
>>>V3:
>>>* rebased onto v4.1.0+
>>>* add the fuzzer as a new build-target type in the build-system
>>>* add indirection to qtest client/server communication functions
>>>* remove ramfile and snapshot-based fuzzing support
>>>* add i440fx fuzz-target as a reference for developers.
>>>* add linker-script to assist with fork-based fuzzer
>>>
>>>V2:
>>>* split off changes to qos virtio-net and qtest server to other patche=
s
>>>* move vl:main initialization into new func: qemu_init
>>>* moved useful functions from qos-test.c to a separate object
>>>* use struct of function pointers for add_fuzz_target(), instead of
>>>=C2=A0 arguments
>>>* move ramfile to migration/qemu-file
>>>* rewrite fork-based fuzzer pending patch to libfuzzer
>>>* pass check-patch
>>>
>>>Alexander Oleinik (20):
>>>=C2=A0softmmu: split off vl.c:main() into main.c
>>>=C2=A0libqos: Rename i2c_send and i2c_recv
>>>=C2=A0fuzz: Add FUZZ_TARGET module type
>>>=C2=A0qtest: add qtest_server_send abstraction
>>>=C2=A0libqtest: Add a layer of abstraciton to send/recv
>>>=C2=A0module: check module wasn't already initialized
>>>=C2=A0qtest: add in-process incoming command handler
>>>=C2=A0tests: provide test variables to other targets
>>>=C2=A0libqos: split qos-test and libqos makefile vars
>>>=C2=A0libqos: move useful qos-test funcs to qos_external
>>>=C2=A0libqtest: make qtest_bufwrite send "atomic"
>>>=C2=A0libqtest: add in-process qtest.c tx/rx handlers
>>>=C2=A0fuzz: add configure flag --enable-fuzzing
>>>=C2=A0fuzz: Add target/fuzz makefile rules
>>>=C2=A0fuzz: add fuzzer skeleton
>>>=C2=A0fuzz: add support for fork-based fuzzing.
>>>=C2=A0fuzz: add support for qos-assisted fuzz targets
>>>=C2=A0fuzz: add i440fx fuzz targets
>>>=C2=A0fuzz: add virtio-net fuzz target
>>>=C2=A0fuzz: add documentation to docs/devel/
>>>
>>>Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++-
>>>Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>>>Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 ++-
>>>configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 39 ++++++
>>>docs/devel/fuzzing.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 119 +++++=
+++++++++++++
>>>exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 12 +-
>>>include/qemu/module.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 4 +-
>>>include/sysemu/qtest.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 4 +
>>>include/sysemu/sysemu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 =
+
>>>main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 52 ++++++++
>>>qtest.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3=
0 ++++-
>>>tests/Makefile.include=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 75 =
+++++------
>>>tests/fuzz/Makefile.include=C2=A0 |=C2=A0 11 ++
>>>tests/fuzz/fork_fuzz.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 51 =
++++++++
>>>tests/fuzz/fork_fuzz.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 =
++++
>>>tests/fuzz/fork_fuzz.ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 37 +++++=
+
>>>tests/fuzz/fuzz.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 177 ++++++++++++++++++++++++++
>>>tests/fuzz/fuzz.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 66 ++++++++++
>>>tests/fuzz/i440fx_fuzz.c=C2=A0=C2=A0=C2=A0=C2=A0 | 176 +++++++++++++++=
+++++++++++
>>>tests/fuzz/qos_fuzz.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 232 =
+++++++++++++++++++++++++++++++++++
>>>tests/fuzz/qos_fuzz.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 33 +++++
>>>tests/fuzz/virtio_net_fuzz.c | 123 +++++++++++++++++++
>>>tests/libqos/i2c-imx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 8 +-
>>>tests/libqos/i2c-omap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 =
+-
>>>tests/libqos/i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 10 +-
>>>tests/libqos/i2c.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 4 +-
>>>tests/libqos/qos_external.c=C2=A0 | 168 +++++++++++++++++++++++++
>>>tests/libqos/qos_external.h=C2=A0 |=C2=A0 28 +++++
>>>tests/libqtest.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 109 ++++++++++++++--
>>>tests/libqtest.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>>>tests/pca9552-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 10 +-
>>>tests/qos-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 140 +--------------------
>>>util/module.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 ++
>>>vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 36 ++----
>>>34 files changed, 1601 insertions(+), 237 deletions(-)
>>>create mode 100644 docs/devel/fuzzing.txt
>>>create mode 100644 main.c
>>>create mode 100644 tests/fuzz/Makefile.include
>>>create mode 100644 tests/fuzz/fork_fuzz.c
>>>create mode 100644 tests/fuzz/fork_fuzz.h
>>>create mode 100644 tests/fuzz/fork_fuzz.ld
>>>create mode 100644 tests/fuzz/fuzz.c
>>>create mode 100644 tests/fuzz/fuzz.h
>>>create mode 100644 tests/fuzz/i440fx_fuzz.c
>>>create mode 100644 tests/fuzz/qos_fuzz.c
>>>create mode 100644 tests/fuzz/qos_fuzz.h
>>>create mode 100644 tests/fuzz/virtio_net_fuzz.c
>>>create mode 100644 tests/libqos/qos_external.c
>>>create mode 100644 tests/libqos/qos_external.h
>>>
>>>--=20
>>>2.23.0
>>>
>>>
>

