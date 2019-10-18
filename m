Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A62CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A6E21852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gJ1OJLhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A6E21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUGO-0002pI-PF
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron@os.amperecomputing.com>) id 1iLUF3-0001o7-84
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1iLUF1-0003zL-Vd
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:32:36 -0400
Received: from mail-eopbgr780100.outbound.protection.outlook.com
 ([40.107.78.100]:28919 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1iLUF1-0003xG-JQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:32:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlgWNvK7Kk/n8CMS1L/sDpMLx65ww5qCGygUKT21o8RstOM3WE37TCIeov6sOLvMkYMfi/U2SuyafcW5n+S1MHSbUNDm/6kiC35LdukvZ1zUqJPzJYyE5WoVt0DHxIiZtM1Ns6btB60VEIEm8WL2N9pokbevI6SzdzqIBU0UO/XtfZowma1Vd8YrSbxQop6wcjmgvnc1rA3mLO5Waf7juneG8FCHXH0trge7ueqBYWNK4TfZq72FFvgAy9guaALznXdIPLPyz+AtpbV0rxM7fslVe3XWQkkYt/O1SboLUHtkI9QduLedaN9806AbxshvNiO45L17W9kLKO0z2XfeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8JeXCc5LTzECh8MLDcdqVA22M9tlQBEfGJRx2iTIW0=;
 b=OYGbaTI5oDjXmkKUOA9ovw20Kqorj29yj7J1FsUGjKV+5i6CjKAFjfa/A+uisgDDQPP6yScQnpIHaDK7iNtiIGRpBsy2ESRH5/o1FB4hZXP1WGvgI2w6okrEQ9ZjS6YBSefvPU+sL5lYKIFrqM7vEEhz5nGmzpRC3qi9FL+qY3x591DAolcFXfk2iP9snVkIVexaNRibXrq0l1ue7pQ8wY7C/oSJuraiv7kA+RLaUOySMTbbDG36ncHeuPBuIWU0Z6gURneBOPsUqQARUeSIRGpUkeAGgaraT8gPm+aPbAwhEwJichWQNRNozhqItrGDxFg99n83nbQCSNptoi84og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8JeXCc5LTzECh8MLDcdqVA22M9tlQBEfGJRx2iTIW0=;
 b=gJ1OJLhBFfHhlvfrEqMMuaXVmyy+dMKClu162v4HVjYJ9sEHBoAhpfezNUOJz6eNBanwUiTX8VtwCaD3cNPxGp4fS/+UQsb3m0vwLn1R1GOzhDIYQCfu+afOyEhFAewV3FyYc4Qcq7+crgtokJWe4AG9svtdavK3Y8viOMLCk1E=
Received: from DM6PR01MB6027.prod.exchangelabs.com (52.132.249.89) by
 DM6PR01MB4363.prod.exchangelabs.com (20.177.221.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 18 Oct 2019 15:32:30 +0000
Received: from DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::3029:7c3:24fc:bb60]) by DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::3029:7c3:24fc:bb60%7]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 15:32:30 +0000
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "cota@braap.org"
 <cota@braap.org>, "peter.puhov@futurewei.com" <peter.puhov@futurewei.com>,
 "robert.foley@futurewei.com" <robert.foley@futurewei.com>
Subject: Re: [PATCH  v6 37/54] plugin: expand the plugin_init function to
 include an info block
Thread-Topic: [PATCH  v6 37/54] plugin: expand the plugin_init function to
 include an info block
Thread-Index: AQHVhO5ZtkD22KgDqEOJovKpMAx4f6dgiJEA
Date: Fri, 18 Oct 2019 15:32:29 +0000
Message-ID: <20191018153214.GE42857@RDU-FVFX20TUHV2H>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
 <20191017131615.19660-38-alex.bennee@linaro.org>
In-Reply-To: <20191017131615.19660-38-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR2201CA0033.namprd22.prod.outlook.com
 (2603:10b6:910:3e::22) To DM6PR01MB6027.prod.exchangelabs.com
 (2603:10b6:5:1da::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64c11447-bf92-41af-1d47-08d753e06324
x-ms-traffictypediagnostic: DM6PR01MB4363:
x-microsoft-antispam-prvs: <DM6PR01MB43630A76C27B05B4C193C7008A6C0@DM6PR01MB4363.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(4636009)(136003)(376002)(366004)(39850400004)(396003)(346002)(54094003)(199004)(189003)(54906003)(64756008)(66946007)(6486002)(66556008)(486006)(478600001)(6436002)(9686003)(66446008)(66066001)(256004)(71200400001)(71190400001)(476003)(229853002)(66476007)(6916009)(14454004)(316002)(446003)(11346002)(14444005)(25786009)(52116002)(99286004)(76176011)(33656002)(102836004)(4326008)(186003)(6506007)(386003)(6246003)(26005)(8676002)(66574012)(7736002)(5660300002)(6512007)(305945005)(1076003)(8936002)(81166006)(81156014)(2906002)(86362001)(3846002)(33716001)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB4363;
 H:DM6PR01MB6027.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Ztwv/tkWNt/jX8QJS5hB3WWoAafMN81jlU10kynpDBSiHlF9CBDd9h75Zp61tHfsFScKGKzLfbjT/HIe7LoIWitI5cchzp+DzOuTkOmUdZRkmRMwIcAoOWrQ3bUhQ4auOGitKhkp8We47c7uzh482YtT/MWLRw27oE6RMsejd0nPVy5vHtQTTklfQqJumi4TMToik6sT7ZOAiDRs3msh0MCZZSQoPoRf+gcbG8FOKrRpepOPd/q3mLzZLD2U3byEYwTCigJoyiMxTKAdn5K5HS3gCaY6W1WKXSXOqDZz4xIEaHKqOQ7Vl39u+UtsCdEIZ9FZstIVqTqkbrLf+FTDtIePK/SBrJG0V0h68isgUQVRHoQERbQe1AI5oIYMCkswzqjsDEZ/7yI/6VnfJF+usnyU/P9qMAVmw4e+Oxy5HQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5D9BBC08D3D38F4E8398FFD373BB2810@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c11447-bf92-41af-1d47-08d753e06324
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 15:32:29.9863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPYhjeRSp77CmRPdVIOgmpJ75l1dasAMZFPVhy/+Ugo6Qeop+XTnBg1E2JVEPgaUxv9dIu8ztoqjVIhJjqOL6CFfPkqoK0Uo4ZDo+JyT0MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4363
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.100
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Oct 17 14:15, Alex Benn=E9e wrote:
> This provides a limited amount of info to plugins about the guest
> system that will allow them to make some additional decisions on
> setup.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ---
> v6
>   - split and move to pre example plugins
>   - checkpatch fixes
> ---
>  include/qemu/qemu-plugin.h | 26 ++++++++++++++++++++++++--
>  plugins/loader.c           | 23 +++++++++++++++++++----
>  2 files changed, 43 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c213d1dd19..784f1dfc3d 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -38,9 +38,27 @@
> =20
>  typedef uint64_t qemu_plugin_id_t;
> =20
> +typedef struct {
> +    /* string describing architecture */

Might be worth noting that this is set to the value of TARGET_NAME qemu
was built with, and pointing to documentation about the possible values
it may hold.

> +    const char *target_name;
> +    /* is this a full system emulation? */
> +    bool system_emulation;

It seems that 'system_emulation' is meant primarily in opposition to
user-mode. I'm wondering if this could/should this be an enum of the
execution mode being used to allow for future expansion? Or, if your
intention here is mostly to allow the user to detect when the *_vcpus
variables are valid, could it be renamed or commented differently to
make that link more clear?

> +    union {
> +        /*
> +         * smp_vcpus may change if vCPUs can be hot-plugged, max_vcpus
> +         * is the system-wide limit.
> +         */
> +        struct {
> +            int smp_vcpus;
> +            int max_vcpus;
> +        } system;
> +    };
> +} qemu_info_t;

[...]

> @@ -241,11 +245,22 @@ static void plugin_desc_free(struct qemu_plugin_des=
c *desc)
>  int qemu_plugin_load_list(QemuPluginList *head)
>  {
>      struct qemu_plugin_desc *desc, *next;
> +    g_autofree qemu_info_t *info =3D g_new0(qemu_info_t, 1);
> +
> +    info->target_name =3D TARGET_NAME;
> +#ifndef CONFIG_USER_ONLY
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    info->system_emulation =3D true;
> +    info->system.smp_vcpus =3D ms->smp.cpus;
> +    info->system.max_vcpus =3D ms->smp.max_cpus;
> +#else
> +    info->system_emulation =3D false;

Thinking "out loud" here - I wonder if it would be helpful to set the
*_vcpus variables even for user mode here. It might allow unconditional
allocation of "per-cpu" structures that the plugin might need - without
first needing to check whether the *_vcpus variables were valid.

-Aaron

