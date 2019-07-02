Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90852C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B0420665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IWimGB+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B0420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJTF-0005Iz-EN
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hiJRR-0004LS-Bs
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hiJRQ-0002Sg-7j
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:07:29 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com
 ([40.107.69.116]:53625 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1hiJRP-0002PZ-RE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo4g1XDYk+gjqIQeWHNRqfkRkCuU8WLBdxzSED1v72U=;
 b=IWimGB+YtLwg5ixhP6IRFxqX2WmKcC/XUbLv3NiwJrvw7yLYpeLPebtXCzzG5wTrYrljcasLtuaE4HTxw8ynQoTVaZFHrA87QQkRQdOUjbp54r68ktoKfJOiItfUFqrpxvce+rWcY+l7PahsYF6VyoBLoR+Aqxv6hBZVyVUn+jY=
Received: from BYAPR01MB4824.prod.exchangelabs.com (20.177.226.222) by
 BYAPR01MB4440.prod.exchangelabs.com (20.177.229.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 14:07:23 +0000
Received: from BYAPR01MB4824.prod.exchangelabs.com
 ([fe80::c9bf:d1e8:ad72:5288]) by BYAPR01MB4824.prod.exchangelabs.com
 ([fe80::c9bf:d1e8:ad72:5288%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 14:07:23 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument memory
 accesses
Thread-Index: AQHVIt11hLjmFwnAA0W4zaK1l+4xhaaxRysAgAAcDgCAAA0TAIAAML6AgARO/oCAAAWVAIABg5OA
Date: Tue, 2 Jul 2019 14:07:23 +0000
Message-ID: <20190702140719.GB5002@quinoa.localdomain>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-20-alex.bennee@linaro.org>
 <20190628153044.GB26345@quinoa.localdomain>
 <87mui1ab4j.fsf@zen.linaroharston>
 <20190628175756.GC26345@quinoa.localdomain>
 <87lfxla0vs.fsf@zen.linaroharston> <20190701144009.GA5002@quinoa.localdomain>
 <877e91ssuf.fsf@zen.linaroharston>
In-Reply-To: <877e91ssuf.fsf@zen.linaroharston>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:903:102::14) To BYAPR01MB4824.prod.exchangelabs.com
 (2603:10b6:a03:8d::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c3dfb89-9120-4ff6-90de-08d6fef69a96
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BYAPR01MB4440; 
x-ms-traffictypediagnostic: BYAPR01MB4440:
x-microsoft-antispam-prvs: <BYAPR01MB4440D9420AA622ED5C7AA54C8AF80@BYAPR01MB4440.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(396003)(39840400004)(376002)(366004)(189003)(199004)(26005)(66066001)(386003)(486006)(186003)(256004)(446003)(99286004)(476003)(478600001)(6916009)(6506007)(102836004)(76176011)(14454004)(5660300002)(64756008)(6246003)(25786009)(66476007)(11346002)(1076003)(73956011)(66556008)(66446008)(66946007)(53936002)(86362001)(8676002)(6436002)(8936002)(6486002)(9686003)(6116002)(229853002)(81166006)(305945005)(81156014)(3846002)(7736002)(6512007)(4326008)(2906002)(68736007)(71190400001)(52116002)(71200400001)(316002)(54906003)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR01MB4440;
 H:BYAPR01MB4824.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cIb2Yh5MGbUxP4MVnBxZdFhmCgtU/4iUCQKtkLCJEYn3U63RcKBMTbBpZ6skhSCUqQ+KKJ+Ho83b+QPkpj467EYFQ7SL/E3xuiscHj7n5Wg77W5hwasu6GK+Fkc/NTcZefTDFtZBBB4mw22X8gObqioRsIClPSH/Pm6jIwwUtTbIEQQtCN7X3yTPcREHZXB/rTg1Tsuwhp7+IJQI0L8swv6TKVytFsWQWokszGYSadzR5wFQciT7/kq3Xml/I42Dk/5BfPZsnFQangSyki1KSPaoJ0x6Yb3NiCzgRC2pXNKPlvg/w/BcH0TyoEW6h6nqn5dFSqtIn7Py/TMWl+wiSlO7W5Lxdr+ZUa/bKqYarAmzuGsIgAHZvD6zOQwBFgaBIvRdRmWq+cOLm6yjUY1/PP4jJR5ldKgpGVwPhHDP2wY=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7744BB4F844369429801783FF308B7AD@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3dfb89-9120-4ff6-90de-08d6fef69a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 14:07:23.4059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aaron@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4440
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.116
Subject: Re: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument
 memory accesses
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
From: Aaron Lindsay OS via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 01 16:00, Alex Benn=E9e wrote:
> Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:
> > - a way for a plugin to reset any instrumentation decisions made in the
> >   past (essentially calls `tb_flush(cpu);` under the covers). We found
> >   this critical for plugins which undergo state changes during the
> >   course of their execution (i.e. watch for event X, then go into a mor=
e
> >   detailed profiling mode until you see event Y)
>=20
> check:
>=20
> /**
>  * qemu_plugin_reset() - Reset a plugin
>  * @id: this plugin's opaque ID
>  * @cb: callback to be called once the plugin has been reset
>  *
>  * Unregisters all callbacks for the plugin given by @id.
>  *
>  * Do NOT assume that the plugin has been reset once this function return=
s.
>  * Plugins are reset asynchronously, and therefore the given plugin recei=
ves
>  * callbacks until @cb is called.
>  */
> void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);

Is this essentially synchronous for the current cpu, and only
asynchronous for any other running cpus that didn't trigger the callback
from which the call to qemu_plugin_reset() is being made? If not, could
the state resetting be made synchronous for the current cpu (even if the
callback doesn't happen until the others are complete)? This isn't
absolutely critical, but it is often nice to begin capturing precisely
when you mean to.

> > - the ability for a plugin to trigger a checkpoint to be taken
>=20
> We don't have this at the moment. Pranith also mentioned it in his
> review comments. I can see its use but I suspect it won't make the
> initial implementation given the broader requirements of QEMU to do
> checkpointing and how to cleanly expose that to plugins.

Sure. Our patch works for us, but I know we're ignoring a few things
that we can externally ensure won't happen while we're attempting a
checkpoint (i.e. migration) that may have to be considered for something
upstream.

-Aaron

