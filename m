Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D9CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8720D217D9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rzYa0NNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8720D217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQU5r-0005f5-M5
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQU4q-0004mV-GZ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQU4o-0003KX-Eb
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:22:44 -0400
Received: from mail-eopbgr50137.outbound.protection.outlook.com
 ([40.107.5.137]:62276 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iQU4n-0003Ep-8n; Fri, 01 Nov 2019 06:22:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr30aKcFGa6pxBWOA3eINW8xW3w0OBE4nOJS+uhy/OGU4bDcHr7hBpqATXUWam5kDpSzxSnes0GBqXpIMFCR22RWZTv6neUuHYlYTD88XSNRb2K3VF1ghclk23qtMItgVs0TSd3AUWykpOqOJvWhb8/bHXl0f2t8+3ZBof38fZH8Ex17tjzFmZayLqmhdvk0ZEcLnFHm4I+f+uWBNZLmeOCd4Ua4FrqrK6UoCwiBBAUo1EoXaVQMbAiYene2KE21rrUiJSADsWGcPdHvq273N1tRxW/qcTfRO7zbn+T6Rgy72mn/dyjG4hlJJfneLNzzHPHbMBPdN6jnvCEXjTQS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDBBO1qypunhBm/P0wvtg6wpvyQWr4mjqcSR8AulMew=;
 b=LLId1ZQSt8vQ9N55LH2oDcLmZ129Ff+vkYJMMijTlyTbg0dEMLhORtLlFkicq4BugMKgaDB0VZUAl+UP/e8CmrGQAbV8JBDlTMxUEcJoxIRb9SWUJe/XmEsNZtJKrgsGYRr7KK4NLMFL4ibYJSHBquOKzzyjS31prTQ48stu3rR5RMkXugVU/G7SFW1q2SCd58PrCQm2CHozvjxcQ/xdcl5VqK34TIjR73SuPYNDkK9cO3ul3sVHxOpiWHOM/5QDmtIv2q1zXchczZkjvnxAi0z3MAjsJSai5xjkgzhEOJm/AtfulJ7EbBQy1RbEP+AUSNO9SAK1udyflfbaXl89hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDBBO1qypunhBm/P0wvtg6wpvyQWr4mjqcSR8AulMew=;
 b=rzYa0NNYE7loWX24+8GMWymhgvWVRBfURPyZ3SwE+ozHe2cRMWiaOLmo5oXEzXJAn3tHh8Y8qlbVUxCrXkYwQaAQjqQvS+9d0DnauP+cMjHtorQJ01g0N5nmStMV5EfZovkDk5et5JT3WYRC7XADFUcFhOfdsTEorUC5b1zgrv8=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3235.eurprd08.prod.outlook.com (52.134.90.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 1 Nov 2019 10:22:37 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2408.019; Fri, 1 Nov 2019
 10:22:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2 1/4] Revert "qcow2: skip writing zero buffers to
 empty COW areas"
Thread-Topic: [PATCH for-4.2 1/4] Revert "qcow2: skip writing zero buffers to
 empty COW areas"
Thread-Index: AQHVkJs2bRukXPIwSUGpDr1ufVKtrKd2G1eA
Date: Fri, 1 Nov 2019 10:22:37 +0000
Message-ID: <43734508-7b2d-2a49-e2f9-365989dd6386@virtuozzo.com>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <20191101100019.9512-2-mreitz@redhat.com>
In-Reply-To: <20191101100019.9512-2-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0165.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::13) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191101132235647
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03029ddf-3947-41b0-0439-08d75eb56b2f
x-ms-traffictypediagnostic: AM0PR08MB3235:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3235E314EC69BC7A61B068A2C1620@AM0PR08MB3235.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(366004)(346002)(199004)(189003)(6246003)(8676002)(81156014)(81166006)(6512007)(4326008)(31686004)(110136005)(2906002)(8936002)(99286004)(14454004)(6116002)(66066001)(71200400001)(86362001)(6486002)(54906003)(31696002)(6436002)(3846002)(66446008)(2501003)(36756003)(476003)(305945005)(71190400001)(25786009)(486006)(26005)(107886003)(508600001)(386003)(186003)(102836004)(6506007)(446003)(11346002)(64756008)(66946007)(14444005)(66556008)(256004)(7736002)(66476007)(5660300002)(76176011)(229853002)(52116002)(2616005)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3235;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzKtbWudg+dBontuE2t0cTizIsfXG/ylDVCLCDcdl6sOTe6fHfm5vqWj+DvA6SuWk6CLk4aUl3K2dAYm89+fIVTsAqoKuucj8x2CimMTa1jJmKPVp2+O97Fa9C51zta2l1yEZMgPE50QYk2sNdoHpl6r7fh/sIuxj/ih20aEhFcvzQCF2hwgSS/kXslEEfaEVuTFl75eL1IkXmk7K+O/sI8SZ0Fzq4Vav9SP4Asb4WsgIFSSxIMxuW5Eq2lNEZCYzKOGABUrgEjsdhQuEWX0+kcjFZOeCjnrm96OIZVDCdwvAMDKF4rP3tbyr2cYg9+ApGKHe/xoQVSCRT+FM7mcwEizsRFyX3hHWbClAB2I0/gRC7CyPZbiD3BB7NTG5P7LJVeYgX0bAKcVPz+3p19R6tasCvTKWnaqYZv0Woi6/DLvHv3yb7U+Rphn1uV8LAYL
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E2868167787AE649B51DC3A69B29CBF0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03029ddf-3947-41b0-0439-08d75eb56b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 10:22:37.7988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eyhy/+wJz9UwLSCqmkgQ5F3ZPlE6NzPatYoxVnbbsk7MjijEyXRLwSkuY+yx/hmXRNO9Y7Mz0SgPejsXltiMJAeEsoY/lPGwystCv2MSumw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3235
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.137
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.11.2019 13:00, Max Reitz wrote:
> This reverts commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a.
>=20
> This commit causes fundamental performance problems on XFS (because
> fallocate() stalls the AIO pipeline), and as such it is not clear that
> we should unconditionally enable this behavior.
>=20
> We expect subclusters to alleviate the performance penalty of small
> writes to newly allocated clusters, so when we get them, the originally
> intended performance gain may actually no longer be significant.
>=20
> If we want to reintroduce something similar to c8bb23cbdbe, it will
> require extensive benchmarking on various systems with subclusters
> enabled.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>

It's sad, but OK:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   qapi/block-core.json       |  4 +-
>   block/qcow2.h              |  6 ---
>   block/qcow2-cluster.c      |  2 +-
>   block/qcow2.c              | 86 --------------------------------------
>   block/trace-events         |  1 -
>   tests/qemu-iotests/060     |  7 +---
>   tests/qemu-iotests/060.out |  5 +--
>   7 files changed, 4 insertions(+), 107 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index aa97ee2641..f053f15431 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3304,8 +3304,6 @@
>   #
>   # @cor_write: a write due to copy-on-read (since 2.11)
>   #
> -# @cluster_alloc_space: an allocation of file space for a cluster (since=
 4.1)
> -#
>   # @none: triggers once at creation of the blkdebug node (since 4.1)
>   #
>   # Since: 2.9
> @@ -3326,7 +3324,7 @@
>               'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
>               'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
>               'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
> -            'cor_write', 'cluster_alloc_space', 'none'] }
> +            'cor_write', 'none'] }
>  =20
>   ##
>   # @BlkdebugIOType:
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 601c2e4c82..8166f6e311 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -418,12 +418,6 @@ typedef struct QCowL2Meta
>        */
>       Qcow2COWRegion cow_end;
>  =20
> -    /*
> -     * Indicates that COW regions are already handled and do not require
> -     * any more processing.
> -     */
> -    bool skip_cow;
> -
>       /**
>        * The I/O vector with the data from the actual guest write request=
.
>        * If non-NULL, this is meant to be merged together with the data
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 8982b7b762..fbfea8c817 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -809,7 +809,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Me=
ta *m)
>       assert(start->nb_bytes + end->nb_bytes <=3D UINT_MAX - data_bytes);
>       assert(start->offset + start->nb_bytes <=3D end->offset);
>  =20
> -    if ((start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) || m->skip_=
cow) {
> +    if (start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) {
>           return 0;
>       }
>  =20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7c18721741..17555cb0a1 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2274,11 +2274,6 @@ static bool merge_cow(uint64_t offset, unsigned by=
tes,
>               continue;
>           }
>  =20
> -        /* If COW regions are handled already, skip this too */
> -        if (m->skip_cow) {
> -            continue;
> -        }
> -
>           /* The data (middle) region must be immediately after the
>            * start region */
>           if (l2meta_cow_start(m) + m->cow_start.nb_bytes !=3D offset) {
> @@ -2305,81 +2300,6 @@ static bool merge_cow(uint64_t offset, unsigned by=
tes,
>       return false;
>   }
>  =20
> -static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t=
 bytes)
> -{
> -    int64_t nr;
> -    return !bytes ||
> -        (!bdrv_is_allocated_above(bs, NULL, false, offset, bytes, &nr) &=
&
> -         nr =3D=3D bytes);
> -}
> -
> -static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
> -{
> -    /*
> -     * This check is designed for optimization shortcut so it must be
> -     * efficient.
> -     * Instead of is_zero(), use is_unallocated() as it is faster (but n=
ot
> -     * as accurate and can result in false negatives).
> -     */
> -    return is_unallocated(bs, m->offset + m->cow_start.offset,
> -                          m->cow_start.nb_bytes) &&
> -           is_unallocated(bs, m->offset + m->cow_end.offset,
> -                          m->cow_end.nb_bytes);
> -}
> -
> -static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
> -{
> -    BDRVQcow2State *s =3D bs->opaque;
> -    QCowL2Meta *m;
> -
> -    if (!(s->data_file->bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK)=
) {
> -        return 0;
> -    }
> -
> -    if (bs->encrypted) {
> -        return 0;
> -    }
> -
> -    for (m =3D l2meta; m !=3D NULL; m =3D m->next) {
> -        int ret;
> -
> -        if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
> -            continue;
> -        }
> -
> -        if (!is_zero_cow(bs, m)) {
> -            continue;
> -        }
> -
> -        /*
> -         * instead of writing zero COW buffers,
> -         * efficiently zero out the whole clusters
> -         */
> -
> -        ret =3D qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
> -                                            m->nb_clusters * s->cluster_=
size,
> -                                            true);
> -        if (ret < 0) {
> -            return ret;
> -        }
> -
> -        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
> -        ret =3D bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
> -                                    m->nb_clusters * s->cluster_size,
> -                                    BDRV_REQ_NO_FALLBACK);
> -        if (ret < 0) {
> -            if (ret !=3D -ENOTSUP && ret !=3D -EAGAIN) {
> -                return ret;
> -            }
> -            continue;
> -        }
> -
> -        trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_clu=
sters);
> -        m->skip_cow =3D true;
> -    }
> -    return 0;
> -}
> -
>   /*
>    * qcow2_co_pwritev_task
>    * Called with s->lock unlocked
> @@ -2421,12 +2341,6 @@ static coroutine_fn int qcow2_co_pwritev_task(Bloc=
kDriverState *bs,
>           qiov_offset =3D 0;
>       }
>  =20
> -    /* Try to efficiently initialize the physical space with zeroes */
> -    ret =3D handle_alloc_space(bs, l2meta);
> -    if (ret < 0) {
> -        goto out_unlocked;
> -    }
> -
>       /*
>        * If we need to do COW, check if it's possible to merge the
>        * writing of the guest data together with that of the COW regions.
> diff --git a/block/trace-events b/block/trace-events
> index 6ba86decca..c615b26d71 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -72,7 +72,6 @@ qcow2_writev_done_part(void *co, int cur_bytes) "co %p =
cur_bytes %d"
>   qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
>   qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co =
%p offset 0x%" PRIx64 " count %d"
>   qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset =
0x%" PRIx64 " count %d"
> -qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset=
 0x%" PRIx64 " nb_clusters %d"
>  =20
>   # qcow2-cluster.c
>   qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %=
p offset 0x%" PRIx64 " bytes %d"
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index b91d8321bb..89e911400c 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -150,15 +150,10 @@ $QEMU_IO -c "$OPEN_RO" -c "read -P 1 0 512" | _filt=
er_qemu_io
>   echo
>   echo "=3D=3D=3D Testing overlap while COW is in flight =3D=3D=3D"
>   echo
> -BACKING_IMG=3D$TEST_IMG.base
> -TEST_IMG=3D$BACKING_IMG _make_test_img 1G
> -
> -$QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_qemu_io
> -
>   # compat=3D0.10 is required in order to make the following discard actu=
ally
>   # unallocate the sector rather than make it a zero sector - we want COW=
, after
>   # all.
> -IMGOPTS=3D'compat=3D0.10' _make_test_img -b "$BACKING_IMG" 1G
> +IMGOPTS=3D'compat=3D0.10' _make_test_img 1G
>   # Write two clusters, the second one enforces creation of an L2 table a=
fter
>   # the first data cluster.
>   $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qe=
mu_io
> diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
> index 0f6b0658a1..e42bf8c5a9 100644
> --- a/tests/qemu-iotests/060.out
> +++ b/tests/qemu-iotests/060.out
> @@ -97,10 +97,7 @@ read 512/512 bytes at offset 0
>  =20
>   =3D=3D=3D Testing overlap while COW is in flight =3D=3D=3D
>  =20
> -Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1073741824
> -wrote 65536/65536 bytes at offset 0
> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
>   wrote 65536/65536 bytes at offset 0
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 65536/65536 bytes at offset 536870912
>=20


--=20
Best regards,
Vladimir

