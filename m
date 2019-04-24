Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F1C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6B7218FD
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="gNsx2PA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6B7218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJINn-0001Zp-Ah
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 09:56:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJILr-0008Qs-9z
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJIKY-0006Oh-3n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:52:59 -0400
Received: from mail-eopbgr700136.outbound.protection.outlook.com
	([40.107.70.136]:35553
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hJIKX-0006NA-R4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tQFPwKkU+dk3BIWLkz7pnlQkZ4XAm7T+A2S/m6xmKdE=;
	b=gNsx2PA8fDDHwgDmIvNenD5sXwonBZcwfMyzqGM9v5MhvLMArjmB7Y67GFMEnYYxZc25pUsU7Jgv9bNCd8c/iH+KBYzo4C9+IIOeLmghRlhj4qNIzVPosqCIjTJg7FSotlR0jTe55D1MnCS7C/SsSfXfArNGtQPHEBDxp4+abyE=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1729.namprd22.prod.outlook.com (10.161.158.157) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Wed, 24 Apr 2019 13:52:54 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8%8]) with mapi id 15.20.1835.010;
	Wed, 24 Apr 2019 13:52:54 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 4/5] linux-user: setsockopt(): Add support for the
	option IPV6_ADD_MEMBERSHIP
Thread-Index: AQHU+p1i8hCRnL/4Mki1onyPDynDdaZLUtwq
Date: Wed, 24 Apr 2019 13:52:53 +0000
Message-ID:
 <BN6PR2201MB125182A9057BB508EDD06DFDC63C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1556110623-655-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556110623-655-5-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8951b095-619e-4a7a-c25c-08d6c8bc2641
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1729; 
x-ms-traffictypediagnostic: BN6PR2201MB1729:
x-microsoft-antispam-prvs: <BN6PR2201MB1729E30144DCDDD6DFEE1E71C63C0@BN6PR2201MB1729.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(52536014)(6436002)(66066001)(71190400001)(66446008)(2501003)(81156014)(256004)(81166006)(4326008)(53546011)(86362001)(6506007)(76116006)(76176011)(66556008)(66946007)(64756008)(5660300002)(8676002)(25786009)(14454004)(71200400001)(2906002)(91956017)(8936002)(66476007)(73956011)(97736004)(476003)(68736007)(107886003)(6116002)(7696005)(55016002)(316002)(305945005)(186003)(110136005)(7736002)(54906003)(3846002)(486006)(102836004)(9686003)(229853002)(478600001)(11346002)(55236004)(446003)(33656002)(26005)(99286004)(74316002)(53936002)(6246003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1729;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZgDr0iPOtCIaPOEKWaFZO2SVopp45Nxyip3p8dEXQHOOQz1uG9ceolGbdh7x5PZPWKl7RpjjCdfqo0iBWraqqLMWMisudbJJqm7DTIKUlvqaJqWG3054W/KHXgj3bILdC3oUJF4jzVMRRljFQHhkJ4fioXBpg1iAnfAG6omAD4Aes0j4fqOFUEQusIDa8fFk9TTRKal1yd2a+EcP43ipj2IoqgHY75+R1v4bfsKcwnVv0zEuJHtsmEJoWwlb11PXle9gX5I2JbOD8VEmxfedCoIFNbp/Tpnlmob8GA9RK/PRKxDQ+dEZe7iN/VEpJ/AtKdtpRM+ks5+mBTwNGRX1eIgEfU6kZhER286e4ZH01fZDelW9qd5f4KIErvy+8Hq2oXEZd/3KjwPIeMVhTnuPVdRh80XiuG8MCUqaF0b3GcM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8951b095-619e-4a7a-c25c-08d6c8bc2641
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 13:52:54.0103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1729
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.136
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user: setsockopt(): Add
 support for the option IPV6_ADD_MEMBERSHIP
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
	"thuth@redhat.com" <thuth@redhat.com>,
	"jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"daniel.santos@pobox.com" <daniel.santos@pobox.com>,
	Neng Chen <nchen@wavecomp.com>, "philmd@redhat.com" <philmd@redhat.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424135253.mhPyz4H2F4hJb0_IN8j48vr-mca9jiIjGFKDgVBgm78@z>

>=20
> ________________________________________
> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, April 24, 2019 2:57 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo; daniel.=
santos@pobox.com; jcmvbkbc@gmail.com; lvivier@redhat.com; thuth@redhat.com;=
 philmd@redhat.com; Neng Chen
> Subject: [PATCH v2 4/5] linux-user: setsockopt(): Add support for the opt=
ion IPV6_ADD_MEMBERSHIP
>=20


Hello, Loraine,


I am just a submitter for this patch (the author is my colegue
Neng Chen), and I see that this patch really fills in some missing
functionality in linux-user, however I would like to ask you for
your opinion on the following:

1) Should the field ipv6mr_multiaddr also be subject to some
big/little endian conversion, or the current solution is sufficient?

2) Should we complete setsockopt() functionality with other remaining
not implemented options at this moment, while we are already on
implementing IPV6_ADD_MEMBERSHIP support?

Thanks,
Aleksandar


> From: Neng Chen <nchen@wavecomp.com>
>=20
> Add support for the option IPV6_ADD_MEMBERSHIP of the syscall
> setsockopt(). This option controls membership in multicast groups.
> Argument is a pointer to a struct ipv6_mreq, which is in turn defined
> in a platform-inedependant manner in the Linux kernel file
> include/uapi/linux/in6.h as:
>=20
> The <netinet/in.h> header defines the ipv6_mreq structure, which
> includes the following members:
>=20
> struct in6_addr ipv6mr_multiaddr  /* IPv6 multicast address   */
> unsigned int    ipv6mr_interface  /* local interface index    */
>=20
> struct ipv6_mreq {
>     /* IPv6 multicast address of group */
>     struct in6_addr  ipv6mr_multiaddr;
>=20
>     /* local IPv6 address of interface */
>     int              ipv6mr_ifindex;
> };
>=20
> The <netinet/in.h> header also defines the in6_addr structure,
> which a union of the following structure:
>=20
> struct in6_addr {
>     union {
>         __u8    u6_addr8[16];
>         __be16  u6_addr16[8];
>         __be32  u6_addr32[4];
>     } in6_u;
>=20
> The emulation behavior of IPV6_ADD_MEMBERSHIP is devised based on
> the definitions above.
>=20
> Signed-off-by: Neng Chen <nchen@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 96cd4bf..b47a45d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1892,6 +1892,24 @@ static abi_long do_setsockopt(int sockfd, int leve=
l, int optname,
>                                         &pki, sizeof(pki)));
>              break;
>          }
> +        case IPV6_ADD_MEMBERSHIP:
> +        {
> +            struct ipv6_mreq ipv6mreq;
> +
> +            if (optlen < sizeof(ipv6mreq)) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            if (copy_from_user(&ipv6mreq, optval_addr, sizeof(ipv6mreq))=
) {
> +                return -TARGET_EFAULT;
> +            }
> +
> +            ipv6mreq.ipv6mr_interface =3D tswap32(ipv6mreq.ipv6mr_interf=
ace);
> +
> +            ret =3D get_errno(setsockopt(sockfd, level, optname,
> +                                       &ipv6mreq, sizeof(ipv6mreq)));
> +            break;
> +        }
>          default:
>              goto unimplemented;
>          }
> --
> 2.7.4
>=20
> =

