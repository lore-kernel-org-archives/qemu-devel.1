Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6591ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AD2218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="KY4LxdlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AD2218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHLR-0000eh-6P
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iIDkZ-0007ck-Dr
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iIDkY-0000kd-85
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:19:39 -0400
Received: from mout.web.de ([212.227.15.14]:58565)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iIDkX-0000kF-VN; Wed, 09 Oct 2019 11:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570634363;
 bh=jfWgR+QqPZ2re2sMpAU6XcfQBs/y4YRLnD/YEV5VVrQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KY4LxdlRzZOl0LSz9nmL2bvRfuJyzr3h1jcEv49qbTWXqGAilZYggeJC8eDeIQJ2W
 3GeeiFtrtIZfxHRcny7OVgB49u2D8Zrng99zWs8iTBZNjqp7adVKNI+IgEVutcun4k
 TkIiKH9bX8y8anS2q/I9lkSYE1xClk7zO/lPqv9E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.16]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgIMg-1iUmmT0FCo-00Njnx; Wed, 09
 Oct 2019 17:19:23 +0200
Date: Wed, 9 Oct 2019 17:19:19 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v6 2/4] tests/test-replication.c: Add test for for
 secondary node continuing replication
Message-ID: <20191009171919.6b90d779@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D78062A756A@shsmsx102.ccr.corp.intel.com>
References: <cover.1570280098.git.lukasstraub2@web.de>
 <acacb35c86d6abae5c397e2e1953b67485c24d91.1570280098.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D78062A756A@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K06TgRoZmAa58S+zsqoMcF2XZpPpCDKkeBDECFTurqbU+SBzgPR
 f7qbZaBx0qbHECof9EurEBoRABJyhAArMKYWDnsHoY67lCGPebRDjuxYIN2SqiivCfvcPQ3
 MvnytCxejxBAbq5pGtF/ezHmgJr1rwKyxEHBzGpr0YS3OnlfmnPcvmPTYqYCKOmnfVdJzKN
 3xXCw8nAs2Lxt5yNSaAHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:agOJwShfo0U=:Lp+F6bhfLbNVwlSZqe2LmS
 8AxkfkK8UmeN2RCqA3mahRe+TdGbABwNLcQHpq/dREYncyBfup2pD1WS9WINtczOmqrWYi9Gs
 jwCK9tJ6MrIqF0gWzIGOv18cqwe6pJhN2sNblqoRTY5BQaZrHliXH89rRzW+V6hl+Lkz72ARO
 o3k6Ooacb0AT2A8b80B3BCKThThQIUpCvJQQ7C+hHrrwoKoUA2u1pK+yj2ei27AqPfBmDWcWC
 Dti3FsQ1FWS6cNKDtgvc5mZU07FkgfTvgxgk+1Jwspa1qq8wN2Cuyr+Uc+UQqJlIhCjMwlofZ
 e0jCm5HHF89VW+aYawuYnoKlSJ5lzQPpPvGzXmCZBhn7PtKuO4EDww73T3NK/kk1tEt3+aGqj
 jM+Kkda/y4nVmVqzgvytT1v/omgPqmoQTYnZPX/uYw6wrQ7F2Y/qdQMlx67ji0OMELbq0ysQM
 pM41jy8lg7ANO4C05yDi018Cpc7hFiGZ+ILk9KExxv2B7cOd6Nu4M0MlzsNPU1nBuWqtcjz6F
 8jlEzGO5dsipoMEe6LeIAk91eTvf2bETQxFTyv1mZ5E8oTSzHyEHquhlTFTOQgCfBx/bttVAJ
 UDtM933oFE/3ne9GLmwVeszmirbpChdRgyEs7jN/VR44S0ZdwEsHwTFYxgDhsDuXJVp5AP0MF
 me7d//eMd0Vsf1/NzfjntdshcDx4UcV2j11tF7Ulca79vwQNiUOY+8uRh5gwTAipYiMGBwtoh
 VehNDZhwAMeZPgM1BmPU8m8R7NZ1OGi6SYmFhBC3E95eS3NyF6FyJ/HipucHrCE+qWLIUGY3S
 5t5GgBgon7jM5axc0Q1l9TezsGPu6ixzwtKhAAwDOM/9sPrKWH1oStSEqRtFa0B8fAPUwjubb
 kg5bHoQA2G/O4U6oWU1E6ZpX8MQ/LhugXRn3xpFeuzTu0FA+E09S5AB4F9jW+Xp6kLb2iWtWu
 S48Lt8Fo34yraAPbW8VRtJgcES/jKgm58hMtSS3VT+CQK7/EIxubLcFxS9JobAk2CvYRdUSsl
 VqkqbhxhMh+0trfzFIoJKdcwOGg8KdZFKiwSLPpQUG53ELUYeGUE1mOham5+XNeDMZhI5etB2
 WzBG2qw6O0vVsAngvUITJTymt8QGYkCnIuxKgo8OiQma8VwmxCPwqus5DDxGq7Aizq5ZRTd2Z
 gEUxC2RH0YbkPGIMGvOZI18f4TDGIKBcMG/slCVyXrTjfr2WPnetnTNJcFZp7Iy35d0HGs9Dv
 n8aGpio7sifFxewn6SQeQzEbkSGz+SNAuLu0w0zRyA54FSzyMN4M17q0KFeo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.14
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Oct 2019 06:03:03 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Saturday, October 5, 2019 9:06 PM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> > Xie Changlong <xiechanglong.d@gmail.com>; Kevin Wolf
> > <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; qemu-block
> > <qemu-block@nongnu.org>
> > Subject: [PATCH v6 2/4] tests/test-replication.c: Add test for for sec=
ondary
> > node continuing replication
> >
> > This simulates the case that happens when we resume COLO after failove=
r.
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  tests/test-replication.c | 52
> > ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/tests/test-replication.c b/tests/test-replication.c index
> > f085d1993a..8e18ecd998 100644
> > --- a/tests/test-replication.c
> > +++ b/tests/test-replication.c
> > @@ -489,6 +489,56 @@ static void test_secondary_stop(void)
> >      teardown_secondary();
> >  }
> >
> > +static void test_secondary_continuous_replication(void)
> > +{
> > +    BlockBackend *top_blk, *local_blk;
> > +    Error *local_err =3D NULL;
> > +
> > +    top_blk =3D start_secondary();
> > +    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
> > +    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);
> > +    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false=
);
> > +
> > +    /* replication will backup s_local_disk to s_hidden_disk */
> > +    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
> > +                  IMG_SIZE / 2, 0, IMG_SIZE, false);
> > +
> > +    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */
> > +    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
> > +
> > +    /* do failover (active commit) */
> > +    replication_stop_all(true, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* it should ignore all requests from now on */
>
> Should we need add teardown_secondary() here?

I don't think so. It is used to remove the block node after each test and =
I'm doing that below.

Regards,
Lukas Straub

> Thanks
> Zhang Chen
>
> > +
> > +    /* start after failover */
> > +    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* checkpoint */
> > +    replication_do_checkpoint_all(&local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* stop */
> > +    replication_stop_all(true, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* read from s_local_disk (0, IMG_SIZE / 2) */
> > +    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
> > +                  0, IMG_SIZE / 2, false);
> > +
> > +
> > +    /* read from s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
> > +    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,
> > +                  IMG_SIZE / 2, 0, IMG_SIZE, false);
> > +
> > +    teardown_secondary();
> > +}
> > +
> >  static void test_secondary_do_checkpoint(void)
> >  {
> >      BlockBackend *top_blk, *local_blk;
> > @@ -584,6 +634,8 @@ int main(int argc, char **argv)
> >      g_test_add_func("/replication/secondary/write", test_secondary_wr=
ite);
> >      g_test_add_func("/replication/secondary/start", test_secondary_st=
art);
> >      g_test_add_func("/replication/secondary/stop",  test_secondary_st=
op);
> > +    g_test_add_func("/replication/secondary/continuous_replication",
> > +                    test_secondary_continuous_replication);
> >      g_test_add_func("/replication/secondary/do_checkpoint",
> >                      test_secondary_do_checkpoint);
> >      g_test_add_func("/replication/secondary/get_error_all",
> > --
> > 2.20.1
>


