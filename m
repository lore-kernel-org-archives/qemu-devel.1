Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28703C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E5C2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="In9FlwOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E5C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybip-0003nL-14
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 08:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1hybi8-00037r-Ah
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1hybi6-0004YH-Jy
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:52:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1hybi6-0004Mk-1q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:52:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GCmlNY178026;
 Fri, 16 Aug 2019 12:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=f4qNr2+cMnguzapqkOpO/KhmjUVfwO8ot6nLsVwZ3fo=;
 b=In9FlwOZ9oPtiVyvHzh/IFYTynWfL4MLcnUFvqt7ExQ3vFPev3XUhDjDX/CyjipjfxB6
 6OK+dpr4YxSIJxIeZ3PsO4gDhQBe7geMwNpk1LMgzLXzzSaZ54RKbsMabNf/qPPVW5QH
 erjST1MUxUZdMQhyY5n05bWtjOVJO8pc+VpvdlkbsmKA2z7/s6WOjVBR3LYgqA8NpKmm
 uHlZt4yBVaEfSTWLA64RPmXRcXzi9yVzgyZ2DrWy7+P3VvCa7PXSN1cdF5QYPdh2CcPi
 8MzsHxumrXBadbcVHm1wjcWG/7iv/zyjXNAFBlBYSjBfUoCmSVApyhxqOK0jxxLmHLa/ Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2u9pjr06ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2019 12:51:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GCn7rc125920;
 Fri, 16 Aug 2019 12:51:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2udscpd1v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2019 12:51:52 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7GCppxu007310;
 Fri, 16 Aug 2019 12:51:51 GMT
Received: from starbug-mbp.localdomain (/10.175.18.150)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 16 Aug 2019 05:51:51 -0700
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 9CB3B401B0EC;
 Fri, 16 Aug 2019 13:51:48 +0100 (IST)
Date: Fri, 16 Aug 2019 13:51:48 +0100
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190816125148.huvrqd7b5izuczta@starbug-mbp>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-10-alxndr@bu.edu>
 <20190809093359.GJ25286@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190809093359.GJ25286@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160132
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/17] fuzz: hardcode needed objects
 into i386 target
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexander,

On Fri, Aug 09, 2019 at 10:33:59AM +0100, Stefan Hajnoczi wrote:
>On Mon, Aug 05, 2019 at 07:11:10AM +0000, Oleinik, Alexander wrote:
>> Temporary solution until there is a better build solution for fuzzers in
>> tests/Makefile.include
>>
>> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>> ---
>>  target/i386/Makefile.objs | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
>> index 48e0c28434..1b8976c0a6 100644
>> --- a/target/i386/Makefile.objs
>> +++ b/target/i386/Makefile.objs
>> @@ -18,5 +18,25 @@ endif
>>  obj-$(CONFIG_HVF) += hvf/
>>  obj-$(CONFIG_WHPX) += whpx-all.o
>>  endif
>> +
>> +# Need to link against target, qtest and qos.. Just list everything here, until
>> +# I find a better way to integrate into the build system
>
>There are two similar solutions:
>
>1. Use tests/Makefile.include, e.g. libqos-obj-y.
>2. Build a .a archive file in tests/Makefile.include and link against it.
>
>In both cases it is no longer necessary to list ../../tests/ object
>files in target/i386/Makefile.objs.
>
>> +ifeq ($(CONFIG_FUZZ),y)
>
>ifeq isn't necessary since obj-$(CONFIG_FUZZ) is already conditional
>below.
>
>> +obj-$(CONFIG_FUZZ) += ../../accel/fuzz.o ../../tests/libqos/qos_external.o
>> +obj-$(CONFIG_FUZZ) += ../../tests/fuzz/fuzz.o ../../tests/fuzz/fuzzer_hooks.o
>> +obj-$(CONFIG_FUZZ) += ../../tests/fuzz/virtio-net-fuzz.o
>> +obj-$(CONFIG_FUZZ) += ../../tests/fuzz/snapshotting.o
>> +obj-$(CONFIG_FUZZ) += ../../tests/fuzz/qtest_fuzz.o
>> +obj-$(CONFIG_FUZZ) += ../../tests/libqtest.o
>> +obj-$(CONFIG_FUZZ) += ../../tests/libqos/qgraph.o ../../tests/libqos/libqos.o
>> +obj-$(CONFIG_FUZZ) += ../../tests/fuzz/qos_fuzz.o ../../tests/fuzz/qos_helpers.o
>> +obj-$(CONFIG_FUZZ) +=  ../../tests/libqos/malloc.o ../../tests/libqos/pci-pc.o \
>> +	../../tests/libqos/virtio-pci.o ../../tests/libqos/malloc-pc.o \
>> +	../../tests/libqos/libqos-pc.o ../../tests/libqos/fw_cfg.o \
>> +	../../tests/libqos/e1000e.o ../../tests/libqos/pci.o \
>> +	../../tests/libqos/pci-pc.o ../../tests/libqos/virtio.o \
>> +	../../tests/libqos/virtio-net.o ../../tests/libqos/x86_64_pc-machine.o
>
>I see filenames here that are not in the tree yet at this point in the
>patch series.  Please make sure that QEMU builds at each point in the
>patch series so that git-bisect(1) works.

Even after applying the series I'm not seeing any snapshotting.[ch]
files - so virtio-net-fuzz.c fails to build too because of the
missing header file.

But overall, I'm finding lots of failures when building the series,
not just at any specific point in time, so it would be worth at
least doing a clean checkout of the tree and applying the patches,
and doing a full build, before sending out the next set, to be sure
that they are complete.

Thanks,

Darren.


