Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BE4C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7323E20861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W1b3y+Qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7323E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcr2U-0000x9-L3
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcquP-0002Nz-9R
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcquO-0005LE-9T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:38:49 -0400
Received: from mail-he1eur04hn2040.outbound.protection.outlook.com
 ([52.101.137.40]:63553 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hcquO-0005JW-0y; Mon, 17 Jun 2019 08:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiK/uDe9lPyJubSFsJYSNEuGvO69KZRMW5g2KzI9saU=;
 b=W1b3y+QuRhIeNrHjj+b7RBoVNZTaJD36E+AoeTGXHp6HdLFVJBJF59CqBlbKMlI8d/8VWzG8ub/qTLbNaQgm2dkZMOWRA1ZTqnMt2r9ibBWeoFZrlIGUz7U+SOGcvhLdrwXCGSIXBdA8i7vAo7eHoCjSHCOQ/QuWsZJ6F2AD5ME=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Mon, 17 Jun 2019 12:38:34 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 12:38:34 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Thread-Topic: [PATCH v2 6/7] iotests: amend QEMU NBD process synchronization
Thread-Index: AQHVIH/W+4fzIICfOUahb05s1OWCZ6af0iSA
Date: Mon, 17 Jun 2019 12:38:34 +0000
Message-ID: <20190617123831.GC32624@rkaganb.sw.ru>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-7-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1560276131-683243-7-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>,	qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kwolf@redhat.com,	mreitz@redhat.com,
 berrange@redhat.com, den@openvz.org,	vsementsov@virtuozzo.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0501CA0009.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::19) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82402d46-8768-4d1c-f8fb-08d6f320b664
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5498; 
x-ms-traffictypediagnostic: DB8PR08MB5498:|DB8PR08MB5498:
x-microsoft-antispam-prvs: <DB8PR08MB5498460663F102B75F357E61C9EB0@DB8PR08MB5498.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(376002)(366004)(39840400004)(136003)(346002)(189003)(199004)(76176011)(446003)(4326008)(54906003)(476003)(52116002)(8676002)(6486002)(81166006)(81156014)(6436002)(316002)(36756003)(11346002)(25786009)(102836004)(6636002)(486006)(14444005)(7736002)(6506007)(386003)(3846002)(71190400001)(8936002)(2906002)(66946007)(66446008)(64756008)(73956011)(66476007)(99286004)(6246003)(6862004)(68736007)(53936002)(6116002)(229853002)(14454004)(86362001)(71200400001)(107886003)(58126008)(186003)(26005)(5660300002)(478600001)(33656002)(66556008)(256004)(305945005)(1076003)(6512007)(66066001)(9686003)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB5498;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pFE9sA9Blr0bbh3ZHH5tjoEGqEc5ZRJ8cNwpdBBNHwdK6gOQ1IalwRA4PwXKENC/3Mb1oH7/Uh/seXduHehpIq2r8jRFQdX3yCM/WupOQSQjaHwgAxTi9+Cno3zv67MRI2IWT6M+2ks5Bb6J/bRW75CXpTShLRwMtS1clscWesdVCbAu3FBeRBokIN4MZOhq9BYhOc94RiRXLLAzrSlVyLKYEJgp9qBHx4JruF6a1smy4tcQmll5Zd8oF5jwtEb9CoS5uxQ5X66AhCMzXjOoLawGPnu3tkNFFg81IvBbMgKu+7hwTTW38J4c4WQLmTjOvn+vFV03EpxR/hVv6QGZ2plBP/8w6OFAYqylO0MxrGKnaGtbbcWJybnR5dVMLt7d/pOz+jcyLhFcJ/m2uedcKs7NLousZQi9s+I9rqdJnM9pohO2idoHznnQZqs7KQyRr28fwSz/bwJpoZc9GPUUkR1KVMiGRvpH3YDiR6s6PJimqwUa6SnQUGDjBcK3vc2w
Content-Type: text/plain; charset="us-ascii"
Content-ID: <823C91F4F69B5648BDF8D2DA7C91A41A@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82402d46-8768-4d1c-f8fb-08d6f320b664
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 12:38:34.5966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5498
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.137.40
Subject: Re: [Qemu-devel] [PATCH v2 6/7] iotests: amend QEMU NBD process
 synchronization
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 11, 2019 at 09:02:10PM +0300, Andrey Shinkevich wrote:
> Processes are dying harder under the Valgring. It results in counting
> the dying process as a newborn one. Make it sure that old NBD job get
> finished before starting a new one.

I think this log message is confusing.

The problem this patch addresses is that nbd_server_stop only sends a
signal to the nbd process and immediately returns, without waiting for
it to actually terminate.  The next operation is often starting a new
instance of nbd; this races with the termination of the old one, and may
result in various failures (like nbd_server_start_* taking the
terminating nbd as the one just started, or the starting nbd
encountering a busy listening socket).

Without valgrind the race window is very small and the problem didn't
surface for long.  However, under valgrind process termination takes
much longer so the race bites every test run.

Since nbd is run in a background job of the test, record the nbd pid at
the daemon start in a shell variable and perform a wait for it when
terminating it.

Roman.

> Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  tests/qemu-iotests/common.nbd | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nbd
> index 25fc9ff..e3dcc60 100644
> --- a/tests/qemu-iotests/common.nbd
> +++ b/tests/qemu-iotests/common.nbd
> @@ -22,6 +22,7 @@
>  nbd_unix_socket="${TEST_DIR}/qemu-nbd.sock"
>  nbd_tcp_addr="127.0.0.1"
>  nbd_pid_file="${TEST_DIR}/qemu-nbd.pid"
> +nbd_job_pid=""
>  
>  nbd_server_stop()
>  {
> @@ -33,6 +34,9 @@ nbd_server_stop()
>              kill "$NBD_PID"
>          fi
>      fi
> +    if [ -n "$nbd_job_pid" ] && kill -s 0 "$nbd_job_pid" 2>/dev/null; then
> +        wait "$nbd_job_pid"
> +    fi
>      rm -f "$nbd_unix_socket"
>  }
>  
> @@ -61,6 +65,7 @@ nbd_server_start_unix_socket()
>  {
>      nbd_server_stop
>      $QEMU_NBD -v -t -k "$nbd_unix_socket" "$@" &
> +    nbd_job_pid=$!
>      nbd_server_wait_for_unix_socket $!
>  }
>  
> @@ -105,5 +110,6 @@ nbd_server_start_tcp_socket()
>  {
>      nbd_server_stop
>      $QEMU_NBD -v -t -b $nbd_tcp_addr -p $nbd_tcp_port "$@" &
> +    nbd_job_pid=$!
>      nbd_server_wait_for_tcp_socket $!
>  }
> -- 
> 1.8.3.1
> 

