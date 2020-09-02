Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C350C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D600220773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aBQLUDiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D600220773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOJh-0006uv-2z
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDOIm-000626-OR
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:39:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDOIk-000673-Ls
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:39:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0828XubP073824;
 Wed, 2 Sep 2020 08:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=s1nGN97ED+11PpNXEQi3zyGuB9NJxXHzae4joFipK6A=;
 b=aBQLUDiSmgDvjXsimMJtUiQPdJcrICV9df+okIM8ac2Ozb7XPaqreYC0u/HC3Mz1LqfS
 +TDC2dI277CoegT+SZe+WdU+y4BC6voahFBDTe/xMAsUgdELWibGkobosE/TtwoorJvk
 5OcTbyVDn9/TyiBNKH9M9Ts+MIc82bw1E3J/ZcJTE7j6WYTSNu8mNaAV09x9sLlkGV+K
 UcExqOsftoT3IWojTveqwGK90KE1v1gQqdDw+sHyUOOUKn95YvJif+Q7OXgWzS8dBFUD
 nIwf3cWJbJxEt1Nyakup0X9brPBHDo3djXvSty6ZDBoe5h/Ral+l+OLdLRjb9Q08IYe+ Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 339dmmyk77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 02 Sep 2020 08:39:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0828ZjCx138706;
 Wed, 2 Sep 2020 08:39:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 3380xy6t6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Sep 2020 08:39:24 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0828dNAq021043;
 Wed, 2 Sep 2020 08:39:23 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 02 Sep 2020 01:39:23 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id F2D9B12C4D14; Wed,  2 Sep 2020 09:39:15 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/tpm: Declare input buffers const and static
In-Reply-To: <20200902080909.161034-1-philmd@redhat.com>
References: <20200902080909.161034-1-philmd@redhat.com>
Date: Wed, 02 Sep 2020 09:39:15 +0100
Message-ID: <m2d034tvws.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020079
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 04:18:53
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-09-02 at 10:09:09 +02, Philippe Mathieu-Daud=C3=A9 wrote:
> The functions using these arrays expect a "const unsigned char *"
> argument, it is safe to declare these as 'static const'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/tpm-tests.c |  4 ++--
>  tests/qtest/tpm-util.c  | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
> index a2f2838e15b..70c80f8379a 100644
> --- a/tests/qtest/tpm-tests.c
> +++ b/tests/qtest/tpm-tests.c
> @@ -59,7 +59,7 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_f=
unc *tx,
>      tpm_util_startup(s, tx);
>      tpm_util_pcrextend(s, tx);
>=20=20
> -    unsigned char tpm_pcrread_resp[] =3D
> +    static const unsigned char tpm_pcrread_resp[] =3D
>          "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
>          "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
>          "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
> @@ -107,7 +107,7 @@ void tpm_test_swtpm_migration_test(const char *src_tp=
m_path,
>      tpm_util_startup(src_qemu, tx);
>      tpm_util_pcrextend(src_qemu, tx);
>=20=20
> -    unsigned char tpm_pcrread_resp[] =3D
> +    static const unsigned char tpm_pcrread_resp[] =3D
>          "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
>          "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
>          "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index e2b29ef0f8c..3ed6c8548a6 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -98,9 +98,9 @@ void tpm_util_tis_transfer(QTestState *s,
>  void tpm_util_startup(QTestState *s, tx_func *tx)
>  {
>      unsigned char buffer[1024];
> -    unsigned char tpm_startup[] =3D
> +    static const unsigned char tpm_startup[] =3D
>          "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
> -    unsigned char tpm_startup_resp[] =3D
> +    static const unsigned char tpm_startup_resp[] =3D
>          "\x80\x01\x00\x00\x00\x0a\x00\x00\x00\x00";
>=20=20
>      tx(s, tpm_startup, sizeof(tpm_startup), buffer, sizeof(buffer));
> @@ -112,14 +112,14 @@ void tpm_util_startup(QTestState *s, tx_func *tx)
>  void tpm_util_pcrextend(QTestState *s, tx_func *tx)
>  {
>      unsigned char buffer[1024];
> -    unsigned char tpm_pcrextend[] =3D
> +    static const unsigned char tpm_pcrextend[] =3D
>          "\x80\x02\x00\x00\x00\x41\x00\x00\x01\x82\x00\x00\x00\x0a\x00\x0=
0"
>          "\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x01\x0=
0"
>          "\x0b\x74\x65\x73\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0"
>          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0"
>          "\x00";
>=20=20
> -    unsigned char tpm_pcrextend_resp[] =3D
> +    static const unsigned char tpm_pcrextend_resp[] =3D
>          "\x80\x02\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0"
>          "\x01\x00\x00";
>=20=20
> @@ -133,7 +133,7 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
>                        const unsigned char *exp_resp, size_t exp_resp_siz=
e)
>  {
>      unsigned char buffer[1024];
> -    unsigned char tpm_pcrread[] =3D
> +    static const unsigned char tpm_pcrread[] =3D
>          "\x80\x01\x00\x00\x00\x14\x00\x00\x01\x7e\x00\x00\x00\x01\x00\x0=
b"
>          "\x03\x00\x04\x00";
>=20=20
> --=20
> 2.26.2

