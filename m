Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76838C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC6E20759
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="w/N5R5Ws";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="lAvc6WrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC6E20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9TH-0007P6-1t
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 11:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kY9R5-0005wO-1Q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:01:55 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3745)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kY9R3-0002Th-29
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1603983713; x=1635519713;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uE2n8OKH1JDQS2p1ZGaOhuml9UTiaK0hEf1JGDig8qk=;
 b=w/N5R5WsgAPO2pLxDIJ+mJd31PaTjEmxJbMEKvWyVeTri7RH41mcQA3H
 m9FinIDoR3OXCeh3AxicSjQwpf+lPHNqN8kCVEHhzg82MpnMFX8PSArdh
 2dVe4GPsPaAAPdgzLoJLXSsN65E1gx+dJ0FodvjKrZOetRnhTgghVKarq k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Oct 2020 08:01:51 -0700
X-QCInternal: smtphost
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 29 Oct 2020 08:01:51 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Oct 2020 08:01:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 29 Oct 2020 08:01:50 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB7091.namprd02.prod.outlook.com (2603:10b6:a03:21c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 29 Oct
 2020 15:01:50 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 15:01:50 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 01/15] qemu/int128: Add int128_or
Thread-Topic: [RFC PATCH 01/15] qemu/int128: Add int128_or
Thread-Index: AQHWp2YTs0kJRoW8I02+xMP4VoXX3qmuueMA
Date: Thu, 29 Oct 2020 15:01:49 +0000
Message-ID: <BYAPR02MB4886F168AA9A1500959BD886DE140@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
 <20201021045149.1582203-2-richard.henderson@linaro.org>
In-Reply-To: <20201021045149.1582203-2-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe7b8a00-2aa5-4c37-f1dd-08d87c1b905c
x-ms-traffictypediagnostic: BY5PR02MB7091:
x-microsoft-antispam-prvs: <BY5PR02MB7091EB7BC606848D4287D23CDE140@BY5PR02MB7091.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:53;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FzZ0Ao9oInG0LcN7cDjaKpd/4NweBdAbkoA651wfJUd/kFeUzhrvvdoHh1uE6S4FpAm3KNAn6RKaOL8de/9qK2dIZxjIpNesD5X/Rd3OAFWdQp4mOAu5mgu/g5SXTokJVNPJQ9ErbsPrS4HXOfJfZ8IK1Hr0fXL77y0yvpbp2+xpXizrF+IgzcP9skbUpXKXwU9imxlK0h95jOiy3EXAp+ZAecj/unGQTqRoe7LmNHAuu5txnLm4JHTVb3Wpj3Z8j92hg7lgz82fx8GRHEDOFM+n5vSoXcGIEI1nCJe1i4cqhV1iXiSl3mmdFnQqd/aX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(186003)(66946007)(2906002)(8676002)(9686003)(71200400001)(478600001)(110136005)(4326008)(7696005)(83380400001)(66556008)(66446008)(86362001)(5660300002)(33656002)(316002)(26005)(6506007)(66476007)(53546011)(8936002)(76116006)(55016002)(52536014)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Pa55WpDqxbqux80f7lN1gKBO7+pjhO+LMjETV7w4vKk5XeBH7hJrzH+N8xgAX02gsOLHceDikotB+1nohdYsjwUPo+kskLDMg7lsaVE3idIAuqY5tSpzMtDiqhqJ6SbjKHrXzKoDQUiYPjfJgLzS4Dpny/czjGO3/+BgS0n/lRDEW8gX3iUvOtTskYQw2M8SQLvz/SDpxUqCp6cANKCcELrXNwS4g3Sw0cPHZAcV3etslTDwlwZ5UWRcW53+BNcPDQ2Zk7jbNM4TBFK8nCM3hocFgGDFgzU4hRr3ZuSldakufao/GDX9zufd2bZ1i8JNEMeGzeI796e+cRBdI6vvK/U6H3SyvJdP5kB4QBZj9o4bK5YtNgPXgddNlkmnQAE6Q4haQnqdi6o9/RfAqaHcjFr6tdH7w4BWiYLMocminSuyC177aDmfydvTR6f2Mwt29r0wSEZuc7bmdb5UEB+msLlfOa40Ydl7y2171xgQQxCg3WJv6Oj/0iSKjOo7oFDUX+sVlUPovuDSCuNHx2Buyzf8XWwZLvhuomy5sIA8DcZF3teGOCr4d6sNgM+D8ABZR2KRri+RhZ58n5OpqXbPsL25Eoth/83auhu6jNjPl0EHVVbvBuz4WkOFNvzxsw5N+s9yfuhnwdR0FtzDoVyNMQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjo3jHJUaPVCDIDChMHZfkkHQVHe+wgFqItb2JmL7wzQRyyIOWkgr4EQiXRcD1KHbjgu5oHzqDv5FxWZF8PNCbzY5WfbNCyVy1RfpCw8lhWiSisbWDnXDSEh8pdqzsbYLNEScOxWGIWqFt7VS5oHhUeQF4ZXx2Bf37d9NzhqOMg/223cvqx9EAWl0r/S8/tD9JFOk+wBoJT7tSCWegVEAFaMwrTNuGYKRwHOINByBejUA9Yyka/hQ1r3DvY+k1aP51Pp3qWGIBdpqSq8coOfLhw6ozso6oFgvjYPfemi549qBxblWb1TEIpbDds+ea3S9mxlGP9EAh4F2700ri75Hg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5qKp4b0m35g1WMx2QRi9Yo9K7x3b1B5xnTqmjaLxKw=;
 b=K12HRz02tMyOWW5FElrQ6veZFNesObZCtAaZ/3RbOl/oVF55ly1TDD/WnD16BcVmeKQpZkZkUsT0rL/T5Tn15j7J82lj3ELIMk8PgRS4DMCN+wOl4s31W3IiAYzXeU+h5PndHyaetE8Ca07GNKSMOonnjoHUrXuDDHClvaciPCx7PXMKiyjMNYy89pTv+GLVLachzcsydF+KUsDuuIwmpdCXMGhsf+pIbolqi3rvBHId3M6qAxz/8pbt8hwHu/dgRVzBEbcKs1orhR7ibjC7+cvLm1t3Xt03J05MPEI7RVkcFpiG1AxfibiorhOmuoYPlP9fnNVCGmcrXhweFskiAA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5qKp4b0m35g1WMx2QRi9Yo9K7x3b1B5xnTqmjaLxKw=;
 b=lAvc6WrY/AXwZUeslxlQBumynUQqe5DYepgK4wrJvlfYXzE/6jY00vhXKeIBW2EHbuqKuTTdw5d8C4kqWhjBr5gnGogklaWnieEf9SgNjZJrm6Mj0527Z9K2QKTMkdYfImd6Ziguq6fwMSHBxP1Z/ojGKMVFY0T5/9/fepNjExY=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: fe7b8a00-2aa5-4c37-f1dd-08d87c1b905c
x-ms-exchange-crosstenant-originalarrivaltime: 29 Oct 2020 15:01:50.0077 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: bb8IBRLjAmnz0psYXntN8Rdd/nf/wzD2+cuvyYwtExVVqc/NkV0INBHoptfe+EfJ1SBXcMFKZMk5d41Yl4/lGg==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB7091
x-originatororg: quicinc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:57:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed by: Taylor Simpson <tsimpson@quicinc.com>

> -----Original Message-----
> From: Qemu-devel <qemu-devel-
> bounces+tsimpson=3Dquicinc.com@nongnu.org> On Behalf Of Richard
> Henderson
> Sent: Tuesday, October 20, 2020 11:52 PM
> To: qemu-devel@nongnu.org
> Cc: alex.bennee@linaro.org
> Subject: [RFC PATCH 01/15] qemu/int128: Add int128_or
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/int128.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/qemu/int128.h b/include/qemu/int128.h
> index 76ea405922..52fc238421 100644
> --- a/include/qemu/int128.h
> +++ b/include/qemu/int128.h
> @@ -58,6 +58,11 @@ static inline Int128 int128_and(Int128 a, Int128 b)
>      return a & b;
>  }
>
> +static inline Int128 int128_or(Int128 a, Int128 b)
> +{
> +    return a | b;
> +}
> +
>  static inline Int128 int128_rshift(Int128 a, int n)
>  {
>      return a >> n;
> @@ -208,6 +213,11 @@ static inline Int128 int128_and(Int128 a, Int128 b)
>      return (Int128) { a.lo & b.lo, a.hi & b.hi };
>  }
>
> +static inline Int128 int128_or(Int128 a, Int128 b)
> +{
> +    return (Int128) { a.lo | b.lo, a.hi | b.hi };
> +}
> +
>  static inline Int128 int128_rshift(Int128 a, int n)
>  {
>      int64_t h;
> --
> 2.25.1
>
>


