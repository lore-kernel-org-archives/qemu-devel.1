Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C3DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 18:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81937206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 18:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="NK90NhIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81937206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8662-0004pM-Hz
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 14:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k864z-00046p-5W
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 14:11:25 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:43597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k864v-0003yc-MQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 14:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=QCJzFVU+GF/ZG0svzDimi/WsrT0ZoCs7k2MDXGSZeGI=; b=NK90NhIiWfoXm4pFndjKZzbJeF
 kq3h9m9XCbu3e/A2SRZJyji53h6x65paCN+nbY+aA7TfI+78+4Wgse+c06r+1vHn2HyxX6TXpqBV0
 vNfzRNtnFpyY0NpfuBSNNlFuUyPaEM4RCTkBN03SGEf7PaV6mqF82WWnROK5RlWBc9QPK5eJurtFd
 zFvks3Iomi9BG9FW7l00L8+gCG1rXsgYnql77nFMQQ/ck2iiN8uuZBAUSSVcnaUfC3dlayUGbLjy4
 aGBNBVhJYUNxESPqQJg3my0miYMXaYaEMaFb1gxxU4MmKKy5IpuQU1IpgG2eLdM+hnKWXyQGq2WO9
 fX8CEH2A==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, kraxel@redhat.com
Subject: Re: [PATCH] audio/jack: fix use after free segfault
Date: Tue, 18 Aug 2020 20:11:15 +0200
Message-ID: <11253274.hK5Fc7SEp3@silver>
In-Reply-To: <20200818131206.BB75F3A0B9F@moya.office.hostfission.com>
References: <20200818131206.BB75F3A0B9F@moya.office.hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 14:11:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 18. August 2020 14:40:36 CEST Geoffrey McRae wrote:
> Due to a ridiculous commit in the Jack library, the client may have been
> freed already by a secondary audio device recovering its session.
>=20
> https://github.com/jackaudio/jack2/issues/627
>=20
> Until there is a proper fix for this we can not risk using the pointer
> at all if we have been notified of a shutdown as it may have been freed
> by the jack library, as such the close call is commented out to prevent
> a use after free segfault.
>=20
> At this time, this will not cause a memory leak as the recovery routine
> will trigger the "cleanup" code in the jack library, however, if this is
> ever corrected in the jack library this will need to be revisited.
>=20
> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  audio/jackaudio.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 72ed7c4929..e8faf1bb89 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -563,7 +563,22 @@ static void qjack_client_fini(QJackClient *c)
>          /* fallthrough */
>=20
>      case QJACK_STATE_SHUTDOWN:
> -        jack_client_close(c->client);
> +        /*
> +         * Due to a rediculous commit in the Jack library, the client may
> have +         * been freed already.

No need to be offending, and especially no need to insult St=E9phane in QEM=
U=20
code.

Could you please describe in more detail how you ran into this situation wi=
th=20
your 2nd audio device?

> +         *
> +         * Until there is a proper fix for this we can not risk using the
> +         * pointer at all if we have been notified of a shutdown, as such
> the +         * below line is commented out to prevent a use after free
> segfault. +         * This will not cause a memory leak as the recovery
> routine will trigger +         * the "cleanup" code in the jack library.
> +         *
> +         *
> https://github.com/jackaudio/jack2/commit/171a3c4a0ddd18d2afae56f3af6291c=
8e
> 96ee3ac +         */
> +
> +        //jack_client_close(c->client);
> +        c->client =3D NULL;
> +
>          /* fallthrough */

Are you aware that there are two distinct variants of JACK? They are common=
ly=20
referred to as JACK1 vs. JACK2 and despite their names, they are in fact=20
completely separate implementations and there are people who prefer one ove=
r=20
the other. Your change would affect JACK1 as well.

Best regards,
Christian Schoenebeck



