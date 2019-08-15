Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F2DC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108E72084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IBcoW5cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108E72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyF4z-000874-HU
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 08:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1hyF4J-0007gs-PM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1hyF4I-0007fo-6i
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:41:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1hyF4H-0007ej-R5
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:41:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FCcQBJ019203;
 Thu, 15 Aug 2019 12:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=42vjv25Rum8vkMZqpLR+rf75kLIb6iSn/c/I2RoD7MA=;
 b=IBcoW5cplI3Gw7gRvYiVCUlZrAhNtfbs+A2AjDu9WNKI+E9xkp9n+7YlXJijkPtjCrUx
 bBQPQGubeCJMYebOMac6cSRJn3szsb/Q32ASVY6KC11cp1kPR2F8A8HKZEytTlBC0iVe
 BIwGjeLwtFeA2QBVLyYOCPloPl/ILvm3OMJFegOgjml3cVFSBgruyx6mIAOv24EbhNlD
 5AZt/vscfd93zYWJWABLerxlC+zZj1YQ6rz7U4897A1V9ckRD5t3AUiqKMbsjQbWXrXz
 VZRcvAHosPyTmHMPLevUnhxyurP7tteJhEOqc0avsHk37lHBWWEOOTxDJch4krZkLKst bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2u9nvpjmpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2019 12:41:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FCcOvo149194;
 Thu, 15 Aug 2019 12:41:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2ucmwjmufx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2019 12:41:20 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7FCfJGa008418;
 Thu, 15 Aug 2019 12:41:19 GMT
Received: from starbug-lenovo.ie.oracle.com (/10.169.104.251)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Aug 2019 05:41:18 -0700
Date: Thu, 15 Aug 2019 13:41:14 +0100
From: Darren Kenny <darren.kenny@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190815124114.du6huaca56jp6heb@starbug-lenovo.ie.oracle.com>
Mail-Followup-To: Paolo Bonzini <pbonzini@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-2-alxndr@bu.edu>
 <7d90f16e-d77f-077e-5291-ae4d5ee3d668@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <7d90f16e-d77f-077e-5291-ae4d5ee3d668@redhat.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150134
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/17] fuzz: Move initialization
 from main to qemu_init
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 05, 2019 at 09:43:06AM +0200, Paolo Bonzini wrote:
>On 05/08/19 09:11, Oleinik, Alexander wrote:
>> Using this, we avoid needing a special case to break out of main(),
>> early, when initializing the fuzzer, as we can just call qemu_init.
>> There is still a #define around main(), since it otherwise conflicts
>> with the libfuzzer main().
>>
>> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>> ---
>>  include/sysemu/sysemu.h |  5 +++++
>>  vl.c                    | 25 +++++++++++++++++++++++--
>>  2 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 984c439ac9..a63d5ccce3 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -184,6 +184,8 @@ QemuOpts *qemu_get_machine_opts(void);
>>
>>  bool defaults_enabled(void);
>>
>> +int qemu_init(int argc, char **argv, char **envp);
>> +
>>  extern QemuOptsList qemu_legacy_drive_opts;
>>  extern QemuOptsList qemu_common_drive_opts;
>>  extern QemuOptsList qemu_drive_opts;
>> @@ -197,4 +199,7 @@ extern QemuOptsList qemu_global_opts;
>>  extern QemuOptsList qemu_mon_opts;
>>  extern QemuOptsList qemu_semihosting_config_opts;
>>
>> +#ifdef CONFIG_FUZZ
>> +int real_main(int argc, char **argv, char **envp);
>> +#endif
>>  #endif
>> diff --git a/vl.c b/vl.c
>> index 130a389712..914bb9b2de 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -130,6 +130,10 @@ int main(int argc, char **argv)
>>  #include "sysemu/iothread.h"
>>  #include "qemu/guest-random.h"
>>
>> +#ifdef CONFIG_FUZZ
>> +#include "tests/libqtest.h"
>> +#endif
>
>Why is this #include needed?
>
>If you leave out the changes to introduce real_main, the patch can be
>committed independent of the rest.  Those can be introduced in patch 2
>or even 12 ("Add fuzzer skeleton").

The build actually fails for me due to this include, because it has it's own
and different declaration of qtest_init:

  In file included from vl.c:134:
  .../qemu-upstream-libfuzz/./tests/libqtest.h:57:13: error: conflicting types for 'qtest_init'
  QTestState *qtest_init(const char *extra_args);
              ^
  .../qemu-upstream-libfuzz/include/sysemu/qtest.h:27:6: note: previous declaration is here
  void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
       ^
  In file included from vl.c:134:
  .../qemu-upstream-libfuzz/./tests/libqtest.h:640:35: error: too few arguments to function call, expected 3, have 1
      global_qtest = qtest_init(args);
                     ~~~~~~~~~~     ^
  .../qemu-upstream-libfuzz/include/sysemu/qtest.h:27:1: note: 'qtest_init' declared here
  void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
  ^
  2 errors generated.

(It's probably a separate issue as to why there are 2 functions with
the same name, are not static and have different signatures in the
first place)

Thanks,

Darren.


