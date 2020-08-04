Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EF7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A5220722
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC0pRF/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A5220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k304M-0000z8-OU
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k303V-0000SD-Vi
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:44:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k303U-0002wF-9a
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596559487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfMpbsk+znj1BpL+fmmDMViOhRt2auiNxNLDKB75Emo=;
 b=LC0pRF/6b7amwFhFvoKnrgNC4Ce41HqvBEOBfhmeyw9P3NGzGqUT2fu3TfUq3q0sBRkRW7
 x0rEqbX7yqNuhzdgh9rZyfoZRiSOuTFg23ikGRBKfWhxIWrTEEXtcRdYQ7DdpNnX+jnQPM
 Cpla8vCxlvpThCyd1vT6bY8ENRpNC9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-H5ozace3PFelE2JUCqh5sw-1; Tue, 04 Aug 2020 12:44:45 -0400
X-MC-Unique: H5ozace3PFelE2JUCqh5sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B21B18A1DFE;
 Tue,  4 Aug 2020 16:44:44 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81EC95DA73;
 Tue,  4 Aug 2020 16:44:42 +0000 (UTC)
Date: Tue, 4 Aug 2020 17:44:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 3/8] migration/dirtyrate: Add dirtyrate statistics
 series functions
Message-ID: <20200804164439.GF2659@work-vm>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-4-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1595646669-109310-4-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> From: Zheng Chuan <zhengchuan@huawei.com>
>=20
> Add dirtyrate statistics to record/update dirtyrate info.
>=20
> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 47 ++++++++++++++++++++++++++++++---------------=
--
>  migration/dirtyrate.h | 11 +++++++++++
>  2 files changed, 41 insertions(+), 17 deletions(-)
>=20
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index fc652fb..6baf674 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -13,19 +13,41 @@
>  #include "dirtyrate.h"
> =20
>  static uint64_t sample_pages_per_gigabytes =3D DIRTYRATE_DEFAULT_SAMPLE_=
PAGES;
> -static uint64_t dirty_rate; /* MB/s */
> +static struct dirtyrate_statistics dirty_stat;
>  CalculatingDirtyRateStage calculating_dirty_rate_stage =3D CAL_DIRTY_RAT=
E_INIT;
> =20
> -static bool calculate_dirtyrate(struct dirtyrate_config config,
> -                        uint64_t *dirty_rate, int64_t time)
> +static void reset_dirtyrate_stat(void)
>  {
> -    /* todo */
> -    return true;
> +    dirty_stat.total_dirty_samples =3D 0;
> +    dirty_stat.total_sample_count =3D 0;
> +    dirty_stat.total_block_mem_MB =3D 0;
> +    dirty_stat.dirty_rate =3D 0;
> +}
> +
> +static void update_dirtyrate_stat(struct block_dirty_info *info)
> +{
> +    dirty_stat.total_dirty_samples +=3D info->sample_dirty_count;
> +    dirty_stat.total_sample_count +=3D info->sample_pages_count;
> +    dirty_stat.total_block_mem_MB +=3D (info->block_pages << DIRTYRATE_P=
AGE_SIZE_SHIFT) >> PAGE_SIZE_SHIFT;
>  }
> =20
> -static void set_dirty_rate(uint64_t drate)
> +static void update_dirtyrate(int64_t msec)
>  {
> -    dirty_rate =3D drate;
> +    uint64_t dirty_rate;
> +    unsigned int total_dirty_samples =3D dirty_stat.total_dirty_samples;
> +    unsigned int total_sample_count =3D dirty_stat.total_sample_count;
> +    unsigned long total_block_mem_MB =3D dirty_stat.total_block_mem_MB;
> +
> +    dirty_rate =3D total_dirty_samples * total_block_mem_MB *
> +                 1000 / (total_sample_count * msec);
> +
> +    dirty_stat.dirty_rate =3D dirty_rate;
> +}
> +
> +
> +static void calculate_dirtyrate(struct dirtyrate_config config, int64_t =
time)
> +{
> +    /* todo */
>  }
> =20
>  /*
> @@ -42,21 +64,12 @@ static void set_dirty_rate_stage(CalculatingDirtyRate=
Stage ratestage)
>  void *get_dirtyrate_thread(void *arg)
>  {
>      struct dirtyrate_config config =3D *(struct dirtyrate_config *)arg;
> -    uint64_t dirty_rate;
> -    uint64_t hash_dirty_rate;
> -    bool query_succ;
>      int64_t msec =3D 0;
>  =20
>      set_dirty_rate_stage(CAL_DIRTY_RATE_ING);
> =20
> -    query_succ =3D calculate_dirtyrate(config, &hash_dirty_rate, msec);
> -    if (!query_succ) {
> -        dirty_rate =3D 0;
> -    } else {
> -        dirty_rate =3D hash_dirty_rate;
> -    }

All this was only just added; it might be easier to create the
update_dirtyrate function first.

> +    calculate_dirtyrate(config, msec);
> =20
> -    set_dirty_rate(dirty_rate);
>      set_dirty_rate_stage(CAL_DIRTY_RATE_END);
> =20
>      return NULL;
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 342b89f..2994535 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -15,6 +15,9 @@
> =20
>  /* take 256 pages per GB for cal dirty rate */
>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES    256
> +#define DIRTYRATE_PAGE_SIZE_SHIFT       12
> +#define BLOCK_INFO_MAX_LEN              256
> +#define PAGE_SIZE_SHIFT                 20

I think you might also have used one of these #define's in a previous
patch; so make sure the patches each compile in order.
Also, can you please comment each one of these - I was confused by a lot
of the calculations above because I don't quite understand what each of
these is.
I don't thinl 'BLOCK_INFO_MAX_LEN' is needed - becuase it's just a
RAMBlock ID, and you can link to the RAMBlock.
I'm not sure what DIRTYRATE_PAGE_SIZE_SHIFT is, or why it's different
from TARGET_PAGE_BITS.

> =20
>  struct dirtyrate_config {
>      uint64_t sample_pages_per_gigabytes;
> @@ -33,6 +36,14 @@ typedef enum {
>      CAL_DIRTY_RATE_END   =3D 2,
>  } CalculatingDirtyRateStage;
> =20
> +struct dirtyrate_statistics {
> +    unsigned int total_dirty_samples;
> +    unsigned int total_sample_count;
> +    unsigned long total_block_mem_MB;

'long' is normally a bad idea - we use it in a few places and it
was generally a bad idea; size_t for a size is much better.

> +    int64_t dirty_rate;

Is this blocks/sec, MB/s what - please comment it.

Dave

> +};
> +
> +
>  /*=20
>   * Store dirtypage info for each block.
>   */
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


