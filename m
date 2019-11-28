Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA2321741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqO0n/Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA2321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaHO2-0000aw-J1
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 05:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iaHF8-0003Ob-40
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iaHEz-0006BD-KY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iaHEx-000660-Au
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574937696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAso0zZrcK7oyN9cBQr4oMSvDDLZNhWKMhoo8vr5p2M=;
 b=fqO0n/CvC04QMf/ge+f6d3TdeMtZwddVBzR5iPheIT/rVuLil9axg4swBv78QrcKZawyJC
 2oRb8oEBMAjHGiqU74vmLH+O3nXbGorzawfo9dVdK2ta9iWanHYeWsVZeZe2cF0VVpppKk
 V62JT1oYx3hP0lvpue9yTI9H5GqPohQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-ZRj1eXtyMkOIDSERxUS-Jg-1; Thu, 28 Nov 2019 05:41:34 -0500
Received: by mail-wr1-f70.google.com with SMTP id l20so3823326wrc.13
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 02:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aoamNYF5Es+DKHVN7S9sZBwJiEagpA1NQ3zDMlmeG/4=;
 b=JRTxoRCM237LoE0yHYDKO1pM8pFRW6w/RYRlMzxsVBVkjdxz3ZE/Huc+dNkZ3ST1Kp
 XlmuXkee1ZIyGhgH4ZQCW1/P0KxkshnbBSm7AaeF2DKPmKAp6fZJAQoEPe2E8602c7zs
 ihFarOwbjFsUPhunvkyuKZEyjKIUCGTr3rmncnfz3cMDW5HFbhME9IBFJzSgblEXV55V
 G/Y6faJZnyWmUu8/PWMCn6TnvF97gwxzx3PlLZbiubuArsBl7iSn75tmDlw3YFVDyk/+
 al7VelnOH1HlPyGLK8z1QkvbklrdO4Eut6JFzW17OUqkw5X5VLIuEbF6SQha7oDWJh/2
 qHjQ==
X-Gm-Message-State: APjAAAWnjMRWQ6eVYDTjMGG/qbcFEj/EWYgF6liCecYkyTTNfllTgR0W
 CDKnuW1QFmqV2rMhp1W61Lrnt4UA4dy+zdS62vmmN4bceh67UXlAsXlj/7/ytTvCou0fG2tTJM+
 mwsRA5GguFRcc804=
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr45358137wrj.168.1574937693366; 
 Thu, 28 Nov 2019 02:41:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqzF3kxZOfcxP0Z7yviD6/givRGjSpN2aFkESoa0KxjfkQQapoeOZq/oVgElAgoi6xf3Xzemyg==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr45358118wrj.168.1574937693056; 
 Thu, 28 Nov 2019 02:41:33 -0800 (PST)
Received: from steredhat (host28-88-dynamic.16-87-r.retail.telecomitalia.it.
 [87.16.88.28])
 by smtp.gmail.com with ESMTPSA id x8sm22652078wrm.7.2019.11.28.02.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 02:41:32 -0800 (PST)
Date: Thu, 28 Nov 2019 11:41:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: pannengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] block/nbd: fix memory leak in nbd_open()
Message-ID: <20191128104130.a2sycwcvevuajb3o@steredhat>
References: <1574930410-43468-1-git-send-email-pannengyuan@huawei.com>
 <20191128090149.it5w2gijbqaw3tpg@steredhat>
 <52fe4ac4-25a8-827d-6c09-42d73ff7858b@huawei.com>
MIME-Version: 1.0
In-Reply-To: <52fe4ac4-25a8-827d-6c09-42d73ff7858b@huawei.com>
X-MC-Unique: ZRj1eXtyMkOIDSERxUS-Jg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, liyiting@huawei.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 06:32:49PM +0800, pannengyuan wrote:
> Hi,
> I think it's a better way, you can implement this new function before
> this patch.

If you want to do it, so you can send everything together, for me there's
no problem, it was just a suggestion.

If you don't have time, I can do it.

Cheers,
Stefano

>=20
> Thanks.
>=20
> On 2019/11/28 17:01, Stefano Garzarella wrote:
> > On Thu, Nov 28, 2019 at 04:40:10PM +0800, pannengyuan@huawei.com wrote:
> >=20
> > Hi,
> > I don't know nbd code very well, the patch LGTM, but just a comment
> > below:
> >=20
> >> From: PanNengyuan <pannengyuan@huawei.com>
> >>
> >> In currently implementation there will be a memory leak when
> >> nbd_client_connect() returns error status. Here is an easy way to repr=
oduce:
> >>
> >> 1. run qemu-iotests as follow and check the result with asan:
> >>     ./check -raw 143
> >>
> >> Following is the asan output backtrack:
> >> Direct leak of 40 byte(s) in 1 object(s) allocated from:
> >>     #0 0x7f629688a560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
> >>     #1 0x7f6295e7e015 in g_malloc0  (/usr/lib64/libglib-2.0.so.0+0x500=
15)
> >>     #2 0x56281dab4642 in qobject_input_start_struct  /mnt/sdb/qemu-4.2=
.0-rc0/qapi/qobject-input-visitor.c:295
> >>     #3 0x56281dab1a04 in visit_start_struct  /mnt/sdb/qemu-4.2.0-rc0/q=
api/qapi-visit-core.c:49
> >>     #4 0x56281dad1827 in visit_type_SocketAddress  qapi/qapi-visit-soc=
kets.c:386
> >>     #5 0x56281da8062f in nbd_config  /mnt/sdb/qemu-4.2.0-rc0/block/nbd=
.c:1716
> >>     #6 0x56281da8062f in nbd_process_options  /mnt/sdb/qemu-4.2.0-rc0/=
block/nbd.c:1829
> >>     #7 0x56281da8062f in nbd_open  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c=
:1873
> >>
> >> Direct leak of 15 byte(s) in 1 object(s) allocated from:
> >>     #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
> >>     #1 0x7f6295e7dfbd in g_malloc  (/usr/lib64/libglib-2.0.so.0+0x4ffb=
d)
> >>     #2 0x7f6295e96ace in g_strdup  (/usr/lib64/libglib-2.0.so.0+0x68ac=
e)
> >>     #3 0x56281da804ac in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/b=
lock/nbd.c:1834
> >>     #4 0x56281da804ac in nbd_open  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c=
:1873
> >>
> >> Indirect leak of 24 byte(s) in 1 object(s) allocated from:
> >>     #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
> >>     #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd=
)
> >>     #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace=
)
> >>     #3 0x56281dab41a3 in qobject_input_type_str_keyval   /mnt/sdb/qemu=
-4.2.0-rc0/qapi/qobject-input-visitor.c:536
> >>     #4 0x56281dab2ee9 in visit_type_str   /mnt/sdb/qemu-4.2.0-rc0/qapi=
/qapi-visit-core.c:297
> >>     #5 0x56281dad0fa1 in visit_type_UnixSocketAddress_members  qapi/qa=
pi-visit-sockets.c:141
> >>     #6 0x56281dad17b6 in visit_type_SocketAddress_members      qapi/qa=
pi-visit-sockets.c:366
> >>     #7 0x56281dad186a in visit_type_SocketAddress     qapi/qapi-visit-=
sockets.c:393
> >>     #8 0x56281da8062f in nbd_config   /mnt/sdb/qemu-4.2.0-rc0/block/nb=
d.c:1716
> >>     #9 0x56281da8062f in nbd_process_options   /mnt/sdb/qemu-4.2.0-rc0=
/block/nbd.c:1829
> >>     #10 0x56281da8062f in nbd_open  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.=
c:1873
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> >> ---
> >>  block/nbd.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/block/nbd.c b/block/nbd.c
> >> index 1239761..bc40a25 100644
> >> --- a/block/nbd.c
> >> +++ b/block/nbd.c
> >> @@ -1881,6 +1881,11 @@ static int nbd_open(BlockDriverState *bs, QDict=
 *options, int flags,
> >> =20
> >>      ret =3D nbd_client_connect(bs, errp);
> >>      if (ret < 0) {
> >> +        object_unref(OBJECT(s->tlscreds));
> >> +        qapi_free_SocketAddress(s->saddr);
> >> +        g_free(s->export);
> >> +        g_free(s->tlscredsid);
> >> +        g_free(s->x_dirty_bitmap);
> >=20
> > Since with this patch we are doing these cleanups in 3 places (here,
> > nbd_close(), and nbd_process_options()), should be better to add a new
> > function to do these cleanups?
> >=20
> > Maybe I'd create a series adding a patch before this one, implementing =
this
> > new function, and change this patch calling it.
> >=20
> > Thanks,
> > Stefano
> >=20
> >=20
> > .
> >=20
>=20

--=20


