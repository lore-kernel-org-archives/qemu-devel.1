Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9633C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59906206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59906206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QAN-0006rm-Es
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w.bumiller@proxmox.com>) id 1j4Q91-0005uN-UI
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <w.bumiller@proxmox.com>) id 1j4Q90-0003cp-SU
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:16:07 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:50120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
 id 1j4Q8x-0003U8-Hy; Wed, 19 Feb 2020 09:16:03 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DD62641928;
 Wed, 19 Feb 2020 15:07:40 +0100 (CET)
Date: Wed, 19 Feb 2020 15:07:39 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 2/4] vl: Initialise main loop earlier
Message-ID: <20200219140739.tfn7p5xsbxofoajq@olga.proxmox.com>
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200218154036.28562-3-kwolf@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 04:40:34PM +0100, Kevin Wolf wrote:
> We want to be able to use qemu_aio_context in the monitor
> initialisation.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  vl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 794f2e5733..98bc51e089 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2894,6 +2894,11 @@ int main(int argc, char **argv, char **envp)
>      runstate_init();
>      precopy_infrastructure_init();
>      postcopy_infrastructure_init();
> +
> +    if (qemu_init_main_loop(&main_loop_err)) {
> +        error_report_err(main_loop_err);
> +        exit(1);
> +    }
>      monitor_init_globals();

This is a tiny bit scary, as we now have around 1kloc of code between
here and os_daemonize() where in the future we may accidentally cause
the aio context's on-demand thread pool to spawn before fork()ing
(silently losing the threads again - we did have such an issue right
there in monitor_init_globals() in the past)

For *now* it should be fine since currently that wouldn't have worked,
but we may need to keep an eye out for that in future patches.
Basically, not everything we do between here and os_daemonize() way down
below is actually allowed to freely use the main loop's aio context even
if now it already exists from this point onward.

I wonder if aio_get_thread_pool() should check the daemonization state
(maybe with some debug #ifdef)?

> =20
>      if (qcrypto_init(&err) < 0) {
> @@ -3811,11 +3816,6 @@ int main(int argc, char **argv, char **envp)
>      qemu_unlink_pidfile_notifier.notify =3D qemu_unlink_pidfile;
>      qemu_add_exit_notifier(&qemu_unlink_pidfile_notifier);
> =20
> -    if (qemu_init_main_loop(&main_loop_err)) {
> -        error_report_err(main_loop_err);
> -        exit(1);
> -    }
> -
>  #ifdef CONFIG_SECCOMP
>      olist =3D qemu_find_opts_err("sandbox", NULL);
>      if (olist) {
> --=20
> 2.20.1


