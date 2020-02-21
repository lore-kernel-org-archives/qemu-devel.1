Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AFFC35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B74820722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sG7e3mQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B74820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54Ur-000519-9L
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j54U9-00048F-FZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j54U7-0006Xw-H0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:20:37 -0500
Received: from mail-eopbgr80135.outbound.protection.outlook.com
 ([40.107.8.135]:52011 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j54U2-0006Ix-7K; Fri, 21 Feb 2020 04:20:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW3c0ZcbcDBsNha3b7DSRfO8eAoooSLiwTZbGXell4xNtKlxq+BCbBgRKD0KjXIkE2u7VY9b7fRXrjHlyqjGhKXEpqCBi3hIk11/r1B4tBWcKuZbV4BHfEtaySo8cRJPmqd/Ri357sSVlmsynIgSyLpHKX26YRiTTOXOpmFuOvURRnAS4/V7HWLYeL5QF+z928qMFU80gxsKM0V2YUlE0JfRdTTPFhFEsxmIX2Pwq9h3Qnh/o0mfai3QqdUyLUSpsnal+NZYT8bai2wCz29mKPnfHVgYqvwJOMzD6WxKUTHukfSvaUmmGJ6yVNhf/dBA7HHPsUxQdgUFqxLIroimjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8e8mK6l/eNKcbrCSO+7HgeScRc2NkPJymKlNWEHxEY=;
 b=mCilWxW8QzRPjE0OTJrNZLpjmuooSXw03aoJSgRGrBCTF/l3bZTvl9OuzpxiObVdmjzWCFrdOMTfsQrSUOBMM+ostjeyc+dYy/Vq7cVxkY+rywgBEBWtJPZrDIwatHK1tTOgszNi1l15wq9imt0PxCh4JqXV1XYihgvnMyn+Hy6mw2t8wXZ2Y+Dx5gf7SMEQ/ss+mGs+bhIyjbO/kwAdzZcO+WNKZLgqPAitD/Ng3ItSw44zkTJcKxb8YDdTp6oOuDDBpsdcVpaGiKnPwjBkGwdiofAmGmRQZQtoGCRS2InoOp1WRrWOksByiXNb+qtIS/nZ/1ofUumO/TM/X8nkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8e8mK6l/eNKcbrCSO+7HgeScRc2NkPJymKlNWEHxEY=;
 b=sG7e3mQFCO8/+RxamXvX52FVYBL3R7Tnx0bDGJIv6AwWUEzsKUcedgCV1HgebN9hGWT0v+M5YoqzZSpdZFkL4E+TNpo1D/tgOfr3+Gs4RJ87709afvgZu46VZVvlDm6Y8FqXOilyiIcelQku8VasNfs6lMktQp8pC6mRJ58HUis=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB2965.eurprd08.prod.outlook.com (52.135.165.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Fri, 21 Feb 2020 09:20:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Fri, 21 Feb 2020
 09:20:26 +0000
Subject: Re: [PATCH v7 01/11] qapi/error: add (Error **errp) cleaning APIs
To: Markus Armbruster <armbru@redhat.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-2-vsementsov@virtuozzo.com>
 <87d0a88k6d.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200221122023695
Message-ID: <7856fcbb-8c01-aba3-a11b-63058c117362@virtuozzo.com>
Date: Fri, 21 Feb 2020 12:20:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87d0a88k6d.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::28)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 09:20:25 +0000
X-Tagtoolbar-Keys: D20200221122023695
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 494ead8a-9763-42dd-0ae6-08d7b6af495f
X-MS-TrafficTypeDiagnostic: AM6PR08MB2965:
X-Microsoft-Antispam-PRVS: <AM6PR08MB2965BE73DAE7255ADC23AA40C1120@AM6PR08MB2965.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(366004)(39840400004)(136003)(189003)(199004)(31686004)(52116002)(54906003)(16576012)(478600001)(316002)(5660300002)(36756003)(7416002)(86362001)(956004)(66556008)(8676002)(6916009)(8936002)(31696002)(6486002)(2616005)(66946007)(16526019)(66476007)(81166006)(186003)(4326008)(81156014)(2906002)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2965;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltmDJz6WYRGafhGew6UanNoaKup5VU4uIGU8zNhNLHdzNfqLiFMXybjt0pvFKhk/BgVrxm/rKo0XV6CcMrU8P+0iIP2fdJR64J358PZD0HWlyqF5Gi14BhaZmuXZyHlLt/q1cc3CTRrpRYkYikm8YV9nc5sedIiLrfh1/f5m3s9trJ2Ab48/QyjbTe5TisEbCmpuFz2RKn2szwMlAn598YnTF7y1kP4BIQgvpOleomJWXf2LTWmOkluSJpuxoC4BV2hG9wrodcgueIARKhOe2x2A+ZOQLIIRgzClTtZe0dh3auLPqW/u6WMBncKmqADoUku32nxuSZAyPRo4Sh31KRc9R3Nhuv+5Fcvbmu8Pi2NhpiqMQjcrNmK2xxsr1OgZY6Nb+uR9SuHk2AB51fzaxCw6siOslNJE+kyiS+ZNfuvVhKWZZ5SW78a/8OsSah/Y
X-MS-Exchange-AntiSpam-MessageData: 8ny6+Jv4tU+b1a9BoNyG8Ldv8la9SciOsNGqfeq/xDJUEKlnlY6zB4CUXQhQbn78lynoLdj4kShmE1gZ7JaBhuSn4r7xK+VX+H+1ET995I/I/cQL1cBQCKDmbtP/1SFRHz6TSynWyOvwAKz/81ZMOw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494ead8a-9763-42dd-0ae6-08d7b6af495f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 09:20:26.5220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NthSav3gfmIJms5I2wIwth7MNgGVXhAcXHjoiEExrvNRq5BqTacTfRb1A+0eT7EweC0KIgaU6Riw8y0BEKzYlb1hSXKeYdZeZZt4tu8vr6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2965
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.135
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.02.2020 10:38, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> Add functions to clean Error **errp: call corresponding Error *err
>> cleaning function an set pointer to NULL.
>>
>> New functions:
>>    error_free_errp
>>    error_report_errp
>>    warn_report_errp
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Greg Kurz <groug@kaod.org>
>> CC: Stefano Stabellini <sstabellini@kernel.org>
>> CC: Anthony Perard <anthony.perard@citrix.com>
>> CC: Paul Durrant <paul@xen.org>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> CC: Laszlo Ersek <lersek@redhat.com>
>> CC: Gerd Hoffmann <kraxel@redhat.com>
>> CC: Stefan Berger <stefanb@linux.ibm.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
>> CC: qemu-block@nongnu.org
>> CC: xen-devel@lists.xenproject.org
>>
>>   include/qapi/error.h | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index ad5b6e896d..d34987148d 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -309,6 +309,32 @@ void warn_reportf_err(Error *err, const char *fmt, =
...)
>>   void error_reportf_err(Error *err, const char *fmt, ...)
>>       GCC_FMT_ATTR(2, 3);
>>  =20
>> +/*
>> + * Functions to clean Error **errp: call corresponding Error *err clean=
ing
>> + * function, then set pointer to NULL.
>> + */
>> +static inline void error_free_errp(Error **errp)
>> +{
>> +    assert(errp && *errp);
>> +    error_free(*errp);
>> +    *errp =3D NULL;
>> +}
>> +
>> +static inline void error_report_errp(Error **errp)
>> +{
>> +    assert(errp && *errp);
>> +    error_report_err(*errp);
>> +    *errp =3D NULL;
>> +}
>> +
>> +static inline void warn_report_errp(Error **errp)
>> +{
>> +    assert(errp && *errp);
>> +    warn_report_err(*errp);
>> +    *errp =3D NULL;
>> +}
>> +
>> +
>>   /*
>>    * Just like error_setg(), except you get to specify the error class.
>>    * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
>=20
> These appear to be unused apart from the Coccinelle script in PATCH 03.
>=20
> They are used in the full "[RFC v5 000/126] error: auto propagated
> local_err" series.  Options:
>=20
> 1. Pick a few more patches into this part I series, so these guys come
>     with users.

It needs some additional effort for this series.. But it's possible. Still,
I think that we at least should not pull out patches which should be in
future series (for example from ppc or block/)..

Grepping through v5:
  for x in {warn_report_errp,error_report_errp,error_free_errp}; do echo =
=3D=3D $x =3D=3D; git grep -l $x | grep -v coccinelle | grep -v 'error\.h';=
 echo; done
=3D=3D warn_report_errp =3D=3D
block/file-posix.c
hw/ppc/spapr.c
hw/ppc/spapr_caps.c
hw/ppc/spapr_irq.c
hw/vfio/pci.c
net/tap.c
qom/object.c

=3D=3D error_report_errp =3D=3D
hw/block/vhost-user-blk.c
util/oslib-posix.c

=3D=3D error_free_errp =3D=3D
block.c
block/qapi.c
block/sheepdog.c
block/snapshot.c
blockdev.c
chardev/char-socket.c
hw/audio/intel-hda.c
hw/core/qdev-properties.c
hw/pci-bridge/pci_bridge_dev.c
hw/pci-bridge/pcie_pci_bridge.c
hw/scsi/megasas.c
hw/scsi/mptsas.c
hw/usb/hcd-xhci.c
io/net-listener.c
migration/colo.c
qga/commands-posix.c
qga/commands-win32.c
util/qemu-sockets.c

What do you want to add?

>=20
> 2. Punt this patch to the first part that has users, along with the
>     part of the Coccinelle script that deals with them.

But coccinelle script would be wrong, if we drop this part from it. I think=
,
that after commit which adds coccinelle script, it should work with any fil=
e,
not only subset of these series.

So, it's probably OK for now to drop these functions, forcing their additio=
n if
coccinelle script will be applied where these functions are needed. We can,=
 for
example comment these three functions.

Splitting coccinelle script into two parts, which will be in different seri=
es will
not help any patch-porting processes.

Moreover, this will create dependencies between future series updating othe=
r files.

So, I don't like [2.]..

>=20
> 3. Do nothing: accept the functions without users.

OK for me)

>=20
> I habitually dislike 3., but reviewing the rest of this series might
> make me override that dislike.
>=20

----------------

same grep with maintainers:
  for x in {warn_report_errp,error_report_errp,error_free_errp}; do echo =
=3D=3D $x =3D=3D; git grep -l $x | grep -v coccinelle | grep -v 'error\.h' =
| while read f; do echo $f; ./scripts/get_maintainer.pl -f --no-rolestats $=
f | grep -v 'qemu-block\|qemu-devel' | sed -e 's/^/   /'; done; echo; done
=3D=3D warn_report_errp =3D=3D
block/file-posix.c
    Kevin Wolf <kwolf@redhat.com>
    Max Reitz <mreitz@redhat.com>
hw/ppc/spapr.c
    David Gibson <david@gibson.dropbear.id.au>
    qemu-ppc@nongnu.org
hw/ppc/spapr_caps.c
    David Gibson <david@gibson.dropbear.id.au>
    qemu-ppc@nongnu.org
hw/ppc/spapr_irq.c
    David Gibson <david@gibson.dropbear.id.au>
    qemu-ppc@nongnu.org
hw/vfio/pci.c
    Alex Williamson <alex.williamson@redhat.com>
net/tap.c
    Jason Wang <jasowang@redhat.com>
qom/object.c
    Paolo Bonzini <pbonzini@redhat.com>
    "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
    Eduardo Habkost <ehabkost@redhat.com>

=3D=3D error_report_errp =3D=3D
hw/block/vhost-user-blk.c
    "Michael S. Tsirkin" <mst@redhat.com>
    Kevin Wolf <kwolf@redhat.com>
    Max Reitz <mreitz@redhat.com>
util/oslib-posix.c
    Paolo Bonzini <pbonzini@redhat.com>

=3D=3D error_free_errp =3D=3D
block.c
    Kevin Wolf <kwolf@redhat.com>
    Max Reitz <mreitz@redhat.com>
block/qapi.c
    Markus Armbruster <armbru@redhat.com>
    Kevin Wolf <kwolf@redhat.com>
    Max Reitz <mreitz@redhat.com>
block/sheepdog.c
    Liu Yuan <namei.unix@gmail.com>
    Kevin Wolf <kwolf@redhat.com>
    Max Reitz <mreitz@redhat.com>
    sheepdog@lists.wpkg.org
block/snapshot.c
    Kevin Wolf <kwolf@redhat.com>
    Max Reitz <mreitz@redhat.com>
blockdev.c
    Markus Armbruster <armbru@redhat.com>
    Kevin Wolf <kwolf@redhat.com>
    Max Reitz <mreitz@redhat.com>
chardev/char-socket.c
    "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
    Paolo Bonzini <pbonzini@redhat.com>
hw/audio/intel-hda.c
    Gerd Hoffmann <kraxel@redhat.com>
hw/core/qdev-properties.c
    Paolo Bonzini <pbonzini@redhat.com>
    "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
    Eduardo Habkost <ehabkost@redhat.com>
hw/pci-bridge/pci_bridge_dev.c
    "Michael S. Tsirkin" <mst@redhat.com>
    Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
hw/pci-bridge/pcie_pci_bridge.c
    "Michael S. Tsirkin" <mst@redhat.com>
    Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
hw/scsi/megasas.c
    Hannes Reinecke <hare@suse.com>
    Paolo Bonzini <pbonzini@redhat.com>
    Fam Zheng <fam@euphon.net>
hw/scsi/mptsas.c
    Paolo Bonzini <pbonzini@redhat.com>
    Fam Zheng <fam@euphon.net>
hw/usb/hcd-xhci.c
    Gerd Hoffmann <kraxel@redhat.com>
io/net-listener.c
    "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
migration/colo.c
    Hailiang Zhang <zhang.zhanghailiang@huawei.com>
    Juan Quintela <quintela@redhat.com>
    "Dr. David Alan Gilbert" <dgilbert@redhat.com>
qga/commands-posix.c
    Michael Roth <mdroth@linux.vnet.ibm.com>
qga/commands-win32.c
    Michael Roth <mdroth@linux.vnet.ibm.com>
util/qemu-sockets.c
    "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
    Gerd Hoffmann <kraxel@redhat.com>



--=20
Best regards,
Vladimir

