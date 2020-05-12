Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5D8C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4830C2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jnHPjcqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4830C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPrz-0006XO-EV
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jYPpk-0004Cz-Tw
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:00:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jYPpi-0004Ss-83
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:00:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C7mVQV117623;
 Tue, 12 May 2020 08:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=mbYBAS9hiY3eXbLURsvb1zcPy0sl4rgH1Ezh3rpuZew=;
 b=jnHPjcqEk3x1QOXHxmX/yPrKXHszd3w/Fs9G5/4N/0NBq06B9Fm2MesMuoeUldlVoota
 kleqBeBbp7CDlb2Xv3G+eY4Ik22Xyjowr61iP4LMAaWt6umBdrSlAeBcdp0Wtrh5kFVa
 0u0RvlJKK67Flnn+o0BmiPLT/4jX30phLD3LdIRYparHJlQQzjoYcl0kw3K4wJHsZsJQ
 AQZj/mVgzBTVepjiQnXyCYdcm0a+pdSA4pbGsIYdjdoUM8yIYEr8enhp35YmPSgxAS5A
 VU+w0y7fTCkIWpDSH/tm8yz2mIrunHn6qPbBM6luPZhzxDVtnLhNz2nnJLwl7/dCQzSg VA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 30x3gmhecc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 08:00:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C7gWNc125664;
 Tue, 12 May 2020 08:00:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 30xbghkvd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 08:00:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04C8050O023044;
 Tue, 12 May 2020 08:00:05 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 01:00:04 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 861496920B1A; Tue, 12 May 2020 09:00:02 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] fuzz: run the main-loop in fork-server process
In-Reply-To: <20200512030133.29896-5-alxndr@bu.edu>
References: <20200512030133.29896-1-alxndr@bu.edu>
 <20200512030133.29896-5-alxndr@bu.edu>
Date: Tue, 12 May 2020 09:00:02 +0100
Message-ID: <m2wo5hlh19.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=827
 spamscore=0 suspectscore=1 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=874
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120067
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 03:59:22
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-05-11 at 23:01:33 -04, Alexander Bulekov wrote:
> Without this, the time since the last main-loop keeps increasing, as the
> fuzzer runs. The forked children need to handle all the "past-due"
> timers, slowing them down, over time. With this change, the
> parent/fork-server process runs the main-loop, while waiting on the
> child, ensuring that the timer events do not pile up, over time.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/fuzz/i440fx_fuzz.c      | 1 +
>  tests/qtest/fuzz/virtio_net_fuzz.c  | 2 ++
>  tests/qtest/fuzz/virtio_scsi_fuzz.c | 2 ++
>  3 files changed, 5 insertions(+)
>
> I'm working on another series to abstract away the details of resetting
> qemu state between runs from the individual targets. That should relieve
> us from needing to add this for each new fuzzing target.
>
> diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
> index 90e75ffaea..8449f81687 100644
> --- a/tests/qtest/fuzz/i440fx_fuzz.c
> +++ b/tests/qtest/fuzz/i440fx_fuzz.c
> @@ -138,6 +138,7 @@ static void i440fx_fuzz_qos_fork(QTestState *s,
>          i440fx_fuzz_qos(s, Data, Size);
>          _Exit(0);
>      } else {
> +        flush_events(s);
>          wait(NULL);
>      }
>  }
> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
> index d08a47e278..a33bd73067 100644
> --- a/tests/qtest/fuzz/virtio_net_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
> @@ -122,6 +122,7 @@ static void virtio_net_fork_fuzz(QTestState *s,
>          flush_events(s);
>          _Exit(0);
>      } else {
> +        flush_events(s);
>          wait(NULL);
>      }
>  }
> @@ -134,6 +135,7 @@ static void virtio_net_fork_fuzz_check_used(QTestState *s,
>          flush_events(s);
>          _Exit(0);
>      } else {
> +        flush_events(s);
>          wait(NULL);
>      }
>  }
> diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> index 3b95247f12..51dce491ab 100644
> --- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> @@ -145,6 +145,7 @@ static void virtio_scsi_fork_fuzz(QTestState *s,
>          flush_events(s);
>          _Exit(0);
>      } else {
> +        flush_events(s);
>          wait(NULL);
>      }
>  }
> @@ -164,6 +165,7 @@ static void virtio_scsi_with_flag_fuzz(QTestState *s,
>          }
>          _Exit(0);
>      } else {
> +        flush_events(s);
>          wait(NULL);
>      }
>  }
> -- 
> 2.26.2

