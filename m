Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A1DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 09:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBCC20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 09:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YvqDEcfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBCC20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kScps-00019D-C2
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 05:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kScp9-0000jd-9z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 05:11:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kScp6-0005TI-Kf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 05:11:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E98VDI158318;
 Wed, 14 Oct 2020 09:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3jjN2OtxQPTfmE989BZakspikHkyWyZ72rrqRWQFHLo=;
 b=YvqDEcfZHoMEZYbRHJU57WoQhtNGFV69gcTWbOoGt4zNTBaPxygF2JKTFWZP3BNQDTCI
 vlkRQNjouO2daZbeLEXqiJDE0w6/5maUIzdx/pgDTI3gTTEBT0h+cNv3ryj8VsR2t5WH
 TYoOBtzTdhcFWoXTML+nmpm9/tWYImuGp5Wsk+lN2Zz3tPd8I1JovZnX03XFgHWxfTU1
 7n3br4PGI6lQalO/HO955NF/lUyed+f89kbEWvLYzkmCJ7AUW+Siu2O298SQubanXUWW
 WJlxWHUYjbzt71kfu8moJH8Y87BRzAYmxb04r6UYXyTHXdP8yPgCaJQv5Vr8R+nas5cE 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 343pajw296-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Oct 2020 09:11:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E94YqF016313;
 Wed, 14 Oct 2020 09:09:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 343pvxgy58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2020 09:09:49 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09E99l77014703;
 Wed, 14 Oct 2020 09:09:47 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 14 Oct 2020 02:09:47 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 0EBAA1C0E02B; Wed, 14 Oct 2020 10:09:43 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] fuzz: Disable QEMU's signal handlers
In-Reply-To: <20201013165246.GU70612@redhat.com>
References: <20201013152920.448335-1-alxndr@bu.edu>
 <m2r1q2m5nm.fsf@oracle.com> <20201013165246.GU70612@redhat.com>
Date: Wed, 14 Oct 2020 10:09:42 +0100
Message-ID: <m2lfg9maw9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140067
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=darren.kenny@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 05:11:51
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tuesday, 2020-10-13 at 17:52:46 +01, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Oct 13, 2020 at 05:50:37PM +0100, Darren Kenny wrote:
>> Hi Alex,
>>=20
>> This mentions the use of atexit() to perform some cleanup, but I'm not
>> seeing that being added here, should it be?
>
> The reference to atexit is strange, because it says the only way to
> kill the fuzzer is SIGKILL, and that won't let atexit handlers run
> anyway.
>

OK, I understand the context now, it is in reference to Dima's patchset:

- https://lore.kernel.org/qemu-devel/cover.1602078083.git.dimastep@yandex-t=
eam.ru/

Where Alex suggested using atexit() to clean up the left over files from
the test.

And with regard to SIGKILL, I believe it is that today, before Alex's
patch that is the only way to stop the fuzzer running - which I can
attest to since I've found it hard to stop in the past :)

Resetting these signal handlers to the default behaviour would allow the
process to be terminated and an atexit() used, as Alex mentioned.

Alex, if you could clarify the commit message, then I feel this does
make sent to change in the fuzz testing code, so:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

>>=20
>> Thanks,
>>=20
>> Darren.
>>=20
>> On Tuesday, 2020-10-13 at 11:29:20 -04, Alexander Bulekov wrote:
>> > With the fuzzer, we never call main_loop_should_exit, since we manually
>> > call main_loop_wait. This means that the only way to terminate the
>> > fuzzer is with SIGKILL. Disable the signal handlers, so there are
>> > reasonable ways to terminate the fuzzer and use atexit() to clean-up
>> > after the fuzzer.
>> >
>> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> > ---
>> >  tests/qtest/fuzz/fuzz.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
>> > index d926c490c5..eb0070437f 100644
>> > --- a/tests/qtest/fuzz/fuzz.c
>> > +++ b/tests/qtest/fuzz/fuzz.c
>> > @@ -217,5 +217,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv,=
 char ***envp)
>> >      /* re-enable the rcu atfork, which was previously disabled in qem=
u_init */
>> >      rcu_enable_atfork();
>> >=20=20
>> > +    /*
>> > +     * Disable QEMU's signal handlers, since we manually control the =
main_loop,
>> > +     * and don't check for main_loop_should_exit
>> > +     */
>> > +    signal(SIGINT, SIG_DFL);
>> > +    signal(SIGHUP, SIG_DFL);
>> > +    signal(SIGTERM, SIG_DFL);
>> > +
>> >      return 0;
>> >  }
>> > --=20
>> > 2.28.0
>>=20
>
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

