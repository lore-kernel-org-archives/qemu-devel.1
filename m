Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809FBC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394F326A2A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RGBpWQm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394F326A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiIe-0005PA-GL
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:14:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWiEo-0002Xd-0p
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWiEm-00009B-Fh
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:10:30 -0400
Received: from mail-eopbgr150120.outbound.protection.outlook.com
	([40.107.15.120]:29566
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWiEh-0008Do-DL; Fri, 31 May 2019 10:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=CJ2hLml4IMIZAUGpCrr/hJ8MTBC12AHxqR5HH65eIUI=;
	b=RGBpWQm68riXM9/xiwoQPIFS0zjbmTAXIInCoVPrlMq1oejJ5OqoKFs0TBIP5KPWaMjp1ZdrQ25jBhb0LKvWpkwsA4PgwkUF2Buvo10nvpzPV12j0Oebb5zpMNkyX9l0zSCaQUQCBfWOBJp+Fo9znRcKjI66CNz8wQx2SwiHJg0=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4257.eurprd08.prod.outlook.com (20.179.33.78) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Fri, 31 May 2019 14:10:17 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1943.018;
	Fri, 31 May 2019 14:10:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Thread-Topic: [PATCH 2/2] block/io: refactor padding
Thread-Index: AQHVF57GDAlVf4H2S0esbxHLYKgnbqaFReWA
Date: Fri, 31 May 2019 14:10:17 +0000
Message-ID: <6cddd33f-9d09-cff0-b8dd-c2c0e8696e69@virtuozzo.com>
References: <20190528084544.183558-1-vsementsov@virtuozzo.com>
	<20190528084544.183558-3-vsementsov@virtuozzo.com>
	<20190531105101.GB29868@stefanha-x1.localdomain>
In-Reply-To: <20190531105101.GB29868@stefanha-x1.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0063.eurprd09.prod.outlook.com
	(2603:10a6:3:45::31) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190531171015447
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf61ec29-ba5a-4ac4-134d-08d6e5d1b564
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB4257; 
x-ms-traffictypediagnostic: AM0PR08MB4257:
x-microsoft-antispam-prvs: <AM0PR08MB425768A6C39F8539DF996F26C1190@AM0PR08MB4257.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(39850400004)(376002)(396003)(346002)(366004)(199004)(189003)(7736002)(446003)(86362001)(53936002)(256004)(476003)(81166006)(81156014)(486006)(6436002)(11346002)(8676002)(76176011)(186003)(71190400001)(102836004)(66446008)(6486002)(68736007)(66946007)(64756008)(5660300002)(14444005)(36756003)(66066001)(305945005)(26005)(229853002)(66556008)(25786009)(2906002)(66476007)(73956011)(2616005)(6246003)(71200400001)(8936002)(6506007)(52116002)(14454004)(386003)(99286004)(54906003)(6916009)(478600001)(4326008)(31696002)(31686004)(6512007)(3846002)(316002)(6116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4257;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E2QTfeIZDegyU9o5QXRMvXoHNNATAG/I4LdiU16KJSwesbU4x17W/hZ8wt1KLYtfOJNu3AgVqoyr6ZbU0mr3O0FfZLVyMyLEirO82WH8BfWACGZl5oiNsWuWz0rsmWx85F7WJp06lRd5Z1bM5m1TnWRYoxPbsG5K0kARYw84eOYD2hHv3I1IEZyxJ3zifEWY5uallytYltbpa4SkOYqQ9mpQx0p0TNvu4FHsWh8H7UpPDMzMc82bS1NK5nuqQ8YiHFR13vvk9dYj0N3wWX42Tqs7sfWYxJioQ8u12+PWZj1SulFlG+waVPscz47byJNj00sb4okeBY2i/cLSN0k9XQ0wgcVDsh6iT8morjt4fwdjN6ykqPrmY2FIfI8f5dw6Xy8pczEQNaV/a0apyDI+WTJeGKiNg9kMFJs8L02Awqg=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <76E7FF8B94EBB646943177B9BCB16DB4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf61ec29-ba5a-4ac4-134d-08d6e5d1b564
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 14:10:17.6302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4257
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.120
Subject: Re: [Qemu-devel] [PATCH 2/2] block/io: refactor padding
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.05.2019 13:51, Stefan Hajnoczi wrote:
> On Tue, May 28, 2019 at 11:45:44AM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> We have similar padding code in bdrv_co_pwritev,
>> bdrv_co_do_pwrite_zeroes and bdrv_co_preadv. Let's combine and unify
>> it.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c | 344 ++++++++++++++++++++++++++++-------------------------
>=20
> Hmmm...this adds more lines than it removes.  O_o

It's near to be the same size, and keep in mind big comment.

>=20
> Merging a change like this can still be useful but there's a risk of
> making the code harder to understand due to the additional layers of
> abstraction.

It's a preparation for adding qiov_offset parameter to read/write path. See=
ms
correct to unify similar things, which I'm going to change. And I really wa=
nt
to make code more understandable than it was.. But my view is not general
of course.

>=20
>>   1 file changed, 179 insertions(+), 165 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 3134a60a48..840e276269 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1344,28 +1344,155 @@ out:
>>   }
>>  =20
>>   /*
>> - * Handle a read request in coroutine context
>> + * Request padding
>> + *
>> + *  |<---- align ---->|                     |<---- align ---->|
>> + *  |<- head ->|<------------ bytes ------------>|<-- tail -->|
>> + *  |          |      |                     |    |            |
>> + * -*----------$------*-------- ... --------*----$------------*---
>> + *  |          |      |                     |    |            |
>> + *  |          offset |                     |    end          |
>> + *  ALIGN_UP(offset)  ALIGN_DOWN(offset)    ALIGN_DOWN(end)   ALIGN_UP(=
end)
>=20
> Are ALIGN_UP(offset) and ALIGN_DOWN(offset) in the wrong order?

yes :(

>=20
>> + *  [buf   ... )                            [tail_buf         )
>> + *
>> + * @buf is an aligned allocation needed to store @head and @tail paddin=
gs. @head
>> + * is placed at the beginning of @buf and @tail at the @end.
>> + *
>> + * @tail_buf is a pointer to sub-buffer, corresponding to align-sized c=
hunk
>> + * around tail, if tail exists.
>> + *
>> + * @merge_reads is true for small requests,
>> + * if @buf_len =3D=3D @head + bytes + @tail. In this case it is possibl=
e that both
>> + * head and tail exist but @buf_len =3D=3D align and @tail_buf =3D=3D @=
buf.
>>    */
>> +typedef struct BdrvRequestPadding {
>> +    uint8_t *buf;
>> +    size_t buf_len;
>> +    uint8_t *tail_buf;
>> +    size_t head;
>> +    size_t tail;
>> +    bool merge_reads;
>> +    QEMUIOVector local_qiov;
>> +} BdrvRequestPadding;
>> +
>> +static bool bdrv_init_padding(BlockDriverState *bs,
>> +                              int64_t offset, int64_t bytes,
>> +                              BdrvRequestPadding *pad)
>> +{
>> +    uint64_t align =3D bs->bl.request_alignment;
>> +    size_t sum;
>> +
>> +    memset(pad, 0, sizeof(*pad));
>> +
>> +    pad->head =3D offset & (align - 1);
>> +    pad->tail =3D ((offset + bytes) & (align - 1));
>> +    if (pad->tail) {
>> +        pad->tail =3D align - pad->tail;
>> +    }
>> +
>> +    if ((!pad->head && !pad->tail) || !bytes) {
>> +        return false;
>> +    }
>> +
>> +    sum =3D pad->head + bytes + pad->tail;
>> +    pad->buf_len =3D (sum > align && pad->head && pad->tail) ? 2 * alig=
n : align;
>> +    pad->buf =3D qemu_blockalign(bs, pad->buf_len);
>> +    pad->merge_reads =3D sum =3D=3D pad->buf_len;
>> +    if (pad->tail) {
>> +        pad->tail_buf =3D pad->buf + pad->buf_len - align;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static int bdrv_padding_read(BdrvChild *child,
>> +                             BdrvTrackedRequest *req,
>> +                             BdrvRequestPadding *pad,
>> +                             bool zero_middle)
>> +{
>> +    QEMUIOVector local_qiov;
>> +    BlockDriverState *bs =3D child->bs;
>> +    uint64_t align =3D bs->bl.request_alignment;
>> +    int ret;
>> +
>> +    assert(req->serialising && pad->buf);
>> +
>> +    if (pad->head || pad->merge_reads) {
>> +        uint64_t bytes =3D pad->merge_reads ? pad->buf_len : align;
>> +
>> +        qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
>> +
>> +        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
>=20
> PWRITEV?  That's unexpected for a function called bdrv_padding_read().
> Please rename this to bdrv_padding_rmw_read() so it's clear this is part
> of a read-modify-write operation, not a regular read.
>=20
>> +        ret =3D bdrv_aligned_preadv(child, req, req->overlap_offset, by=
tes,
>> +                                  align, &local_qiov, 0);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
>> +
>> +        if (pad->merge_reads) {
>> +            goto zero_mem;
>> +        }
>> +    }
>> +
>> +    if (pad->tail) {
>> +        qemu_iovec_init_buf(&local_qiov, pad->tail_buf, align);
>> +
>> +        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
>> +        ret =3D bdrv_aligned_preadv(
>> +                child, req,
>> +                req->overlap_offset + req->overlap_bytes - align,
>> +                align, align, &local_qiov, 0);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
>> +    }
>> +
>> +zero_mem:
>> +    if (zero_middle) {
>> +        memset(pad->buf + pad->head, 0, pad->buf_len - pad->head - pad-=
>tail);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void bdrv_padding_destroy(BdrvRequestPadding *pad)
>> +{
>> +    if (pad->buf) {
>> +        qemu_vfree(pad->buf);
>> +        qemu_iovec_destroy(&pad->local_qiov);
>> +    }
>> +}
>> +
>> +static QEMUIOVector *bdrv_pad_request(BlockDriverState *bs, QEMUIOVecto=
r *qiov,
>> +                                      int64_t *offset, unsigned int *by=
tes,
>> +                                      BdrvRequestPadding *pad)
>=20
> Doc comment missing?
>=20
>> +{
>> +    bdrv_init_padding(bs, *offset, *bytes, pad);
>> +    if (!pad->buf) {
>> +        return qiov;
>> +    }
>=20
> I think there's no need to peek at pad->buf:
>=20
>    if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
>        return qiov;
>    }
>=20


--=20
Best regards,
Vladimir

