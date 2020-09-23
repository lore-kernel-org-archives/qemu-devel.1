Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D0BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16E720B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI7gyaH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16E720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL5CW-0004P6-11
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL5At-0003k9-4O
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL5An-0007s0-2r
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600869064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zs90ozxccO5hxjIALZr1rjnn+hSLyazdJufnBa6XG0U=;
 b=UI7gyaH0JEtgXwOv9qQc0dLfDnZNqx57rITa4cdIskpD74Zv5EdfIPj3hjsJo/vQa/a9he
 Qg6e5RF0c39bLQPFeQWSJsbGsUjkLpADQpOVZP9MinjgwNqfgHpgqtH5esklNCd9j1iawD
 X2rNVsXcsA1bi3txXZEvvfDn0OsB1mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-UqsZXtLQOsaRxxABtJMcwg-1; Wed, 23 Sep 2020 09:50:59 -0400
X-MC-Unique: UqsZXtLQOsaRxxABtJMcwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D33D2ACE32;
 Wed, 23 Sep 2020 13:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FC467368B;
 Wed, 23 Sep 2020 13:50:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA7C61132E9A; Wed, 23 Sep 2020 15:50:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] block: deprecate the sheepdog block driver
References: <20200922161611.2049616-1-berrange@redhat.com>
 <20200922161611.2049616-3-berrange@redhat.com>
Date: Wed, 23 Sep 2020 15:50:49 +0200
In-Reply-To: <20200922161611.2049616-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 22 Sep 2020 17:16:11
 +0100")
Message-ID: <87r1qs4n5y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, libvir-list@redhat.com,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This thread from a little over a year ago:
>
>   http://lists.wpkg.org/pipermail/sheepdog/2019-March/thread.html
>
> states that sheepdog is no longer actively developed. The only mentioned
> users are some companies who are said to have it for legacy reasons with
> plans to replace it by Ceph. There is talk about cutting out existing
> features to turn it into a simple demo of how to write a distributed
> block service. There is no evidence of anyone working on that idea:
>
>   https://github.com/sheepdog/sheepdog/commits/master
>
> No real commits to git since Jan 2018, and before then just some minor
> technical debt cleanup..

Drop the extra period.

>
> There is essentially no activity on the mailing list aside from
> patches to QEMU that get CC'd due to our MAINTAINERS entry.
>
> Fedora packages for sheepdog failed to build from upstream source
> because of the more strict linker that no longer merges duplicate
> global symbols. Fedora patches it to add the missing "extern"
> annotations and presumably other distros do to, but upstream source
> remains broken.
>
> There is only basic compile testing, no functional testing of the
> driver.
>
> Since there are no build pre-requisites the sheepdog driver is currently
> enabled unconditionally. This would result in configure issuing a
> deprecation warning by default for all users. Thus the configure default
> is changed to disable it, requiring users to pass --enable-sheepdog to
> build the driver.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/sheepdog.c           | 15 +++++++++++++++
>  configure                  |  5 +++--
>  docs/system/deprecated.rst |  9 +++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index cbbebc1aaf..7f68bd6a1a 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -242,6 +242,17 @@ typedef struct SheepdogInode {
>   */
>  #define FNV1A_64_INIT ((uint64_t)0xcbf29ce484222325ULL)
> =20
> +static void deprecation_warning(void)
> +{
> +    static bool warned =3D false;

Obey checkpatch :)

> +
> +    if (!warned) {
> +        warn_report("the sheepdog block driver is deprecated and will be=
 "
> +                    "removed in a future release");

Similar warnings elsewhere don't say "will be removed".

Some of them are nice enough to advise what to use instead, but that may
not be practical here.

> +        warned =3D true;
> +    }
> +}
> +
>  /*
>   * 64 bit Fowler/Noll/Vo FNV-1a hash code
>   */
> @@ -1548,6 +1559,8 @@ static int sd_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
>      char *buf =3D NULL;
>      QemuOpts *opts;
> =20
> +    deprecation_warning();
> +
>      s->bs =3D bs;
>      s->aio_context =3D bdrv_get_aio_context(bs);
> =20
> @@ -2007,6 +2020,8 @@ static int sd_co_create(BlockdevCreateOptions *opti=
ons, Error **errp)
> =20
>      assert(options->driver =3D=3D BLOCKDEV_DRIVER_SHEEPDOG);
> =20
> +    deprecation_warning();
> +
>      s =3D g_new0(BDRVSheepdogState, 1);
> =20
>      /* Steal SocketAddress from QAPI, set NULL to prevent double free */
> diff --git a/configure b/configure
> index 7564479008..c6af83f2e6 100755
> --- a/configure
> +++ b/configure
> @@ -533,7 +533,7 @@ vdi=3D"yes"
>  vvfat=3D"yes"
>  qed=3D"yes"
>  parallels=3D"yes"
> -sheepdog=3D"yes"
> +sheepdog=3D"no"
>  libxml2=3D""
>  debug_mutex=3D"no"
>  libpmem=3D""
> @@ -1941,7 +1941,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
>    vvfat           vvfat image format support
>    qed             qed image format support
>    parallels       parallels image format support
> -  sheepdog        sheepdog block driver support
> +  sheepdog        sheepdog block driver support (deprecated)
>    crypto-afalg    Linux AF_ALG crypto backend driver
>    capstone        capstone disassembler support
>    debug-mutex     mutex debugging support
> @@ -7350,6 +7350,7 @@ if test "$parallels" =3D "yes" ; then
>    echo "CONFIG_PARALLELS=3Dy" >> $config_host_mak
>  fi
>  if test "$sheepdog" =3D "yes" ; then
> +  add_to deprecated_features "sheepdog"
>    echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
>  fi
>  if test "$pty_h" =3D "yes" ; then
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 0cb8b01424..49b9f4b02e 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -405,6 +405,15 @@ The above, converted to the current supported format=
::
> =20
>    json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
> =20
> +``sheepdog`` driver (since 5.2.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``sheepdog`` block device driver is deprecated. The corresponding up=
stream
> +server project is no longer actively maintained. Users are recommended t=
o switch
> +to an alternative distributed block device driver such as RBD. The
> +``qemu-img convert`` command can be used to liberate existing data by mo=
ving
> +it out of sheepdog volumes into an alternative storage backend.
> +
>  linux-user mode CPUs
>  --------------------

Preferably with my nits addressed:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


