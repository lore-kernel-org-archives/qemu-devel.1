Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B017DC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 19:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF0D2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 19:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mBbjjgGK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="sXsYGRDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF0D2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZftj-0001V0-Io
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 14:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1kZfsh-0000xT-LY
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:52:44 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:39145)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1kZfsf-0001Xo-4U
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1604346761; x=1635882761;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=XTop2QzeDiVUcQz5yJzUX2wXTiaerXcLcwNhivBoKYE=;
 b=mBbjjgGKXRx1xfYxfqw/BbBc3IUl+cAxh3QxNpXMSvyn6bMvCxg1Iha/
 04aOki4IPa5juSSouNwVhDhAQ+u/0OnA5E7DjhvSri8pZae2Bxgdz3lxB
 y/EDYVE5QekDDweA05mOwfmQF4ciibESAPkj09SrjcRpSD5YnJG3NKFQG M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Nov 2020 11:52:38 -0800
X-QCInternal: smtphost
Received: from nasanexm03b.na.qualcomm.com ([10.85.0.98])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 02 Nov 2020 11:52:38 -0800
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Nov 2020 11:52:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 2 Nov 2020 11:52:38 -0800
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MW4PR02MB7171.namprd02.prod.outlook.com
 (2603:10b6:303:7d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 19:52:34 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::dda2:8e04:fb37:ea4c]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::dda2:8e04:fb37:ea4c%7]) with mapi id 15.20.3477.035; Mon, 2 Nov 2020
 19:52:34 +0000
From: Stephen Long <steplong@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philippe.mathieu.daude@gmail.com>
Subject: Re: linux-user/elfload.c: Seeing a segfault in qemu with a binary
 with no data section
Thread-Topic: Re: linux-user/elfload.c: Seeing a segfault in qemu with a
 binary with no data section
Thread-Index: AdaxUBSiheknI6L2R5GCXC/d6LxPmg==
Date: Mon, 2 Nov 2020 19:52:34 +0000
Message-ID: <MWHPR0201MB3547FBEE7E70CD8E44AD3C53C7100@MWHPR0201MB3547.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [2606:6000:cfc0:2f:41ec:6160:7613:734c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2951cb1-667e-4971-47ce-08d87f68d7c3
x-ms-traffictypediagnostic: MW4PR02MB7171:
x-microsoft-antispam-prvs: <MW4PR02MB717107C94532DBCFF39C1235C7100@MW4PR02MB7171.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljQ7pTejWjG3+blnZEVGV8QKNRKkWFVvCMTR+qv42YvVOtoNloJ2LA2zn8dGMSQuqAwaWjA+T5Rk0aVbS+8Lkh/rnmYVt5hRFN6aUjzOM5+BBtCRC3bpLoPXDCYOi+YQC7/UDT0WAw2qv6/ssZALFZN6iT9R729/zMyRQUy3QGytSyh+mU1IU9G0ilLRyrv8pfpFoEmXBACOKWl0DZd4IV61phZPMi0Fh5DMqpszKDd4OTppam5DzV2Wa/TEnH5QcW13VuJAnK4BNXfbUxip3PJoc3diTBM/qtex5EWw4YboQamkSAyrMi8yN1bhN/2S22LZYvYrPKjZV10g11fxEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(39860400002)(136003)(376002)(366004)(33656002)(66556008)(86362001)(55016002)(316002)(64756008)(66946007)(66446008)(66476007)(110136005)(71200400001)(54906003)(76116006)(8676002)(7696005)(2906002)(5660300002)(478600001)(6506007)(9686003)(4326008)(52536014)(8936002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: QLq5CvR5BWGV3e/JwHYodVeDuHgZfVjzedSNt0T++D/CBQTqc6PAUXOUkjRZxKQBmz4+nGdp0TuYGWIP3a5lFwJcDldq5LidM8O8t1fpcQzCteTgyZidPafZllec6NahncKCqBTb96RXMsPHGbitDGllSHqwsmpZYxbP2JXkxZDRPmPNli8hUOD5658iLNVS8LSf3+3J+6J80LhQcUjtp7XSL/f41aBLYKgFzBfTx9p1W0aNQ+tJYmLBhh4eZrNZKkA6+TtjuLjogThQcUy2myWF1GDtLIIKaDVsWIX9fyFUPq12ekW/moA+zNstmg4glzMPAbiCCNaze47G4hHYl4xjPomuoJufFjKaI+0Kkq7vfC1DO7HKwSseSLxG33Tc6F6Ep4AfM9CC4g+oKv5j39pIdLyn6nErSijy+1jW80qNGafmoOJCJsJaexTZZbU+4qDnxFjLcqXwSX8EcBZcROIfVXAkSzA/2F5iAc00sgh781927cw+PhWBlkzyHktM6QYXfCkjKRFIp6GfLr7fBvaJ1nWIu4t7IuQGWUkRKUVQrtIivqiKqSy1qPJPbJomT7Je0KBe48thbtlbe15NG2EUkppee5Avtbj9UAUYdT9tFBVrHh0IxhLT4mDbskyQPUKhkh0idx1he9iWIBzMTumCUDxtBfeJqr4+FD9iLTL4mBa9G2W2rUEfPYYqGlKeD+f3ZLfPiqPMGX0p6DlTQg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Roqv7AKNy4xZV3CYei9gtipziMqyytMf24dXdydGh229P/bBb1M3IhboTUBshGtdDn96U8jhEssndWI9atfl3E3mq99m2Gtzo8bGxSzdmOJ6fA4S7njIgzwI6KamdCRUwF21aWhHH86HQNJLuTeUTBa9rD8ixuR0JRuzCxe8GmGZ216/E/smMxQeYe9GeKTorKTGJWxE2XRZ5fOtVMxg9XbhIxpulb0ag3S5Btb5k9qC7vLgt/teSUZHtBrnHJwUFQMDcNCMlhIRNyG+v4sE+bk89Nkpyr5Go98G93MKfj9idQPb7gehK0lCEClPLmutGt01V8TkpMdCI2DuBf/77A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE7QIKppBz831hkZEckiwLYkIhPnkUpKkbqcGaj4OiU=;
 b=b0tuOjKVD74klK+Q37awYgn8PO8U9hf2Fe6N0xn7uGUvOBZVL7L81MEyfKNUERDYw/tcBCC8cSUx2kpElCyzeQs1sYLV6Ke7FYgyZLbOaC1fKDd7pA8aEnjsQqwL5vIXQkDIzJrb8sdPjWgmxIRUIrWe+/E65AFcxUnPTh/s+vEbYZMEszwut/oB/eZGgXrYzB2/bvhXRFAKXLtf1/zz0jpKp/MYQ9fwWNA1m4RUryO/YpNyhDIPum5Sh9HkzIcLPQsAHs80Rgb/1u6yoDGACwI5J1L2F6n3iAIfS21Gix8KXD/6svCzvf1+jCLZnm+h9hzB4Q69MMq5zWv84fIWBg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE7QIKppBz831hkZEckiwLYkIhPnkUpKkbqcGaj4OiU=;
 b=sXsYGRDL3keJGSqaJzZVRhY48r+EVa4SjO1LDWmiKgEHDSn2XxG/mRaQ7TPKVRFvjbAubZ8BXZT5QI70kw1h0op5j4BBkasUUP0xwGpUNRAtunwhbszggEXVeYsdZWZNQFKkHEy7TJ+fIcqkKp9V14znqVmZan9i920MCuaAEQA=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MWHPR0201MB3547.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f2951cb1-667e-4971-47ce-08d87f68d7c3
x-ms-exchange-crosstenant-originalarrivaltime: 02 Nov 2020 19:52:34.5111 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: jSoHm0qaVq41G1BelRdM1WjZ7kSbD8YItkcmIKGEkLY4CV5J6yWADTFeWcecX6zNMt6o/NCH4yiaYBftFPFc0A==
x-ms-exchange-transport-crosstenantheadersstamped: MW4PR02MB7171
x-originatororg: quicinc.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 14:52:39
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Ben Hutchings <ben@decadent.org.uk>,
 "laurent@vivier.eu" <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I think that a variant of that patch made it into master:

            /*
             * Some segments may be completely empty without any backing fi=
le
             * segment, in that case just let zero_bss allocate an empty bu=
ffer
             * for it.
             */
            if (eppnt->p_filesz !=3D 0) {
                error =3D target_mmap(vaddr_ps, vaddr_len, elf_prot,
                                    MAP_PRIVATE | MAP_FIXED,
                                    image_fd, eppnt->p_offset - vaddr_po);

                if (error =3D=3D -1) {
                    goto exit_perror;
                }
            }

            vaddr_ef =3D vaddr + eppnt->p_filesz;

In the case of my elf, it is letting zero_bss() allocate the empty buffer. =
But since there is no data segment before it, the memset in zero_bss() segf=
aults. zero_bss()'s mapping starts at host_map_start.
Here's the output of "readelf -l" on my elf:

Elf file type is EXEC (Executable file)
Entry point 0x2102e8
There are 8 program headers, starting at offset 64

Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz  Me=
mSiz   Flg Align
  PHDR           0x000040 0x0000000000200040 0x0000000000200040 0x0001c0 0x=
0001c0 R   0x8
  LOAD           0x000000 0x0000000000200000 0x0000000000200000 0x0002e4 0x=
0002e4 R   0x10000
  LOAD           0x0002e8 0x00000000002102e8 0x00000000002102e8 0x000c88 0x=
000c88 R E 0x10000
  LOAD           0x000f70 0x0000000000220f70 0x0000000000220f70 0x000068 0x=
000068 RW  0x10000
  LOAD           0x000fd8 0x0000000000230fd8 0x0000000000230fd8 0x000000 0x=
000278 RW  0x10000
  GNU_RELRO      0x000f70 0x0000000000220f70 0x0000000000220f70 0x000068 0x=
000090 R   0x1
  GNU_EH_FRAME   0x000224 0x0000000000200224 0x0000000000200224 0x00002c 0x=
00002c R   0x4
  GNU_STACK      0x000000 0x0000000000000000 0x0000000000000000 0x000000 0x=
000000 RW  0

 Section to Segment mapping:
  Segment Sections...
   00
   01     .rodata .eh_frame_hdr .eh_frame
   02     .text .init .fini
   03     .init_array .got
   04     .bss
   05     .init_array .got
   06     .eh_frame_hdr
   07

