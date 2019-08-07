Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F1521BE6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bZukdkO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F1521BE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvK1H-0006AP-Kv
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 07:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liam.merwick@oracle.com>) id 1hvK0t-0005jA-7U
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1hvK0s-0003V7-8A
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:21:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1hvK0s-0003RQ-0C
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:21:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77BIboD021118;
 Wed, 7 Aug 2019 11:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PY98ybaZ8NwpB8y7BZtetibEwNGFbRuuCRYGDpL25Ks=;
 b=bZukdkO0Tvh4E8xlrqc9IZSm01w+WJpFdYYl0C/rQUrql7JkpgaN0xcLBBa0CEGc/Wil
 Eh4Tp6FJseAJE1mdcX2Fh35y8ZlMY4WNE1cB+/Fq/kXm1laphAhyxmN1Sdm1RRo4U0U3
 S1LM9JCxcKo/1dqI8kfnLNM3NbTjdL1Xp+xJg4RNn5/5zTOSXO1cjy7e3ewkgPQogpKQ
 IpK44Cxi9fT8DUTOXLr2UTfU5ydb27VVY9OjyTfnwIjqO2K10rWcaFHJwjHaZOa0hkIl
 LkTcQ5QfzmDWH6gnMHfEG9D4dLgUcyIDyk/cApUcaIomwqP4YEmLZZAoQeaDQPLdfqR7 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2u527puncx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Aug 2019 11:21:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77BHeh1051631;
 Wed, 7 Aug 2019 11:21:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2u7577urkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Aug 2019 11:21:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x77BLhTn027001;
 Wed, 7 Aug 2019 11:21:43 GMT
Received: from dhcp-10-175-176-44.vpn.oracle.com (/10.175.176.44)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 07 Aug 2019 04:21:43 -0700
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190807084048.4258-1-marcandre.lureau@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <afcfc5c8-b19e-24eb-3be6-1fe448ac11f1@oracle.com>
Date: Wed, 7 Aug 2019 12:21:40 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807084048.4258-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070126
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 x77BIboD021118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH] usbredir: fix buffer-overflow on vmload
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/2019 09:40, Marc-Andr=C3=A9 Lureau wrote:
> If interface_count is NO_INTERFACE_INFO, let's not access the arrays
> out-of-bounds.
>=20
> =3D=3D994=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x625000243930 at pc 0x5642068086a8 bp 0x7f0b6f9ffa50 sp 0x7f0b6f9ffa40
> READ of size 1 at 0x625000243930 thread T0
>      #0 0x5642068086a7 in usbredir_check_bulk_receiving /home/elmarco/s=
rc/qemu/hw/usb/redirect.c:1503
>      #1 0x56420681301c in usbredir_post_load /home/elmarco/src/qemu/hw/=
usb/redirect.c:2154
>      #2 0x5642068a56c2 in vmstate_load_state /home/elmarco/src/qemu/mig=
ration/vmstate.c:168
>      #3 0x56420688e2ac in vmstate_load /home/elmarco/src/qemu/migration=
/savevm.c:829
>      #4 0x5642068980cb in qemu_loadvm_section_start_full /home/elmarco/=
src/qemu/migration/savevm.c:2211
>      #5 0x564206899645 in qemu_loadvm_state_main /home/elmarco/src/qemu=
/migration/savevm.c:2395
>      #6 0x5642068998cf in qemu_loadvm_state /home/elmarco/src/qemu/migr=
ation/savevm.c:2467
>      #7 0x56420685f3e9 in process_incoming_migration_co /home/elmarco/s=
rc/qemu/migration/migration.c:449
>      #8 0x564207106c47 in coroutine_trampoline /home/elmarco/src/qemu/u=
til/coroutine-ucontext.c:115
>      #9 0x7f0c0604e37f  (/lib64/libc.so.6+0x4d37f)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   hw/usb/redirect.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 998fc6e4b0..9764a57987 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1495,6 +1495,11 @@ static void usbredir_check_bulk_receiving(USBRed=
irDevice *dev)
>       for (i =3D EP2I(USB_DIR_IN); i < MAX_ENDPOINTS; i++) {
>           dev->endpoint[i].bulk_receiving_enabled =3D 0;
>       }
> +
> +    if (dev->interface_info.interface_count =3D=3D NO_INTERFACE_INFO) =
{
> +        return;
> +    }
> +
>       for (i =3D 0; i < dev->interface_info.interface_count; i++) {
>           quirks =3D usb_get_quirks(dev->device_info.vendor_id,
>                                   dev->device_info.product_id,
>=20


