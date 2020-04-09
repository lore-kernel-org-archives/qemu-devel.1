Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4DDC2D0EA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 07:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F048821973
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ic84U0YZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F048821973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMS5c-0002eq-5d
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 03:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMS4e-00029a-Nn
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 03:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMS4d-0001lt-Ge
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 03:58:08 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:57440 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMS4a-0001kh-De; Thu, 09 Apr 2020 03:58:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N53tYtS5JRbg/6+m071+eHzV6cV4d3itGy+bvVlA5H7eCkwPIwGcR4pAKkZRlnktoqs9lkJvHzXqSvAJ/UtOzcO3IdBKZNHSpZWqp1qc+uriB58SjZkric72u87H/Oj/NnM+7ujKQvbCk9jpKIx3hFtKwXqASKiTfJYaO3TaS9adQcGNFQ/8vkTVY7mpCu11Jy1jsgAvYTcSHsIHqhhZWSAltYt13oVzPMNWB2+oBT6A3pmbtMWQnHoxyIwvx9z+RjMWpPfyihU2TmNe2+iW0fszeFYOqXrO56DbwwKpKBZbwtNM+DKWg6qnkewhRhA7penP5K8NBA+y/91YtoAzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIfD5leIaIIYLkgFtlEBnqj+hQ8B255908NGp78QnHA=;
 b=VgsrXbYA3cUYo2eCBp8ZDIQ+HMb7ljs5hUuhRIouy0ZYZPnHTBc1MgypWMP8B8nmTGUkCYtXOT8yFhcVD/Jr+BRr8jYBw7+K1c0brgUzgakO0qFVbD2+5VxZs0NKYkdTcuosQxtoCMe5bkHUHlMyRzkdVEcrMWlzW/OQoGMQeVk4C0gaDphVX5QSUwVGjaZfsLn3hQls5i5uTn0avfXfDzRjBfmapAgJ0xf3SaduF/voI+KbkgQdbe/1vNkhaxV/b7v4pmcBD9OtPRrNLkKKoFA6xOoSPdWAnry+wlFKUnoN0RuzJjyOL7NXp1Mp+NPpkgdjf18JcaNLysVGV3nDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIfD5leIaIIYLkgFtlEBnqj+hQ8B255908NGp78QnHA=;
 b=Ic84U0YZ8Ltr2I+2XmWudhk5xpQOccI+sg+jh4f7mLkMOp1LvYbkoELKtdgREWNxonBnMjDg+8lM/j4bbzD4MZCYqiSguQEb7+gPtrc5Nn80yMZ+QlRbtVofcIJUZJsxK7Htq1LHRceAMwFApHR0x83zQJGdZVLCm8dREJ4R7Xc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5349.eurprd08.prod.outlook.com (2603:10a6:20b:107::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 9 Apr
 2020 07:58:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 07:58:01 +0000
Subject: Re: [PATCH v4 02/30] qcow2: Convert qcow2_get_cluster_offset() into
 qcow2_get_host_offset()
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <65243debd4a41e1ebd13877c2e6c665759c37b38.1584468723.git.berto@igalia.com>
 <2f8f3cba-d4e4-49f2-722f-fc6cc96bdd65@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200409105759711
Message-ID: <7c21a1f3-e263-9175-2d6d-41aafba85f55@virtuozzo.com>
Date: Thu, 9 Apr 2020 10:57:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <2f8f3cba-d4e4-49f2-722f-fc6cc96bdd65@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM7PR02CA0019.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM7PR02CA0019.eurprd02.prod.outlook.com (2603:10a6:20b:100::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend
 Transport; Thu, 9 Apr 2020 07:58:00 +0000
X-Tagtoolbar-Keys: D20200409105759711
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e22e909c-1ec1-42c7-e726-08d7dc5bb9e1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53492243B4F8DE353C518FB2C1C10@AM7PR08MB5349.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(376002)(39840400004)(396003)(366004)(346002)(16526019)(2906002)(53546011)(66476007)(4326008)(186003)(6486002)(31696002)(66946007)(66556008)(107886003)(26005)(2616005)(956004)(5660300002)(8676002)(52116002)(86362001)(36756003)(8936002)(81166007)(54906003)(31686004)(16576012)(316002)(478600001)(110136005)(81156014);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zt0sEaWjf+IkOmnQwCQValohyEFVvIjbsLa36cIDfvAvAc8aBpy7tF3i6meKBbVe69GPMpXuJNm1sn7UN6OyQkOqm5hc72+k/WTJhTwCT0d3WaQdeloVFUeNGQaT7WkpV+H0thgqvkc2OwoLa3F3EgrFpOkAbi6lCXA2idFDlT13EJHCKvMSgBrPgH3BB8vvOWruUlqDrg9X1u27XAF3espriUrj2lOhHa8fXYzyIm0xjuRfKZTx5dW5bJNk+XNWUWSGH09IyLURIE4mRA8nZQxQy5BdMxRHDyovs82ea/k5ACx4G2FzSNuGaXSIWTwHoFncdXhFqTjbbFA3XOTaWSpiXSkjB2fqblswFdvpKIF75bgVGXNDhZGJGv8uHx+zYGKT8V5ekryHDOQ6hp82qNrt92Q+TIbc5ECTXeFHCGWbqdsNftXVTQArI3MS7xEv
X-MS-Exchange-AntiSpam-MessageData: JvrliJvRFJbIxlXLHq/RHFBkUmV5QeGJBXOXLZHd0lVfdtua8B/PRNrnjgxHvFW9vl7SFzma5CnmTyIxS6hsEY1PZXuNPkPaagiVTKhTEuap1KPaf9zvqFX2zDG0gr31E8IwUF7Ny7PShMY5PHnk7Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22e909c-1ec1-42c7-e726-08d7dc5bb9e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 07:58:01.6273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9YBRgUazOBA3yWiDdohZDj5AMhXG9lIff/pIvIIXy8/fdok353RdRjNcgKLaxOEvk2oA/m9TOBd1iKSjb6o1tdpQqtL1dEMZoyjT4CN/50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5349
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.04.2020 13:51, Max Reitz wrote:
> On 17.03.20 19:15, Alberto Garcia wrote:
>> qcow2_get_cluster_offset() takes an (unaligned) guest offset and
>> returns the (aligned) offset of the corresponding cluster in the qcow2
>> image.
>>
>> In practice none of the callers need to know where the cluster starts
>> so this patch makes the function calculate and return the final host
>> offset directly. The function is also renamed accordingly.
>>
>> There is a pre-existing exception with compressed clusters: in this
>> case the function returns the complete cluster descriptor (containing
>> the offset and size of the compressed data). This does not change with
>> this patch but it is now documented.
>>
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>   block/qcow2.h         |  4 ++--
>>   block/qcow2-cluster.c | 38 ++++++++++++++++++++++----------------
>>   block/qcow2.c         | 24 +++++++-----------------
>>   3 files changed, 31 insertions(+), 35 deletions(-)
>>
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index 0942126232..f47ef6ca4e 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>=20
> [...]
>=20
>>       case QCOW2_CLUSTER_ZERO_ALLOC:
>>       case QCOW2_CLUSTER_NORMAL:
>>           /* how many allocated clusters ? */
>>           c =3D count_contiguous_clusters(bs, nb_clusters, s->cluster_si=
ze,
>>                                         &l2_slice[l2_index], QCOW_OFLAG_=
ZERO);
>> -        *cluster_offset &=3D L2E_OFFSET_MASK;
>> -        if (offset_into_cluster(s, *cluster_offset)) {
>> +        *host_offset =3D l2_entry & L2E_OFFSET_MASK;
>> +        if (offset_into_cluster(s, *host_offset)) {
>>               qcow2_signal_corruption(bs, true, -1, -1,
>>                                       "Cluster allocation offset %#"
>>                                       PRIx64 " unaligned (L2 offset: %#"=
 PRIx64
>> -                                    ", L2 index: %#x)", *cluster_offset=
,
>> +                                    ", L2 index: %#x)", *host_offset,
>>                                       l2_offset, l2_index);
>>               ret =3D -EIO;
>>               goto fail;
>>           }
>> -        if (has_data_file(bs) && *cluster_offset !=3D offset - offset_i=
n_cluster)
>> +        if (has_data_file(bs) && *host_offset !=3D offset - offset_in_c=
luster)
>>           {
>=20
> (1) The { should be moved to the preceding line;
>=20
> (2) I think it makes more sense to move the
> =E2=80=9C*host_offset +=3D offset_in_cluster=E2=80=9D before this conditi=
on, so it becomes
> =E2=80=9C... && *host_offset !=3D offset=E2=80=9D.
>=20
>>               qcow2_signal_corruption(bs, true, -1, -1,
>>                                       "External data file host cluster o=
ffset %#"
>=20
> (Maybe we then need to drop the =E2=80=9Ccluster=E2=80=9D from this line,=
 but other than
> that, it would fit with this error message.)
>=20

Message would be less useful I think, better is compare two cluster offsets=
, as host cluster offset is specified by qcow2 metadata, not host offset.

What about squashing this:

--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -615,32 +615,34 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint6=
4_t offset,
          break;
      case QCOW2_CLUSTER_ZERO_ALLOC:
      case QCOW2_CLUSTER_NORMAL:
+    {
+        uint64_t host_cluster_offset =3D l2_slice & L2E_OFFSET_MASK;
+        *host_offset =3D host_cluster_offset + offset_in_cluster;
+
          /* how many allocated clusters ? */
          c =3D count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
                                        &l2_slice[l2_index], QCOW_OFLAG_ZER=
O);
-        *host_offset =3D l2_entry & L2E_OFFSET_MASK;
-        if (offset_into_cluster(s, *host_offset)) {
+        if (offset_into_cluster(s, host_cluster_offset)) {
              qcow2_signal_corruption(bs, true, -1, -1,
                                      "Cluster allocation offset %#"
                                      PRIx64 " unaligned (L2 offset: %#" PR=
Ix64
-                                    ", L2 index: %#x)", *host_offset,
+                                    ", L2 index: %#x)", host_cluster_offse=
t,
                                      l2_offset, l2_index);
              ret =3D -EIO;
              goto fail;
          }
-        if (has_data_file(bs) && *host_offset !=3D offset - offset_in_clus=
ter)
-        {
+        if (has_data_file(bs) && *host_offset !=3D offset) {
              qcow2_signal_corruption(bs, true, -1, -1,
                                      "External data file host cluster offs=
et %#"
                                      PRIx64 " does not match guest cluster=
 "
                                      "offset: %#" PRIx64
-                                    ", L2 index: %#x)", *host_offset,
+                                    ", L2 index: %#x)", host_cluster_offse=
t,
                                      offset - offset_in_cluster, l2_index)=
;
              ret =3D -EIO;
              goto fail;
          }
-        *host_offset +=3D offset_in_cluster;
          break;
+    }
      default:
          abort();
      }



--=20
Best regards,
Vladimir

